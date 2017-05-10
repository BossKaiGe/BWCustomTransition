//
//  BWCustomTransitionDelegate.h
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/4.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BWPercentDrivenInteractiveTransition.h"
@interface BWCustomTransitionDelegate : NSObject <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate,BWPercentDrivenInteractiveTransitionDelegate>
/**
 Processing system transition animation agent method
 */
+(instancetype)shareInstance;
@end
