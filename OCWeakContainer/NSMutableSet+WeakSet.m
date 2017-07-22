//
//  NSMutableSet+WeakSet.m
//  OCWeakContainer
//
//  Created by Nemocdz on 2017/7/22.
//  Copyright © 2017年 Nemocdz. All rights reserved.
//

#import "NSMutableSet+WeakSet.h"

@implementation NSMutableSet (WeakSet)

+ (instancetype)cdz_weakSet{
    CFSetCallBacks callbacks = {0, NULL, NULL, CFCopyDescription, CFEqual};
    return (NSMutableSet *)CFBridgingRelease(CFSetCreateMutable(0, 0, &callbacks));
}



- (void)cdz_weakAddObject:(NSObject *)object{
    [self addObject:object];
    CFRelease((__bridge CFTypeRef)(object));
}

- (void)cdz_removeAllObjects{
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        CFRetain((__bridge CFTypeRef)(obj));
    }];
    [self removeAllObjects];
}


@end
