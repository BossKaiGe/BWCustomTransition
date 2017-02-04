//
//  BWTransitionManager+PhotoBrowserIn.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/21.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"

@interface BWTransitionManager (PhotoBrowserIn)
@property(nonatomic,strong)UIImageView * photoBrowserImgView;
@property(nonatomic,strong)UICollectionView * photoListView;
-(CustomAnimationBlock)generatePhotoBrowserInAnimationWithDuration:(CGFloat)duration;
-(CGRect)getRect;
-(CGRect)getFullRect;
@end
