//
//  BWPercentDrivenInteractiveTransition.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/8.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWPercentDrivenInteractiveTransition.h"
#import "BWCustomTransition.h"
#import "BWCustomTransitionDelegate.h"
@interface BWPercentDrivenInteractiveTransition()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UINavigationController * targetNavC;
@property(nonatomic,strong)UIViewController * targetVC;
@property(nonatomic,strong)UIPanGestureRecognizer * panGesture;
@end
@implementation BWPercentDrivenInteractiveTransition
-(instancetype)initWithTargetVC:(UIViewController *)targetVC{
    self = [super init];
    if (self) {
        self.targetVC = targetVC;
        self.delegate = [BWCustomTransitionDelegate shareInstance];
        [targetVC.view addGestureRecognizer:self.panGesture];
    }
    return self;
}
-(void)cancelInteractiveTransition{
    self.targetNavC.delegate = self.targetVC.manager;
    [super cancelInteractiveTransition];
}
-(void)panGestureFired:(UIPanGestureRecognizer *)gesture{
   
    CGFloat percent = [self bw_caculateTransitionPercent];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(bw_percentDrivenInteractiveTransitionWillBegin:)]) {
            [self.delegate bw_percentDrivenInteractiveTransitionWillBegin:self];
        }
        if (self.targetVC.presentingViewController) {
            [self.targetVC dismissViewControllerAnimated:YES completion:nil];
        }else if (self.targetVC.navigationController.viewControllers.count >= 2) {
            self.targetNavC = self.targetVC.navigationController;
            [self.targetVC.navigationController popViewControllerAnimated:YES];
        }
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        if (percent > 0) {
            [self updateInteractiveTransition:percent];
        }
    }else if (gesture.state == UIGestureRecognizerStateEnded){
        if (self.delegate && [self.delegate respondsToSelector:@selector(bw_percentDrivenInteractiveTransitionWillEnd:)]) {
            [self.delegate bw_percentDrivenInteractiveTransitionWillEnd:self];
        }
        if (percent >.5) {
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
    }
}
-(CGFloat)bw_caculateTransitionPercent{
    UIView * view = self.panGesture.view;
    CGPoint translation = [self.panGesture translationInView:view];
    CGFloat translation_x = translation.x * view.transform.a;
    CGFloat translation_y = translation.y * view.transform.d;
    CGFloat percent = 0.0;
    switch (self.targetVC.manager.stackOutGesture) {
        case BWStackOutGesture_Left:
            translation_x = -translation_x;
            percent = translation_x / ([UIScreen mainScreen].bounds.size.width * .8) ;
            break;
        case BWStackOutGesture_Right:
            percent = translation_x / ([UIScreen mainScreen].bounds.size.width * .8);
            break;
        case BWStackOutGesture_Up:
            translation_y = -translation_y;
            percent = translation_y / ([UIScreen mainScreen].bounds.size.width * .8);
            break;
        case BWStackOutGesture_Down:
            percent = translation_y / ([UIScreen mainScreen].bounds.size.width * .8);
        default:
            break;
    }
    if (percent < 0) {
        return 0;
    }else{
        return percent > 1 ? 1 :percent;
    }
}
#pragma mark:懒加载
-(UIPanGestureRecognizer *)panGesture{
    if (_panGesture == nil) {
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureFired:)];
        _panGesture.delegate = self;
    }
    return _panGesture;
}
@end
