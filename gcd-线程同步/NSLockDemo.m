//
//  NSLockDemo.m
//  gcd-线程同步
//
//  Created by 舒通 on 2022/2/28.
//

#import "NSLockDemo.h"

@interface NSLockDemo ()
/// 锁  封装pthread_mutex
@property (nonatomic, strong) NSLock *lock;
/// 递归锁
@property (nonatomic, strong) NSRecursiveLock *recursiveLock;
@end

@implementation NSLockDemo
- (instancetype)init {
    if ([super init]) {
        self.lock = [[NSLock alloc]init];
        self.recursiveLock = [[NSRecursiveLock alloc]init];
    }
    return self;
}
- (void)__saveMoney {
    [self.lock lock];
    [super __saveMoney];
    [self.lock unlock];
}
- (void)__drawMoney {
    [self.lock lock];
    [super __drawMoney];
    [self.lock unlock];
}

- (void)otherTest {
    NSLog(@"%s", __func__);
    [self.recursiveLock lock];
//    [self.lock lock];
        static int count = 0;
        if (count < 10) {
            count++;
            [self otherTest];
        }
    [self.recursiveLock unlock];
//    [self.lock unlock];
}
@end
