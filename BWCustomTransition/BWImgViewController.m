//
//  BWImgViewController.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/15.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWImgViewController.h"
#import "UIViewController+animationBlock.h"
@interface BWImgViewController ()
@property(nonatomic,strong)UIImageView * bgImg;
@end

@implementation BWImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgImg];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
-(void)dealloc{
    NSLog(@"imgVc dealloc");
}
#pragma mark:懒加载
-(UIImageView *)bgImg{
    if (_bgImg == nil) {
        _bgImg = [[UIImageView alloc]init];
        _bgImg.frame = [UIScreen mainScreen].bounds;
        _bgImg.image = [UIImage imageNamed:@"bg_img_2"];
    }
    return _bgImg;
}

@end
