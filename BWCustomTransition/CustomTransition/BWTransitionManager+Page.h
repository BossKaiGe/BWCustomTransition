//
//  BWTransitionManager+Page.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/8.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"

@interface BWTransitionManager (Page)

/**
 Generate a counterclockwise page animation

 @param duration The animation duration
 @return The animation block
 */
-(CustomAnimationBlock)generatePageInAnimationWithDuration:(CGFloat)duration;

/**
 Generate a clockwise page animation

 @param duration The animation duration
 @return The animation block
 */
-(CustomAnimationBlock)generatePageOutAnimationWithDuration:(CGFloat)duration;

@end
