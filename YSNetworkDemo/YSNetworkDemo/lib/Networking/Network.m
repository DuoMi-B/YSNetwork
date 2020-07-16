//
//  Network.m


#import "Network.h"


@interface Network ()

/**
 组任务队列
 */
@property (nonatomic, strong) dispatch_group_t dataGroup;

/**
 任务队列
 */
@property (nonatomic, strong) dispatch_queue_t dataQueue;
@end

@implementation Network

/**
 约定外部初始化方式禁止通过init的方式创建
 
 @return 实例对象
 */
- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFHTTPSessionManager alloc]initWithBaseURL:nil sessionConfiguration:configuration];
        _manager.requestSerializer.timeoutInterval = 60.f;
    }
    return self;
}

/**
 工厂创建方法
 
 @return 当前类
 */
+ (instancetype)network {
    return [[self alloc] init];
}


/**
 Get请求方式
 
 @param url 链接
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 @return 当前任务task
 */
- (NSURLSessionDataTask *)GETRequest:(NSString *)url
                          parameters:(id)parameters
                             success:(SuccessBlock)success
                             failure:(FailureBlock)failure {
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [self.manager.requestSerializer setValue:[WAFTool getToken:parameters] forHTTPHeaderField:@"wToken"];

    NSURLSessionDataTask *task = [self.manager GET:url parameters:parameters progress:nil success:success failure:failure];
    [task resume];
    return task;
}

/**
 POST请求方式
 
 @param url 链接
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 @return 当前task任务
 */
- (NSURLSessionDataTask *)POSTRequest:(NSString *)url
                           parameters:(id)parameters
                              success:(SuccessBlock)success
                              failure:(FailureBlock)failure {
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [self.manager.requestSerializer setValue:[WAFTool getToken:parameters] forHTTPHeaderField:@"wToken"];
    NSURLSessionDataTask *task = [self.manager POST:url parameters:parameters progress:nil success:success failure:failure];
    [task resume];
    return task;
    
}

/**
 PUT请求方式
 
 @param url 链接
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 @return 当前task任务
 */
- (NSURLSessionDataTask *)PUTRequest:(NSString *)url
                           parameters:(id)parameters
                              success:(SuccessBlock)success
                              failure:(FailureBlock)failure {
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [self.manager.requestSerializer setValue:[WAFTool getToken:parameters] forHTTPHeaderField:@"wToken"];
    NSURLSessionDataTask *task = [self.manager PUT:url parameters:parameters success:success failure:failure];
    [task resume];
    return task;
    
}

/**
 DELETE请求方式
 
 @param url 链接
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 @return 当前task任务
 */
- (NSURLSessionDataTask *)DELETERequest:(NSString *)url
                            parameters:(id)parameters
                               success:(SuccessBlock)success
                               failure:(FailureBlock)failure {
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [self.manager.requestSerializer setValue:[WAFTool getToken:parameters] forHTTPHeaderField:@"wToken"];
    NSURLSessionDataTask *task = [self.manager DELETE:url parameters:parameters success:success failure:failure];
    [task resume];
    return task;
    
}

/**
 PATCH请求方式
 
 @param url 链接
 @param parameters 请求参数
 @param success 成功回调
 @param failure 失败回调
 @return 当前task任务
 */
- (NSURLSessionDataTask *)PATCHRequest:(NSString *)url
                          parameters:(id)parameters
                             success:(SuccessBlock)success
                             failure:(FailureBlock)failure {
    self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [self.manager.requestSerializer setValue:[WAFTool getToken:parameters] forHTTPHeaderField:@"wToken"];

    NSURLSessionDataTask *task = [self.manager PATCH:url parameters:parameters success:success failure:failure];
    [task resume];
    return task;
    
}

/**
 上传任务
 
 @param URLString 链接
 @param parameters 参数
 @param block 上传附带的表单数据
 @param uploadProgress 上传进度
 @param success 成功回调
 @param failure 失败回调
 @return 当前任务
 */
- (NSURLSessionDataTask *)uploadWithURL:(NSString *)URLString
                             parameters:(id)parameters
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                               progress:(void (^)(NSProgress *progress))uploadProgress
                                success:(SuccessBlock)success
                                failure:(FailureBlock)failure {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
    NSURLSessionDataTask *task = [_manager POST:URLString
                                     parameters:parameters
                      constructingBodyWithBlock:block
                                       progress:uploadProgress
                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            success(task, responseObject);
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                
                                                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                            });
                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            failure(task, error);
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                
                                                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                            });
                                        }];
    return task;
}

/**
 下载任务
 
 @param URLString 链接
 @param downloadProgressBlock 下载进度
 @param destination 文件目标地址
 @param completionHandler 完成操作
 @return 下载任务
 */
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSString *)URLString
                                     progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                  destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                            completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler {
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = nil;
    downloadTask = [_manager downloadTaskWithRequest:request
                                            progress:downloadProgressBlock
                                         destination:destination
                                   completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                       completionHandler(response, filePath, error);
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           
                                           [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                       });
                                       
                                   }];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
    [downloadTask resume];
    return downloadTask;
}
- (BOOL)checkNetworkIsAvailable {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //开始监测网络状态
    [manager startMonitoring];
    
    //结果回调
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            return;
        }
    }];
    
    return YES;
}
#pragma mark - 私有方法


#pragma mark - 懒加载

- (dispatch_group_t)dataGroup {
    if (!_dataGroup) {
        _dataGroup = dispatch_group_create();
        
    }
    return _dataGroup;
}
- (dispatch_queue_t)dataQueue {
    if (!_dataQueue) {
        _dataQueue = dispatch_queue_create("com.treeGe.data.queue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    }
    return _dataQueue;
}

@end
