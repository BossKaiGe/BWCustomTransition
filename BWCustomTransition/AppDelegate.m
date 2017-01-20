//
//  AppDelegate.m
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/4.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UINavigationController+animationBlock.h"
#import "UITabBarController+animationBlock.h"
#import "BWCustomTransitionDelegate.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UITabBarController * tabBarVC = [[UITabBarController alloc]init];
    ViewController * vc = [[ViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [tabBarVC addChildViewController:nav];
    BW_WeakSelf(ws);

    
    UIViewController * vc1 = [[UIViewController alloc]init];
    vc1.view.backgroundColor = [UIColor purpleColor];
    [tabBarVC addChildViewController:vc1];
    self.window.rootViewController = tabBarVC;

    [tabBarVC setInitializeBlock:^(BWTransitionManager *manager) {
        manager.tabTransitionType = BWAnimationTransition_FadeAndScale;
        manager.transitionDuration_TabTransition = 3.0;
        manager.originDelegate = ws;
    }];

    [self.window makeKeyAndVisible];
    return YES;
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSLog(@"shouldSelectViewController");
    return YES;
}
#pragma mark:
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"%@ will show",viewController);
}
@end
