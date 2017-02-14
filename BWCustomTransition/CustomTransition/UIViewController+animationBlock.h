//
//  UIViewController+animationBlock.h
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/16.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWTransitionFoundation.h"
#import "BWPercentDrivenInteractiveTransition.h"
@interface UIViewController (animationBlock)
@property(nonatomic,copy)InitializeBlock initializeBlock;
@property(nonatomic,strong)BWTransitionManager * manager;
@property(nonatomic,strong)BWPercentDrivenInteractiveTransition * interactiveTransition;
-(void)setInitializeBlock:(InitializeBlock)initializeBlock;
@end
