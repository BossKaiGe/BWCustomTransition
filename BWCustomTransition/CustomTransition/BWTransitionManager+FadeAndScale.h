//
//  BWTransitionManager+FadeAndScale.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/6.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"
#import "BWTransitionFoundation.h"
@interface BWTransitionManager (FadeAndScale)
-(CustomAnimationBlock)generateFadeAndScaleAnimationWithDuration:(CGFloat)duration;
@end
