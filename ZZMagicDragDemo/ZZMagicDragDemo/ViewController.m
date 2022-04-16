//
//  ViewController.m
//  ZZMagicDragDemo
//
//  Created by 左礼振 on 2022/4/16.
//

#import "ViewController.h"
#import "ZZMagicDragGestureView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@property (strong, nonatomic) ZZMagicDragGestureView *landGestureView;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong, nonatomic) UIView *landShowView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
    [self.view addGestureRecognizer:pan];
    self.panGesture = pan;
    self.panGesture.delegate = self;
    
    [self.view addSubview:self.landShowView];
    [self.landShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view).offset(20);
        make.right.bottom.mas_equalTo(self.view).offset(-20);
    }];
    
    self.landGestureView = [[ZZMagicDragGestureView alloc] initWithFrame:self.landGestureView.bounds];
    [self.landShowView addSubview:self.landGestureView];
    [self.landGestureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.landShowView);
    }];
}

- (BOOL)supportsAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0)
{
    return [super supportedInterfaceOrientations];
}


- (void)onPanGesture: (UIPanGestureRecognizer *)gestureRecognizer
{
    [self.landGestureView onPanGesture:gestureRecognizer];
}

- (UIView *)landShowView
{
    if (!_landShowView) {
        _landShowView = [[UIView alloc] init];
        _landShowView.backgroundColor = [UIColor redColor];
    }
    return _landShowView;
}




@end
