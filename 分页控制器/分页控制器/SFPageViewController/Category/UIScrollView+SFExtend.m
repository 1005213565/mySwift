//
//  UIScrollView+SFExtend.m
//  分页控制器
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIScrollView+SFExtend.h"
#import <objc/runtime.h>

static NSString *sf_scrollViewDidScrollViewBlockKey = @"sf_scrollViewDidScrollViewBlockKey";
static NSString *sf_scrollViewWillBeginDraggingBlockKey = @"sf_scrollViewWillBeginDraggingBlockKey";


@implementation UIScrollView (SFExtend)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:NSSelectorFromString(@"_notifyDidScroll") withMethod:@selector(sf_scrollViewDidScrollView)];
        [self swizzleInstanceMethod:NSSelectorFromString(@"_scrollViewWillBeginDragging") withMethod:@selector(sf_scrollViewWillBeginDragging)];
    });
}

- (void)sf_scrollViewDidScrollView {
    [self sf_scrollViewDidScrollView];

    if (self.sf_scrollViewDidScrollViewBlock) {
        
        self.sf_scrollViewDidScrollViewBlock(self);
    }
}



- (void)sf_scrollViewWillBeginDragging {
    [self sf_scrollViewWillBeginDragging];

    if (self.sf_scrollViewWillBeginDraggingBlock) {
        
        self.sf_scrollViewWillBeginDraggingBlock(self);
    }
}

#pragma mark ---属性绑定---
- (void)setSf_scrollViewDidScrollViewBlock:(void (^)(UIScrollView * _Nonnull))sf_scrollViewDidScrollViewBlock {
    
    objc_setAssociatedObject(self, &sf_scrollViewDidScrollViewBlockKey, sf_scrollViewDidScrollViewBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIScrollView * _Nonnull))sf_scrollViewDidScrollViewBlock {
    
    return objc_getAssociatedObject(self, &sf_scrollViewDidScrollViewBlockKey);
}

- (void)setSf_scrollViewWillBeginDraggingBlock:(void (^)(UIScrollView * _Nonnull))sf_scrollViewWillBeginDraggingBlock {
    
    objc_setAssociatedObject(self, &sf_scrollViewWillBeginDraggingBlock, sf_scrollViewWillBeginDraggingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIScrollView * _Nonnull))sf_scrollViewWillBeginDraggingBlock {
    
    return objc_getAssociatedObject(self, &sf_scrollViewWillBeginDraggingBlockKey);
}

#pragma mark -- set方法---
- (void)sf_setContentOffsetY:(CGFloat)offsetY {
    if (self.contentOffset.y != offsetY) {
        self.contentOffset = CGPointMake(0, offsetY);
    }
}

#pragma mark ---get方法---
- (CGFloat) contentOffsetY {
    
    return self.contentOffset.y;
}


#pragma mark ---Swizzle---
+ (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    Class cls = [self class];
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    if (class_addMethod(cls,
                        origSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));

    } else {
        class_replaceMethod(cls,
                            newSelector,
                            class_replaceMethod(cls,
                                                origSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

@end
