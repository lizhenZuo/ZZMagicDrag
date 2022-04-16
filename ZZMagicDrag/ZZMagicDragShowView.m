//
//  ZZMagicDragShowView.m
//  projectTest
//
//  Created by zuolizhen on 2022/4/9.
//

#import "ZZMagicDragShowView.h"

@interface ZZMagicDragShowView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLable;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL isShowing;


@end

@implementation ZZMagicDragShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectZero;
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.isShowing = NO;
        [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.5]];

        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLable];
        
        self.titleLabel.frame = CGRectMake(10, 0, 45, 40);
        self.contentLable.frame = CGRectMake(55, 0, 40, 40);
    }

    return self;
}

- (void)updateWithVolume:(CGFloat)volume
{
    if (![self.titleLabel.text isEqualToString:@"音量："]) {
        [self.titleLabel setText:@"音量："];
    }
    [self updateWithValue:volume];
}

- (void)updateWithAlpha:(CGFloat)alpha
{
    if (![self.titleLabel.text isEqualToString:@"亮度："]) {
        [self.titleLabel setText:@"亮度："];
    }
    
    [self updateWithValue:alpha];
}

- (void)hideShowView
{
    // 先停止计时器
    [self removeTimer];
    // 隐藏视图
    [self disAppearView];
}

- (void)updateWithValue:(CGFloat)value
{
    if (!self.isShowing) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        self.isShowing = YES;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        self.frame = CGRectMake(width/2-50, height/2-20, 100, 40);
    }
    
    [self appearView];
    
    int volumeNum = (int)(value*100);
    if (volumeNum < 0) {
        volumeNum = 0;
    } else if (volumeNum > 100) {
        volumeNum = 100;
    }
    [self.contentLable setText:[NSString stringWithFormat:@"%d%%", volumeNum]];
}

#pragma mark getter methods
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"音量：";
    }

    return _titleLabel;
}

- (UILabel *)contentLable
{
    if (!_contentLable) {
        _contentLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLable.font = [UIFont systemFontOfSize:14];
        _contentLable.textColor = [UIColor whiteColor];
        _contentLable.textAlignment = NSTextAlignmentCenter;
    }

    return _contentLable;
}

#pragma mark - timer
- (void)appearView
{
    self.alpha = 1.0;
    [self updateTimer];
}

- (void)disAppearView
{
    if (self.alpha == 1.0) {
        self.alpha = 0.0;
    }
    
    if ([self.titleLabel.text isEqualToString:@"音量："]) {
        // 音量调节
    } else if ([self.titleLabel.text isEqualToString:@"亮度："]) {
        // 亮度调节
    }
}

- (void)addTimer
{
    if (self.timer) {
        return;
    }

    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(disAppearView) userInfo:nil repeats:NO];
}

- (void)removeTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)updateTimer
{
    [self removeTimer];
    [self addTimer];
}

@end

