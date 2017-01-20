//
//  BWTransitionManager.h
//  BWCustomTransition
//
//  Created by 静静静 on 16/12/25.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BWCustomTransition.h"
typedef NS_ENUM(NSInteger, BWAnimationTransition) {
    BWAnimationTransition_Custom,
    BWAnimationTransition_FadeAndScale,
    BWAnimationTransition_PageIn,
    BWAnimationTransition_PageOut
};
@interface BWTransitionManager : NSObject <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate,UITabBarControllerDelegate>
@property(nonatomic,strong)UIView * fromView;
@property(nonatomic,strong)UIView * toView;
@property(nonatomic,assign)BWAnimationTransition stackInType;
@property(nonatomic,assign)BWAnimationTransition stackOutType;
@property(nonatomic,assign)BWAnimationTransition tabTransitionType;
@property(nonatomic,copy)CustomAnimationBlock stackInBlock;
@property(nonatomic,copy)CustomAnimationBlock stackOutBlock;
@property(nonatomic,copy)CustomAnimationBlock tabTransitionBlock;
@property(nonatomic,assign)CGFloat transitionDuration_StackIn;
@property(nonatomic,assign)CGFloat transitionDuration_StackOut;
@property(nonatomic,assign)CGFloat transitionDuration_TabTransition;
@property(nonatomic,weak)id originDelegate;
-(void)generateAnimation;
-(void)setStackInBlock:(CustomAnimationBlock)stackInBlock;
-(void)setStackOutBlock:(CustomAnimationBlock)stackOutBlock;
@end
