//
//  PthreadMutexCondDemo.m
//  gcd-线程同步
//
//  Created by 舒通 on 2022/2/28.
//

#import "PthreadMutexCondDemo.h"
#import <pthread.h>

@interface PthreadMutexCondDemo ()
@property (nonatomic, assign) pthread_mutex_t mutex;
@property (nonatomic, assign) pthread_cond_t cond;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PthreadMutexCondDemo
// 线程条件

//初始化线程
- (void)__initPthreadMutex:(pthread_mutex_t *)mutex {
    // 配置属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    // 初始化锁
    pthread_mutex_init(mutex, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
}
- (instancetype)init {
    if (self = [super init]) {
        [self __initPthreadMutex:&_mutex];
        pthread_cond_init(&_cond, NULL);// 初始化条件 类型为null是默认锁
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    // 销毁锁
    pthread_mutex_destroy(&_mutex);
}

- (void)otherTest {
 
    [[[NSThread alloc]initWithTarget:self selector:@selector(__delete) object:nil] start];
    [[[NSThread alloc]initWithTarget:self selector:@selector(__add) object:nil] start];
}
- (void)__add {
    NSLog(@"%s",__func__);
    pthread_mutex_lock(&_mutex);
    [self.dataArray addObject:@"test"];
    NSLog(@"添加完数据");
    pthread_cond_signal(&_cond); // 完成之后 通知条件 再次加锁
    pthread_mutex_unlock(&_mutex);
}
- (void)__delete {
    NSLog(@"%s",__func__);
    pthread_mutex_lock(&_mutex);
    if (self.dataArray.count == 0) {
        // 如果数据为空 ， 则等待有数据之后 再进行删除
        pthread_cond_wait(&_cond, &_mutex);// 第一次先释放锁， 然后不往下走了。再次唤醒会再次加锁，然后下面在释放锁
    }
    [self.dataArray removeLastObject];
    NSLog(@"删除完数据");
    pthread_mutex_unlock(&_mutex);
}

@end
