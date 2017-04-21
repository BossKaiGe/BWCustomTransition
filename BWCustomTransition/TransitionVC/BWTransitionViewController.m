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
#import "BWNormalToViewController.h"
#import "BWTransitionCollectionCell.h"
#import "BWPhotoBrowserVC.h"
#import "BWNormalFromViewController.h"
#import "BWPhotoBrowserListVC.h"
#import "BWDotSpreadVC.h"
static NSString * const kPhotoBrowserTransition = @"PhotoBrowser";
static NSString * const kPageInPageOutTransition = @"PageInPageOut";
static NSString * const kFadeAndScaleTransition = @"FadeAndScale";
static NSString * const kDotSpreadTransition = @"DotSpreadTransition";
static NSString * const kMidPageTransition = @"MidPageTransition";
static NSString * const kMidOpenDoorTransition = @"MidOpenDoorTransition";
static NSString * const kScanningTransition = @"ScanningTransition";
static NSString * const kFoldTransition = @"FoldTransition";
static NSString * const kFragmentationTransition = @"kFragmentationTransition";
static NSString * const kLinesTransition = @"kLinesTransition";
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
        BWNormalFromViewController * imgVC = [[BWNormalFromViewController alloc]init];
        imgVC.stackInType = BWAnimationTransition_FadeAndScale;
        imgVC.stackOutType = BWAnimationTransition_FadeAndScale;
        [self.navigationController pushViewController:imgVC animated:YES];
    }else if ([transitionType isEqualToString:kPageInPageOutTransition]){
        BWNormalFromViewController * imgVC = [[BWNormalFromViewController alloc]init];
        imgVC.stackInType = BWAnimationTransition_PageIn;
        imgVC.stackOutType = BWAnimationTransition_PageOut;
        [self.navigationController pushViewController:imgVC animated:YES];
    }else if ([transitionType isEqualToString:kPhotoBrowserTransition]){
        BWPhotoBrowserListVC * listVC = [[BWPhotoBrowserListVC alloc]init];
        [self.navigationController pushViewController:listVC animated:YES];
    }else if ([transitionType isEqualToString:kDotSpreadTransition]){
        BWDotSpreadVC * dotSpreadVC = [[BWDotSpreadVC alloc]init];
        [self.navigationController pushViewController:dotSpreadVC animated:YES];
    }else if ([transitionType isEqualToString:kMidPageTransition]){
        BWNormalFromViewController * imgVC = [[BWNormalFromViewController alloc]init];
        imgVC.stackInType = BWAnimationTransition_Mid_page_Left;
        imgVC.stackOutType = BWAnimationTransition_Mid_page_Right;
        [self.navigationController pushViewController:imgVC animated:YES];
    }else if ([transitionType isEqualToString:kMidOpenDoorTransition]){
        BWNormalFromViewController * imgVC = [[BWNormalFromViewController alloc]init];
        imgVC.stackInType = BWAnimationTransition_Mid_openDoor_Horizontal;
        imgVC.stackOutType = BWAnimationTransition_Mid_closeDoor_Horizontal;
        [self.navigationController pushViewController:imgVC animated:YES];
    }else if ([transitionType isEqualToString:kScanningTransition]){
        BWNormalFromViewController * imgVC = [[BWNormalFromViewController alloc]init];
        imgVC.stackInType = BWAnimationTransition_Scanning_Right;
        imgVC.stackOutType = BWAnimationTransition_Scanning_Left;
        [self.navigationController pushViewController:imgVC animated:YES];
    }else if ([transitionType isEqualToString:kFoldTransition]){
        BWNormalFromViewController * imgVC = [[BWNormalFromViewController alloc]init];
        imgVC.stackInType = BWAnimationTransition_Fold_Left;
        imgVC.stackOutType = BWAnimationTransition_Fold_Right;
        [self.navigationController pushViewController:imgVC animated:YES];
    }else if ([transitionType isEqualToString:kFragmentationTransition]){
        BWNormalFromViewController * imgVC = [[BWNormalFromViewController alloc]init];
        imgVC.stackInType = BWAnimationTransition_Fragmentation;
        imgVC.stackOutType = BWAnimationTransition_Fragmentation;
        [self.navigationController pushViewController:imgVC animated:YES];
    }else if ([transitionType isEqualToString:kLinesTransition]){
        BWNormalFromViewController * imgVC = [[BWNormalFromViewController alloc]init];
        imgVC.stackInType = BWAnimationTransition_Lines_Right;
        imgVC.stackOutType = BWAnimationTransition_Lines_Left;
        [self.navigationController pushViewController:imgVC animated:YES];
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
        _dataSource = @[kPhotoBrowserTransition,kPageInPageOutTransition,kFadeAndScaleTransition,kDotSpreadTransition,kMidPageTransition,kMidOpenDoorTransition,kScanningTransition,kFoldTransition,kFragmentationTransition,kLinesTransition];
    }
    return _dataSource;
}
@end
