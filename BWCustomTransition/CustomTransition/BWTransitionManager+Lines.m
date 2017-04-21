//
//  BWTransitionManager+Lines.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/4/19.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager+Lines.h"
#import "UIView+ScreenShot.h"
@implementation BWTransitionManager (Lines)
-(CustomAnimationBlock)generateLinesAnimationWithDuration:(CGFloat)duration withOrientation:(BWLinesOrientation)orientation{
    return  ^(id <UIViewControllerContextTransitioning> transitionContext){
        BOOL vertical;
        if (orientation == BWLinesOrientation_right || orientation == BWLinesOrientation_left) {
            vertical = NO;
        }else{
            vertical = YES;
        }
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *toView = toVC.view;
        UIView *fromView = fromVC.view;
        UIView *containerView = [transitionContext containerView];
        [containerView insertSubview:toView atIndex:0];
        NSArray * fromViewLines = [self bw_lineViews:fromView intoSlicesOfDis:4 containerView:containerView vertical:vertical];
        NSArray * toViewLines = [self bw_lineViews:toView intoSlicesOfDis:4 containerView:containerView vertical:vertical];
        CGFloat toViewStart = vertical ? toView.frame.origin.y : toView.frame.origin.x;
        vertical ? [self bw_repositionViewSlices:toViewLines moveFirstFrameUp:NO]:[self bw_repositionViewSlices:toViewLines moveLeft:(orientation == BWLinesOrientation_left)];
        fromVC.view.hidden = YES;
        toView.hidden = YES;
        [UIView animateWithDuration:duration - 0.01 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            vertical ? [self bw_repositionViewSlices:fromViewLines moveFirstFrameUp:YES] : [self bw_repositionViewSlices:fromViewLines moveLeft:!(orientation == BWLinesOrientation_left)];
            [self bw_resetViewSlices:toViewLines toOrigin:toViewStart vertical:vertical];
        } completion:^(BOOL finished) {
            fromVC.view.hidden = NO;
            toView.hidden = NO;
            [toView setNeedsUpdateConstraints];
            [toViewLines makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [fromViewLines makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    };

}
-(void)bw_resetViewSlices:(NSArray *)views toOrigin:(CGFloat)o vertical:(BOOL)vertical{
    CGRect frame;
    for (UIView *line in views) {
        frame = line.frame;
        if (vertical) {
            frame.origin.y = o;
        }else{
            frame.origin.x = o;
        }
        line.frame = frame;
    }
}

-(void)bw_repositionViewSlices:(NSArray *)views moveLeft:(BOOL)left{
    CGRect frame;
    float width;
    for (UIView *line in views) {
        frame = line.frame;
        width = CGRectGetWidth(frame) * BWRandomFloat(1.0, 8.0);
        frame.origin.x += (left)?-width:width;
        line.frame = frame;
    }
}

-(void)bw_repositionViewSlices:(NSArray *)views moveFirstFrameUp:(BOOL)startUp{
    
    BOOL up = startUp;
    CGRect frame;
    float height;
    for (UIView *line in views) {
        frame = line.frame;
        height = CGRectGetHeight(frame) * BWRandomFloat(1.0, 4.0);
        frame.origin.y += (up)?-height:height;
        line.frame = frame;
        up = !up;
    }
}
static inline float BWRandomFloat(float max, float min){
    return ((float)arc4random() / 0x100000000) * (max - min) + min;
}
- (NSArray<UIView *> *)bw_lineViews:(UIView *)view intoSlicesOfDis:(float)dis containerView:(UIView *)containerView vertical:(BOOL)vertical{
    CGFloat width = vertical ? CGRectGetHeight(view.frame) : CGRectGetWidth(view.frame);
    CGFloat height = !vertical ? CGRectGetHeight(view.frame) : CGRectGetWidth(view.frame);
    UIImage *img = [view bw_capture];
    NSMutableArray *lineViews = [NSMutableArray array];
    for (int i = 0; i < height; i += dis) {
        CGRect subrect = vertical ? CGRectMake(i, 0, dis, width) : CGRectMake(0, i, width, dis);
        UIView *subsnapshot = [UIView new];
        subsnapshot.layer.contents= (__bridge id)img.CGImage;
        subsnapshot.layer.contentsRect = vertical ? CGRectMake((float)i / view.frame.size.width, 0.0,  dis / view.frame.size.width, 1.0) : CGRectMake(0, (float)i / view.frame.size.height, 1.0, dis / view.frame.size.height);
        subsnapshot.frame = subrect;
        [lineViews addObject:subsnapshot];
        [containerView addSubview:subsnapshot];
    }
    return lineViews;
}

@end
