//
//  UIView+ScreenShot.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/24.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "UIView+ScreenShot.h"

@implementation UIView (ScreenShot)

- (UIImage *)bw_capture{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)bw_capture:(CGRect)rect withContent:(CGRect)rectOfContent{
    UIGraphicsBeginImageContextWithOptions(rectOfContent.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * parentImage = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRef imageRef = parentImage.CGImage;
    CGRect rectOfImageRef ;
    CGFloat scale = [UIScreen mainScreen].scale;
    rectOfImageRef = CGRectMake(rect.origin.x * scale, rect.origin.y * scale , rect.size.width * scale, rect.size.height * scale);
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rectOfImageRef);
    CGContextRef context  = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, subImageRef);
    UIImage * image = [UIImage imageWithCGImage:subImageRef scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return image;
}

@end
