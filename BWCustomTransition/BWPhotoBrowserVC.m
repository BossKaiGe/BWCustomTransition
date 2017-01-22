//
//  BWPhotoBrowserVC.m
//  BWPhotoBrowser
//
//  Created by 静静静 on 15/10/16.
//  Copyright © 2015年 BossKai. All rights reserved.
//
#import "BWPhotoBrowserVC.h"
#import "BWPhotoBrowserView.h"
#import "BWTransitionCollectionCell.h"
#import "UIViewController+animationBlock.h"
#import "BWTransitionManager.h"
@interface BWPhotoBrowserVC ()
@property (nonatomic,strong)NSArray * imageList;
@property (nonatomic,strong)UIButton * rightBtn;
@property (nonatomic,strong)BWPhotoBrowserView * collectionView;
@property (nonatomic,strong) UIPageControl * pageControl;
@property (nonatomic,strong)NSIndexPath * indexPath;
@end

@implementation BWPhotoBrowserVC
-(instancetype)initWithImgList:(NSArray *)imgList selectedIndex:(NSInteger)index{
    self = [super init];
    if (self) {
        self.imageList = imgList;
        self.indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:(UICollectionViewScrollPositionNone) animated:NO];
}

-(void)rightBtnClick
{
    self.manager.photoBrowserImgView = [self currentImageView];
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismiss");
    }];
}
//pageControl点击事件
-(void)pageControlChange
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:self.pageControl.currentPage inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionNone) animated:YES];
}
-(void)setUpUI
{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.rightBtn];
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = self.imageList.count;
    self.pageControl.currentPage = self.indexPath.item;
    self.collectionView.pageControl = self.pageControl;
    
    CGFloat margin = 10;
    self.rightBtn.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBtn attribute:(NSLayoutAttributeRight) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeRight) multiplier:1 constant:-margin]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBtn attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeBottom) multiplier:1 constant:-margin]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBtn attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1 constant:70]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBtn attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1 constant:30]];
    
    self.pageControl.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeCenterX) multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:(NSLayoutAttributeBottom) relatedBy:(NSLayoutRelationEqual) toItem:self.view attribute:(NSLayoutAttributeBottom) multiplier:1 constant:-margin]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1 constant:100]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.rightBtn attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1 constant:30]];
    
}
#pragma mark 懒加载
-(UIButton *)rightBtn
{
    if (_rightBtn == nil) {
        _rightBtn = [[UIButton alloc]init];
        [_rightBtn setBackgroundColor:[UIColor darkGrayColor]];
        [_rightBtn setTitle:@"返回" forState:(UIControlStateNormal)];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _rightBtn;
}
-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[BWPhotoBrowserView alloc]initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc]init] imageList:self.imageList];
    }
    return _collectionView;
}
-(NSIndexPath *)indexPath
{
    if (_indexPath == nil) {
        _indexPath = [[NSIndexPath alloc]init];
    }
    return _indexPath;
}
-(UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]init];
        [_pageControl addTarget:self action:@selector(pageControlChange) forControlEvents:(UIControlEventValueChanged)];
    }
    return _pageControl;
}
-(UIImageView *)currentImageView
{
    NSIndexPath * currentIndexPath = [[self.collectionView indexPathsForVisibleItems]lastObject];
    BWTransitionCollectionCell * cell = (BWTransitionCollectionCell *)[self.manager.photoListView cellForItemAtIndexPath:currentIndexPath];
    return cell.imgView;
}
@end
