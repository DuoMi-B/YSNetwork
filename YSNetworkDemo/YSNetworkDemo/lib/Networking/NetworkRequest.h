//
//  NetworkRequest.h


#import <Foundation/Foundation.h>
#import "Network.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkRequest : NSObject

+ (instancetype)defaultRequest;
/**
 正常的Json请求 默认回调
 
 @param handler 处理者
 @param methodType 请求方法
 @param url 请求链接
 @param params 参数
 @param cache 是否取缓存
 @param callBack 默认回调
 @return 网络请求相关

 */
- (Request *)requestWithHandler:(NSObject *)handler
                    method:(HTTPMethod)methodType
                       url:(NSString *)url
                    params:(NSDictionary *)params
                     cache:(BOOL)cache
                  callBack:(void(^)(BOOL isSuccess, NSDictionary * responseObject))callBack;


/**
 和前端公用接口的Http请求 默认回调
 
 @param handler 处理者
 @param methodType 请求类型
 @param url 请求地址
 @param params 参数
 @param cache 是否取缓存
 @param callBack 默认回调
 @return 网络请求相关
 */
- (Request *)requestHttpWithHandler:(NSObject *)handler
                        method:(HTTPMethod)methodType
                           url:(NSString *)url
                        params:(NSDictionary *)params
                         cache:(BOOL)cache
                      callBack:(void(^)(BOOL isSuccess, NSDictionary * responseObject))callBack;

/**
 一般请求的接口 默认回调
 
 @param handler 处理者
 @param methodType 方法
 @param url 链接地址
 @param params 参数
 @param cache 是否取缓存
 @param callBack 默认回调
 @return 网络请求相关
 */
- (Request *)requestOtherWithHandler:(NSObject *)handler
                         method:(HTTPMethod)methodType
                            url:(NSString *)url
                         params:(NSDictionary *)params
                          cache:(BOOL)cache
                       callBack:(void(^)(BOOL isSuccess, NSDictionary * responseObject))callBack;


/**
 正常的Json请求

 @param handler 处理者
 @param methodType 请求方法
 @param url 请求链接
 @param params 参数
 @param cache 是否取缓存
 @param successBlock 成功回调
 @param cacheBlock 缓存回调
 @param failureBlock 失败的回调
 @return 缓存key
 */
- (Request *)requestWithHandler:(NSObject *)handler
                    method:(HTTPMethod)methodType
                       url:(NSString *)url
                    params:(NSDictionary *)params
                     cache:(BOOL)cache
             responseCache:(void(^)(id responseCache))cacheBlock
              successBlock:(void(^)(id response))successBlock
              failureBlock:(void(^)(NSError *error))failureBlock;

/**
 只取缓存接口

 @param handler 处理者
 @param methodType 请求方式
 @param url 链接
 @param params 参数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void )requestCacheWithHandler:(NSObject *)handler
                          method:(HTTPMethod)methodType
                             url:(NSString *)url
                          params:(NSDictionary *)params
                    successBlock:(void(^)(id response))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock;


/**
 和前端公用接口的Http请求

 @param handler 处理者
 @param methodType 请求类型
 @param url 请求地址
 @param params 参数
 @param cache 是否取缓存
 @param successBlock 成功回调
 @param cacheBlock 缓存回调
 @param failureBlock 失败回调
 @return 缓存key
 */
- (Request *)requestHttpWithHandler:(NSObject *)handler
                        method:(HTTPMethod)methodType
                           url:(NSString *)url
                        params:(NSDictionary *)params
                         cache:(BOOL)cache
                 responseCache:(void(^)(id responseCache))cacheBlock
                  successBlock:(void(^)(id response))successBlock
                  failureBlock:(void(^)(NSError *error))failureBlock;

/**
 一般请求的接口

 @param handler 处理者
 @param methodType 方法
 @param url 链接地址
 @param params 参数
 @param cache 是否取缓存
 @param successBlock 成功回调
 @param cacheBlock 缓存回调
 @param failureBlock 失败回调
 @return 缓存key
 */
- (Request *)requestOtherWithHandler:(NSObject *)handler
                         method:(HTTPMethod)methodType
                            url:(NSString *)url
                         params:(NSDictionary *)params
                          cache:(BOOL)cache
                  responseCache:(void(^)(id responseCache))cacheBlock
                   successBlock:(void(^)(id response))successBlock
                   failureBlock:(void(^)(NSError *error))failureBlock;

