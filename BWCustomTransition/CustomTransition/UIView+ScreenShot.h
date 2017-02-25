//
//  UIView+ScreenShot.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/24.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ScreenShot)
/*
 * 对当前View截屏
 * @return uiiamge
 */
- (UIImage *)bw_capture;

- (UIImage *)bw_capture:(CGRect)rect withContent:(CGRect)rectOfContent;

@end
