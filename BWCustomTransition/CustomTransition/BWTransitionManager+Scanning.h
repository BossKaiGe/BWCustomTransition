//
//  BWTransitionManager+Scanning.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/3/18.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"
typedef NS_ENUM(NSInteger,BWScanningOrientation){
    BWScanningOrientation_left,
    BWScanningOrientation_right,
    BWScanningOrientation_up,
    BWScanningOrientation_down
};
@interface BWTransitionManager (Scanning)

/**
 You can change the scan bar by this property
 */
@property(nonatomic,strong)UIImage * scanImg;

/**
 Generate a scan transition animation

 @param duration Animation duration
 @param orientation scanning orientation
 @return The animation block
 */
-(CustomAnimationBlock)generateScanningAnimationWithDuration:(CGFloat)duration withOrientation:(BWScanningOrientation)orientation;
@end