/**
 一般请求的接口 ,不做参数截取
 
 @param handler 处理者
 @param methodType 方法
 @param url 链接地址
 @param params 参数
 @param cache 是否取缓存
 @param successBlock 成功回调
 @param cacheBlock 缓存回调
 @param failureBlock 失败回调
 @return 缓存key
 */
- (Request *)specialRequestOtherWithHandler:(NSObject *)handler
                                method:(HTTPMethod)methodType
                                   url:(NSString *)url
                                params:(NSDictionary *)params
                                 cache:(BOOL)cache
                         responseCache:(void(^)(id responseCache))cacheBlock
                          successBlock:(void(^)(id response))successBlock
                          failureBlock:(void(^)(NSError *error))failureBlock;

/**
 以form表单的形式提交数据

 @param handler 处理者
 @param url url
 @param params 参数
 @param cache 是否取缓存
 @param cacheBlock 缓存回到
 @param successBlock 成功回调
 @param failureBlock 失败回调
 @return 缓存key
 */
- (Request *)requestFormDataWithHandler:(NSObject *)handler
                                      url:(NSString *)url
                                   params:(NSDictionary *)params
                                    cache:(BOOL)cache
                            responseCache:(void(^)(id responseCache))cacheBlock
                             successBlock:(void(^)(id response))successBlock
                             failureBlock:(void(^)(NSError *error))failureBlock;


/**
 图片上传
 
 @param handler 处理者
 @param image 图片、或者是图片data
 @param apiName api地址
 @param keyName 服务器处理文件的字段
 @param progressBlock 进度回调
 @param responseBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)uploadImageWithHandler:(NSObject *)handler
                         image:(id)image
                       apiName:(NSString *)apiName
                       keyName:(NSString *)keyName
                      progress:(void (^)(NSProgress * uploadProgress))progressBlock
                 responesBlock:(void (^)(id response))responseBlock
                  failuerBlcok:(void (^)(NSError * error))failureBlock;


/**
 图片上传(带参数传给服务器)
 
 @param handler 处理者
 @param params 参数
 @param image 图片、或者是图片data
 @param apiName api地址
 @param keyName 服务器处理文件的字段
 @param progressBlock 进度回调
 @param responseBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)uploadImageToBLWithHandler:(NSObject *)handler
                        params:(NSDictionary *)params
                         image:(id)image
                       apiName:(NSString *)apiName
                       keyName:(NSString *)keyName
                      progress:(void (^)(NSProgress * uploadProgress))progressBlock
                 responesBlock:(void (^)(id response))responseBlock
                  failuerBlcok:(void (^)(NSError * error))failureBlock;
/**
 图片 images数组上传(带参数传给服务器)
 
 @param handler 处理者
 @param params 参数
 @param images 图片数组
 @param apiName api地址
 @param keyName 服务器处理文件的字段
 @param progressBlock 进度回调
 @param responseBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)uploadImageToBLWithHandler:(NSObject *)handler
                            params:(NSDictionary *)params
                             images:(NSArray <UIImage *> *)images
                           apiName:(NSString *)apiName
                           keyName:(NSString *)keyName
                          progress:(void (^)(NSProgress * uploadProgress))progressBlock
                     responesBlock:(void (^)(id response))responseBlock
                      failuerBlcok:(void (^)(NSError * error))failureBlock;
/**
 图片data数组上传(带参数传给服务器)
 
 @param handler 处理者
 @param params 参数
 @param datas data数组
 @param apiName api地址
 @param keyName 服务器处理文件的字段
 @param progressBlock 进度回调
 @param responseBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)uploadImageToBLWithHandler:(NSObject *)handler
                            params:(NSDictionary *)params
                            datas:(NSArray <NSData *> *)datas
                           apiName:(NSString *)apiName
                           keyName:(NSString *)keyName
                          progress:(void (^)(NSProgress * uploadProgress))progressBlock
                     responesBlock:(void (^)(id response))responseBlock
                      failuerBlcok:(void (^)(NSError * error))failureBlock;

/**
 图片上传 外部自构block 形式

 @param handler 处理者
 @param params 参数
 @param apiName 请求地址
 @param constructingBlock 构建回调
 @param progressBlock 进度回调
 @param responseBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)uploadImageToBLWithHandler:(NSObject *)handler
                            params:(NSDictionary *)params
                           apiName:(NSString *)apiName
         constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBlock
                          progress:(void (^)(NSProgress * uploadProgress))progressBlock
                     responesBlock:(void (^)(id response))responseBlock
                      failuerBlcok:(void (^)(NSError * error))failureBlock;


@end

NS_ASSUME_NONNULL_END
