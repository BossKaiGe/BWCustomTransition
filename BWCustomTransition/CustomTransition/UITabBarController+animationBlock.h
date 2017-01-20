//
//  UITabBarController+animationBlock.h
//  BWCustomTransition
//
//  Created by 静静静 on 16/10/9.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWCustomTransition.h"
@class BWTransitionManager;
@interface UITabBarController (animationBlock)
@property(nonatomic,strong)BWTransitionManager * manager;
@property(nonatomic,copy)InitializeBlock initializeBlock;
-(void)setInitializeBlock:(InitializeBlock)initializeBlock;
@end
