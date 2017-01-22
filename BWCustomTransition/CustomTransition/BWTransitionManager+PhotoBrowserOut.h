//
//  BWTransitionManager+PhotoBrowserOut.h
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/22.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionManager.h"

@interface BWTransitionManager (PhotoBrowserOut)
-(CustomAnimationBlock)generatePhotoBrowserOutAnimationWithDuration:(CGFloat)duration;
-(void)upDataImgWithPhotoListIndexPath:(NSIndexPath *)indexPath photoPropertyNameInListCell:(NSString *)propertyName;
@end
