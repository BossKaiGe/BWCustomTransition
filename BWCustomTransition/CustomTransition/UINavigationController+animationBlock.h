//
//  UIViewController+animationBlock.h
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/4.
//  Copyright © 2016年 BossKai. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BWCustomTransition.h"
#import "BWTransitionManager.h"
#import "BWTransitionManager.h"
@interface UINavigationController (animationBlock)
@property(nonatomic,copy)InitializeBlock initializeBlock;
@property(nonatomic,strong)BWTransitionManager * manager;
-(void)resignTransition;
-(void)setInitializeBlock:(InitializeBlock)initializeBlock;
@end
