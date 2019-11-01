//
//  UIView+SFFrame.h
//  分页控制器
//
//  Created by mac on 2019/10/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SFFrame)

@property (nonatomic, assign) CGFloat sf_x;

@property (nonatomic, assign) CGFloat sf_y;

@property (nonatomic, assign) CGFloat sf_width;

@property (nonatomic, assign) CGFloat sf_height;

@property (nonatomic, assign) CGFloat sf_bottom;

@property (nonatomic, assign) CGFloat sf_tail;

@end

NS_ASSUME_NONNULL_END
