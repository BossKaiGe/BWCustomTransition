//
//  BWTransitionManager.h
//  BWCustomTransition
//
//  Created by 静静静 on 16/12/25.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BWTransitionFoundation.h"
#import "UIView+AnchorPoint.h"
typedef NS_ENUM(NSInteger, BWAnimationTransition) {
    BWAnimationTransition_Custom,
    BWAnimationTransition_FadeAndScale,
    BWAnimationTransition_PageIn,
    BWAnimationTransition_PageOut,
    BWAnimationTransition_PhotoBrowserIn,
    BWAnimationTransition_PhotoBrowserOut,
    BWAnimationTransition_DotSpreadIn,
    BWAnimationTransition_DotSpreadOut,
    BWAnimationTransition_Mid_page_Left,
    BWAnimationTransition_Mid_page_Right,
    BWAnimationTransition_Mid_page_Up,
    BWAnimationTransition_Mid_page_Down,
    BWAnimationTransition_Mid_openDoor_Horizontal,
    BWAnimationTransition_Mid_openDoor_Vertical,
    BWAnimationTransition_Mid_closeDoor_Horizontal,
    BWAnimationTransition_Mid_closeDoor_Vertical
};
typedef NS_ENUM(NSInteger, BWStackOutGesture) {
    BWStackOutGesture_None,
    BWStackOutGesture_Left,
    BWStackOutGesture_Right,
    BWStackOutGesture_Up,
    BWStackOutGesture_Down
};
@interface BWTransitionManager : NSObject <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate,UITabBarControllerDelegate>
@property(nonatomic,assign)BWAnimationTransition stackInType;
@property(nonatomic,assign)BWAnimationTransition stackOutType;
@property(nonatomic,copy)CustomAnimationBlock stackInBlock;
@property(nonatomic,copy)CustomAnimationBlock stackOutBlock;
@property(nonatomic,assign)CGFloat transitionDuration_StackIn;
@property(nonatomic,assign)CGFloat transitionDuration_StackOut;
@property(nonatomic,assign)BWStackOutGesture stackOutGesture;
@property(nonatomic,weak)id originDelegate;
-(UIImageView *)getTransitionImgView;
-(void)generateAnimation;
-(void)setStackInBlock:(CustomAnimationBlock)stackInBlock;
-(void)setStackOutBlock:(CustomAnimationBlock)stackOutBlock;
@end
