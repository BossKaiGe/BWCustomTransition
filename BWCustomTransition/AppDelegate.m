//
//  AppDelegate.m
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/4.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import "AppDelegate.h"
#import "BWTransitionViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BWTransitionViewController * vc = [[BWTransitionViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
