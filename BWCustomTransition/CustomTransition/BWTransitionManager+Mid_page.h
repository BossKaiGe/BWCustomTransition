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
-(CustomAnimationBlock)generateMid_pageAnimationWithDuration:(CGFloat)duration withOrientation:(BWMid_pageOrientation)orientation;

@end
