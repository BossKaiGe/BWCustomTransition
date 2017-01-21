//
//  BWTransitionManager+PhotoBrowserIn.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/21.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+PhotoBrowserIn.h"

@implementation BWTransitionManager (PhotoBrowserIn)
-(CustomAnimationBlock)generatePhotoBrowserInAnimationWithDuration:(CGFloat)duration{
    BW_WeakSelf(ws);
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIImageView * transitionImgView = [ws getTransitionImgView];
        transitionImgView.frame = [ws getRect];
        [[transitionContext containerView] addSubview:transitionImgView];
        [UIView animateWithDuration:duration animations:^{
            transitionImgView.frame = [ws getFullRect];
        } completion:^(BOOL finished) {
            UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
            [[transitionContext containerView] addSubview:toView];
            [transitionImgView removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    };
}
-(CGRect)getRect{
    CGRect rect = [self.photoBrowserImgView.superview convertRect:self.photoBrowserImgView.frame toCoordinateSpace:[[UIApplication sharedApplication] keyWindow]];
    return rect;
}
-(CGRect)getFullRect{
    UIImage * image = self.photoBrowserImgView.image;
    CGFloat scale = image.size.height/image.size.width;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = w * scale;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - h)*0.5;
    if (y < 0) {
        y = 0;
    }
    return CGRectMake(0, y, w, h);
}

@end
