//
//  SFPageScrollMenuView.m
//  分页控制器
//
//  Created by mac on 2019/10/30.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SFPageScrollMenuView.h"
#import "UIView+SFFrame.h"

@interface SFPageScrollMenuView ()<UITableViewDelegate>

/// 配置model
@property (nonatomic, strong) SFPageConfig *pageConfig;

/// 菜单栏的代理
@property (nonatomic, weak) id <SFPageScrollMenuViewDelegate> delegate;

/// 底部线条view
@property (nonatomic, strong) UIView *bottomLine;

/// item当前的位置
@property (nonatomic, assign) NSInteger currentIndex;

/// item上一个item的位置
@property (nonatomic, assign) NSInteger lastIndex;

/// 菜单栏的 scrollView
@property (nonatomic, strong) UIScrollView *menuScrollView;

/// 标题数组
@property (nonatomic, strong) NSMutableArray *titles;

/// 存储按钮的数组
@property (nonatomic, strong) NSMutableArray *itemBtnMArr;

/// 存储原始按钮的宽度数组
@property (nonatomic, strong) NSMutableArray *itemBtnWidthMArr;

/// 记录最大的item实际(没有加扩展宽度)的宽度
@property (nonatomic, assign) CGFloat itemMaxWidth;

@end

@implementation SFPageScrollMenuView

#pragma mark ---初始化---
- (instancetype)init
{
    self = [super init];
    if (self) {
        

        self.itemMaxWidth = 0;
    }
    return self;
}

/**
 初始化YNPageScrollMenuView
 
 @param frame 大小
 @param titles 标题
 @param configration 配置信息
 */
+ (instancetype)pagescrollMenuViewWithFrame:(CGRect)frame
                                     titles:(NSMutableArray *)titles
                               configration:(SFPageConfig *)configration delegate:(nonnull id<SFPageScrollMenuViewDelegate>)delegate currentIndex:(NSInteger)currentIndex{
    SFPageScrollMenuView *menuView = [[SFPageScrollMenuView alloc] init];
    menuView.titles = titles;
    menuView.pageConfig = configration;
    menuView.delegate = delegate;
    menuView.currentIndex = currentIndex;
    menuView.frame = frame;
    
    
    
    [menuView setupSubViews];
    [menuView setupOtherSubViews];
    
    return menuView;
}

#pragma mark ---私有方法---
- (void) setupSubViews {
    
    if (self.titles.count > 0) { // 数组个数大于0的时候创建按钮
        
        [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self setupItemBtn:itemBtn title:obj index:idx];
        }];
    }
}

