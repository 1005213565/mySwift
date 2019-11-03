//
//  SFSlideShadowAnimation.h
//  SFSlideShadowAnimation
//
//  Created by fly-石峰
//

#import "SFSlideShadowAnimation.h"

@interface SFSlideShadowAnimation(){
    
    CABasicAnimation *currentAnimation;
}

@end

@implementation SFSlideShadowAnimation

- (id)init
{
    self = [super init];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{

    self.shadowBackgroundColor = [UIColor redColor];
    self.shadowForegroundColor = [UIColor greenColor];
    
    self.shadowWidth = 50;
    self.repeatCount = HUGE_VALF;
    self.duration = 10.0;
}

- (void)start
{
    if(!self.animatedView){
       
        return;
    }
    
//    [self stop];
    
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.frame = self.animatedView.bounds;
    
    CGFloat gradientSize = self.shadowWidth / self.animatedView.frame.size.width;
    
    NSArray *startLocations = @[
                                @0.5,
                                
                                [NSNumber numberWithFloat:gradientSize]
                                ];
    NSArray *endLocations = @[
                              [NSNumber numberWithFloat:(1. - gradientSize)],
                              [NSNumber numberWithFloat:(1. - (gradientSize / 2.))],
                              @1
                              ];
    
    
    gradientMask.colors = @[
                            
                            (id)self.shadowForegroundColor.CGColor,
                            (id)self.shadowBackgroundColor.CGColor
                            ];
    gradientMask.locations = startLocations;
    gradientMask.startPoint = CGPointMake(0 - (gradientSize * 2), .5);
    gradientMask.endPoint = CGPointMake(1 + gradientSize, .5);
    
    self.animatedView.layer.mask = gradientMask;
    
//    gradientMask.locations = endLocations;
    
//    currentAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
//    currentAnimation.fromValue = startLocations;
//    currentAnimation.toValue = endLocations;
//    currentAnimation.repeatCount = self.repeatCount;
//    currentAnimation.duration  = self.duration;
//    // JTSlideShadowAnimation
//    [gradientMask addAnimation:currentAnimation forKey:@"SFSlideShadowAnimation"];
}

- (void)stop
{
    if(self.animatedView && self.animatedView.layer.mask){
        [self.animatedView.layer.mask removeAnimationForKey:@"SFSlideShadowAnimation"];
        self.animatedView.layer.mask = nil;
        currentAnimation = nil;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)finished
{
    if(anim == currentAnimation){
        [self stop];
    }
}

@end
