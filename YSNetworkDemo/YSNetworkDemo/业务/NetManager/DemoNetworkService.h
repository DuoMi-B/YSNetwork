//
//  DemoNetworkService.h
// 

#import "NetworkService.h"
#import "DemoNetRegisterLoginHandler.h"


@interface DemoNetworkService : NetworkService<DemoNetRegisterLoginProtocol>
+ (instancetype)shareService ;
//注册具体实现类
- (void)registerHttps;
@end


