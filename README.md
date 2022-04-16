# ZZMagicDrag

a landscape gesture drag framework（一个横屏下的手势操作，左边是亮度变化；右边是音量变化）

集成方式：

1、pod 'ZZMagicDrag', '~> 1.0.2'

2、把源代码拷贝到工程里面


使用方式：

具体可以参考demo实现方式

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.landShowView];
    [self.landShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view).offset(20);
        make.right.bottom.mas_equalTo(self.view).offset(-20);
    }];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
    [self.view addGestureRecognizer:pan];
    self.panGesture = pan;
    
    self.landGestureView = [[ZZMagicDragGestureView alloc] initWithFrame:self.landGestureView.bounds];
    [self.landShowView addSubview:self.landGestureView];
    [self.landGestureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.landShowView);
    }];
}

- (void)onPanGesture: (UIPanGestureRecognizer *)gestureRecognizer
{
    [self.landGestureView onPanGesture:gestureRecognizer];
}

// 屏幕旋转
- (BOOL)supportsAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0)
{
    return [super supportedInterfaceOrientations];
}
