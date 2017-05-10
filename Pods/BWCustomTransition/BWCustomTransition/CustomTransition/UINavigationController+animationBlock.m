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
@implementation UINavigationController (animationBlock)
#pragma mark:properties
+(void)load{
    [self bw_swizzleMethod:@selector(bw_pushViewController:animated:) withClass:self withMethod:@selector(pushViewController:animated:) error:nil];
    [self bw_swizzleMethod:@selector(bw_popViewControllerAnimated:) withClass:self withMethod:@selector(popViewControllerAnimated:) error:nil];
}
-(void)bw_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController.manager) {
        self.delegate = viewController.manager;
    }
    [self bw_pushViewController:viewController animated:animated];
}
-(UIViewController *)bw_popViewControllerAnimated:(BOOL)animated{
    NSLog(@"bw_popViewControllerAnimated");
    UIViewController * poppedController = [self bw_popViewControllerAnimated:animated];
    if (poppedController.manager.originDelegate) {
        self.delegate = poppedController.manager.originDelegate;
    }else{
        self.delegate = nil;
    }
    return poppedController;
}

@end
