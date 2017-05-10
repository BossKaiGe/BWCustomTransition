//
//  BWTransitionManager+FadeAndScale.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/6.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+FadeAndScale.h"

@implementation BWTransitionManager (FadeAndScale)
-(CustomAnimationBlock)generateFadeAndScaleAnimationWithDuration:(CGFloat)duration;{
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [[transitionContext containerView] addSubview:toViewController.view];
        toViewController.view.alpha = 0;
        CGAffineTransform transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:duration animations:^{
            fromViewController.view.transform = CGAffineTransformScale(transform, .1, .3);
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [toViewController.view removeFromSuperview];
            }
        }];
    };
}
@end
