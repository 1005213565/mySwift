//
//  UIScrollView+SFExtend.m
//  分页控制器
//
//  Created by mac on 2019/11/1.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIScrollView+SFExtend.h"
#import <objc/runtime.h>

static NSString *isScrollRightDirectionKey = @"isScrollRightDirectionKey";
static NSString *beginOffsetXKey = @"beginOffsetXKey";
static NSString *sf_delegateKey = @"sf_delegateKey";


@implementation UIScrollView (SFExtend)



//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
////        [self swizzleInstanceMethod:NSSelectorFromString(@"setDelegate:") withMethod:@selector(sf_setDelegate:)];
//    });
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    NSLog(@"哈啊");
//}
//
//
//- (void) sf_setDelegate:(id<UIScrollViewDelegate>)delegate {
//
//    self.sf_delegate = delegate;
//
//
////    [self swizzleInstanceMethod:NSSelectorFromString(@"scrollViewDidScroll:") withMethod:@selector(sf_scrollViewDidScrollView:)];
////    [self swizzleInstanceMethod:NSSelectorFromString(@"scrollViewWillBeginDragging:") withMethod:@selector(sf_scrollViewWillBeginDragging:)];
//
//
//    SEL oldSelector = @selector(scrollViewDidScroll:);
//    SEL newSelector = @selector(sf_scrollViewDidScrollView:);
//    Method oldMethod_del = class_getInstanceMethod([delegate class], oldSelector);
//    Method oldMethod_self = class_getInstanceMethod([self class], oldSelector);
//    Method newMethod = class_getInstanceMethod([self class], newSelector);
//
//    // 若未实现代理方法，则先添加代理方法
//    BOOL isSuccess = class_addMethod([delegate class], oldSelector, class_getMethodImplementation([self class], newSelector), method_getTypeEncoding(newMethod));
//    if (isSuccess) {
//        class_replaceMethod([delegate class], newSelector, class_getMethodImplementation([self class], oldSelector), method_getTypeEncoding(oldMethod_self));
//    } else {
//        // 若已实现代理方法，则添加 hook 方法并进行交换
//        BOOL isVictory = class_addMethod([delegate class], newSelector, class_getMethodImplementation([delegate class], oldSelector), method_getTypeEncoding(oldMethod_del));
//        if (isVictory) {
//            class_replaceMethod([delegate class], oldSelector, class_getMethodImplementation([self class], newSelector), method_getTypeEncoding(newMethod));
//        }
//    }
//
//    [self sf_setDelegate:delegate];
//}
//
//- (void)sf_scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//
//    self.beginOffsetX = scrollView.contentOffset.x;
//    [self sf_scrollViewWillBeginDragging:scrollView];
//}
//
//- (void)sf_scrollViewDidScrollView:(UIScrollView *)scrollView {
//
//    self.beginOffsetX = 0;
//    if (self.beginOffsetX > scrollView.contentOffset.x) {
//
//        self.isScrollRightDirection = YES;
//    }else {
//
//        self.isScrollRightDirection = NO;
//    }
//    [self sf_scrollViewDidScrollView:scrollView];
//}
//
//
//- (void)setIsScrollRightDirection:(BOOL)isScrollRightDirection {
//
//    objc_setAssociatedObject(self, &isScrollRightDirectionKey, [NSNumber numberWithBool:isScrollRightDirection], OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (BOOL)isScrollRightDirection {
//
//    return [objc_getAssociatedObject(self, &isScrollRightDirectionKey) boolValue];
//}
//
////- (void)setBeginOffsetX:(CGFloat)beginOffsetX {
////
////    objc_setAssociatedObject(self, &beginOffsetXKey, [NSNumber numberWithFloat:beginOffsetX], OBJC_ASSOCIATION_ASSIGN);
////}
////
////- (CGFloat)beginOffsetX {
////
////    return [objc_getAssociatedObject(self, &beginOffsetXKey) floatValue];
////}
//
//- (void)setSf_delegate:(id<UIScrollViewDelegate>)sf_delegate {
//
//    objc_setAssociatedObject(self, &sf_delegateKey, sf_delegate, OBJC_ASSOCIATION_ASSIGN);
//}
//
//- (id<UIScrollViewDelegate>)sf_delegate {
//
//    return objc_getAssociatedObject(self, &sf_delegateKey);
//}
//#pragma mark ---Swizzle---
//+ (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector {
//    Class cls = [self class];
//    Method originalMethod = class_getInstanceMethod(cls, origSelector);
//    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
//    if (class_addMethod(cls,
//                        origSelector,
//                        method_getImplementation(swizzledMethod),
//                        method_getTypeEncoding(swizzledMethod)) ) {
//        class_replaceMethod(cls,
//                            newSelector,
//                            method_getImplementation(originalMethod),
//                            method_getTypeEncoding(originalMethod));
//
//    } else {
//        class_replaceMethod(cls,
//                            newSelector,
//                            class_replaceMethod(cls,
//                                                origSelector,
//                                                method_getImplementation(swizzledMethod),
//                                                method_getTypeEncoding(swizzledMethod)),
//                            method_getTypeEncoding(originalMethod));
//    }
//}
//
//- (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector {
//    Class cls = [self.delegate class];
//    Method originalMethod = class_getInstanceMethod(cls, origSelector);
//    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
//    if (class_addMethod(cls,
//                        origSelector,
//                        method_getImplementation(swizzledMethod),
//                        method_getTypeEncoding(swizzledMethod)) ) {
//        class_replaceMethod(cls,
//                            newSelector,
//                            method_getImplementation(originalMethod),
//                            method_getTypeEncoding(originalMethod));
//
//    } else {
//        class_replaceMethod(cls,
//                            newSelector,
//                            class_replaceMethod(cls,
//                                                origSelector,
//                                                method_getImplementation(swizzledMethod),
//                                                method_getTypeEncoding(swizzledMethod)),
//                            method_getTypeEncoding(originalMethod));
//    }
//}
@end
