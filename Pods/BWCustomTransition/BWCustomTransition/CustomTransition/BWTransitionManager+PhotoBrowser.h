//
//  BWTransitionManager+PhotoBrowser.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/21.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"

@interface BWTransitionManager (PhotoBrowser)
/**
 ImageView for transition animation
 */
@property(nonatomic,strong)UIImageView * photoBrowserImgView;

/**
 The photo list for transition animation
 */
@property(nonatomic,strong)UICollectionView * photoListView;

/**
 Generate an animation that transition to the photo browsing page

 @param duration The animation duration
 @return The animation blcok
 */
-(CustomAnimationBlock)generatePhotoBrowserInAnimationWithDuration:(CGFloat)duration;

/**
 Generate an animation that transition to the photo list page

 @param duration The animation duration
 @return The animation blcok
 */
-(CustomAnimationBlock)generatePhotoBrowserOutAnimationWithDuration:(CGFloat)duration;

/**
 Update the information to the final browsing location

 @param indexPath The final browsing location
 @param propertyName The name of the photo property in the list cell
 */
-(void)upDataImgWithPhotoListIndexPath:(NSIndexPath *)indexPath photoPropertyNameInListCell:(NSString *)propertyName;
@end
