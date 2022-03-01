//
//  PthreadMutexDemo.m
//  gcd-线程同步
//
//  Created by 舒通 on 2022/3/1.
//

#import "PthreadMutexDemo.h"
#import <pthread.h>

@interface PthreadMutexDemo ()
@property (nonatomic, assign) pthread_mutex_t mutex;
@property (nonatomic, assign) pthread_mutex_t ticketMutex;
@end
@implementation PthreadMutexDemo

- (void)__initMutex:(pthread_mutex_t *)mutex {
    
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT); // 默认模式
    // 初始化mutex互斥锁
    pthread_mutex_init(mutex, &attr);  //        pthread_mutex_init(&mutex, NULL)// 条件为空 条件类型是默认模式

    // 释放属性
    pthread_mutexattr_destroy(&attr);
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __initMutex:&_mutex];
        [self __initMutex:&_ticketMutex];
        
    }
    return self;
}
- (void)dealloc { 
    // 释放锁
    pthread_mutex_destroy(&_mutex);
}
- (void)__saveMoney {
    // 互斥锁，如果当前线程有锁，则会睡眠等待解锁。然后上锁开始执行任务
    pthread_mutex_lock(&_mutex); // 加锁
    [super __saveMoney];
    pthread_mutex_unlock(&_mutex); //解锁
}

- (void)__drawMoney {
    pthread_mutex_lock(&_mutex);
    [super __drawMoney];
    pthread_mutex_unlock(&_mutex);
}


- (void)__saleTicket {
    pthread_mutex_lock(&_ticketMutex);
    [super __saleTicket];
    pthread_mutex_unlock(&_ticketMutex);
}
@end
