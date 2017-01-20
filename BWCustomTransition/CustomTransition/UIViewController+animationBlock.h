//
//  UIViewController+animationBlock.h
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/16.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWCustomTransition.h"
@class BWTransitionManager;
@interface UIViewController (animationBlock)
@property(nonatomic,copy)InitializeBlock initializeBlock;
@property(nonatomic,strong)BWTransitionManager * manager;

-(void)setInitializeBlock:(InitializeBlock)initializeBlock;
@end
