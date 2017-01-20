//
//  BWCustomPopAnimation.h
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/4.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum _CustomAnimationType{
    CustomAnimationType_Push = 0,
    CustomAnimationType_Pop,
    CustomAnimationType_Present,
    CustomAnimationType_Dismiss,
    CustomAnimationType_TabBar
}CustomAnimationType;
@interface BWCustomAnimation : NSObject<UIViewControllerAnimatedTransitioning>
-(instancetype)initWithAnimationType:(CustomAnimationType)animationType;
@end
