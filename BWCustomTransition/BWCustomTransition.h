//
//  BWCustomTransition.h
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/17.
//  Copyright © 2016年 BossKai. All rights reserved.
//
//(UITabBarController *)tabBarController
//animationControllerForTransitionFromViewController:(UIViewController *)fromVC
//toViewController:(UIViewController *)toVC
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class BWTransitionManager;
#import "NSObject+Swizzle.h"
#ifndef BWCustomTransition_h
#define BWCustomTransition_h
#define BW_WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

typedef void (^CustomAnimationBlock)( id <UIViewControllerContextTransitioning> transitionContext);
typedef void (^customTabBarAnimationBlock)( UITabBarController * tabBarVC,UIViewController * fromVC,UIViewController * toVC);
typedef void (^CustomGestureBlock)(UIPanGestureRecognizer* recognizer);
typedef void (^InitializeBlock) (BWTransitionManager * manager);
//typedef void (^InitializeBlock)(BWTransitionManager * manager);
#endif /* BWCustomTransition_h */
