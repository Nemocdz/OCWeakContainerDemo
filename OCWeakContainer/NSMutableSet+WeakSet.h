//
//  NSMutableSet+WeakSet.h
//  OCWeakContainer
//
//  Created by Nemocdz on 2017/7/22.
//  Copyright © 2017年 Nemocdz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableSet (WeakSet)

+ (instancetype)cdz_weakSet;

- (void)cdz_weakAddObject:(NSObject *)objcet;

- (void)cdz_removeAllObjects;

@end
