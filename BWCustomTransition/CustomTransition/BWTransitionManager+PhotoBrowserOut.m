//
//  BWTransitionManager+PhotoBrowserOut.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/22.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+PhotoBrowserOut.h"
#import "BWTransitionManager+PhotoBrowserIn.h"
@implementation BWTransitionManager (PhotoBrowserOut)
-(CustomAnimationBlock)generatePhotoBrowserOutAnimationWithDuration:(CGFloat)duration{
    BW_WeakSelf(ws);
    return ^(id <UIViewControllerContextTransitioning> transitionContext){
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [[transitionContext containerView]addSubview:toView];
        UIImageView * transitionImgView = [ws getTransitionImgView];
        transitionImgView.frame = [ws getFullRect];
        [[transitionContext containerView] addSubview:transitionImgView];
        [UIView animateWithDuration:duration animations:^{
            transitionImgView.frame = [ws getRect];
            fromView.alpha = 0;
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            [transitionImgView removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    };
}
-(void)upDataImgWithPhotoListIndexPath:(NSIndexPath *)indexPath photoPropertyNameInListCell:(NSString *)propertyName{
    id cell = [self.photoListView cellForItemAtIndexPath:indexPath];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([cell class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *key = [NSString stringWithUTF8String:char_f];
        if (key == propertyName) {
            id propertyValue = [self valueForKey:(NSString *)key];
            self.photoBrowserImgView = propertyValue;
        }
    }
    free(properties);
}

@end
