//
//  SFPageBaseScrollView.m
//  分页控制器
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SFPageBaseScrollView.h"

@interface SFPageBaseScrollView ()

/*! 是否支持多个手势  */
@property (nonatomic, assign) BOOL isSupportMultipleGesture;


@end

@implementation SFPageBaseScrollView

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.beginOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScrollView:(UIScrollView *)scrollView {
    
    self.beginOffsetX = 0;
    if (self.beginOffsetX > scrollView.contentOffset.x) {
        
        self.isScrollRightDirection = YES;
    }else {
        
        self.isScrollRightDirection = NO;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.isSupportMultipleGesture = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollSupportMultipleGesture:) name:@"scrollSupportMultipleGesture" object:nil];
    }
    return self;
}

- (void) scrollSupportMultipleGesture:(NSNotification *)sender {
    
    NSDictionary *dic = sender.object;
    self.isSupportMultipleGesture = [dic[@"supportMultiple"] boolValue];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return self.isSupportMultipleGesture;
}

@end
