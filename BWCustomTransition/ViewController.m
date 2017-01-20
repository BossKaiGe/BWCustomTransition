//
//  ViewController.m
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/4.
//  Copyright © 2016年 BossKai. All rights reserved.
//
#import "ViewController.h"
#import "BWCustomTransition.h"
#import "UINavigationController+animationBlock.h"
#import "BWCustomTransitionDelegate.h"
#import "UIViewController+animationBlock.h"
#import "BWImgViewController.h"

static  NSString * const kBWAnimationTransition_FadeAndScale = @"BWAnimationTransition_FadeAndScale";
static  NSString * const kBWAnimationTransition_PageIn = @"BWAnimationTransition_PageIn";
static  NSString * const kBWAnimationTransition_PageOut = @"BWAnimationTransition_PageOut";

static NSString * const kCellId = @"kCellId";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray * dataSourceArray;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
}

#pragma mark:UITableViewDelegate && UITableViewDataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BWImgViewController * imgVC = [[BWImgViewController alloc]init];
    
    [imgVC setInitializeBlock:^(BWTransitionManager *manager) {
        manager.stackInType = BWAnimationTransition_PageIn;
        manager.stackOutType = BWAnimationTransition_PageOut;
        manager.transitionDuration_StackOut = 3.0;
        manager.transitionDuration_StackIn = 3.0;
    }];
    [imgVC setBgImgWith:[UIImage imageNamed:@"bc_img_1"]];
    [self presentViewController:imgVC animated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString * title = self.dataSourceArray[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}
#pragma mark:懒加载
-(NSArray *)dataSourceArray{
    if (_dataSourceArray == nil) {
        _dataSourceArray = @[kBWAnimationTransition_FadeAndScale,kBWAnimationTransition_PageIn,kBWAnimationTransition_PageOut];
    }
    return _dataSourceArray;
}
@end