/// 设置其他子视图
- (void) setupOtherSubViews {
    
    self.menuScrollView.frame = CGRectMake(0, 0, self.sf_width, self.sf_height);
    self.menuScrollView.backgroundColor = self.pageConfig.menuScrollViewBgColor;
    [self addSubview:self.menuScrollView];
    
    /// 设置所有按钮的frame
    __block CGFloat itemX = 0;
    __block CGFloat itemY = 0;
    __block CGFloat itemHeight = self.sf_height - self.pageConfig.bottomLineHeight;
    __block CGFloat itemWidth = 0;
    
    __block CGFloat itemMaxWidth = 0; // 最大的item的宽度
    [self.itemBtnMArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
    
        UIButton *itemBtn = (UIButton *)obj;
        
        if (self.pageConfig.isAllItemAverageMenum) {
            
            
            if (itemMaxWidth < itemBtn.sf_width) {
                
                itemMaxWidth = itemBtn.sf_width;
            }
            
        }else {
            
            if (idx == 0) {
                
                itemX += self.pageConfig.itemFirstAndEndMargin;
            }else {
                
                itemX += self.pageConfig.itemLeftMargin + [self.itemBtnWidthMArr[idx - 1] floatValue];
            }
            itemWidth = [self.itemBtnWidthMArr[idx] floatValue];
            itemBtn.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
        }
        
    }];
    
    // 如果平均分配的时候，就按照最大的按钮实际宽度 + 15为每一个的btn宽度
    if (self.pageConfig.isAllItemAverageMenum) {
        
        self.itemMaxWidth = itemMaxWidth;
        itemWidth = itemMaxWidth + self.pageConfig.itemExtendWidth;
        if (itemWidth*self.itemBtnMArr.count < self.sf_width) {
            
            itemWidth = self.sf_width/self.itemBtnMArr.count;
        }
        
        [self.itemBtnMArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            UIButton *itemBtn = (UIButton *)obj;
            itemX = itemWidth*idx;
            
            
            itemBtn.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
        }];
        
    }
    
    // 设置内部scrollView的contentSize
    UIButton *lastItemBtn = self.itemBtnMArr.lastObject;
    CGFloat scrollContentSizeWidth = lastItemBtn.sf_tail;
    if (self.pageConfig.isAllItemAverageMenum) {
        
        if (scrollContentSizeWidth > self.menuScrollView.sf_width) {
            
            self.menuScrollView.contentSize = CGSizeMake(scrollContentSizeWidth, self.menuScrollView.sf_height);
        }else {
            
            self.menuScrollView.contentSize = CGSizeMake(self.menuScrollView.sf_width, self.menuScrollView.sf_height);
        }
    }else {
        
        scrollContentSizeWidth += self.pageConfig.itemFirstAndEndMargin;
        if (scrollContentSizeWidth > self.menuScrollView.sf_width) {
            
            self.menuScrollView.contentSize = CGSizeMake(scrollContentSizeWidth, self.menuScrollView.sf_height);
        }else {
            
            self.menuScrollView.contentSize = CGSizeMake(self.menuScrollView.sf_width, self.menuScrollView.sf_height);
        }
    }
    
    
    
    
    // 设置底部线条
    if (self.pageConfig.isShowBottomLine) {
        
        CGFloat lineX = 0;
        CGFloat lineY = 0;
        CGFloat lineWidth = 0;
        CGFloat lineHeight = 0;
        
        if (self.pageConfig.isAllItemAverageMenum) {
            
            lineY = self.sf_height - self.pageConfig.bottomLineHeight;
            lineHeight = self.pageConfig.bottomLineHeight;
            
            
            lineWidth = itemMaxWidth + self.pageConfig.itemExtendWidth;
            if (lineWidth*self.itemBtnMArr.count < self.sf_width) {
                
                lineWidth = self.sf_width/self.itemBtnMArr.count;
            }
            
            lineX = itemWidth*self.currentIndex;
        }else {
            
            lineY = self.sf_height - self.pageConfig.bottomLineHeight;
            lineWidth = [self.itemBtnWidthMArr[self.currentIndex] floatValue];
            lineHeight = self.pageConfig.bottomLineHeight;
            lineX = [self getBottomLineView_X];
        }
        
        
        UIView *bottomLine = [UIView new];
        bottomLine.frame = CGRectMake(lineX, lineY, lineWidth, lineHeight);
        bottomLine.backgroundColor = self.pageConfig.bottomLineBgColor;
        self.bottomLine = bottomLine;
        [self.menuScrollView addSubview:bottomLine];
    }
    
    // 平移到中间位置
    if (self.pageConfig.isTranslationItemCenter) {
        
        [self translationItemToCenter];
    }
    
    // 设置最后一个位置
    self.lastIndex = self.currentIndex;
}

