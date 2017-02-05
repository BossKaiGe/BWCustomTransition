//
//  BWTransitionManager+PageOut.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/8.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+PageOut.h"

@implementation BWTransitionManager (PageOut)
-(CustomAnimationBlock)generatePageOutAnimationWithDuration:(CGFloat)duration{
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIViewController* toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *toView = toVC.view;
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        [containerView bringSubviewToFront:toView];
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -0.002;
        containerView.layer.sublayerTransform = transform;
        toView.alpha = 1;
        toView.layer.anchorPoint = CGPointMake(0.0, 0.5);
        toView.layer.position    = CGPointMake(0, CGRectGetMidY([UIScreen mainScreen].bounds));
        toView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1.0, 0);

        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = toView.bounds;
        gradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor,
                            (id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor];
        gradient.startPoint = CGPointMake(0.0, 0.5);
        gradient.endPoint = CGPointMake(0.8, 0.5);
        UIView *shadow = [[UIView alloc]initWithFrame:toView.bounds];
        shadow.backgroundColor = [UIColor clearColor];
        [shadow.layer insertSublayer:gradient atIndex:1];
        shadow.alpha = 0.0;
        [toView addSubview:shadow];
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toView.layer.transform = CATransform3DMakeRotation(0, 0, 1.0, 0);
            shadow.alpha = 1.0;
        } completion:^(BOOL finished) {
                //7
            toView.layer.transform = CATransform3DIdentity;
            toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            toView.layer.position    = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
            toView.layer.transform = CATransform3DIdentity;
            [shadow removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    };
}


@end
