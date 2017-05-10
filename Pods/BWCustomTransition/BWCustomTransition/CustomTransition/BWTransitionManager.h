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
    BWAnimationTransition_Mid_closeDoor_Vertical,
    BWAnimationTransition_Scanning_Left,
    BWAnimationTransition_Scanning_Right,
    BWAnimationTransition_Scanning_Up,
    BWAnimationTransition_Scanning_Down,
    BWAnimationTransition_Fold_Left,
    BWAnimationTransition_Fold_Right,
    BWAnimationTransition_Fragmentation,
    BWAnimationTransition_Lines_Left,
    BWAnimationTransition_Lines_Right,
    BWAnimationTransition_Lines_Up,
    BWAnimationTransition_Lines_Down

};
typedef NS_ENUM(NSInteger, BWStackOutGesture) {
    BWStackOutGesture_None,
    BWStackOutGesture_Left,
    BWStackOutGesture_Right,
    BWStackOutGesture_Up,
    BWStackOutGesture_Down
};
@interface BWTransitionManager : NSObject <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate,UITabBarControllerDelegate>

/**
The animation type for push or present
 */
@property(nonatomic,assign)BWAnimationTransition stackInType;

/**
 The animation type for pop or dismiss
 */
@property(nonatomic,assign)BWAnimationTransition stackOutType;

/**
 The animation block for push or present.You can use this property to customize the stack animation
 */
@property(nonatomic,copy)CustomAnimationBlock stackInBlock;

/**
 The animation block for pop or dismiss.You can use this property to customize the stack animation
 */
@property(nonatomic,copy)CustomAnimationBlock stackOutBlock;

/**
 The animation duration for push or present
 */
@property(nonatomic,assign)CGFloat transitionDuration_StackIn;

/**
 The animation duration for pop or dismiss
 */
@property(nonatomic,assign)CGFloat transitionDuration_StackOut;

/**
 The gesture type for pop or dismiss
 */
@property(nonatomic,assign)BWStackOutGesture stackOutGesture;

/**
 Multiple delegates, you can use this property to specify another delegate to handle other delegate methods. Such as page conversion tracking
 */
@property(nonatomic,weak)id originDelegate;

/**
 Start generating animations
 */
-(void)generateAnimation;

/**
 stackInBlock setting method
 */
-(void)setStackInBlock:(CustomAnimationBlock)stackInBlock;

/**
 stackOutBlock setting method
 */
-(void)setStackOutBlock:(CustomAnimationBlock)stackOutBlock;
@end
