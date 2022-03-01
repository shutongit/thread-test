//
//  OSUnfairLockDemo.m
//  gcd-线程同步
//
//  Created by 舒通 on 2022/3/1.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>

@interface OSUnfairLockDemo ()
@property (nonatomic, assign) os_unfair_lock moneyLock;
@property (nonatomic, assign) os_unfair_lock ticketLock;
@end
@implementation OSUnfairLockDemo

/*
 是对OSSpinlock的优化， 但是只支持ios10.0+
 
 */

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moneyLock = OS_UNFAIR_LOCK_INIT;
        self.ticketLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

- (void)__saveMoney {
    // 对应的加锁和解锁的锁一定要一致，否则会死锁
    os_unfair_lock_lock(&_moneyLock);
    [super __saveMoney];
    os_unfair_lock_unlock(&_moneyLock);
}
- (void)__drawMoney {
    os_unfair_lock_lock(&_moneyLock);
    [super __drawMoney];
    os_unfair_lock_unlock(&_moneyLock);
}

- (void)__saleTicket {
    os_unfair_lock_lock(&_ticketLock);
    [super __saleTicket];
    os_unfair_lock_unlock(&_ticketLock);
}
@end
