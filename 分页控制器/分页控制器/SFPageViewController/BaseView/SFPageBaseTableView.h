//
//  SFPageBaseTableView.h
//  分页控制器
//
//  Created by fly on 2019/11/3.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFPageBaseTableView : UITableView

/*! 是否支持多个手势  */
@property (nonatomic, assign) BOOL isSupportMultipleGesture;

@property (nonatomic, assign) BOOL canScroll;
@end
