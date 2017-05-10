//
//  BWCustomTransitionDelegate.m
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/4.
//  Copyright © 2016年 BossKai. All rights reserved.
//
#import "BWCustomTransitionDelegate.h"
#import "BWCustomAnimation.h"
#import "UINavigationController+animationBlock.h"
#import "BWPercentDrivenInteractiveTransition.h"
#import <UIKit/UIKit.h>
#define AppSharedInstance			((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface BWCustomTransitionDelegate()
@property(nonatomic,strong) BWPercentDrivenInteractiveTransition * interactionController;
@end
@implementation BWCustomTransitionDelegate
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static  BWCustomTransitionDelegate *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[BWCustomTransitionDelegate alloc]init];
    });
    return instance;
}
#pragma mark:BWPercentDrivenInteractiveTransitionDelegate
-(void)bw_percentDrivenInteractiveTransitionWillBegin:(BWPercentDrivenInteractiveTransition *)transition{
    self.interactionController = transition;
}
-(void)bw_percentDrivenInteractiveTransitionWillEnd:(BWPercentDrivenInteractiveTransition *)transition{
    self.interactionController = nil;
}
#pragma mark:vc
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[BWCustomAnimation alloc]initWithAnimationType:CustomAnimationType_Present];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [[BWCustomAnimation alloc]initWithAnimationType:CustomAnimationType_Dismiss];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return self.interactionController;
}
#pragma mark:nav
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{

    return self.interactionController;
}
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        return [[BWCustomAnimation alloc]initWithAnimationType:(CustomAnimationType_Push)];
    }else if (operation == UINavigationControllerOperationPop){
        return [[BWCustomAnimation alloc]initWithAnimationType:(CustomAnimationType_Pop)];
    }
    return nil;
}
@end
