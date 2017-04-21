//
//  BWTransitionManager+Lines.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/4/19.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"
typedef NS_ENUM(NSInteger,BWLinesOrientation){
    BWLinesOrientation_left,
    BWLinesOrientation_right,
    BWLinesOrientation_up,
    BWLinesOrientation_down
};
@interface BWTransitionManager (Lines)
-(CustomAnimationBlock)generateLinesAnimationWithDuration:(CGFloat)duration withOrientation:(BWLinesOrientation)orientation;
@end
