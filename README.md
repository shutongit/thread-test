

## iOS线程同步方案

- OSSPinLock

- os_unfair_lock

- pthread_mutex

- dispatch_semaphore

- dispath_queue(DISPATCH_QUEUE_SERIAL)

- NSLock

- NSRecursiveLock

- NSCondition

- NSConditionLock

- @synchronized

>   性能从高到低排序
   > - os_unfair_lock (ios10+)
   > - OSSPinLock （存在线程优先级反转问题,不推荐）
   > - dispatch_semaphore
   >  - pthread_mutex (支持多平台ios linux c等)
   >  - dispatch_queue(DISPATCH_QUEUE_SERIAL)
   >  - NSLock
   >  - NSCondition
   >  - pthread_mutex(recursive)
