//
//  BWTransitionManager+Mid_page.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/24.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+Mid_page.h"
#import "UIView+ScreenShot.h"
@implementation BWTransitionManager (Mid_page)
-(CustomAnimationBlock)generateMid_pageAnimationWithDuration:(CGFloat)duration withOrientation:(BWMid_pageOrientation)orientation{
    BW_WeakSelf(ws);
       return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView * containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        [containerView sendSubviewToBack:toView];
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -0.002;
        containerView.layer.sublayerTransform = transform;
        NSArray * toSnapShotView = [ws snapShotViewFor:toView withOrientation:orientation];

        NSArray * fromSnapShotView = [ws snapShotViewFor:fromView withOrientation:orientation];

        UIView *  fromAnimationView;
        UIView *  toAniamtionView;
        CGFloat rotation_Angle;
        CGFloat rotation_x;
        CGFloat rotation_y;
        
        [self configurationRotation_Angle:&rotation_Angle rotation_x:&rotation_x rotation_y:&rotation_y fromAnimationView:&fromAnimationView toAniamtionView:&toAniamtionView withFromSnapShotView:fromSnapShotView withToSnapShotView:toSnapShotView andOrientation:orientation];

        toAniamtionView.layer.transform = CATransform3DMakeRotation(rotation_Angle, rotation_x, rotation_y, 0);
       
        [UIView animateKeyframesWithDuration:duration delay:0.0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
                fromAnimationView.layer.transform = CATransform3DMakeRotation(-rotation_Angle, rotation_x, rotation_y, 0);
                UIView *shadowView = fromAnimationView.subviews.lastObject;
                shadowView.alpha = 1.0;
            }];
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:1 animations:^{
                toAniamtionView.layer.transform = CATransform3DMakeRotation(rotation_Angle > 0 ? 0.01 : - 0.01, rotation_x, rotation_y, 0);
                UIView *shadowView = toAniamtionView.subviews.lastObject;
                shadowView.alpha = 0.0;
            }];
        } completion:^(BOOL finished) {
            [fromSnapShotView makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [toSnapShotView makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
  
    };
}

-(void)configurationRotation_Angle:(CGFloat *)angle rotation_x:(CGFloat *)rotation_x rotation_y:(CGFloat *)rotation_y fromAnimationView:(UIView **)fromAnimationView toAniamtionView:(UIView **)toAniamtionView withFromSnapShotView:(NSArray *)fromSnapShotView withToSnapShotView:(NSArray *)toSnapShotView andOrientation:(BWMid_pageOrientation)orientation{
    if (orientation == BWMid_pageOrientation_right || orientation == BWMid_pageOrientation_up) {
        *fromAnimationView = fromSnapShotView[0];
        *toAniamtionView = toSnapShotView[1];
    }else{
        * fromAnimationView = fromSnapShotView[1];
        * toAniamtionView = toSnapShotView[0];
    }
    switch (orientation) {
        case BWMid_pageOrientation_left:
            *angle = M_PI_2;
            [*fromAnimationView bw_setAnchorPointTo:CGPointMake(0, 0.5)];
            [*toAniamtionView bw_setAnchorPointTo:CGPointMake(1, 0.5)];
            *rotation_x = 0;
            *rotation_y = 1;
            break;
        case BWMid_pageOrientation_right:
            *angle = -M_PI_2;
            [*fromAnimationView bw_setAnchorPointTo:CGPointMake(1, 0.5)];
            [*toAniamtionView bw_setAnchorPointTo:CGPointMake(0, 0.5)];
            *rotation_x = 0;
            *rotation_y = 1;
            break;
            
        case BWMid_pageOrientation_up:
            *angle = M_PI_2;
            [*fromAnimationView bw_setAnchorPointTo:CGPointMake(0.5, 1)];
            [*toAniamtionView bw_setAnchorPointTo:CGPointMake(0.5, 0)];
            *rotation_x = 1;
            *rotation_y = 0;
            break;
            
        case BWMid_pageOrientation_Down:
            *angle = -M_PI_2;
            [*fromAnimationView bw_setAnchorPointTo:CGPointMake(0.5, 0)];
            [*toAniamtionView bw_setAnchorPointTo:CGPointMake(0.5, 1)];
            *rotation_x = 1;
            *rotation_y = 0;
            break;
        default:
            break;
    }
    CAGradientLayer *toAnimationGradient = [CAGradientLayer layer];
    toAnimationGradient.frame = [*toAniamtionView bounds];
    toAnimationGradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor];
    toAnimationGradient.startPoint = CGPointMake(0.0, 0.5);
    toAnimationGradient.endPoint = CGPointMake(1, 0.5);
    UIView *toShadowView = [[UIView alloc]initWithFrame:[*toAniamtionView bounds]];
        toShadowView.backgroundColor = [UIColor clearColor];
    [toShadowView.layer insertSublayer:toAnimationGradient atIndex:1];
    toShadowView.alpha = 1.0;
    [*toAniamtionView addSubview:toShadowView];   
    CAGradientLayer *fromAnimationGradient = [CAGradientLayer layer];
    fromAnimationGradient.frame = [*fromAnimationView bounds];
    fromAnimationGradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor,
                                   (id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor];
    fromAnimationGradient.startPoint = CGPointMake(0.0, 0.5);
    fromAnimationGradient.endPoint = CGPointMake(1, 0.5);
    UIView *fromShadowView = [[UIView alloc]initWithFrame:[*toAniamtionView bounds]];
    fromShadowView.backgroundColor = [UIColor clearColor];
    [fromShadowView.layer insertSublayer:fromAnimationGradient atIndex:1];
    fromShadowView.alpha = 0.0;
    [*fromAnimationView addSubview:fromShadowView];
}
-(CustomAnimationBlock)generateMid_OpenDoorAnimationWidthDuration:(CGFloat)duration withOrientation:(BWMid_pageOrientation)orientation{
    BW_WeakSelf(ws);
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView * containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -0.002;
        containerView.layer.sublayerTransform = transform;
        toView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1);

        NSArray * fromSnapShotView = [ws snapShotViewFor:fromView withOrientation:orientation];
        [fromView removeFromSuperview];
        UIImageView * pageOne = fromSnapShotView[0];
        UIImageView * pageTwo = fromSnapShotView[1];
        
        [UIView animateWithDuration:duration animations:^{
            if (orientation == BWMid_pageOrientation_left || orientation == BWMid_pageOrientation_right) {
                pageOne.frame = CGRectOffset(pageOne.frame, -pageOne.frame.size.width, 0);
                pageTwo.frame = CGRectOffset(pageTwo.frame, pageTwo.frame.size.width, 0);
            }else{
                pageOne.frame = CGRectOffset(pageOne.frame, 0, -pageOne.frame.size.height);
                pageTwo.frame = CGRectOffset(pageTwo.frame, 0, pageTwo.frame.size.height);
            }
            toView.layer.transform = CATransform3DMakeScale(1, 1, 1);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [containerView addSubview:fromView];
                [toView removeFromSuperview];
            }
            [pageOne removeFromSuperview];
            [pageTwo removeFromSuperview];
        }];
    };

}
-(CustomAnimationBlock)generateMid_CloseDoorAnimationWidthDuration:(CGFloat)duration withOrientation:(BWMid_pageOrientation)orientation{
    BW_WeakSelf(ws);
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView * containerView = [transitionContext containerView];
        [containerView addSubview:toView];
        [containerView sendSubviewToBack:toView];
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -0.002;
        containerView.layer.sublayerTransform = transform;
        fromView.layer.transform = CATransform3DIdentity;
        NSArray * toSnapShotView = [ws snapShotViewFor:toView withOrientation:orientation];
        UIImageView * pageOne = toSnapShotView[0];
        UIImageView * pageTwo = toSnapShotView[1];
        if (orientation == BWMid_pageOrientation_left || orientation == BWMid_pageOrientation_right) {
            pageOne.frame = CGRectOffset(pageOne.frame, -pageOne.frame.size.width, 0);
            pageTwo.frame = CGRectOffset(pageTwo.frame, pageTwo.frame.size.width, 0);
        }else{
            pageOne.frame = CGRectOffset(pageOne.frame, 0, -pageOne.frame.size.height);
            pageTwo.frame = CGRectOffset(pageTwo.frame, 0, pageTwo.frame.size.height);
        }
        toView.alpha = 0;
        [UIView animateWithDuration:duration animations:^{
            if (orientation == BWMid_pageOrientation_left || orientation == BWMid_pageOrientation_right) {
                pageOne.frame = CGRectOffset(pageOne.frame, pageOne.frame.size.width, 0);
                pageTwo.frame = CGRectOffset(pageTwo.frame, -pageTwo.frame.size.width, 0);
            }else{
                pageOne.frame = CGRectOffset(pageOne.frame, 0, pageOne.frame.size.height);
                pageTwo.frame = CGRectOffset(pageTwo.frame, 0, -pageTwo.frame.size.height);
            }
            fromView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1);
        } completion:^(BOOL finished) {
            toView.alpha = 1;
            if ([transitionContext transitionWasCancelled]) {
                [toView removeFromSuperview];
            }else{
                [fromView removeFromSuperview];
            }
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            [pageOne removeFromSuperview];
            [pageTwo removeFromSuperview];
        }];

    };
}
-(NSArray *)snapShotViewFor:(UIView *)view withOrientation:(BWMid_pageOrientation)orientation{
    UIView * containerView = view.superview;
    CGSize size = view.bounds.size;
    CGRect rectOne;
    CGRect rectTwo;
    if (orientation == BWMid_pageOrientation_left || orientation == BWMid_pageOrientation_right) {
        rectOne = CGRectMake(0, 0, size.width/2.0, size.height);
        rectTwo = CGRectMake(size.width/2.0, 0, size.width/2.0, size.height);
    }else{
        rectOne = CGRectMake(0, 0, size.width, size.height/2.0);
        rectTwo = CGRectMake(0, size.height/2.0, size.width, size.height/2.0);
    }
    UIImage * imageOne = [view bw_capture:rectOne withContent:view.bounds];
    UIImage * imageTwo = [view bw_capture:rectTwo withContent:view.bounds];
    UIImageView * imgViewOne = [[UIImageView alloc]initWithImage:imageOne];
    imgViewOne.frame = rectOne;
    UIImageView * imgViewTwo = [[UIImageView alloc]initWithImage:imageTwo];
    imgViewTwo.frame = rectTwo;
    [containerView addSubview:imgViewOne];
    [containerView addSubview:imgViewTwo];
    return @[imgViewOne,imgViewTwo];
}
@end
