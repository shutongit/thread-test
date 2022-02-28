//
//  NSConditionLockDemo.m
//  gcd-线程同步
//
//  Created by 舒通 on 2022/2/28.
//

#import "NSConditionLockDemo.h"

@interface NSConditionLockDemo ()
@property (nonatomic, strong) NSConditionLock *conditionLock;

@property (nonatomic, strong) NSRecursiveLock *recursiveLock;
@end

@implementation NSConditionLockDemo
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.conditionLock = [[NSConditionLock alloc]initWithCondition:1];
        self.recursiveLock = [[NSRecursiveLock alloc]init];
    }
    return self;
}
- (void)otherTest {

    [[[NSThread alloc]initWithTarget:self selector:@selector(otherTest1) object:nil] start];
    [[[NSThread alloc]initWithTarget:self selector:@selector(otherTest2) object:nil] start];
    [[[NSThread alloc]initWithTarget:self selector:@selector(otherTest3) object:nil] start];
}
- (void)otherTest1 {
    [self.conditionLock lock]; // 加锁 不论条件是多少，只要没有加锁就都可以加锁成功
    NSLog(@"%s",__func__);
    sleep(1);
    [self.conditionLock unlockWithCondition:3]; //解锁，并设置锁的条件是3
}
- (void)otherTest2 {
    [self.conditionLock lockWhenCondition:3];  // 当条件是3的时候 才能加锁
    NSLog(@"%s",__func__);
    sleep(1);
    [self.conditionLock unlockWithCondition:4];
}
- (void)otherTest3 {
    [self.conditionLock lockWhenCondition:4];
    NSLog(@"%s",__func__);
    sleep(1);
    [self.conditionLock lock];
}
//
//- (void)otherTest1 {
//    [self.recursiveLock lock];
//    NSLog(@"%s",__func__);
//    [self otherTest2];
//    sleep(1);
//    [self.recursiveLock unlock];
//}
//- (void)otherTest2 {
//    [self.recursiveLock lock];
//    NSLog(@"%s",__func__);
//    [self otherTest3];
//    sleep(1);
//    [self.recursiveLock unlock];
//}
//- (void)otherTest3 {
//    [self.recursiveLock lock];
//    NSLog(@"%s",__func__);
//    sleep(1);
//    [self.recursiveLock unlock];
//}

@end
