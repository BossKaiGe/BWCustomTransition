//
//  BWNormalToViewController.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/15.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWNormalToViewController.h"
@interface BWNormalToViewController ()
@property(nonatomic,strong)UIImageView * bgImg;
@property(nonatomic,strong)UILabel * tipsLabel;
@end

@implementation BWNormalToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgImg];
    [self.view addSubview:self.tipsLabel];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureTapped)];
    [self.view addGestureRecognizer:tapGesture];

}
-(void)tapGestureTapped{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)setTipsWith:(NSString  *)tips{
    self.tipsLabel.text = tips;
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
-(UILabel *)tipsLabel{
    if (_tipsLabel == nil) {
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.font = [UIFont systemFontOfSize:16];
        _tipsLabel.textColor = [UIColor whiteColor];
        _tipsLabel.bounds = CGRectMake(0, 0, 300, 40);
        _tipsLabel.center = CGPointMake(self.view.center.x, self.view.center.y + 150);
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLabel;
}
@end
