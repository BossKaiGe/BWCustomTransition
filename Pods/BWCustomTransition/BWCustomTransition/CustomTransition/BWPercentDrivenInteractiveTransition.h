//
//  BWPercentDrivenInteractiveTransition.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/8.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BWPercentDrivenInteractiveTransition;
@protocol BWPercentDrivenInteractiveTransitionDelegate<NSObject>
//The transition gesture will begin
-(void)bw_percentDrivenInteractiveTransitionWillBegin:(BWPercentDrivenInteractiveTransition *)transition;
//The transition gesture will end
-(void)bw_percentDrivenInteractiveTransitionWillEnd:(BWPercentDrivenInteractiveTransition *)transition;
@end
@interface BWPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition
@property(nonatomic,weak)id <BWPercentDrivenInteractiveTransitionDelegate> delegate;

/**
 Set boundary  for the transition gesture,default is 0.5. (Must be between 0.1 and 0.9)
 */
@property(nonatomic,assign)CGFloat boundary;

/**
 Max allowed initial distance to left edge when you begin the interactive
 gesture. 0 by default, which means it will ignore this limit.
 */
@property(nonatomic,assign)CGFloat interactiveStackOutMaxAllowedInitialDistanceToLeftEdge;
/**
 Initialization method
 
 @param targetVC  The controller that need to add gestures
 */
-(instancetype)initWithTargetVC:(UIViewController *)targetVC;

@end
