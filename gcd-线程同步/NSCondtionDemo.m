//
//  NSCondtionLockDemo.m
//  gcd-线程同步
//
//  Created by 舒通 on 2022/2/28.
//

#import "NSCondtionDemo.h"

@interface NSCondtionDemo ()
// 对mutex和cond的封装
@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, strong) NSMutableArray *data;
@end
@implementation NSCondtionDemo
//
- (instancetype)init {
    self = [super init];
    if (self) {
        self.condition = [[NSCondition alloc]init];
        self.data = [NSMutableArray array];
    }
    return self;
}
- (void)otherTest {
    [[[NSThread alloc]initWithTarget:self selector:@selector(__delete) object:nil]start];
    [[[NSThread alloc]initWithTarget:self selector:@selector(__add) object:nil]start];
}
- (void)__add {
    NSLog(@"%s",__func__);
    [self.condition lock];
    [self.data addObject:@"test"];
//    [self.condition broadcast];/// 广播
    NSLog(@"添加完数据");
    [self.condition signal];
    [self.condition unlock];
}
- (void)__delete {
    NSLog(@"%s",__func__);
    [self.condition lock];
    if (self.data.count == 0) {
        [self.condition wait];
    }
    [self.data removeLastObject];
    NSLog(@"删除完数据");
    [self.condition unlock];
}

@end
