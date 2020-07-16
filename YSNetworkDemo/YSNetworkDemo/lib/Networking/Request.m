//
//  Request.m


#import "Request.h"
#import "NetworkCache.h"

@interface Request()
@property (nonatomic, strong) NSURLSessionDataTask * task;
@end

@implementation Request
+ (id)create:(id)key value:(id)task {
    Request *pair = [[Request alloc] init];
    pair.key = key;
    pair.task = task;
    return pair;
}
- (BOOL)isContainsCache {
   id response = [[NetworkCache defaultCache] getResponseCacheForKey:self.key];
    return response == nil ? NO : YES;
}
@end
