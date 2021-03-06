//
//  SFPageBaseTableView.m
//  分页控制器
//
//  Created by fly on 2019/11/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SFPageBaseTableView.h"



@implementation SFPageBaseTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.isSupportMultipleGesture = NO;
    }
    return self;
}


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
