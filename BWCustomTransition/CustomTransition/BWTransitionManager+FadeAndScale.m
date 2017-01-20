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
        
        [UIView animateWithDuration:duration animations:^{
            fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    };
}
@end
