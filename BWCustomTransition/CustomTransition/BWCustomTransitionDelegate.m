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
#import "UITabBarController+animationBlock.h"
#import <UIKit/UIKit.h>
#define AppSharedInstance			((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface BWCustomTransitionDelegate()
@property(nonatomic,strong) UIPercentDrivenInteractiveTransition * interactionController;
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
#pragma mark:tabBar
- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC{
    return [[BWCustomAnimation alloc]initWithAnimationType:CustomAnimationType_TabBar];
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
-(void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)recognizer withController:(UIViewController *)vc{
    static CGFloat startLocation = 0.0;
    
    UIView * view = recognizer.view;
    CGPoint location = [recognizer locationInView:vc.view.window];
    CGFloat distance;
    if (startLocation != 0.0) {
        distance = location.x - startLocation;
    }else{
        distance = 0.0;
    }
    CGFloat percent = distance/CGRectGetMaxX(view.bounds);
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (location.x >  10) {
            NSLog(@"start");
            startLocation = location.x;
            self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
            if (vc.presentingViewController) {
                [vc dismissViewControllerAnimated:YES completion:nil];
            }else if (vc.navigationController.viewControllers.count >= 2) {
                [vc.navigationController popViewControllerAnimated:YES];
            }
        }
     
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        NSLog(@"%f",distance);
        if (distance > 0) {
            NSLog(@"%f",percent);
            [self.interactionController updateInteractiveTransition:percent];
        }

    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        CGFloat percent = distance/CGRectGetMaxX(view.bounds);
        if (distance > 0 && percent >.5) {
            [self.interactionController finishInteractiveTransition];
        }else{
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }

}
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
