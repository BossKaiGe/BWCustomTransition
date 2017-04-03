//
//  BWTransitionManager+DotSpread.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/16.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+DotSpread.h"
static NSString * const kDotView = @"kDotView";
@implementation BWTransitionManager (DotSpread)
@dynamic dotView;
-(CustomAnimationBlock)generateDotSpreadInAnimationWithDuration:(CGFloat)duration{
    BW_WeakSelf(ws);
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView * containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        UIBezierPath *startPath =  [UIBezierPath bezierPathWithArcCenter:ws.dotView.center radius:ws.dotView.frame.size.width / 2.0 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        CGFloat x = ws.dotView.center.x;
        CGFloat y = ws.dotView.center.y;
        CGFloat endX = MAX(x, containerView.frame.size.width - x);
        CGFloat endY = MAX(y, containerView.frame.size.height - y);
        CGFloat endRadius = sqrtf(pow(endX, 2) + pow(endY, 2));
        UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:ws.dotView.center radius:endRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = endPath.CGPath;
        toView.layer.mask = maskLayer;
        CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
        maskLayerAnimation.toValue = (__bridge id)((endPath.CGPath));
        maskLayerAnimation.duration = duration;
        maskLayerAnimation.delegate = self;
        [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
        [maskLayer addAnimation:maskLayerAnimation forKey:nil];
    };
}
-(CustomAnimationBlock)generateDotSpreadOutAnimationWithDuration:(CGFloat)duration{
    BW_WeakSelf(ws);
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView * containerView = [transitionContext containerView];
        [containerView insertSubview:toView belowSubview:fromView];
        UIBezierPath *endPath =  [UIBezierPath bezierPathWithArcCenter:ws.dotView.center radius:ws.dotView.frame.size.width/2.0 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        CAShapeLayer *maskLayer = (CAShapeLayer *)fromView.layer.mask;
        UIBezierPath * startPath = [UIBezierPath bezierPathWithCGPath:maskLayer.path] ;
        maskLayer.path = (__bridge CGPathRef _Nullable)(startPath);
        CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
        maskLayerAnimation.toValue = (__bridge id)((endPath.CGPath));
        maskLayerAnimation.duration = duration;
        maskLayerAnimation.delegate = self;
        maskLayerAnimation.removedOnCompletion = YES;
        maskLayerAnimation.fillMode = kCAFillModeBackwards;
        [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
        [maskLayer addAnimation:maskLayerAnimation forKey:nil];
    };
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
    CABasicAnimation * basicAnima = (CABasicAnimation *)anim;
//    UIView * containerView = [transitionContext containerView];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CAShapeLayer * maskLayer = (CAShapeLayer *)fromView.layer.mask;
        if ([transitionContext transitionWasCancelled]) {
            maskLayer.path = (__bridge CGPathRef _Nullable)(basicAnima.fromValue);
        }else{
            maskLayer.path = (__bridge CGPathRef _Nullable)(basicAnima.toValue);
        }
    });

    NSLog(@"animationDidStop");
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
}

#pragma mark:propertys
-(UIView *)dotView{
    return objc_getAssociatedObject(self, (__bridge const void *)(kDotView));
}
-(void)setDotView:(UIView *)dotView{
    objc_setAssociatedObject(self, (__bridge const void *)(kDotView), dotView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
