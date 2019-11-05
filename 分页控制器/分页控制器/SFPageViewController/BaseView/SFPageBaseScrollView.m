//
//  SFPageBaseScrollView.m
//  分页控制器
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SFPageBaseScrollView.h"

@interface SFPageBaseScrollView ()

@end

@implementation SFPageBaseScrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.isSupportMultipleGesture = NO;
    }
    return self;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return self.isSupportMultipleGesture;
}


@end
