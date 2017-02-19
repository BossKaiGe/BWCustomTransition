//
//  BWTransitionManager+DotSpread.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/16.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"

@interface BWTransitionManager (DotSpread)<CAAnimationDelegate>
@property(nonatomic,strong)UIView * dotView;
-(CustomAnimationBlock)generateDotSpreadInAnimationWithDuration:(CGFloat)duration;
-(CustomAnimationBlock)generateDotSpreadOutAnimationWithDuration:(CGFloat)duration;
@end
