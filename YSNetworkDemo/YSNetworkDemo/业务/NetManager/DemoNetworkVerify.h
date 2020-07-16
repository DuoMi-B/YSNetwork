//
//  DemoNetworkVerify.h
//  

#import <Foundation/Foundation.h>
#import "NSString+Extension.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoNetworkVerify : NSObject
/**
 获取用户id
 */
FOUNDATION_EXPORT NSString * GetUserId(void);
/**
 *  获取校验
 */
+(NSString *)getVerify;

@end

NS_ASSUME_NONNULL_END
