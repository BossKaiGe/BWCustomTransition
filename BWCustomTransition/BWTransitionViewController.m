//
//  BWTransitionViewController.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/21.
//  Copyright © 2017年 BossKai. All rights reserved.
//
#import "BWTransitionViewController.h"
#import "BWTransitionManager.h"
#import "UINavigationController+animationBlock.h"
#import "BWImgViewController.h"
typedef NS_ENUM(NSInteger, ChooseAnimationType) {
    ChooseAnimationType_StackIn,
    ChooseAnimationType_StackOut
};

@interface BWTransitionViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)UIImageView * bgImg;
@property(nonatomic,strong)UITapGestureRecognizer * tapGesture;
@property(nonatomic,assign)BWAnimationTransition stackInType;
@property(nonatomic,assign)BWAnimationTransition stackOutType;
@end

@implementation BWTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgImg];
    self.stackOutType = BWAnimationTransition_FadeAndScale;
    self.stackInType = BWAnimationTransition_FadeAndScale;
    [self setupNavBar];
}

-(void)setupNavBar{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    UIBarButtonItem * stackInItem = [[UIBarButtonItem alloc]initWithTitle:@"choose stackIn" style:(UIBarButtonItemStylePlain) target:self action:@selector(stackInItemClick:)];
    UIBarButtonItem * stackOutItem = [[UIBarButtonItem alloc]initWithTitle:@"choose stackOut" style:(UIBarButtonItemStylePlain) target:self action:@selector(stackOutItemClick:)];
    self.navigationItem.leftBarButtonItem = stackInItem;
    self.navigationItem.rightBarButtonItem = stackOutItem;
}
-(void)stackInItemClick:(id)sender{
    NSLog(@"stackInItemClick");
    [self showActionSheetWith:ChooseAnimationType_StackIn];
    
}
-(void)stackOutItemClick:(id)sender{
    NSLog(@"stackOutItemClick");
    [self showActionSheetWith:ChooseAnimationType_StackOut];
}
-(void)showActionSheetWith:(ChooseAnimationType)chooseType{
    __block ChooseAnimationType  transitionType = chooseType;
    BW_WeakSelf(ws);
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"stackIn Type" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction * fadeAndScaleAction = [UIAlertAction actionWithTitle:@"BWAnimationTransition_FadeAndScale" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (transitionType == ChooseAnimationType_StackIn) {
            ws.stackInType = BWAnimationTransition_FadeAndScale;
        }else{
            ws.stackOutType = BWAnimationTransition_FadeAndScale;
        }
    }];
    UIAlertAction * pageInAction = [UIAlertAction actionWithTitle:@"BWAnimationTransition_PageIn" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (transitionType == ChooseAnimationType_StackIn) {
            ws.stackInType = BWAnimationTransition_PageIn;
        }else{
            ws.stackOutType = BWAnimationTransition_PageIn;
        }
    }];
    UIAlertAction * pageOutAction = [UIAlertAction actionWithTitle:@"BWAnimationTransition_PageOut" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (transitionType == ChooseAnimationType_StackIn) {
            ws.stackInType = BWAnimationTransition_PageOut;
        }else{
            ws.stackOutType = BWAnimationTransition_PageOut;
        }
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:(UIAlertActionStyleDefault) handler:nil];
    [alert addAction:fadeAndScaleAction];
    [alert addAction:pageInAction];
    [alert addAction:pageOutAction];
    [alert addAction: cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)tapGestureTapped{
    BW_WeakSelf(ws);
    [self.navigationController setInitializeBlock:^(BWTransitionManager *manager) {
        manager.stackInType = ws.stackInType;
        manager.stackOutType = ws.stackOutType;
        manager.transitionDuration_StackIn = 1.0;
        manager.transitionDuration_StackOut = 1.0;
        manager.originDelegate = ws;
    }];
    [self.navigationController pushViewController:[[BWImgViewController alloc]init] animated:YES];
}
#pragma mark:UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"willShowViewController %@",viewController);
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    NSLog(@"didShowViewController %@",viewController);
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
