//
//  BWTransitionManager+DotSpread.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/16.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"

@interface BWTransitionManager (DotSpread)<CAAnimationDelegate>

/**
 The animation starts from this view when the specified enumeration is BWAnimationTransition_DotSpreadIn。
 The animation ends from this view when the specified enumeration is BWAnimationTransition_DotSpreadOut
 */
@property(nonatomic,strong)UIView * dotView;

/**
 Generate a dot spread animation

 @param duration Animation duration
 @return The animation block
 */
-(CustomAnimationBlock)generateDotSpreadInAnimationWithDuration:(CGFloat)duration;

/**
 Generate an animation that is reduced to a dot

 @param duration Animation duration
 @return The animation block
 */
-(CustomAnimationBlock)generateDotSpreadOutAnimationWithDuration:(CGFloat)duration;
@end
