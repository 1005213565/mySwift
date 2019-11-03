//
//  UIScrollView+SFExtend.h
//  分页控制器
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (SFExtend)<UIScrollViewDelegate>

///// 是否向右滚动    向右：YES    向左：NO
//@property (nonatomic, assign) BOOL isScrollRightDirection;
//
///// 开始拖拽的X位置
//@property (nonatomic, assign) CGFloat beginOffsetX;
//
//@property (nonatomic, weak) id<UIScrollViewDelegate> sf_delegate;
@end

NS_ASSUME_NONNULL_END
