//
//  BWCustomPopAnimation.m
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/4.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import "BWCustomAnimation.h"
#import "UINavigationController+animationBlock.h"
#import "UITabBarController+animationBlock.h"
#import "BWCustomTransitionDelegate.h"
#import "UIViewController+animationBlock.h"
@interface BWCustomAnimation()
@property(nonatomic,assign)CustomAnimationType animationType;
@end

@implementation BWCustomAnimation
-(instancetype)initWithAnimationType:(CustomAnimationType)animationType{
    self = [super init];
    if (self) {
        self.animationType = animationType;
    }
    return self;
}
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    switch (self.animationType) {
        case CustomAnimationType_Push:
            return fromVC.navigationController.manager.transitionDuration_StackIn;
            break;
        case CustomAnimationType_Pop:
            return fromVC.navigationController.manager.transitionDuration_StackOut;
            break;
        case CustomAnimationType_Present:
            return toVC.manager.transitionDuration_StackIn;
            break;
        case CustomAnimationType_Dismiss:
            return fromVC.manager.transitionDuration_StackOut;
            break;
        case CustomAnimationType_TabBar:
            return fromVC.tabBarController.manager.transitionDuration_TabTransition;
        default:
            break;
    }
    return 0;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    switch (self.animationType) {
        case CustomAnimationType_Push:
            fromVC.navigationController.manager.stackInBlock(transitionContext);
            break;
        case CustomAnimationType_Pop:
            fromVC.navigationController.manager.stackOutBlock(transitionContext);
            break;
        case CustomAnimationType_Present:
            toVC.manager.stackInBlock(transitionContext);
            break;
        case CustomAnimationType_Dismiss:
            fromVC.manager.stackOutBlock(transitionContext);
            break;
        case CustomAnimationType_TabBar:
            fromVC.tabBarController.manager.tabTransitionBlock(transitionContext);
        default:
            break;
    }
}
@end
