//
//  NSObject+Swizzle.m
//  BWCustomTransition
//
//  Created by 静静静 on 16/9/11.
//  Copyright © 2016年 BossKai. All rights reserved.
//

#import "NSObject+Swizzle.h"
#define SetNSErrorFor(FUNC, ERROR_VAR, FORMAT,...)   \
if (ERROR_VAR) {   \
NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,FUNC,##__VA_ARGS__]; \
*ERROR_VAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" \
code:-1	\
userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]]; \
}

#define SetNSError(ERROR_VAR, FORMAT,...) SetNSErrorFor(__func__, ERROR_VAR, FORMAT, ##__VA_ARGS__)

@implementation NSObject (Swizzle)
+ (BOOL)bw_swizzleMethod:(SEL)origSel_ withClass:(Class)altClass_ withMethod:(SEL)altSel_ error:(NSError **)error_
{
    Method origMethod = class_getInstanceMethod([self class], origSel_);
    if (!origMethod)
    {
        SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self class]);
        
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(altClass_, altSel_);
    if (!altMethod)
    {
        SetNSError(error_, @"alternate method %@ not fount for class %@", NSStringFromSelector(altSel_), altClass_);
        
        return NO;
    }
    if(class_addMethod([self class], altSel_, method_getImplementation(origMethod),method_getTypeEncoding(origMethod)))
    {
        class_replaceMethod([self class], origSel_, method_getImplementation(altMethod), method_getTypeEncoding(altMethod));
    }
    else
    {
        method_exchangeImplementations(origMethod, altMethod);
    }
    return YES;
}


@end
