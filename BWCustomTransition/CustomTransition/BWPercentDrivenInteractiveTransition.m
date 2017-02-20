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
@property(nonatomic,strong)id <UIViewControllerContextTransitioning> transitionContext;
@property(nonatomic,strong)CADisplayLink * displayLink;
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
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    [super startInteractiveTransition:transitionContext];
    CALayer *containerLayer = [transitionContext containerView].layer;
    containerLayer.beginTime = [containerLayer convertTime:CACurrentMediaTime() fromLayer:nil] - self.duration;
    self.transitionContext = transitionContext;
}

- (void)finishInteractiveTransition {
    [super finishInteractiveTransition];
    CALayer *containerLayer = [_transitionContext containerView].layer;
    CFTimeInterval pausedTime = [containerLayer timeOffset];
    containerLayer.speed = 1.0;
    containerLayer.timeOffset = 0.0;
    containerLayer.beginTime = 0.0;
    containerLayer.beginTime = [containerLayer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
}

- (void)cancelInteractiveTransition {

    self.targetNavC.delegate = self.targetVC.manager;

    CADisplayLink *  displayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(animationTick:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
-(void)animationTick:(CADisplayLink *)displayLink{
    
    CALayer *maskLayer=[self.transitionContext containerView].layer;
    CGFloat timeOffset=maskLayer.timeOffset;
    timeOffset=MAX(0,timeOffset- (1.0/60.0));
    maskLayer.timeOffset=timeOffset;
    if (timeOffset==0) {
        displayLink.paused=YES;
        [super cancelInteractiveTransition];
    }
}
-(void)dealloc{
    NSLog(@"dealloc");
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
