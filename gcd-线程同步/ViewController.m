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


#import "OSSPinLockDemo.h"
#import "OSUnfairLockDemo.h"
#import "PthreadMutexDemo.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

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
    
//    NSConditionLockDemo *demo = [[NSConditionLockDemo alloc]init];
//    [demo otherTest];

    [self createUI];
    [self loadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    NSDictionary *dic =  [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.text = dic[@"subTitle"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            OSSPinLockDemo *demo = [[OSSPinLockDemo alloc]init];
            [demo saleTicketTest];
            [demo takeMoneyTest];
        }
            break;
        case 1:
        {
            OSUnfairLockDemo *demo = [[OSUnfairLockDemo alloc]init];
            [demo saleTicketTest];
            [demo takeMoneyTest];
        }
            break;
        case 2:
        {
            PthreadMutexDemo *demo = [[PthreadMutexDemo alloc]init];
            [demo saleTicketTest];
            [demo takeMoneyTest];
        }
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
        case 6:
            
            break;
        case 7:
            
            break;
        case 8:
            
            break;
        case 9:
            
            break;
        case 10:
            
            break;
        
    }
}

- (void)loadData {
    [self.dataArray addObjectsFromArray:@[@{@"title": @"OSSPinLock", @"subTitle": @"#import <libkern/OSAtomic.h>"},
                                          @{@"title": @"os_unfair_lock", @"subTitle": @"#import <os/lock.h>"},
                                          @{@"title": @"pthread_mutex", @"subTitle": @"#import <pthread.h>"},
                                          @{@"title": @"dispatch_semaphore", @"subTitle": @""},
                                          @{@"title": @"dispath_queue(DISPATCH_QUEUE_SERIAL)", @"subTitle": @""},
                                          @{@"title": @"NSLock", @"subTitle": @""},
                                          @{@"title": @"NSRecursiveLock", @"subTitle": @""},
                                          @{@"title": @"NSCondition", @"subTitle": @""},
                                          @{@"title": @"NSConditionLock", @"subTitle": @""},
                                          @{@"title": @"@synchronized", @"subTitle": @""},]];
    
    [self.tableView reloadData];
}
- (void)createUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
