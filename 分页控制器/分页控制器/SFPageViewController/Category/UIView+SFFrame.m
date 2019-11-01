//
//  UIView+SFFrame.m
//  分页控制器
//
//  Created by mac on 2019/10/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIView+SFFrame.h"

@implementation UIView (SFFrame)

- (void)setSf_x:(CGFloat)sf_x {
    CGRect frame = self.frame;
    frame.origin.x = sf_x;
    self.frame = frame;
}

- (CGFloat)sf_x {
    return self.frame.origin.x;
}

- (void)setSf_y:(CGFloat)sf_y {
    CGRect frame = self.frame;
    frame.origin.y = sf_y;
    self.frame = frame;
}

- (CGFloat)sf_y {
    return self.frame.origin.y;
}

- (CGFloat)sf_width {
    return self.frame.size.width;
}

- (void)setSf_width:(CGFloat)sf_width {
    CGRect frame = self.frame;
    frame.size.width = sf_width;
    self.frame = frame;
}

- (CGFloat)sf_height {
    return self.frame.size.height;
}

- (void)setSf_height:(CGFloat)sf_height {
    CGRect frame = self.frame;
    frame.size.height = sf_height;
    self.frame = frame;
}

- (CGFloat)sf_bottom {
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setSf_bottom:(CGFloat)sf_bottom {
    CGRect frame = self.frame;
    frame.origin.y = sf_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)sf_tail {
    
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setSf_tail:(CGFloat)sf_tail {
    
    CGRect frame = self.frame;
    frame.origin.x = sf_tail - frame.size.width;
    self.frame = frame;
}
@end
