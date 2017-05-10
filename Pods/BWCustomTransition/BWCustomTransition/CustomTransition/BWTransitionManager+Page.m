//
//  BWTransitionManager+Page.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/8.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+Page.h"
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5
@implementation BWTransitionManager (Page)

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
        transform.m34 = -0.002;
        containerView.layer.sublayerTransform = transform;
        [fromView bw_setAnchorPointTo:CGPointMake(0.0, 0.5)];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = fromView.bounds;
        gradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor,
                            (id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor];
        gradient.startPoint = CGPointMake(0.0, 0.5);
        gradient.endPoint = CGPointMake(0.8, 0.5);
        UIView *shadow = [[UIView alloc]initWithFrame:fromView.bounds];
        shadow.backgroundColor = [UIColor clearColor];
        [shadow.layer insertSublayer:gradient atIndex:1];
        shadow.alpha = 0.0;
        [fromView addSubview:shadow];
        
        
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            //旋转fromView 90度
            fromView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1.0, 0);
            shadow.alpha = 1.0;
        } completion:^(BOOL finished) {
            fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            fromView.layer.position    = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
            fromView.layer.transform = CATransform3DIdentity;
            [shadow removeFromSuperview];

            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [toView removeFromSuperview];
            }
        }];
    };
}
-(CustomAnimationBlock)generatePageOutAnimationWithDuration:(CGFloat)duration{
    BW_WeakSelf(ws);
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
        [toView bw_setAnchorPointTo:CGPointMake(0.0, 0.5)];

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
        shadow.alpha = 1.0;
        [toView addSubview:shadow];
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            toView.layer.transform = CATransform3DMakeRotation(0, 0, 1.0, 0);
            [ws applyLightingToFace:toView.layer];
            shadow.alpha = 0.0;
        } completion:^(BOOL finished) {
            toView.layer.transform = CATransform3DIdentity;
            toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
            toView.layer.position    = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
            toView.layer.transform = CATransform3DIdentity;
            [shadow removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [toView removeFromSuperview];
            }
        }];
    };
}
- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

@end
