//
//  DemoNetRegisterLoginProtocol.h
//

#import <Foundation/Foundation.h>
#import "Network.h"

@protocol DemoNetRegisterLoginProtocol <NSObject>



/**
 发送验证码
 
 @param url url
 @param params 参数
 @param methodType 请求方式
 @param callBack 回调
 */
- (void)sendSmsCodeWithUrl:(NSString *_Nullable)url
                    params:(NSDictionary *_Nullable)params
                    method:(HTTPMethod)methodType
                  callBack:(void(^_Nullable)(BOOL isSuccess, NSDictionary * _Nullable responseObject))callBack;


@end

