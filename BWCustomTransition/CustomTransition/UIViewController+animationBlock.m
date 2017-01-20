//
//  UIViewController+animationBlock.m
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/16.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import "UIViewController+animationBlock.h"
#import "NSObject+Swizzle.h"
#import "BWCustomTransitionDelegate.h"
#import "BWTransitionManager.h"


static NSString * const kInitializeBlock = @"kInitializeBlock";
static NSString * const kTransitionManager = @"kTransitionManager";

@implementation UIViewController (animationBlock)
@dynamic initializeBlock;
@dynamic manager;
+(void)load{
    [self bw_swizzleMethod:@selector(bw_viewDidLoad) withClass:self withMethod:@selector(viewDidLoad) error:nil];
}
-(void)bw_viewDidLoad{
    [self bw_viewDidLoad];
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureFired:)];
    [self.view addGestureRecognizer:panGesture];
}
-(void)panGestureFired:(UIPanGestureRecognizer *)sender{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [[BWCustomTransitionDelegate shareInstance] performSelector:@selector(handlePanGestureRecognizer: withController:) withObject:sender withObject:self];
#pragma clang diagnostic pop
}

#pragma mark:properties

-(InitializeBlock)initializeBlock{
    return objc_getAssociatedObject(self, (__bridge const void *)(kInitializeBlock));
}
-(void)setInitializeBlock:(InitializeBlock)initializeBlock{
    objc_setAssociatedObject(self, (__bridge const void *)(kInitializeBlock), initializeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.manager = [[BWTransitionManager alloc]init];
    initializeBlock(self.manager);
    [self.manager generateAnimation];
    self.transitioningDelegate = self.manager;
}

-(BWTransitionManager *)manager{
    return objc_getAssociatedObject(self, (__bridge const void *)(kTransitionManager));
}
-(void)setManager:(BWTransitionManager *)manager{
    objc_setAssociatedObject(self, (__bridge const void *)(kTransitionManager), manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
