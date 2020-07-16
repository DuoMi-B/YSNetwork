//
//  NetworkRequest.m


#import "NetworkRequest.h"
#import "Network.h"
#import "NSObject+AutoCancelNetwork.h"
#import "NetworkCache.h"
#import "DemoNetworkVerify.h"


/**
 网络请求打印函数
 
 @param para 参数
 @param url 地址
 @param resonpse 响应
 */
static void BLNetworkingLog(NSDictionary * para, NSString * url, id resonpse) {
    NSString *responseString;
    if (!resonpse) {
        responseString = @"";
    } else {
        NSData* jsonData =[NSJSONSerialization dataWithJSONObject:resonpse
                                                          options:NSJSONWritingPrettyPrinted error:nil];
        responseString = [[NSString alloc] initWithData:jsonData
                                               encoding:NSUTF8StringEncoding];
    }
    NSString *paraString;
    if (!para) {
        paraString = @"";
    } else {
        NSData* jsonData =[NSJSONSerialization dataWithJSONObject:para
                                                          options:NSJSONWritingPrettyPrinted error:nil];
        paraString = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
        
    }
    
    NSLog(@"\n\n🍺🍺🍺🍺🍺🍺 network info 🍺🍺🍺🍺🍺🍺");
    NSLog(@" parameters = %@\n",paraString);
    NSLog(@" url = %@\n",url);
    NSLog(@" response = %@\n",responseString);
    NSLog(@"🍺🍺🍺🍺🍺🍺 info end 🍺🍺🍺🍺🍺🍺\n\n");
}

/**
 网络请求错误打印函数
 
 @param para 参数
 @param url 地址
 @param error 错误
 */
static void BLNetworkingErrorLog(NSDictionary * para, NSString * url, NSError * error) {
    NSString *paraString;
    if (!para) {
        paraString = @"";
    } else {
        NSData* jsonData =[NSJSONSerialization dataWithJSONObject:para
                                                          options:NSJSONWritingPrettyPrinted error:nil];
        paraString = [[NSString alloc] initWithData:jsonData
                                           encoding:NSUTF8StringEncoding];
    }
    NSLog(@"\n\n🍏🍏🍏🍏🍏🍏 network error 🍏🍏🍏🍏🍏🍏");
    NSLog(@" parameters = %@\n",paraString);
    NSLog(@" url = %@\n",url);
    NSLog(@" error = %@\n",error.userInfo[NSLocalizedDescriptionKey]);
    NSLog(@"🍏🍏🍏🍏🍏🍏 error end 🍏🍏🍏🍏🍏🍏\n\n");
}



@interface NetworkRequest ()
@property (nonatomic, strong) Network *network;
@end

@implementation NetworkRequest
+ (instancetype)defaultRequest {
    return [[self alloc] init];
}
- (instancetype)init {
    if (self = [super init]) {
        self.network = [Network network];
        self.network.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.network.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/javascript", @"text/plain",@"text/html", nil];
    }
    return self;
}
/**
 正常的Json请求 默认回调
 
 @param handler 处理者
 @param methodType 请求方法
 @param url 请求链接
 @param params 参数
 @param cache 是否缓存
 @param callBack 默认回调
 
 */
- (Request *)requestWithHandler:(NSObject *)handler
                    method:(HTTPMethod)methodType
                       url:(NSString *)url
                    params:(NSDictionary *)params
                     cache:(BOOL)cache
                  callBack:(void(^)(BOOL isSuccess, NSDictionary * responseObject))callBack {
   return  [self requestWithHandler:handler
                      method:methodType
                         url:url
                      params:params
                       cache:cache
               responseCache:^(id  _Nonnull responseCache) {
                   if (cache) {
                       if (callBack) {
                           callBack(YES,responseCache);
                       }
                   }
               }
                successBlock:^(id  _Nonnull response) {
                    if (callBack) {
                        callBack(YES,response);
                    }
                    
                }
                failureBlock:^(NSError * _Nonnull error) {
                    if (callBack) {
                        callBack(NO,nil);
                    }
                    
                }];
}


/**
 和前端公用接口的Http请求 默认回调
 
 @param handler 处理者
 @param methodType 请求类型
 @param url 请求地址
 @param params 参数
 @param cache 缓存
 @param callBack 默认回调
 */
