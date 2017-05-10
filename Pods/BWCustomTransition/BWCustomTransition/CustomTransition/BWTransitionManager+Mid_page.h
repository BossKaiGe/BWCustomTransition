//
//  BWTransitionManager+Mid_page.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/24.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"
typedef NS_ENUM(NSInteger, BWMid_pageOrientation) {
    BWMid_pageOrientation_left,
    BWMid_pageOrientation_right,
    BWMid_pageOrientation_up,
    BWMid_pageOrientation_Down
};
@interface BWTransitionManager (Mid_page)

/**
Generates an animation that flips from the middle of the page

 @param duration The animation duration
 @param orientation Page flip orientation
 @return The animation block
 */
-(CustomAnimationBlock)generateMid_pageAnimationWithDuration:(CGFloat)duration withOrientation:(BWMid_pageOrientation)orientation;

/**
 Generate an animation that separates from the middle

 @param duration The animation duration
 @param orientation Page separates orientation
 @return The animation block
 */
-(CustomAnimationBlock)generateMid_OpenDoorAnimationWidthDuration:(CGFloat)duration withOrientation:(BWMid_pageOrientation)orientation;

/**
 Generate an animation from both sides to the middle

 @param duration The animation duration
 @param orientation The animation orientation
 @return The animation block
 */
-(CustomAnimationBlock)generateMid_CloseDoorAnimationWidthDuration:(CGFloat)duration withOrientation:(BWMid_pageOrientation)orientation;
@end
