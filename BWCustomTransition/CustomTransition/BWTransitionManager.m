//
//  BWTransitionManager.m
//  BWCustomTransition
//
//  Created by 静静静 on 16/12/25.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"
#import "BWCustomTransitionDelegate.h"
#import "BWTransitionManager+FadeAndScale.h"
#import "BWTransitionManager+PageIn.h"
#import "BWTransitionManager+PageOut.h"
#import "BWTransitionManager+PhotoBrowserIn.h"
#import "BWTransitionManager+PhotoBrowserOut.h"
@interface BWTransitionManager()
@end
@implementation BWTransitionManager
-(void)generateAnimation{
    if (self.stackInType != BWAnimationTransition_Custom) {
        [self setStackInBlock:[self setAnimationWith:self.stackInType duration:self.transitionDuration_StackIn]];
    }
    if (self.stackOutType != BWAnimationTransition_Custom) {
        [self setStackOutBlock:[self setAnimationWith:self.stackOutType duration:self.transitionDuration_StackOut]];
    }
    if (self.tabTransitionType != BWAnimationTransition_Custom) {
        [self setTabTransitionBlock:[self setAnimationWith:self.tabTransitionType duration:self.transitionDuration_TabTransition]];
    }
}
-(CustomAnimationBlock)setAnimationWith:(BWAnimationTransition)type duration:(CGFloat)duration{
    switch (type) {
        case BWAnimationTransition_FadeAndScale:
            return [self generateFadeAndScaleAnimationWithDuration:duration];
            break;
        case BWAnimationTransition_PageIn:
            return [self generatePageInAnimationWithDuration:duration];
            break;
        case BWAnimationTransition_PageOut:
            return [self generatePageOutAnimationWithDuration:duration];
            break;
        case BWAnimationTransition_PhotoBrowserIn:
            return [self generatePhotoBrowserInAnimationWithDuration:duration];
            break;
        case BWAnimationTransition_PhotoBrowserOut:
            return [self generatePhotoBrowserOutAnimationWithDuration:duration];
            break;
        default:
            break;
    }
    return nil;
}
-(void)dealloc{
    NSLog(@"manager dealloc");
}
//利用消息转发分派消息
-(id)forwardingTargetForSelector:(SEL)aSelector{
    if ([self.originDelegate respondsToSelector:aSelector]) {
        return self.originDelegate;
    }else{
        return [BWCustomTransitionDelegate shareInstance];
    }
}
-(BOOL)respondsToSelector:(SEL)aSelector{
    if ([self.originDelegate respondsToSelector:aSelector] || [[BWCustomTransitionDelegate shareInstance]respondsToSelector:aSelector]) {
        return YES;
    }else{
        return [super respondsToSelector:aSelector];
    }
}
-(UIImageView *)getTransitionImgView{
    UIImageView * transitionImgView = [[UIImageView alloc]init];
    transitionImgView.image = self.photoBrowserImgView.image;
    transitionImgView.contentMode = self.photoBrowserImgView.contentMode;
    return transitionImgView;
}
@end
