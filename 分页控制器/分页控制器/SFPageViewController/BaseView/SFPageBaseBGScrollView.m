//
//  SFPageBaseBGScrollView.m
//  SFPageViewController
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SFPageBaseBGScrollView.h"

@implementation SFPageBaseBGScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *recognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        CGFloat currentY = [recognizer translationInView:self].y;
        CGFloat currentX = [recognizer translationInView:self].x;
        
        if (currentX == 0.0) {
            return YES;
        } else {
            if (fabs(currentY)/currentX >= 5.0) {
                return YES;
            } else {
                return NO;
            }
        }
    }
    return YES;
}

@end
