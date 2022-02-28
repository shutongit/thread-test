//
//  BaseEventDemo.h
//  gcd-线程同步
//
//  Created by 舒通 on 2022/2/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseEventDemo : NSObject
- (void)saleTicketTest;
- (void)takeMoneyTest;
- (void)otherTest;

- (void)__saveMoney;
- (void)__drawMoney;
- (void)__saleTicket;
@end

NS_ASSUME_NONNULL_END
