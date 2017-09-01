//
//  NSMutableSet+WeakSet.h
//  OCWeakContainer
//
//  Created by Nemocdz on 2017/7/22.
//  Copyright © 2017年 Nemocdz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableSet<ObjectType>  (WeakSet)

+ (instancetype)cf_weakSet;
- (void)cf_addObject:(ObjectType)object;

- (void)mrc_addObject:(ObjectType)object;
- (void)mrc_removeAllObjects;

@end


