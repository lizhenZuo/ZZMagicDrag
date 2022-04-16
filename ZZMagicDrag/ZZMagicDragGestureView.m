//
//  ZZMagicDragGestureView.m
//  projectTest
//
//  Created by zuolizhen on 2022/4/9.
//

#import "ZZMagicDragGestureView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ZZMagicDragShowView.h"

typedef NS_ENUM(NSUInteger, ZZMagicDragLandscapeDirection) {
    ZZMagicDragLandscapeDirectionOfLR,  // 左右手势
    ZZMagicDragLandscapeDirectionOfUD,  // 上下手势
    ZZMagicDragLandscapeDirectionOfNone // 没有手势
};

typedef NS_ENUM(NSUInteger, ZZMagicDragLandscapeOperationType) {
    ZZMagicDragLandscapeOperationTypeBright, // 亮度
    ZZMagicDragLandscapeOperationTypeVolume // 声音
};

@interface ZZMagicDragGestureView()

// 控制音量的view
@property (nonatomic, strong) MPVolumeView *volumeView;
@property (nonatomic, strong) UISlider *volumeViewSlider;

@property (nonatomic, assign) ZZMagicDragLandscapeDirection direction;
@property ( nonatomic, assign) ZZMagicDragLandscapeOperationType operationType;

@property (nonatomic, strong) ZZMagicDragShowView *magicDragShowView;


@end

@implementation ZZMagicDragGestureView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    self.userInteractionEnabled = NO;
    self.hidden = YES;
}

- (void)onPanGesture:(UIPanGestureRecognizer *)recognizer
{
    UIView *gesView = recognizer.view;
    CGPoint point = [recognizer locationInView:gesView];
    
    //点击引导
    if ([self pointInside:[self convertPoint:point fromView:gesView] withEvent:nil]) {
        [self onLandscapeVerticalPanGesture:recognizer];
    }
}

- (void)onLandscapeVerticalPanGesture:(UIPanGestureRecognizer *)gesture
{
    UIView *gesView = gesture.view;
    CGPoint locationPoint = [gesture locationInView:gesView];
    CGPoint veloctyPoint = [gesture velocityInView:gesView];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x > y) {
                self.direction = ZZMagicDragLandscapeDirectionOfLR;
            } else if (x < y) {
                self.direction = ZZMagicDragLandscapeDirectionOfUD;
                if (locationPoint.x <= self.frame.size.width / 2.0) {
                    self.operationType = ZZMagicDragLandscapeOperationTypeBright;

                } else {
                    self.operationType = ZZMagicDragLandscapeOperationTypeVolume;
                }
            }

            break;
        }
        case UIGestureRecognizerStateChanged: {
            switch (self.direction) {
                case ZZMagicDragLandscapeDirectionOfUD: {
                    [self verticalMoved:veloctyPoint.y];
                    break;
                }
                default:
                    break;
            }

            break;
        }
        case UIGestureRecognizerStateEnded: {
            break;
        }
        default:
            break;
    }
}

- (void)verticalMoved:(CGFloat)value
{
    if (self.operationType == ZZMagicDragLandscapeOperationTypeBright) {
        CGFloat alpha = [UIScreen mainScreen].brightness - (value / 10000.0);
        [[UIScreen mainScreen] setBrightness:alpha];
        // 显示当前亮度
        [self.magicDragShowView updateWithAlpha:alpha];
    } else {
        CGFloat volumeValue = self.volumeViewSlider.value - value / 10000.0;
        if ([[UIDevice currentDevice] systemVersion].floatValue >= 11) {
            // ios11音量提示实现有变，此处兼容下
            volumeValue = self.volumeViewSlider.value - value / 5000.0;
            self.volumeViewSlider.value = volumeValue;
            // 显示当前声音
            [self.magicDragShowView updateWithVolume:volumeValue];
        } else {
            if (value < 0) {
                [self.volumeViewSlider setValue:volumeValue animated:YES];
                if (volumeValue - self.volumeViewSlider.value >= 0.1) {
                    [self.volumeViewSlider setValue:0.1 animated:NO];
                    [self.volumeViewSlider setValue:volumeValue animated:YES];
                    // 显示当前声音
                    [self.magicDragShowView updateWithVolume:volumeValue];
                }
            } else {
                [self.volumeViewSlider setValue:volumeValue animated:YES];
                // 显示当前声音
                [self.magicDragShowView updateWithVolume:volumeValue];
            }
        }
    }
}

- (void)changeVCDirection:(BOOL)isLandscape
{
    self.hidden = !isLandscape;
    
    if (!isLandscape && _magicDragShowView) {
        // 需要magicDragView已经存在才能调用
        [self.magicDragShowView hideShowView];
    }
}

#pragma mark - getter methdos
- (MPVolumeView *)volumeView
{
    if (!_volumeView) {
        _volumeView = [[MPVolumeView alloc] init];
        [_volumeView sizeToFit];
        _volumeView.hidden = YES;
    }

    return _volumeView;
}

- (UISlider *)volumeViewSlider
{
    UISlider* volumeSlider =nil;
    for(UIView *view in [self.volumeView subviews]) {
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeSlider = (UISlider*)view;
            break;
        }
    }

    return volumeSlider;
}

#pragma mark - getter
- (ZZMagicDragShowView *)magicDragShowView
{
    if (!_magicDragShowView) {
        _magicDragShowView = [[ZZMagicDragShowView alloc] initWithFrame:CGRectMake(0, 0, 76, 40)];
    }
    return _magicDragShowView;
}

@end

