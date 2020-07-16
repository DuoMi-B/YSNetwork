//
//  DemoNetRegisterLoginHandler.m
//

#import "DemoNetRegisterLoginHandler.h"
#import "NetworkRequest.h"

@implementation DemoNetRegisterLoginHandler



/**
 发送验证码
 
 @param url url
 @param params 参数
 @param methodType 请求方式
 @param callBack 回调
 */
- (void)sendSmsCodeWithUrl:(NSString *)url
                             params:(NSDictionary *)params
                             method:(HTTPMethod)methodType
                           callBack:(void(^)(BOOL isSuccess, NSDictionary * responseObject))callBack{
    
    [[NetworkRequest defaultRequest] requestWithHandler:self
                                                   method:methodType
                                                      url:url
                                                   params:params
                                                    cache:NO
                                                 callBack:callBack];
}

@end
