//
//  ZZMagicDragGestureView.h
//  projectTest
//
//  Created by zuolizhen on 2022/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZMagicDragGestureView : UIView

- (void)onPanGesture:(UIPanGestureRecognizer *)recognizer;

- (void)changeVCDirection:(BOOL)isLandscape;

@end

NS_ASSUME_NONNULL_END
