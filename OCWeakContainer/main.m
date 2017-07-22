//
//  main.m
//  OCWeakContainer
//
//  Created by Nemocdz on 2017/7/22.
//  Copyright © 2017年 Nemocdz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableSet+WeakSet.h"


#define logRetainCount(x) NSLog(@"objectReatinCount:%@",[(x) valueForKey:@"retainCount"])

void func1() {
    NSLog(@"----NSHashTable/NSMaptable/NSPointerArray---");
    NSObject *object = [NSObject.alloc init];
    logRetainCount(object);

    NSMutableSet<NSObject *> *set = [NSMutableSet set];
    [set addObject:object];
    logRetainCount(object);
    
    NSHashTable<NSObject *> *weakSet = [NSHashTable weakObjectsHashTable];
    [weakSet addObject:object];
    logRetainCount(object);

    NSMutableDictionary<NSString *,NSObject *> *dic = [NSMutableDictionary dictionary];
    [dic setObject:object forKey:@"key"];
    logRetainCount(object);
    
    NSMapTable<NSString *,NSObject *> *weakDic = [NSMapTable strongToWeakObjectsMapTable];
    [weakDic setObject:object forKey:@"key"];
    logRetainCount(object);
    
    NSMutableArray<NSObject *> *array = [NSMutableArray array];
    [array addObject:object];
    logRetainCount(object);

    NSLog(@"%@",object);
    void *point = (__bridge void *)object;
    NSLog(@"%@",(__bridge NSObject *)point);
    
    NSPointerArray  *weakArray = [NSPointerArray weakObjectsPointerArray];
    [weakArray addPointer:point];
    logRetainCount(object);
    
    NSLog(@"-------");
}


void func2() {
    NSLog(@"----CFFoundation---");
    NSObject *object = [NSObject.alloc init];
    logRetainCount(object);
    
    NSMutableSet *set = [NSMutableSet set];
    [set addObject:object];
    logRetainCount(object);
    
    NSMutableSet *weakSet = [NSMutableSet cdz_weakSet];
    [weakSet addObject:object];
    logRetainCount(object);
    
    NSLog(@"-------");
}


void func3() {
    NSLog(@"---MRC---");
    
    NSObject *object = [NSObject.alloc init];
    logRetainCount(object);
    
    NSMutableSet *set = [NSMutableSet set];
    [set addObject:object];
    logRetainCount(object);
    
    NSMutableSet *set_ = [NSMutableSet set];
    [set_ cdz_weakAddObject:object];
    logRetainCount(object);
    [set_ cdz_removeAllObjects];
    
    NSLog(@"-----");
}


void func4() {
    NSLog(@"----NSValue---");
    NSObject *object = [NSObject.alloc init];
    logRetainCount(object);
    NSLog(@"%@",object);
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:object];
    logRetainCount(object);
    
    NSValue *weakObject = [NSValue valueWithNonretainedObject:object];
    NSLog(@"%@",weakObject.nonretainedObjectValue);
    [array addObject:weakObject];
    logRetainCount(object);
    
    NSLog(@"-------");
}

typedef id(^CDZWeakObjectBlock)();

CDZWeakObjectBlock blockOfObjcet (id object) {
    __weak id weakObjcet = object;
    return ^{
        return weakObjcet;
    };
}


id objectOfBlock (CDZWeakObjectBlock block) {
    if (block) {
        return block();
    }
    else {
        return nil;
    }
}



void func5() {
    NSLog(@"---block---");
    
    NSObject *object = [NSObject.alloc init];
    logRetainCount(object);
    NSLog(@"%@",object);
    
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:object];
    logRetainCount(object);
    
    
    CDZWeakObjectBlock block = blockOfObjcet(object);
    NSLog(@"%@",objectOfBlock(block));
    [array addObject:block];
    logRetainCount(object);
    
    NSLog(@"-----");
}








int main(int argc, const char * argv[]) {
    @autoreleasepool {
        func1();
        func2();
        func3();
        func4();
        func5();
        NSLog(@"Hello, World!");
    }
    return 0;
}


