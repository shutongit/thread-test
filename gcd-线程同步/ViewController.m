//
//  ViewController.m
//  gcd-线程同步
//
//  Created by 舒通 on 2022/2/28.
//

#import "ViewController.h"
#import "PthreadMutexCondDemo.h"
#import "NSLockDemo.h"
#import "NSCondtionDemo.h"
#import "NSConditionLockDemo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    PthreadMutexCondDemo *demo = [[PthreadMutexCondDemo alloc]init];
//    [demo otherTest];
    
//    NSLockDemo *demo1 = [[NSLockDemo alloc]init];
//    [demo1 takeMoneyTest];
//    [demo1 otherTest];
    
//    NSCondtionDemo *demo = [[NSCondtionDemo alloc]init];
//    [demo otherTest];
    
    NSConditionLockDemo *demo = [[NSConditionLockDemo alloc]init];
    [demo otherTest];
}


@end
