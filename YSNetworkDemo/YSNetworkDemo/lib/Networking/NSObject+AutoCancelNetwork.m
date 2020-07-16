//
//  NSObject+AutoCancelNetwork.m


#import "NSObject+AutoCancelNetwork.h"
#import <objc/runtime.h>

@implementation NSObject (AutoCancelNetwork)
/**
 id object ：关联的源对象
 const void *key：关联的key
 id value：关联对象，通过将此个值置成nil来清除关联。
 objc_AssociationPolicy policy：关联的策略
 
 关键策略是一个enum值
 OBJC_ASSOCIATION_ASSIGN = 0,      <指定一个弱引用关联的对象>
 OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,<指定一个强引用关联的对象>
 OBJC_ASSOCIATION_COPY_NONATOMIC = 3,  <指定相关的对象复制>
 OBJC_ASSOCIATION_RETAIN = 01401,      <指定强参考>
 OBJC_ASSOCIATION_COPY = 01403    <指定相关的对象复制>
 */
- (AutoCancelNetwork *)autoCancelNetworkRequests {
    AutoCancelNetwork *requests = objc_getAssociatedObject(self, @selector(autoCancelNetworkRequests));
    if (requests == nil) {
        requests = [[AutoCancelNetwork alloc]init];
        objc_setAssociatedObject(self, @selector(autoCancelNetworkRequests), requests, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return requests;
}
@end
