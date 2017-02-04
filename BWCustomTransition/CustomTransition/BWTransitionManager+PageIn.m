//
//  BWTransitionManager+PageIn.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/8.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+PageIn.h"


@implementation BWTransitionManager (PageIn)

-(CustomAnimationBlock)generatePageInAnimationWithDuration:(CGFloat)duration{
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIView *fromView = fromVC.view;
        UIView *toView = toVC.view;
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        [containerView sendSubviewToBack:toView];
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -0.003;
        containerView.layer.sublayerTransform = transform;
        fromView.layer.anchorPoint = CGPointMake(0.0, 0.5);
        fromView.layer.position    = CGPointMake(0, CGRectGetMidY([UIScreen mainScreen].bounds));
        
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //旋转fromView 90度
            fromView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1.0, 0);
//            shadow.alpha = 1.0;
        } completion:^(BOOL finished) {
            fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            fromView.layer.position    = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
            fromView.layer.transform = CATransform3DIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    };
}

@end
