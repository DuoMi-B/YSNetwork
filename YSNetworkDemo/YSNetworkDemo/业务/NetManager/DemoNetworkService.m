//
//  DemoNetworkService.m
//  

#import "DemoNetworkService.h"


@implementation DemoNetworkService

+ (instancetype)shareService {
    static DemoNetworkService *_shareService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareService = [DemoNetworkService alloc];
        _shareService.protocolHandlers = [NSMutableDictionary dictionary];
    });
    return _shareService;
}
- (void)registerHttps {

    [self registerHttpProtocol:@protocol(DemoNetRegisterLoginProtocol) handler:[DemoNetRegisterLoginHandler new]];
   
}
@end
