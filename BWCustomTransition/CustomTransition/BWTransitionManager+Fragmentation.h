//
//  BWTransitionManager+Fragmentation.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/4/3.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"

@interface BWTransitionManager (Fragmentation)

/**
 Generate view fragmentation transition animation

 @param duration Animation duration
 @return The animation block
 */
-(CustomAnimationBlock)generateFragmentationAnimationWithDuration:(CGFloat)duration;
@end
