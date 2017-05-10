//
//  BWNormalFromViewController.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/4.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWNormalFromViewController.h"
#import <BWCustomTransition/BWCustomTransition.h>
@interface BWNormalFromViewController : UIViewController
@property(nonatomic,assign)BWAnimationTransition stackInType;
@property(nonatomic,assign)BWAnimationTransition stackOutType;
@end
