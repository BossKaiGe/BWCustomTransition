//
//  UIView+AnchorPoint.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/25.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "UIView+AnchorPoint.h"

@implementation UIView (AnchorPoint)

-(void)bw_setAnchorPointTo:(CGPoint)anchorPointNew{
    CGPoint anchorPointOld = self.layer.anchorPoint;
    CGPoint positionOld = self.layer.position;
    CGPoint positionNew;
    positionNew.x = positionOld.x + (anchorPointNew.x - anchorPointOld.x)  * self.bounds.size.width;
    positionNew.y = positionOld.y + (anchorPointNew.y - anchorPointOld.y)  * self.bounds.size.height;
    self.layer.anchorPoint = anchorPointNew;
    self.layer.position = positionNew;
}
@end