- (Request *)requestHttpWithHandler:(NSObject *)handler
                        method:(HTTPMethod)methodType
                           url:(NSString *)url
                        params:(NSDictionary *)params
                         cache:(BOOL)cache
                      callBack:(void(^)(BOOL isSuccess, NSDictionary * responseObject))callBack {
   return  [self requestHttpWithHandler:handler
                          method:methodType
                             url:url
                          params:params
                           cache:cache
                   responseCache:^(id  _Nonnull responseCache) {
                       if (cache) {
                           if (callBack) {
                               callBack(YES,responseCache);
                           }
                       }
                   }
                    successBlock:^(id  _Nonnull response) {
                        if (callBack) {
                            callBack(YES,response);
                        }
                        
                    }
                    failureBlock:^(NSError * _Nonnull error) {
                        if (callBack) {
                            callBack(NO,nil);
                        }
                        
                    }];
    
}

/**
 一般请求的接口 默认回调
 
 @param handler 处理者
 @param methodType 方法
 @param url 链接地址
 @param params 参数
 @param cache 缓存
 @param callBack 默认回调
 */
- (Request *)requestOtherWithHandler:(NSObject *)handler
                         method:(HTTPMethod)methodType
                            url:(NSString *)url
                         params:(NSDictionary *)params
                          cache:(BOOL)cache
                       callBack:(void(^)(BOOL isSuccess, NSDictionary * responseObject))callBack {
    
   return  [self requestOtherWithHandler:handler
                           method:methodType
                              url:url
                           params:params
                            cache:cache
                    responseCache:^(id  _Nonnull responseCache) {
                        if (cache) {
                            if (callBack) {
                                callBack(YES,responseCache);
                            }
                        }
                    }
                     successBlock:^(id  _Nonnull response) {
                         if (callBack) {
                             callBack(YES,response);
                         }
                         
                     }
                     failureBlock:^(NSError * _Nonnull error) {
                         if (callBack) {
                             callBack(NO,nil);
                         }
                         
                     }];
}
- (Request *)requestWithHandler:(NSObject *)handler
                    method:(HTTPMethod)methodType
                       url:(NSString *)url
                    params:(NSDictionary *)params
                     cache:(BOOL)cache
             responseCache:(void (^)(id _Nonnull))cacheBlock
              successBlock:(void (^)(id _Nonnull))successBlock
              failureBlock:(void (^)(NSError * _Nonnull))failureBlock{
    return [self requestWithHandler:handler
                      isJson:YES
                    isFromBL:YES
                      method:methodType
                         url:url
                      params:params
                       cache:cache
               responseCache:cacheBlock
                successBlock:successBlock
                failureBlock:failureBlock];
    
}
- (Request *)requestHttpWithHandler:(NSObject *)handler
                        method:(HTTPMethod)methodType
                           url:(NSString *)url
                        params:(NSDictionary *)params
                         cache:(BOOL)cache
                 responseCache:(void (^)(id _Nonnull))cacheBlock
                  successBlock:(void (^)(id _Nonnull))successBlock
                  failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    return [self requestWithHandler:handler
                      isJson:NO
                    isFromBL:YES
                      method:methodType
                         url:url
                      params:params
                       cache:cache
               responseCache:cacheBlock
                successBlock:successBlock
                failureBlock:failureBlock];
    
}
- (Request *)requestOtherWithHandler:(NSObject *)handler
                         method:(HTTPMethod)methodType
                            url:(NSString *)url
                         params:(NSDictionary *)params
                          cache:(BOOL)cache
                  responseCache:(void (^)(id _Nonnull))cacheBlock
                   successBlock:(void (^)(id _Nonnull))successBlock
                   failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
   return  [self requestWithHandler:handler
                      isJson:YES
                    isFromBL:NO
                      method:methodType
                         url:url
                      params:params
                       cache:cache
               responseCache:cacheBlock
                successBlock:successBlock
                failureBlock:failureBlock];
}

