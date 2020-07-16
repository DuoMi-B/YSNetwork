//
//  NetworkService.m


#import "NetworkService.h"
#import <objc/runtime.h>

@implementation NetworkService
static NetworkService *_shareService = nil;
+ (instancetype)shareService {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareService = [[self alloc] init];
        _shareService.protocolHandlers = [NSMutableDictionary dictionary];
    });
    return _shareService;
}

- (void)registerHttps {
   
}

/**
 *
 * 1.遍历Protocol的所有方法（利用Objective-C的Runtime）。
 * 2.保存Protocol所有方法到实现类的对象的映射关系。（用方法的字符串表示作为key，实现类对象为value）
 */
- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler {
    unsigned int numberOfMethods = 0;
     //获取Protocol的所有方法
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(httpProtocol, YES, YES, &numberOfMethods);
     //为Protocol的每个方法注册真正的实现类对象handler
    for (unsigned int i = 0; i < numberOfMethods; i++) {
        struct objc_method_description method = methods[i];
        [_protocolHandlers setValue:handler forKey:NSStringFromSelector(method.name)];
    }
}

- (id)forwardingTargetForSelector:(SEL)selector {
     //获取method的字符串表示
    NSString *methodsName = NSStringFromSelector(selector);
    //查找对应实现类对象
    id handler = [_protocolHandlers valueForKey:methodsName];
    //再次检查handler是否可以响应此消息
    if (handler != nil && [handler respondsToSelector:selector]) {
        return handler;
    }
    return nil;
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}
@end
