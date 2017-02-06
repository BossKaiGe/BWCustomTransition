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
    UIView * view = recognizer.view;
    CGPoint location = [recognizer translationInView:view];
 
    CGFloat percent = location.x/CGRectGetMaxX(view.bounds);
    NSLog(@"%f",percent);
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"start");
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc]init];
        if (vc.presentingViewController) {
            [vc dismissViewControllerAnimated:YES completion:nil];
        }else if (vc.navigationController.viewControllers.count >= 2) {
            [vc.navigationController popViewControllerAnimated:YES];
        }
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        if (percent > 0) {
            [self.interactionController updateInteractiveTransition:percent];
        }
    }else if (recognizer.state == UIGestureRecognizerStateEnded){
        if (percent >.5) {
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
