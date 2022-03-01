//
//  OSSPinLockDemo.m
//  gcd-线程同步
//
//  Created by 舒通 on 2022/3/1.
//

#import "OSSPinLockDemo.h"
#import <libkern/OSAtomic.h>

@interface OSSPinLockDemo ()
// 同一个变量的读写要使用同一个锁，才能锁住
@property (nonatomic, assign) OSSpinLock lock;
@property (nonatomic, assign) OSSpinLock ticketLock;
@end
@implementation OSSPinLockDemo

/**
 OSSpinlock 是自旋锁，一直等待上个线程的完成。
 类似一个while循环一直询问是否解锁.
 
 因为存在优先级反转的问题，所以不推荐使用了
 */

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lock = OS_SPINLOCK_INIT;
        self.ticketLock = OS_SPINLOCK_INIT;
    }
    return self;
}
- (void)__saveMoney {
    OSSpinLockLock(&_lock);// 加锁
    [super __saveMoney];
    OSSpinLockUnlock(&_lock); // 解锁
}
- (void)__drawMoney {
    OSSpinLockLock(&_lock);// 加锁
    [super __drawMoney];
    OSSpinLockUnlock(&_lock); // 解锁
}

- (void)__saleTicket {
    OSSpinLockLock(&_ticketLock);// 加锁
    [super __saleTicket];
    OSSpinLockUnlock(&_ticketLock); // 解锁
}

@end
