//
//  BWTransitionManager+Fold.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/3/29.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+Fold.h"
#import "UIView+ScreenShot.h"
#import "UIView+AnchorPoint.h"

static NSString * const kNumberOfFolds = @"kNumberOfFolds";

@implementation BWTransitionManager (Fold)
-(CustomAnimationBlock)generateFoldAnimationWithDuration:(CGFloat)duration withOrientation:(BWFlodOrientation)orientation{
    BW_WeakSelf(ws);
    CGFloat numberOfFolds = [self getFoldsNumber];
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView * containerView = [transitionContext containerView];
        toView.frame = CGRectOffset(toView.frame, toView.frame.size.width, 0);
        [containerView addSubview:toView];
        CATransform3D transform = CATransform3DIdentity;
        transform.m34 = -0.005;
        containerView.layer.sublayerTransform = transform;
        CGSize size = toView.frame.size;
        float foldWidth = size.width * 0.5 / numberOfFolds ;
        NSMutableArray* fromViewFolds = [NSMutableArray new];
        NSMutableArray* toViewFolds = [NSMutableArray new];
        UIImage * fromViewImg = [fromView bw_capture];
        UIImage * toViewImg = [toView bw_capture];
        for (int i = 0; i < numberOfFolds; i ++) {
            float offset = i * foldWidth * 2;
            CGRect rect = CGRectMake(offset, 0, foldWidth, size.height);
            UIView * leftFromViewFold = [ws createSnapshotFromView:fromView rect:rect image:fromViewImg left:YES];
            leftFromViewFold.layer.position = CGPointMake(offset, size.height/2);
            [leftFromViewFold.subviews[0] setAlpha:0.0];
            [fromViewFolds addObject:leftFromViewFold];
            [containerView addSubview:leftFromViewFold];
            UIView * rightFromViewFold = [ws createSnapshotFromView:fromView rect:CGRectOffset(rect, foldWidth, 0) image:fromViewImg left:NO];

            [rightFromViewFold.subviews[0] setAlpha:0.0];
            rightFromViewFold.layer.position = CGPointMake(offset + foldWidth * 2, size.height/2);
            [fromViewFolds addObject:rightFromViewFold];
            [containerView addSubview:rightFromViewFold];
            UIView * leftToViewFold = [ws createSnapshotFromView:toView rect:rect image:toViewImg  left:YES];
            [toViewFolds addObject:leftToViewFold];
            leftToViewFold.layer.position = CGPointMake((orientation == BWFlodOrientation_left) ? size.width : 0.0, size.height/2);
            leftToViewFold.layer.transform = CATransform3DMakeRotation(M_PI_2, 0.0, 1.0, 0.0);
            [containerView addSubview:leftToViewFold];
            UIView * rightToViewFold = [ws createSnapshotFromView:toView rect:CGRectOffset(rect, foldWidth, 0) image:toViewImg left:NO];
            rightToViewFold.layer.position = CGPointMake((orientation == BWFlodOrientation_left) ? size.width : 0.0, size.height/2);
            rightToViewFold.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0.0, 1.0, 0.0);
            [containerView addSubview:rightToViewFold];
            [toViewFolds addObject:rightToViewFold];
        }
        fromView.frame = CGRectOffset(fromView.frame, fromView.frame.size.width, 0);
        [UIView animateWithDuration:duration animations:^{
            for (int i = 0; i < numberOfFolds; i ++) {
                float offset = (float)i * foldWidth * 2;
                UIView * leftFromView = fromViewFolds[i*2];
                [leftFromView.subviews[0] setAlpha:1.0];
                leftFromView.layer.transform = CATransform3DRotate(transform, M_PI_2, 0.0, 1.0, 0);
                leftFromView.layer.position = CGPointMake((orientation == BWFlodOrientation_left) ? 0.0 : size.width, size.height/2);

                UIView* rightFromView = fromViewFolds[i*2+1];
                rightFromView.layer.transform = CATransform3DRotate(transform, -M_PI_2, 0.0, 1.0, 0);
                rightFromView.layer.position = CGPointMake((orientation == BWFlodOrientation_left) ? 0.0 : size.width, size.height/2);
                [rightFromView.subviews[0] setAlpha:1.0];

                UIView* leftToView = toViewFolds[i*2];
                leftToView.layer.position = CGPointMake(offset, size.height/2);
                [leftToView.subviews[0] setAlpha:0.0];
                leftToView.layer.transform = CATransform3DIdentity;
                
                UIView* rightToView = toViewFolds[i*2+1];
                rightToView.layer.position = CGPointMake(offset + foldWidth * 2, size.height/2);
                rightToView.layer.transform = CATransform3DIdentity;
                [rightToView.subviews[0] setAlpha:0.0];
            }
        } completion:^(BOOL finished) {
            [toViewFolds makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [fromViewFolds makeObjectsPerformSelector:@selector(removeFromSuperview)];
            BOOL transitionFinished = ![transitionContext transitionWasCancelled];
            if (transitionFinished) {
                toView.frame = containerView.bounds;
                fromView.frame = containerView.bounds;
            }
            else {
                fromView.frame = containerView.bounds;
            }
            [transitionContext completeTransition:transitionFinished];
        }];
    };
}
- (UIView *)createSnapshotFromView:(UIView *)view rect:(CGRect)rect image:(UIImage *)image left:(BOOL)isLeft{
    
    CGSize size = view.frame.size;
    UIView *containerView = view.superview;
    UIView *snapshotView = [UIView new];
    snapshotView.frame = rect;
    snapshotView.layer.contents = (__bridge id _Nullable)(image.CGImage);
    snapshotView.layer.contentsRect = CGRectMake(rect.origin.x / size.width, 0.0, rect.size.width / size.width, 1.0);
    CAGradientLayer * gradient = [CAGradientLayer layer];
    UIView* shadowView = [[UIView alloc] initWithFrame:snapshotView.bounds];
    gradient.frame = shadowView.bounds;
    gradient.colors = @[(id)[UIColor colorWithWhite:0.0 alpha:0.0].CGColor,
                        (id)[UIColor colorWithWhite:0.0 alpha:1.0].CGColor];
    gradient.startPoint = CGPointMake(isLeft? 0.0 : 1.0, isLeft ? 0.2:0.0);
    gradient.endPoint = CGPointMake(isLeft?1.0:0.0, isLeft?0.0:1.0);
    [shadowView.layer addSublayer:gradient];
    snapshotView.layer.anchorPoint = CGPointMake(isLeft ? 0.0 : 1.0, 0.5);
    [snapshotView addSubview:shadowView];
    [containerView addSubview:snapshotView];
    return snapshotView;
}
-(CGFloat)getFoldsNumber{
    if (self.numberOfFolds && [self.numberOfFolds integerValue] >= 1) {
        return [self.numberOfFolds floatValue];
    }else{
        return 5.0;
    }
}
#pragma mark:propertys
-(NSNumber *)numberOfFolds{
    return objc_getAssociatedObject(self, (__bridge const void *)(kNumberOfFolds));
}
-(void)setNumberOfFolds:(NSNumber *)numberOfFolds{
    objc_setAssociatedObject(self, (__bridge const void *)(kNumberOfFolds), numberOfFolds, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
