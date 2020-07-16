//
//  NetworkService.h


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSProxy
//保存映射关系的字典。
@property (nonatomic, strong) NSMutableDictionary *protocolHandlers;
- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler;
//获取单例
+ (instancetype)shareService;
//注册具体实现类
- (void)registerHttps;
@end

NS_ASSUME_NONNULL_END
