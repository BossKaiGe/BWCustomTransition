//
//  BWTransitionFoundation.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/24.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#ifndef BWTransitionFoundation_h
#define BWTransitionFoundation_h
#import "NSObject+Swizzle.h"
@class BWTransitionManager;
#define BW_WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
typedef void (^CustomAnimationBlock)( id <UIViewControllerContextTransitioning> transitionContext);
typedef void (^InitializeBlock) (BWTransitionManager * manager);
#endif /* BWTransitionFoundation_h */
