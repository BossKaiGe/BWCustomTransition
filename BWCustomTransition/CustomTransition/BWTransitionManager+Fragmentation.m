//
//  BWTransitionManager+Fragmentation.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/4/3.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+Fragmentation.h"
#import "UIView+ScreenShot.h"
@implementation BWTransitionManager (Fragmentation)
-(CustomAnimationBlock)generateFragmentationAnimationWithDuration:(CGFloat)duration{
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *toView = toVC.view;
        UIView *fromView = fromVC.view;
        UIView *containerView = [transitionContext containerView];
        [containerView insertSubview:toView atIndex:0];
        CGSize size = toView.frame.size;
        NSMutableArray *snapshots = [NSMutableArray new];
        CGFloat xNum = 10.0f;
        CGFloat yNum = xNum * size.height / size.width;
        UIImage *fromImage = [fromView bw_capture];
        CGFloat fromWidth = fromVC.view.bounds.size.width;
        CGFloat fromHeight = fromVC.view.bounds.size.height;
        for (CGFloat x=0; x < size.width; x+= size.width / xNum) {
            for (CGFloat y=0; y < size.height; y+= size.height / yNum) {
                CGRect snapshotRegion = CGRectMake(x, y, size.width / xNum, size.height / yNum);
                UIView *snapshot = [UIView new];
                snapshot.layer.contents = (__bridge id _Nullable)(fromImage.CGImage);
                CGRect contentRect = CGRectMake(x / fromWidth, y / fromHeight, size.width / xNum / fromWidth, size.height / yNum / fromHeight);
                snapshot.layer.contentsRect = contentRect;
                snapshot.frame = snapshotRegion;
                [containerView addSubview:snapshot];
                [snapshots addObject:snapshot];
            }
        }
        fromView.hidden = YES;
        [UIView animateWithDuration:duration animations:^{
            for (UIView *view in snapshots) {
                CGFloat xOffset = [self bw_randomFloatBetween:-100.0 and:100.0];
                CGFloat yOffset = [self bw_randomFloatBetween:-100.0 and:100.0];
                view.frame = CGRectOffset(view.frame, xOffset, yOffset);
                view.alpha = 0.0;
                view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation([self bw_randomFloatBetween:-10.0 and:10.0]), 0.01, 0.01);
            }
        } completion:^(BOOL finished) {
            for (UIView *view in snapshots) {
                [view removeFromSuperview];
            }
            fromView.hidden = NO;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    };
}
- (float)bw_randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

@end
