//
//  BWPhotoBrowserView.h
//  BWPhotoBrowser
//
//  Created by 静静静 on 15/10/16.
//  Copyright © 2015年 BossKai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWPhotoBrowserView : UICollectionView
@property (nonatomic,strong) UIPageControl * pageControl;
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout imageList:(NSMutableArray *)imageList;
@end
