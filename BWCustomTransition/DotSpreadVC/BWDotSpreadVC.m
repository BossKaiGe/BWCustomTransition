//
//  BWDotSpreadFromVC.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/16.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWDotSpreadVC.h"
#import "BWNormalToViewController.h"
#import "BWCustomTransition.h"

@interface BWDotSpreadVC ()
@property(nonatomic,strong)UIButton * dragBtn;
@property(nonatomic,strong)UIImageView * bgImg;
@end

@implementation BWDotSpreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgImg];
    [self.view addSubview:self.dragBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)drag:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint transition = [gestureRecognizer translationInView:gestureRecognizer.view];
    CGFloat transitionX = fmax(20, fmin(self.dragBtn.center.x + transition.x, self.view.bounds.size.width - 20));
    CGFloat transitionY = fmax(64 + 20, fmin(self.dragBtn.center.y + transition.y, self.view.bounds.size.height - 20));
    self.dragBtn.center = CGPointMake(transitionX, transitionY);
    [gestureRecognizer setTranslation:CGPointZero inView:gestureRecognizer.view];
}
-(void)dragBtnClick:(id)sender{
    BWNormalToViewController * imgVC = [[BWNormalToViewController alloc]init];
    [imgVC setTipsWith:@"点我或下划"];
    BW_WeakSelf(ws);
    [imgVC setInitializeBlock:^(BWTransitionManager *manager) {
        manager.stackInType = BWAnimationTransition_DotSpreadIn;
        manager.stackOutType = BWAnimationTransition_DotSpreadOut;
        manager.transitionDuration_StackIn = .6;
        manager.transitionDuration_StackOut = .6;
        manager.stackOutGesture = BWStackOutGesture_Down;
        manager.dotView = ws.dragBtn;
    }];
    [self.navigationController pushViewController:imgVC animated:YES];
}
#pragma mark:懒加载
-(UIButton *)dragBtn{
    if (_dragBtn == nil) {
        _dragBtn = [[UIButton alloc]init];
        [_dragBtn addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)]];
        [_dragBtn setTitle:@"点我\n拖我" forState:(UIControlStateNormal)];
        [_dragBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        _dragBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _dragBtn.backgroundColor = [UIColor lightGrayColor];
        _dragBtn.titleLabel.numberOfLines = 0;
        _dragBtn.bounds = CGRectMake(0, 0, 40, 40);
        _dragBtn.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
        _dragBtn.layer.cornerRadius = 20;
        _dragBtn.layer.masksToBounds = YES;
        [_dragBtn addTarget:self action:@selector(dragBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _dragBtn;
}
-(UIImageView *)bgImg{
    if (_bgImg == nil) {
        _bgImg = [[UIImageView alloc]init];
        _bgImg.frame = [UIScreen mainScreen].bounds;
        _bgImg.image = [UIImage imageNamed:@"bc_img_1"];
    }
    return _bgImg;
}

@end
