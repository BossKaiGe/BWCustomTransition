//
//  BWNormalFromViewController.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/4.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWNormalFromViewController.h"
#import "BWNormalToViewController.h"
@interface BWNormalFromViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)UIImageView * bgImg;
@property(nonatomic,strong)UITapGestureRecognizer * tapGesture;
@end

@implementation BWNormalFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgImg];

    // Do any additional setup after loading the view.
}

-(void)tapGestureTapped{
    BW_WeakSelf(ws);
    BWNormalToViewController * imgVC = [[BWNormalToViewController alloc]init];

    [imgVC setTipsWith:@"点我或右滑"];
    [imgVC setInitializeBlock:^(BWTransitionManager *manager) {
        manager.stackInType = ws.stackInType;
        manager.stackOutType = ws.stackOutType;
        manager.transitionDuration_StackIn = 0.6;
        manager.transitionDuration_StackOut = 0.6;
        manager.stackOutGesture = BWStackOutGesture_Right;
        manager.originDelegate = ws;
    }];
    imgVC.interactiveTransition.boundary = .4;
    imgVC.interactiveTransition.interactiveStackOutMaxAllowedInitialDistanceToLeftEdge = 100;
    if (ws.stackInType == BWAnimationTransition_Custom) {
        [imgVC.manager setStackInBlock:^(id<UIViewControllerContextTransitioning> transitionContext) {
            UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            [[transitionContext containerView] addSubview:toViewController.view];
            toViewController.view.alpha = 0;
            fromViewController.view.alpha = 1;
            [UIView animateWithDuration:1 animations:^{
                fromViewController.view.alpha = 0;
                toViewController.view.alpha = 1;
            } completion:^(BOOL finished) {
                
                fromViewController.view.alpha = 1;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                if ([transitionContext transitionWasCancelled]) {
                    [toViewController.view removeFromSuperview];
                }
            }];
        } ];
    }
    if (ws.stackOutType == BWAnimationTransition_Custom) {
        [imgVC.manager setStackOutBlock:^(id<UIViewControllerContextTransitioning> transitionContext) {
            UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
            UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
            [[transitionContext containerView] addSubview:toViewController.view];
            toViewController.view.alpha = 0;
            fromViewController.view.alpha = 1;
            [UIView animateWithDuration:1 animations:^{
                fromViewController.view.alpha = 0;
                toViewController.view.alpha = 1;
            } completion:^(BOOL finished) {
                
                fromViewController.view.alpha = 1;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                if ([transitionContext transitionWasCancelled]) {
                    [toViewController.view removeFromSuperview];
                }
            }];

        }];
    }
    [self.navigationController presentViewController:imgVC animated:YES completion:nil];
}
#pragma mark:UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"%@",viewController);
}
#pragma mark:懒加载
-(UIImageView *)bgImg{
    if (_bgImg == nil) {
        _bgImg = [[UIImageView alloc]init];
        _bgImg.frame = [UIScreen mainScreen].bounds;
        _bgImg.image = [UIImage imageNamed:@"bc_img_1"];
        _bgImg.userInteractionEnabled = YES;
        [_bgImg addGestureRecognizer:self.tapGesture];
    }
    return _bgImg;
}
-(UITapGestureRecognizer *)tapGesture{
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureTapped)];
    }
    return _tapGesture;
}
@end
