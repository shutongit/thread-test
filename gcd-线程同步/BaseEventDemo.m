//
//  BaseEventDemo.m
//  gcd-线程同步
//
//  Created by 舒通 on 2022/2/28.
//

#import "BaseEventDemo.h"

@interface BaseEventDemo ()
@property (nonatomic, assign) int money;
@property (nonatomic, assign) int count;
@end
@implementation BaseEventDemo
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)saleTicketTest {
    self.count = 15;
    dispatch_queue_t queue = dispatch_queue_create("saleTicket", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i ++) {
            [self __saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i ++) {
            [self __saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i ++) {
            [self __saleTicket];
        }
    });
    
}
- (void)takeMoneyTest {
    self.money = 100;
    dispatch_queue_t queue = dispatch_queue_create("saveMoney", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i ++) {
            [self __saveMoney];
        }
    });
    dispatch_queue_t queue1 = dispatch_queue_create("drawMoney", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue1, ^{
        for (int i = 0; i < 5; i ++) {
            [self __drawMoney];
        }
    });
}
- (void)otherTest {}

- (void)__saleTicket {
    self.count --;
    NSLog(@"买完票后还有：%d票, %@",self.count, [NSThread currentThread]);
}
- (void)__saveMoney {
    self.money += 50;
    NSLog(@"存完钱后还有：%d钱, %@",self.money,[NSThread currentThread]);
}
- (void)__drawMoney {
    self.money -= 20;
    NSLog(@"取完钱后还有：%d钱, %@",self.money,[NSThread currentThread]);
}

@end
