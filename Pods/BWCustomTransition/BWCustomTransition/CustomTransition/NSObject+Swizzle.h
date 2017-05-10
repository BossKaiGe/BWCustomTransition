//
//  NSObject+Swizzle.h
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/11.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_IPHONE_SIMULATOR
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif
@interface NSObject (Swizzle)
+ (BOOL)bw_swizzleMethod:(SEL)origSel_ withClass:(Class)altClass_ withMethod:(SEL)altSel_ error:(NSError **)error_;
@end
