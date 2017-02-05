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
#import "UIViewController+animationBlock.h"
#import "BWImgViewController.h"
#import "BWTransitionCollectionCell.h"
#import "BWPhotoBrowserVC.h"
#import "BWImgTransitionVC.h"
#import "BWPhotoBrowserListVC.h"
static NSString * const kPhotoBrowserTransition = @"PhotoBrowser";
static NSString * const kPageInPageOutTransition = @"PageInPageOut";
static NSString * const kFadeAndScaleTransition = @"FadeAndScale";

@interface BWTransitionViewController ()
@property(nonatomic,strong) NSArray * dataSource;
@end
static NSString * const kTableViewCellId = @"kTableViewCellId";
@implementation BWTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellId];
    
}

#pragma mark:UITableViewDelegate && UITableViewDataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * transitionType = self.dataSource[indexPath.row];
    if ([transitionType isEqualToString:kFadeAndScaleTransition]) {
        BWImgTransitionVC * imgVC = [[BWImgTransitionVC alloc]init];
        imgVC.stackInType = BWAnimationTransition_FadeAndScale;
        imgVC.stackOutType = BWAnimationTransition_FadeAndScale;
        [self.navigationController pushViewController:imgVC animated:YES];
    }else if ([transitionType isEqualToString:kPageInPageOutTransition]){
        BWImgTransitionVC * imgVC = [[BWImgTransitionVC alloc]init];
        imgVC.stackInType = BWAnimationTransition_PageIn;
        imgVC.stackOutType = BWAnimationTransition_PageOut;
        [self.navigationController pushViewController:imgVC animated:YES];
    }else if ([transitionType isEqualToString:kPhotoBrowserTransition]){
        BWPhotoBrowserListVC * listVC = [[BWPhotoBrowserListVC alloc]init];
        [self.navigationController pushViewController:listVC animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellId];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
#pragma mark:懒加载
-(NSArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = @[kPhotoBrowserTransition,kPageInPageOutTransition,kFadeAndScaleTransition];
    }
    return _dataSource;
}
@end
