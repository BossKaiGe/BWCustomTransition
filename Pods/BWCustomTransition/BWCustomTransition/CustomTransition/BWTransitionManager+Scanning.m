//
//  BWTransitionManager+Scanning.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/3/18.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+Scanning.h"
static NSString * const kScanImg = @"kScanImg";
@implementation BWTransitionManager (Scanning)
@dynamic scanImg;
-(CustomAnimationBlock)generateScanningAnimationWithDuration:(CGFloat)duration withOrientation:(BWScanningOrientation)orientation{
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView * containerView = [transitionContext containerView];
        [containerView insertSubview:toView atIndex:0];
        UIView * maskView = [[UIView alloc]initWithFrame:containerView.bounds];
        maskView.backgroundColor = [UIColor whiteColor];
        UIView * scanView = [[UIView alloc]init];
        if (self.scanImg) {
            scanView.layer.contents = (__bridge id _Nullable)([self.scanImg CGImage]);
        }else{
            scanView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"line"].CGImage);
        }
        fromView.maskView = maskView;
        [containerView addSubview:scanView];
        CGFloat width = containerView.frame.size.width;
        CGFloat height = containerView.frame.size.height;
        CGAffineTransform transfrom = CGAffineTransformIdentity;
        switch (orientation) {
            case BWScanningOrientation_left:
                scanView.bounds = CGRectMake(0, 0, 18, height * 1.5);
                scanView.center = CGPointMake(-4, containerView.center.y);
                transfrom = CGAffineTransformMakeTranslation(width, 0);
                break;
            case BWScanningOrientation_right:
                scanView.bounds = CGRectMake(0, 0, 18, height * 1.5);
                scanView.center = CGPointMake(width + 4, containerView.center.y);
                transfrom = CGAffineTransformMakeTranslation(-width, 0);
                break;
            case BWScanningOrientation_up:
                scanView.bounds = CGRectMake(0, 0,width * 1.5, 18);
                scanView.center = CGPointMake(containerView.center.x, -4);
                transfrom = CGAffineTransformMakeTranslation(0, height);
                break;
            case BWScanningOrientation_down:
                scanView.bounds = CGRectMake(0, 0,width * 1.5, 18);
                scanView.center = CGPointMake(containerView.center.x,height + 4);
                transfrom = CGAffineTransformMakeTranslation(0, -height);
                break;
            default:
                break;
        }
        [UIView animateWithDuration:duration animations:^{
            maskView.transform = transfrom;
            scanView.transform = transfrom;
        }completion:^(BOOL finished) {
            fromView.maskView = nil;
            [scanView removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [toView removeFromSuperview];
            }
        }];
    };
}
#pragma mark:propertys
-(UIImage *)scanImg{
    return objc_getAssociatedObject(self, (__bridge const void *)(kScanImg));
}
-(void)setScanImg:(UIImage *)scanImg{
    objc_setAssociatedObject(self, (__bridge const void *)(kScanImg), scanImg, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
