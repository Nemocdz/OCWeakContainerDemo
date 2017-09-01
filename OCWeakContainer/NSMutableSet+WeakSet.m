//
//  NSMutableSet+WeakSet.m
//  OCWeakContainer
//
//  Created by Nemocdz on 2017/7/22.
//  Copyright © 2017年 Nemocdz. All rights reserved.
//

#import "NSMutableSet+WeakSet.h"
#import <objc/runtime.h>

@interface CDZDeallocObserver : NSObject
@property (nonatomic, copy) void (^block)(void);
@end

@implementation CDZDeallocObserver
- (void)dealloc{
    if (self.block) {
        self.block();
    }
}
@end

const void *CDZDellocBlockKey = &CDZDellocBlockKey;

@implementation NSObject (DeallocBlock)

- (void)cdz_deallocBlock:(void(^)(void))block{
    CDZDeallocObserver *observer = objc_getAssociatedObject(self, CDZDellocBlockKey);
    if (!observer) {
        observer = [CDZDeallocObserver new];
        objc_setAssociatedObject(self, CDZDellocBlockKey, observer, OBJC_ASSOCIATION_RETAIN);
    }
    observer.block = block;
}
@end


@implementation NSMutableSet(WeakSet)

+ (instancetype)cf_weakSet{
    return (__bridge_transfer NSMutableSet *)CFSetCreateMutable(nil, 0, nil);
}

- (void)cf_addObject:(id)object{
    [self addObject:object];
    __unsafe_unretained typeof (object) unRetainObject = object;
    __weak typeof(self) weakSelf = self;
    [object cdz_deallocBlock:^{
        if (unRetainObject) {
            [weakSelf removeObject:unRetainObject];
        }
    }];
}


- (void)mrc_addObject:(id)object{
    [self addObject:object];
    __unsafe_unretained typeof (object) unRetainObject = object;
    __weak typeof(self) weakSelf = self;
    [object cdz_deallocBlock:^{
        if (unRetainObject) {
            [weakSelf removeObject:unRetainObject];
        }
    }];
    CFRelease((__bridge CFTypeRef)(object));
}

- (void)mrc_removeAllObjects{
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        CFRetain((__bridge CFTypeRef)(obj));
    }];
    [self removeAllObjects];
}


@end