/**
 一般请求的接口 ,不做参数截取
 
 @param handler 处理者
 @param methodType 方法
 @param url 链接地址
 @param params 参数
 @param cache 缓存
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
                                 failureBlock:(void(^)(NSError *error))failureBlock{
    self.network.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    switch (methodType) {
        case HTTPMethod_GET:
            return  [self getRequestWithHanler:handler
                                           url:url
                                        params:params
                                         cache:cache
                                 responseCache:cacheBlock
                                  successBlock:successBlock
                                  failureBlock:failureBlock];
            break;
        case HTTPMethod_POST:
            return  [self postRequestWithHanler:handler
                                            url:url
                                         params:params
                                          cache:cache
                                  responseCache:cacheBlock
                                   successBlock:successBlock
                                   failureBlock:failureBlock];
            break;
        default:
            break;
    }
    return nil;
}

- (Request *)requestFormDataWithHandler:(NSObject *)handler
                                      url:(NSString *)url
                                   params:(NSDictionary *)params
                                    cache:(BOOL)cache
                            responseCache:(void (^)(id _Nonnull))cacheBlock
                             successBlock:(void (^)(id _Nonnull))successBlock
                             failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    NSString * requestUrl = [NSString stringWithFormat:@"%@%@",url,[DemoNetworkVerify getVerify]];
    //缓存key
    NSString *cacheKey = [requestUrl stringByReplacingOccurrencesOfString:[DemoNetworkVerify getVerify] withString:GetUserId()];
    SuccessBlock responseBlock = ^(NSURLSessionDataTask *task,id response) {
        BLNetworkingLog(params, url, response);
        
        [[NetworkCache defaultCache] saveResponseCache:response forKey:cacheKey];
        [self handlerResponse:response responesBlock:successBlock failuerBlcok:failureBlock];
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    
    FailureBlock fail = ^(NSURLSessionDataTask *task,NSError *error) {
        BLNetworkingErrorLog(params, url, error);
        if (failureBlock) {
            failureBlock(error);
        }
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    if (cache&&cacheBlock) {
        id responseCache = [[NetworkCache defaultCache] getResponseCacheForKey:cacheKey];
        [self handlerResponse:responseCache responesBlock:cacheBlock failuerBlcok:nil];
    }
    void(^uploadBlock)(id<AFMultipartFormData> formData) = ^(id<AFMultipartFormData> formData) {
        for (NSString *key in params.allKeys) {
            id value = params[key];
            NSData *data;
            if ([value isKindOfClass:[NSString class]]) {
                data = [value dataUsingEncoding:NSUTF8StringEncoding];
            } else {
                data = [NSJSONSerialization dataWithJSONObject:value options:NSJSONWritingPrettyPrinted error:nil];
            }
            [formData appendPartWithFormData:data name:key];
        }
    };
    NSURLSessionDataTask * task = [self.network uploadWithURL:requestUrl parameters:@{} constructingBodyWithBlock:uploadBlock progress:nil success:responseBlock failure:fail];
    
    Request *pair = [Request create:cacheKey value:task];
    pair.requestArgument = params;
    [handler.autoCancelNetworkRequests addTask:pair];
    return pair;
}

- (Request *)requestWithHandler:(NSObject *)handler
                    isJson:(BOOL)isJson
                  isFromBL:(BOOL)isFromBL
                    method:(HTTPMethod)methodType
                       url:(NSString *)url
                    params:(NSDictionary *)params
                     cache:(BOOL)cache
             responseCache:(void (^)(id _Nonnull))cacheBlock
              successBlock:(void (^)(id _Nonnull))successBlock
              failureBlock:(void (^)(NSError * _Nonnull))failureBlock  {
    self.network.manager.requestSerializer = isJson ? [AFJSONRequestSerializer serializer] : [AFHTTPRequestSerializer serializer];
    NSString * requestUrl = isFromBL ? [NSString stringWithFormat:@"%@%@",url,[DemoNetworkVerify getVerify]] : url;
    if([url containsString:@"?"]){
        NSArray *arr = [url componentsSeparatedByString:@"?"];
        url = [arr objectAtIndex:0];
        NSString *other = [arr objectAtIndex:1];
        requestUrl = isFromBL ? [NSString stringWithFormat:@"%@%@&%@",url,[DemoNetworkVerify getVerify],other ]: url;
    }
    switch (methodType) {
        case HTTPMethod_GET:
          return  [self getRequestWithHanler:handler
                                   url:requestUrl
                                params:params
                                 cache:cache
                         responseCache:cacheBlock
                          successBlock:successBlock
                          failureBlock:failureBlock];
            break;
        case HTTPMethod_POST:
           return  [self postRequestWithHanler:handler
                                    url:requestUrl
                                 params:params
                                  cache:cache
                          responseCache:cacheBlock
                           successBlock:successBlock
                           failureBlock:failureBlock];
            break;
        case HTTPMethod_PUT:
            return  [self putRequestWithHanler:handler
                                            url:requestUrl
                                         params:params
                                          cache:cache
                                  responseCache:cacheBlock
                                   successBlock:successBlock
                                   failureBlock:failureBlock];
            break;
            
        case HTTPMethod_DELETE:
            return  [self deleteRequestWithHanler:handler
                                              url:requestUrl
                                           params:params
                                            cache:cache
                                    responseCache:cacheBlock
                                     successBlock:successBlock
                                     failureBlock:failureBlock];
            break;
        case HTTPMethod_PATCH:
            return  [self patchRequestWithHanler:handler
                                              url:requestUrl
                                           params:params
                                            cache:cache
                                    responseCache:cacheBlock
                                     successBlock:successBlock
                                     failureBlock:failureBlock];
            break;
        default:
            break;
    }
    
}
- (Request *)getRequestWithHanler:(NSObject *)handler
                         url:(NSString *)url
                      params:(NSDictionary *)params
                       cache:(BOOL)cache
               responseCache:(void (^)(id _Nonnull))cacheBlock
                successBlock:(void (^)(id _Nonnull))successBlock
                failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    NSString *cacheKey=url;
    if ([url containsString:@"&"]) {
        cacheKey = [[url componentsSeparatedByString:@"&"] objectAtIndex:0];
    }
    if (params) {
        cacheKey = [[cacheKey stringByAppendingString:[self convertJsonStringFromDictionaryOrArray:params]] ext_stringWithMD5];
    }
    if (cache&&cacheBlock) {
        id responseCache = [[NetworkCache defaultCache] getResponseCacheForKey:cacheKey];
        [self handlerResponse:responseCache responesBlock:cacheBlock failuerBlcok:nil];
    }
    SuccessBlock responseBlock = ^(NSURLSessionDataTask *task,id response) {
        BLNetworkingLog(params, url, response);
        
        [[NetworkCache defaultCache] saveResponseCache:response forKey:cacheKey];
        [self handlerResponse:response responesBlock:successBlock failuerBlcok:failureBlock];
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    FailureBlock fail = ^(NSURLSessionDataTask *task,NSError *error) {
        BLNetworkingErrorLog(params, url, error);
        if (failureBlock) {
            failureBlock(error);
        }
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    NSURLSessionDataTask * task = [self.network GETRequest:url
                                                parameters:params
                                                   success:responseBlock
                                                   failure:fail];
    Request *pair = [Request create:cacheKey value:task];
    pair.requestArgument = params;
    [handler.autoCancelNetworkRequests addTask:pair];
    return pair;
    
    
}
- (void)requestCacheWithHandler:(NSObject *)handler
                                method:(HTTPMethod)methodType
                                   url:(NSString *)url
                                params:(NSDictionary *)params
                          successBlock:(void (^)(id _Nonnull))successBlock
                          failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    NSString *cacheKey=url;
    if ([url containsString:@"&"]) {
        cacheKey = [[url componentsSeparatedByString:@"&"] objectAtIndex:0];
    }
    if (params) {
        cacheKey = [[cacheKey stringByAppendingString:[self convertJsonStringFromDictionaryOrArray:params]] ext_stringWithMD5];
    }
    id responseCache = [[NetworkCache defaultCache] getResponseCacheForKey:cacheKey];
    if (responseCache) {
        if (successBlock) {
            successBlock(responseCache);
        }
    } else {
        if (failureBlock) {
            failureBlock([NSError new]);
        }
    }

    
    
}
- (Request *)postRequestWithHanler:(NSObject *)handler
                          url:(NSString *)url
                       params:(NSDictionary *)params
                        cache:(BOOL)cache
                responseCache:(void (^)(id _Nonnull))cacheBlock
                 successBlock:(void (^)(id _Nonnull))successBlock
                 failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    NSString *cacheKey=url;
    if ([url containsString:@"&"]) {
        cacheKey = [[url componentsSeparatedByString:@"&"] objectAtIndex:0];
    }
    if (params) {
        NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
        [newDic addEntriesFromDictionary:params];
        [newDic removeObjectForKey:@"sign"];
        [newDic removeObjectForKey:@"timestamp"];
        cacheKey = [[cacheKey stringByAppendingString:[self convertJsonStringFromDictionaryOrArray:newDic]] ext_stringWithMD5];
    }
    
    SuccessBlock responseBlock = ^(NSURLSessionDataTask *task,id response) {
        BLNetworkingLog(params, url, response);
        
        [[NetworkCache defaultCache] saveResponseCache:response forKey:cacheKey];
        [self handlerResponse:response responesBlock:successBlock failuerBlcok:failureBlock];
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    
    FailureBlock fail = ^(NSURLSessionDataTask *task,NSError *error) {
        BLNetworkingErrorLog(params, url, error);
        if (failureBlock) {
            failureBlock(error);
        }
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    if (cache&&cacheBlock) {
        id responseCache = [[NetworkCache defaultCache] getResponseCacheForKey:cacheKey];
        [self handlerResponse:responseCache responesBlock:cacheBlock failuerBlcok:nil];
    }
    
    NSURLSessionDataTask * task = [self.network POSTRequest:url
                                                 parameters:params
                                                    success:responseBlock
                                                    failure:fail];
    Request *pair = [Request create:cacheKey value:task];
    pair.requestArgument = params;
    [handler.autoCancelNetworkRequests addTask:pair];
    return pair;
    
}

- (Request *)patchRequestWithHanler:(NSObject *)handler
                                url:(NSString *)url
                             params:(NSDictionary *)params
                              cache:(BOOL)cache
                      responseCache:(void (^)(id _Nonnull))cacheBlock
                       successBlock:(void (^)(id _Nonnull))successBlock
                       failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    NSString *cacheKey=url;
    if ([url containsString:@"&"]) {
        cacheKey = [[url componentsSeparatedByString:@"&"] objectAtIndex:0];
    }
    if (params) {
        NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
        [newDic addEntriesFromDictionary:params];
        [newDic removeObjectForKey:@"sign"];
        [newDic removeObjectForKey:@"timestamp"];
        cacheKey = [[cacheKey stringByAppendingString:[self convertJsonStringFromDictionaryOrArray:newDic]] ext_stringWithMD5];
    }
    
    SuccessBlock responseBlock = ^(NSURLSessionDataTask *task,id response) {
        BLNetworkingLog(params, url, response);
        
        [[NetworkCache defaultCache] saveResponseCache:response forKey:cacheKey];
        [self handlerResponse:response responesBlock:successBlock failuerBlcok:failureBlock];
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    
    FailureBlock fail = ^(NSURLSessionDataTask *task,NSError *error) {
        BLNetworkingErrorLog(params, url, error);
        if (failureBlock) {
            failureBlock(error);
        }
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    if (cache&&cacheBlock) {
        id responseCache = [[NetworkCache defaultCache] getResponseCacheForKey:cacheKey];
        [self handlerResponse:responseCache responesBlock:cacheBlock failuerBlcok:nil];
    }
    
    NSURLSessionDataTask * task = [self.network PATCHRequest:url
                                                parameters:params
                                                   success:responseBlock
                                                   failure:fail];
    Request *pair = [Request create:cacheKey value:task];
    pair.requestArgument = params;
    [handler.autoCancelNetworkRequests addTask:pair];
    return pair;
    
}

- (Request *)putRequestWithHanler:(NSObject *)handler
                                 url:(NSString *)url
                              params:(NSDictionary *)params
                               cache:(BOOL)cache
                       responseCache:(void (^)(id _Nonnull))cacheBlock
                        successBlock:(void (^)(id _Nonnull))successBlock
                        failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    NSString *cacheKey=url;
    if ([url containsString:@"&"]) {
        cacheKey = [[url componentsSeparatedByString:@"&"] objectAtIndex:0];
    }
    if (params) {
        NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
        [newDic addEntriesFromDictionary:params];
        [newDic removeObjectForKey:@"sign"];
        [newDic removeObjectForKey:@"timestamp"];
        cacheKey = [[cacheKey stringByAppendingString:[self convertJsonStringFromDictionaryOrArray:newDic]] ext_stringWithMD5];
    }
    
    SuccessBlock responseBlock = ^(NSURLSessionDataTask *task,id response) {
        BLNetworkingLog(params, url, response);
        
        [[NetworkCache defaultCache] saveResponseCache:response forKey:cacheKey];
        [self handlerResponse:response responesBlock:successBlock failuerBlcok:failureBlock];
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    
    FailureBlock fail = ^(NSURLSessionDataTask *task,NSError *error) {
        BLNetworkingErrorLog(params, url, error);
        if (failureBlock) {
            failureBlock(error);
        }
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    if (cache&&cacheBlock) {
        id responseCache = [[NetworkCache defaultCache] getResponseCacheForKey:cacheKey];
        [self handlerResponse:responseCache responesBlock:cacheBlock failuerBlcok:nil];
    }
    
    NSURLSessionDataTask * task = [self.network PUTRequest:url
                                                 parameters:params
                                                    success:responseBlock
                                                    failure:fail];
    Request *pair = [Request create:cacheKey value:task];
    pair.requestArgument = params;
    [handler.autoCancelNetworkRequests addTask:pair];
    return pair;
    
}

- (Request *)deleteRequestWithHanler:(NSObject *)handler
                                url:(NSString *)url
                             params:(NSDictionary *)params
                              cache:(BOOL)cache
                      responseCache:(void (^)(id _Nonnull))cacheBlock
                       successBlock:(void (^)(id _Nonnull))successBlock
                       failureBlock:(void (^)(NSError * _Nonnull))failureBlock {
    NSString *cacheKey=url;
    if ([url containsString:@"&"]) {
        cacheKey = [[url componentsSeparatedByString:@"&"] objectAtIndex:0];
    }
    if (params) {
        NSMutableDictionary *newDic = [NSMutableDictionary dictionary];
        [newDic addEntriesFromDictionary:params];
        [newDic removeObjectForKey:@"sign"];
        [newDic removeObjectForKey:@"timestamp"];
        cacheKey = [[cacheKey stringByAppendingString:[self convertJsonStringFromDictionaryOrArray:newDic]] ext_stringWithMD5];
    }
    
    SuccessBlock responseBlock = ^(NSURLSessionDataTask *task,id response) {
        BLNetworkingLog(params, url, response);
        
        [[NetworkCache defaultCache] saveResponseCache:response forKey:cacheKey];
        [self handlerResponse:response responesBlock:successBlock failuerBlcok:failureBlock];
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    
    FailureBlock fail = ^(NSURLSessionDataTask *task,NSError *error) {
        BLNetworkingErrorLog(params, url, error);
        if (failureBlock) {
            failureBlock(error);
        }
        [handler.autoCancelNetworkRequests removeTask:cacheKey];
    };
    if (cache&&cacheBlock) {
        id responseCache = [[NetworkCache defaultCache] getResponseCacheForKey:cacheKey];
        [self handlerResponse:responseCache responesBlock:cacheBlock failuerBlcok:nil];
    }
    
    NSURLSessionDataTask * task = [self.network DELETERequest:url
                                                parameters:params
                                                   success:responseBlock
                                                   failure:fail];
    Request *pair = [Request create:cacheKey value:task];
    pair.requestArgument = params;
    [handler.autoCancelNetworkRequests addTask:pair];
    return pair;
    
}

- (void)uploadImageWithHandler:(NSObject *)handler
                         image:(id)image
                       apiName:(NSString *)apiName
                       keyName:(NSString *)keyName
                      progress:(void (^)(NSProgress * _Nonnull))progressBlock
                 responesBlock:(void (^)(id _Nonnull))responseBlock
                  failuerBlcok:(void (^)(NSError * _Nonnull))failureBlck {
    //    如果传图片统一压缩 具体的压缩比例待定 这边可以对图片进行统一处理
    if ([image isKindOfClass:[UIImage class]]) {
        UIImage *_image = (UIImage *)image;
        image = UIImageJPEGRepresentation(_image, 1.0);
    }
    [self uploadFileWithHandler:handler
                        apiName:apiName
                       isFromBL:NO
                          files:@[image]
                     parameters:nil
                           name:keyName
                     fileSuffix:@"jpg"
                       mimeType:@"image/jpeg"
                       progress:progressBlock
                  responesBlock:responseBlock
                   failuerBlcok:failureBlck];
    
}

- (void)uploadImageToBLWithHandler:(NSObject *)handler
                        params:(NSDictionary *)params
                         image:(id)image
                       apiName:(NSString *)apiName
                       keyName:(NSString *)keyName
                      progress:(void (^)(NSProgress * _Nonnull))progressBlock
                 responesBlock:(void (^)(id _Nonnull))responseBlock
                  failuerBlcok:(void (^)(NSError * _Nonnull))failureBlck {
    //    如果传图片统一压缩 具体的压缩比例待定 这边可以对图片进行统一处理
    if ([image isKindOfClass:[UIImage class]]) {
        UIImage *_image = (UIImage *)image;
        image = UIImageJPEGRepresentation(_image, 1.0);
    }
    NSArray *imageArr;
    if (image) {
        imageArr = @[image];
    }
    [self uploadFileWithHandler:handler
                        apiName:apiName
                       isFromBL:YES
                          files:imageArr
                     parameters:params
                           name:keyName
                     fileSuffix:@"jpg"
                       mimeType:@"image/jpeg"
                       progress:progressBlock
                  responesBlock:responseBlock
                   failuerBlcok:failureBlck];
    
}
- (void)uploadImageToBLWithHandler:(NSObject *)handler params:(NSDictionary *)params datas:(NSArray<NSData *> *)datas apiName:(NSString *)apiName keyName:(NSString *)keyName progress:(void (^)(NSProgress * _Nonnull))progressBlock responesBlock:(void (^)(id _Nonnull))responseBlock failuerBlcok:(void (^)(NSError * _Nonnull))failureBlock {
   
    [self uploadFileWithHandler:handler
                        apiName:apiName
                       isFromBL:YES
                          files:datas
                     parameters:params
                           name:keyName
                     fileSuffix:@"jpg"
                       mimeType:@"image/jpeg"
                       progress:progressBlock
                  responesBlock:responseBlock
                   failuerBlcok:failureBlock];
    
    
}
- (void)uploadImageToBLWithHandler:(NSObject *)handler
                            params:(NSDictionary *)params
                            images:(NSArray<UIImage *> *)images
                           apiName:(NSString *)apiName
                           keyName:(NSString *)keyName
                          progress:(void (^)(NSProgress * _Nonnull))progressBlock
                     responesBlock:(void (^)(id _Nonnull))responseBlock
                      failuerBlcok:(void (^)(NSError * _Nonnull))failureBlock {
    NSMutableArray<NSData *> *dataArray = [NSMutableArray array];
    for (UIImage *image in images) {
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [dataArray addObject:data];
    }
    [self uploadFileWithHandler:handler
                        apiName:apiName
                       isFromBL:YES
                          files:dataArray
                     parameters:params
                           name:keyName
                     fileSuffix:@"jpg"
                       mimeType:@"image/jpeg"
                       progress:progressBlock
                  responesBlock:responseBlock
                   failuerBlcok:failureBlock];
    
    
}

- (void)uploadFileWithHandler:(NSObject *)handler
                      apiName:(NSString *)apiName
                     isFromBL:(BOOL)isFromBL
                        files:(NSArray<NSData *> *)files
                   parameters:(id)parameters
                         name:(NSString *)name
                   fileSuffix:(NSString *)fileSuffix
                     mimeType:(NSString *)mimeType
                     progress:(void (^)(NSProgress *))progressBlock
                responesBlock:(void (^)(id))responseBlock
                 failuerBlcok:(void (^)(NSError *))failureBlock {
    NSString  *fileName = nil;
    void (^uploadBlock)(id <AFMultipartFormData> formData) = nil;
    if(files && files.count > 0 && name){
        fileName = [NSString stringWithFormat:@"%ld.%@", (long)([[NSDate date] timeIntervalSince1970]),fileSuffix];
        uploadBlock = ^(id<AFMultipartFormData> formData) {
            for (NSData *file in files) {
                [formData appendPartWithFileData:file name:name fileName:fileName mimeType:mimeType];
            }
        };
    }
    NSString * requestUrl = isFromBL ? [NSString stringWithFormat:@"%@%@",apiName,[DemoNetworkVerify getVerify]] : apiName;
    if([apiName containsString:@"?"]){
        NSArray *arr = [apiName componentsSeparatedByString:@"?"];
        apiName = [arr objectAtIndex:0];
        NSString *other = [arr objectAtIndex:1];
        requestUrl = isFromBL ? [NSString stringWithFormat:@"%@%@&%@",apiName,[DemoNetworkVerify getVerify],other ]: apiName;
    }
    NSURLSessionDataTask *task = nil;
    NSString *key = apiName;
    if (parameters) {
        key = [key stringByAppendingString:[self convertJsonStringFromDictionaryOrArray:parameters]];
    }
    
    SuccessBlock success = ^(NSURLSessionDataTask *task, id response) {
        BLNetworkingLog(parameters, requestUrl, response);
        [handler.autoCancelNetworkRequests removeTask:key];
        [self handlerResponse:response responesBlock:responseBlock failuerBlcok:failureBlock];
    };
    FailureBlock fail = ^(NSURLSessionDataTask *task, NSError *error) {
        BLNetworkingErrorLog(parameters, requestUrl, error);
        if (failureBlock) {
            failureBlock(error);
        }
        [handler.autoCancelNetworkRequests removeTask:key];
    };
    
    void (^pgBlock)(NSProgress * progress) = ^(NSProgress *progress) {
        if (progressBlock) {
            progressBlock(progress);
        }
    };
    task = [_network uploadWithURL:requestUrl
                        parameters:parameters
         constructingBodyWithBlock:uploadBlock
                          progress:pgBlock
                           success:success
                           failure:fail];
    Request *pair = [Request create:key value:task];
    [handler.autoCancelNetworkRequests addTask:pair];
    
}

- (void)uploadImageToBLWithHandler:(NSObject *)handler
                            params:(NSDictionary *)params
                           apiName:(NSString *)apiName
         constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))constructingBlock
                          progress:(void (^)(NSProgress * uploadProgress))progressBlock
                     responesBlock:(void (^)(id response))responseBlock
                      failuerBlcok:(void (^)(NSError * error))failureBlock {
    NSString * requestUrl =  [NSString stringWithFormat:@"%@%@",apiName,[DemoNetworkVerify getVerify]];
    if([apiName containsString:@"?"]){
        NSArray *arr = [apiName componentsSeparatedByString:@"?"];
        apiName = [arr objectAtIndex:0];
        NSString *other = [arr objectAtIndex:1];
        requestUrl =  [NSString stringWithFormat:@"%@%@&%@",apiName,[DemoNetworkVerify getVerify],other ];
    }
    NSURLSessionDataTask *task = nil;
    NSString *key = apiName;
    if (params) {
        key = [key stringByAppendingString:[self convertJsonStringFromDictionaryOrArray:params]];
    }
    
    SuccessBlock success = ^(NSURLSessionDataTask *task, id response) {
        BLNetworkingLog(params, requestUrl, response);
        [handler.autoCancelNetworkRequests removeTask:key];
        [self handlerResponse:response responesBlock:responseBlock failuerBlcok:failureBlock];
    };
    FailureBlock fail = ^(NSURLSessionDataTask *task, NSError *error) {
        BLNetworkingErrorLog(params, requestUrl, error);
        if (failureBlock) {
            failureBlock(error);
        }
        [handler.autoCancelNetworkRequests removeTask:key];
    };
    
    void (^pgBlock)(NSProgress * progress) = ^(NSProgress *progress) {
        if (progressBlock) {
            progressBlock(progress);
        }
    };
    task = [_network uploadWithURL:requestUrl
                        parameters:params
         constructingBodyWithBlock:constructingBlock
                          progress:pgBlock
                           success:success
                           failure:fail];
    Request *pair = [Request create:key value:task];
    [handler.autoCancelNetworkRequests addTask:pair];
    
}
- (NSString *)convertJsonStringFromDictionaryOrArray:(id)parameter {
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}
/**
 处理返回的请求
 
 @param response 返回的东西
 @param responseBlock 成功回调
 @param failureBlck 失败的回调
 */
- (void)handlerResponse:(id)response
      responesBlock:(void(^)(id response))responseBlock
       failuerBlcok:(void(^)(NSError *error))failureBlck
{
    if (!response) {
        if(failureBlck){
            NSError *error=[[NSError alloc] initWithDomain:@"network.request.error" code:-1 userInfo:@{@"errormessage":@"服务器返回空数据!"}];
            failureBlck(error);
        }
       return;
    }
    
    if (![response isKindOfClass:[NSDictionary class]]) {
        if(failureBlck){
            NSError *error=[[NSError alloc] initWithDomain:@"network.request.error" code:-1 userInfo:@{@"errormessage":@"服务器返回数据异常!"}];
            failureBlck(error);
        }
        return;
    }
    
    if(responseBlock){
        responseBlock(response);
    }
}

@end
