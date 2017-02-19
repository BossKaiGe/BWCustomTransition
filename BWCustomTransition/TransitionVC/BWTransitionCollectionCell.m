//
//  BWTransitionCollectionCell.m
//  BWCustomTransition
//
//  Created by 静静静 on 17/1/21.
//  Copyright © 2017年 BossKai. All rights reserved.
//

#import "BWTransitionCollectionCell.h"

@implementation BWTransitionCollectionCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgView];
    }
    return self;
}

-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imgView;
}
@end
