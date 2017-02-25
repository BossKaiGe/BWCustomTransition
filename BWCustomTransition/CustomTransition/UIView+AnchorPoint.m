//
//  UIView+AnchorPoint.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/25.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "UIView+AnchorPoint.h"

@implementation UIView (AnchorPoint)
- (void)setAnchorPointTo:(CGPoint)point forView:(UIView *)view{
    view.frame = CGRectOffset(view.frame, (point.x - view.layer.anchorPoint.x) * view.frame.size.width, (point.y - view.layer.anchorPoint.y) * view.frame.size.height);
    view.layer.anchorPoint = point;
}
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
