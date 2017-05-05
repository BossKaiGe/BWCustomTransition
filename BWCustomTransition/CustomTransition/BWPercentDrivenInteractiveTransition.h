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
 Initialization method
 
 @param targetVC  The controller that need to add gestures
 */
-(instancetype)initWithTargetVC:(UIViewController *)targetVC;
@end
