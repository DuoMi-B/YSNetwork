//
//  Request.h


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Request : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong, readonly) NSURLSessionDataTask * task;
@property(nonatomic,strong)id requestArgument;
+ (id)create:(id)key value:(NSURLSessionDataTask *)task;
- (BOOL)isContainsCache;
@end

NS_ASSUME_NONNULL_END
