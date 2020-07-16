//
//  AutoCancelNetwork.m


#import "AutoCancelNetwork.h"

#define LOCK(...) dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER); \
__VA_ARGS__; \
dispatch_semaphore_signal(_lock);
@interface AutoCancelNetwork () {
    dispatch_semaphore_t _lock;

}
@property (nonatomic, strong) NSMutableArray<Request *> *requestsArray;
@end

@implementation AutoCancelNetwork
- (void)dealloc {
    [self.requestsArray enumerateObjectsUsingBlock:^(Request * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.task cancel];
    }];
    [self.requestsArray removeAllObjects];
    self.requestsArray = nil;
    

}
- (instancetype)init {
    if (self = [super init]) {
        _lock = dispatch_semaphore_create(1);
    }
    return self;
}
- (void)addTask:(Request *)pair {
    LOCK(
         [self.requestsArray addObject:pair];
    )
    
}
- (void)removeTask:(NSString *)key {
    LOCK(
    Request * removePair;
    for (Request * pair in self.requestsArray) {
        if (pair.key == key) {
            removePair = pair;
        }
    }
    [removePair.task cancel];
    [self.requestsArray removeObject:removePair];
    )
    
}
- (void)removeTask:(NSString *)key completion:(void (^)(void))completion {
    [self removeTask:key];
    if (completion) {
        completion();
        completion = nil;
    }
}
- (NSMutableArray *)requestsArray {
    if (!_requestsArray) {
        _requestsArray = [[NSMutableArray alloc] init];
        
    }
    return _requestsArray;
}
@end
