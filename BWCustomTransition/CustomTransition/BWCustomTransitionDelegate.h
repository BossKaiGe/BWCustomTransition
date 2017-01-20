//
//  BWCustomTransitionDelegate.h
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/4.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BWCustomTransitionDelegate : NSObject <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate,UITabBarControllerDelegate>
+(instancetype)shareInstance;
@end
