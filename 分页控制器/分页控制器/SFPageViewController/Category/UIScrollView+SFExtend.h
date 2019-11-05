//
//  UIScrollView+SFExtend.h
//  分页控制器
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (SFExtend)


/// 正在滚动
@property (nonatomic, copy) void (^sf_scrollViewDidScrollViewBlock)(UIScrollView *scrollView);

/// 开始拖拽
@property (nonatomic, copy) void (^sf_scrollViewWillBeginDraggingBlock)(UIScrollView *scrollView);

/// contentOffset
@property (nonatomic, assign) CGFloat contentOffsetY;

@end

NS_ASSUME_NONNULL_END