/// 设置btn
- (void) setupItemBtn:(UIButton *)itemBtn  title:(NSString *)title index:(NSInteger)index {
    
    [itemBtn setTitle:title forState:UIControlStateNormal];
    itemBtn.titleLabel.font = [UIFont systemFontOfSize:self.pageConfig.itemTitleFontNormal];
    if (index == self.currentIndex) {
        
        [itemBtn setTitleColor:self.pageConfig.itemTitleSelectColorNormal forState:UIControlStateNormal];
        itemBtn.transform = CGAffineTransformMakeScale(self.pageConfig.itemSelectMaxScale, self.pageConfig.itemSelectMaxScale);
    }else {
        
        [itemBtn setTitleColor:self.pageConfig.itemTitleColorNormal forState:UIControlStateNormal];
    }
    
    itemBtn.tag = index;
    [itemBtn addTarget:self action:@selector(itemBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [itemBtn sizeToFit]; // 按钮的frame适应文字
    [self.menuScrollView addSubview:itemBtn];
    
    /// 将添加了的按钮存储起来
    [self.itemBtnMArr addObject:itemBtn];
    
    /// 将按钮的宽度存储起来
    [self.itemBtnWidthMArr addObject:@(itemBtn.sf_width)];
}

/// 设置合适的item 位置和线条位置
- (void) adjustItemAnimate:(BOOL)animate {
    
    [UIView animateWithDuration:animate?0.3:0 animations:^{
       
        
        /// 标题颜色和缩放变化
        [self.itemBtnMArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            UIButton *itemBtn = (UIButton *)obj;
            if (idx == self.currentIndex) {
                
               [itemBtn setTitleColor:self.pageConfig.itemTitleSelectColorNormal forState:UIControlStateNormal];
                
                itemBtn.transform = CGAffineTransformMakeScale(self.pageConfig.itemSelectMaxScale, self.pageConfig.itemSelectMaxScale);
            }else {
                
                [itemBtn setTitleColor:self.pageConfig.itemTitleColorNormal forState:UIControlStateNormal];
                itemBtn.transform = CGAffineTransformMakeScale(1, 1);
            }
            
        }];
        
        // 线条位置设置
        if (self.pageConfig.isShowBottomLine) {
            
            
            UIButton *selectBtn = self.itemBtnMArr[self.currentIndex];
            
            CGFloat lineWidth = 0;
            CGFloat lineX = 0;

            if (self.pageConfig.isAllItemAverageMenum) {
                
                
                lineWidth = self.itemMaxWidth + self.pageConfig.itemExtendWidth;
                if (lineWidth*self.itemBtnMArr.count < self.sf_width) {
                    
                    lineWidth = self.sf_width/self.itemBtnMArr.count;
                }
                lineX = lineWidth*self.currentIndex;
            }else {
                
                lineWidth = selectBtn.sf_width; // 缩放后的宽
                lineX = selectBtn.sf_x; // 缩放后的X
            }
            
            self.bottomLine.sf_x = lineX;
            self.bottomLine.sf_width = lineWidth;
        }
        
        
        // 平移item到中间
        if (self.pageConfig.isTranslationItemCenter) {
         
            [self translationItemToCenter];
        }
        
    } completion:^(BOOL finished) {
        
    }];
}

/// 设置原始lieViewX的距离
- (CGFloat) getBottomLineView_X {
    
    __block CGFloat lineX = 0;
    if (self.currentIndex == 0) {
        
        lineX = self.pageConfig.itemFirstAndEndMargin;
    }else {
        
        [self.itemBtnWidthMArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx < self.currentIndex) {
                
                CGFloat itemWidth = [obj floatValue];
                
                lineX += self.pageConfig.itemLeftMargin + itemWidth;
            }
            
            
        }];
        lineX += self.pageConfig.itemFirstAndEndMargin;
    }
    return lineX;
}

/// 平移item到中间
- (void) translationItemToCenter {
 
    if (self.menuScrollView.contentSize.width > self.menuScrollView.sf_width) {
        
        UIButton *currentBtn = self.itemBtnMArr[self.currentIndex];
        CGFloat itemCenter_X = currentBtn.center.x;
        CGFloat scrollViewContentSizeWidth = self.menuScrollView.contentSize.width;
        
        CGFloat translateWidth = itemCenter_X - self.menuScrollView.sf_width/2.0;
        if (translateWidth <= 0) {
            
            self.menuScrollView.contentOffset = CGPointMake(0, 0);
        }else if (translateWidth >= scrollViewContentSizeWidth - self.menuScrollView.sf_width) {
            
            self.menuScrollView.contentOffset = CGPointMake(scrollViewContentSizeWidth - self.menuScrollView.sf_width, 0);
        }else {
            
            self.menuScrollView.contentOffset = CGPointMake(translateWidth, 0);
        }
        
    }
    
}

#pragma mark ---外部接口---
/// 选中下标
- (void)selectedItemIndex:(NSInteger)index
                 animated:(BOOL)animated {
    
    self.lastIndex = self.currentIndex;
    self.currentIndex = index;
    [self adjustItemAnimate:animated];
}

#pragma mark ---按钮的点击方法---
- (void) itemBtnAction:(UIButton *)sender {
    
    self.lastIndex = self.currentIndex;
    self.currentIndex = sender.tag;
    [self adjustItemAnimate:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sfScrollMenuViewItemOnClick:index:)]) {
        
        [self.delegate sfScrollMenuViewItemOnClick:sender index:self.currentIndex];
    }
}


#pragma mark ---懒加载---
- (NSMutableArray *)titles {
    
    if (!_titles) {
        
        _titles = [NSMutableArray new];
    }
    return _titles;
}

- (UIScrollView *)menuScrollView {
    
    if (!_menuScrollView) {
        
        _menuScrollView = [[UIScrollView alloc] init];
        _menuScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _menuScrollView;
}

- (NSMutableArray *)itemBtnMArr {
    
    if (!_itemBtnMArr) {
        
        _itemBtnMArr = [NSMutableArray new];
    }
    return _itemBtnMArr;
}

- (NSMutableArray *)itemBtnWidthMArr {
    
    if (!_itemBtnWidthMArr) {
        
        _itemBtnWidthMArr = [NSMutableArray new];
    }
    return _itemBtnWidthMArr;
}
@end
