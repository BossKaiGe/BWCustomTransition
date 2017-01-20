//
//  UIViewController+animationBlock.m
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/4.
//  Copyright © 2016年 BossKai. All rights reserved.
//
#import <objc/runtime.h>
#import "UINavigationController+animationBlock.h"
#import "BWCustomTransitionDelegate.h"


static NSString * const kTransitionManager = @"kTransitionManager";
static NSString * const kInitializeBlock = @"kInitializeBlock";
@implementation UINavigationController (animationBlock)
@dynamic manager;
@dynamic initializeBlock;

#pragma mark:properties
-(void)resignTransition{
    self.delegate = self.manager.originDelegate;
    self.manager = nil;
}
-(InitializeBlock)initializeBlock{
    return objc_getAssociatedObject(self, (__bridge const void *)(kInitializeBlock));
}
-(void)setInitializeBlock:(InitializeBlock)initializeBlock{
    objc_setAssociatedObject(self, (__bridge const void *)(kInitializeBlock), initializeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.manager = [[BWTransitionManager alloc]init];
    initializeBlock(self.manager);
    [self.manager generateAnimation];
    self.delegate = self.manager;
}
-(BWTransitionManager *)manager{
    return objc_getAssociatedObject(self, (__bridge const void *)(kTransitionManager));
}
-(void)setManager:(BWTransitionManager *)manager{
    objc_setAssociatedObject(self, (__bridge const void *)(kTransitionManager), manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
