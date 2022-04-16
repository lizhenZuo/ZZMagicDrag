//
//  ZZMagicDragShowView.h
//  projectTest
//
//  Created by zuolizhen on 2022/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZMagicDragShowView : UIView

// 音量调节
- (void)updateWithVolume:(CGFloat)volume;

// 亮度调节
- (void)updateWithAlpha:(CGFloat)alpha;

// 隐藏
- (void)hideShowView;

@end

NS_ASSUME_NONNULL_END
