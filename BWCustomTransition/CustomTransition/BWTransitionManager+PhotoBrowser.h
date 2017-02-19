//
//  BWTransitionManager+PhotoBrowser.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/21.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"

@interface BWTransitionManager (PhotoBrowser)
@property(nonatomic,strong)UIImageView * photoBrowserImgView;
@property(nonatomic,strong)UICollectionView * photoListView;
-(CustomAnimationBlock)generatePhotoBrowserInAnimationWithDuration:(CGFloat)duration;
-(CustomAnimationBlock)generatePhotoBrowserOutAnimationWithDuration:(CGFloat)duration;
-(void)upDataImgWithPhotoListIndexPath:(NSIndexPath *)indexPath photoPropertyNameInListCell:(NSString *)propertyName;
-(CGRect)getRect;
-(CGRect)getFullRect;
@end
