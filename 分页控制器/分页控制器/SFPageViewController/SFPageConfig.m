//
//  SFPageConfig.m
//  分页控制器
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SFPageConfig.h"

@implementation SFPageConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.currentIndex = 0;
        
        self.menuHeight = 50;
        self.menuWidth = [UIScreen mainScreen].bounds.size.width;
        
        self.isTranslationItemCenter = NO;
        self.itemSelectMaxScale = 1;
        self.itemTitleSelectColorNormal = [UIColor redColor];
        self.itemTitleFontNormal = 13;
        self.isShowBottomLine = YES;
        self.isAllItemAverageMenum = NO;
        self.itemExtendWidth = 15;
        self.menuScrollViewBgColor = [UIColor whiteColor];
        self.itemTitleColorNormal = [UIColor blackColor];
        self.itemLeftMargin = 15;
        self.itemFirstAndEndMargin = 15;
        self.bottomLineHeight = 1;
        self.bottomLineBgColor = [UIColor redColor];
        
        
        self.pageScrollViewWidth = [UIScreen mainScreen].bounds.size.width;
        self.pageScrollViewHeight = [UIScreen mainScreen].bounds.size.height - 50;
    }
    return self;
}

@end
