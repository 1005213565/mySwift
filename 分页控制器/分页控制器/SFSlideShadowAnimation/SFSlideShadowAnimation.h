//
//  SFSlideShadowAnimation.h
//  SFSlideShadowAnimation
//
//  Created by fly-石峰
//

#import <UIKit/UIKit.h>

@interface SFSlideShadowAnimation : NSObject

@property (weak, nonatomic) UIView *animatedView;

@property (strong, nonatomic) UIColor *shadowBackgroundColor;
@property (strong, nonatomic) UIColor *shadowForegroundColor;
@property (assign, nonatomic) CGFloat shadowWidth;
@property (assign, nonatomic) CGFloat repeatCount;
@property (assign, nonatomic) NSTimeInterval duration;

- (void)start;
- (void)stop;

@end
