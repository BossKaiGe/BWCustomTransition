//
//  BWTransitionManager+Fold.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/3/29.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"
typedef NS_ENUM(NSInteger,BWFlodOrientation){
    BWFlodOrientation_left,
    BWFlodOrientation_right
};
@interface BWTransitionManager (Fold)
@property(nonatomic,strong)NSNumber * numberOfFolds;

/**
 Generate a view folding transition animation

 @param duration Animation duration
 @param orientation Folding orientation
 @return The animation block
 */
-(CustomAnimationBlock)generateFoldAnimationWithDuration:(CGFloat)duration withOrientation:(BWFlodOrientation)orientation;
@end
