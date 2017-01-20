//
//  UITabBarController+animationBlock.m
//  BWCustomTransition
//
//  Created by 静静静 on 16/10/9.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import "UITabBarController+animationBlock.h"
#import "BWTransitionManager.h"
#import <objc/runtime.h>
static NSString * const kTransitionManager = @"kTransitionManager";
static NSString * const kInitializeBlock = @"kInitializeBlock";
@implementation UITabBarController (animationBlock)
@dynamic manager;
@dynamic initializeBlock;

#pragma mark:properties
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
