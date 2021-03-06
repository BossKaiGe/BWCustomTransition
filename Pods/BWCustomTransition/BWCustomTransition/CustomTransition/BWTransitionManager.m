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
#import "BWTransitionManager+Page.h"
#import "BWTransitionManager+PhotoBrowser.h"
#import "BWTransitionManager+DotSpread.h"
#import "BWTransitionManager+Mid_page.h"
#import "BWTransitionManager+Scanning.h"
#import "BWTransitionManager+Fold.h"
#import "BWTransitionManager+Fragmentation.h"
#import "BWTransitionManager+Lines.h"
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
        case BWAnimationTransition_DotSpreadIn:
            return [self generateDotSpreadInAnimationWithDuration:duration];
            break;
        case BWAnimationTransition_DotSpreadOut:
            return [self generateDotSpreadOutAnimationWithDuration:duration];
            break;
        case BWAnimationTransition_Mid_page_Down:
            return [self generateMid_pageAnimationWithDuration:duration withOrientation:(BWMid_pageOrientation_Down)];
            break;
        case BWAnimationTransition_Mid_page_Up:
            return [self generateMid_pageAnimationWithDuration:duration withOrientation:(BWMid_pageOrientation_up)];
            break;
        case BWAnimationTransition_Mid_page_Left:
            return [self generateMid_pageAnimationWithDuration:duration withOrientation:(BWMid_pageOrientation_left)];
            break;
        case BWAnimationTransition_Mid_page_Right:
            return [self generateMid_pageAnimationWithDuration:duration withOrientation:(BWMid_pageOrientation_right)];
            break;
        case BWAnimationTransition_Mid_openDoor_Vertical:
            return [self generateMid_OpenDoorAnimationWidthDuration:duration withOrientation:BWMid_pageOrientation_up];
            break;
        case BWAnimationTransition_Mid_openDoor_Horizontal:
            return [self generateMid_OpenDoorAnimationWidthDuration:duration withOrientation:BWMid_pageOrientation_left];
            break;
        case BWAnimationTransition_Mid_closeDoor_Vertical:
            return [self generateMid_CloseDoorAnimationWidthDuration:duration withOrientation:BWMid_pageOrientation_up];
            break;
        case BWAnimationTransition_Mid_closeDoor_Horizontal:
            return [self generateMid_CloseDoorAnimationWidthDuration:duration withOrientation:BWMid_pageOrientation_left];
            break;
        case BWAnimationTransition_Scanning_Up:
            return [self generateScanningAnimationWithDuration:duration withOrientation:BWScanningOrientation_up];
            break;
        case BWAnimationTransition_Scanning_Down:
            return [self generateScanningAnimationWithDuration:duration withOrientation:BWScanningOrientation_down];
            break;
        case BWAnimationTransition_Scanning_Left:
            return [self generateScanningAnimationWithDuration:duration withOrientation:BWScanningOrientation_left];
            break;
        case BWAnimationTransition_Scanning_Right:
            return [self generateScanningAnimationWithDuration:duration withOrientation:BWScanningOrientation_right];
            break;
        case BWAnimationTransition_Fold_Left:
            return [self generateFoldAnimationWithDuration:duration withOrientation:BWFlodOrientation_left];
            break;
        case BWAnimationTransition_Fold_Right:
            return [self generateFoldAnimationWithDuration:duration withOrientation:BWFlodOrientation_right];
            break;
        case BWAnimationTransition_Fragmentation:
            return [self generateFragmentationAnimationWithDuration:duration];
        case BWAnimationTransition_Lines_Up:
            return [self generateLinesAnimationWithDuration:duration withOrientation:BWLinesOrientation_up];
        case BWAnimationTransition_Lines_Down:
            return [self generateLinesAnimationWithDuration:duration withOrientation:BWLinesOrientation_down];
        case BWAnimationTransition_Lines_Left:
            return [self generateLinesAnimationWithDuration:duration withOrientation:BWLinesOrientation_left];
        case BWAnimationTransition_Lines_Right:
            return [self generateLinesAnimationWithDuration:duration withOrientation:BWLinesOrientation_right];
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
    if ([self.originDelegate respondsToSelector:aSelector]) {
        return YES;
    }else if (self.stackInBlock && self.stackOutBlock && [[BWCustomTransitionDelegate shareInstance]respondsToSelector:aSelector]){
        return YES;
    }else{
        return [super respondsToSelector:aSelector];
    }
}

@end
