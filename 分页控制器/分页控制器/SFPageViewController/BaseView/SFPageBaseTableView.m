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
    
    return self.isSupportMultipleGesture;
}
@end
