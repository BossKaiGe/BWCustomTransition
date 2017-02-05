//
//  BWPhotoBrowserListVC.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/2/4.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWPhotoBrowserListVC.h"
#import "BWTransitionCollectionCell.h"
#import "BWPhotoBrowserVC.h"
#import "BWCustomTransition.h"
@interface BWPhotoBrowserListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray * imgDataSource;
@end
static NSString * const kCollectionCellId = @"kCollectionCellId";

@implementation BWPhotoBrowserListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}
#pragma mark:UICollectionViewDelegate && UICollectionViewDataSource
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BWTransitionCollectionCell * collectionCell = (BWTransitionCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    BWPhotoBrowserVC * photoBrowserVC = [[BWPhotoBrowserVC alloc]initWithImgList:self.imgDataSource selectedIndex:indexPath.item];
    [photoBrowserVC setInitializeBlock:^(BWTransitionManager *manager) {
        manager.stackInType = BWAnimationTransition_PhotoBrowserIn;
        manager.stackOutType = BWAnimationTransition_PhotoBrowserOut;
        manager.transitionDuration_StackIn = 2.0;
        manager.transitionDuration_StackOut = 2.0;
        manager.photoBrowserImgView = collectionCell.imgView;
        manager.photoListView = collectionView;
    }];
    [self.navigationController presentViewController:photoBrowserVC animated:YES completion:nil];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgDataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BWTransitionCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellId forIndexPath:indexPath];
    [cell.imgView setImage:[UIImage imageNamed:self.imgDataSource[indexPath.item]]];
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(400, 10, 0, 10);
}

#pragma mark:懒加载
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width = ([UIScreen mainScreen].bounds.size.width - 40)/3.0;
        layout.itemSize = CGSizeMake(floor(width), floor(width));
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
        [_collectionView registerClass:[BWTransitionCollectionCell class] forCellWithReuseIdentifier:kCollectionCellId];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}
-(NSArray *)imgDataSource{
    if (_imgDataSource == nil) {
        _imgDataSource = @[@"lufei_1",@"lufei_2",@"lufei_3",@"lufei_4",@"lufei_5",@"lufei_6",@"lufei_7",@"lufei_8",@"lufei_9"];
    }
    return _imgDataSource;
}

@end
