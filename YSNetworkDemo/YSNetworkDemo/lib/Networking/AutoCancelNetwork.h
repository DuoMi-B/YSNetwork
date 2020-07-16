//
//  AutoCancelNetwork.h


#import <Foundation/Foundation.h>
#import "Request.h"
NS_ASSUME_NONNULL_BEGIN

@interface AutoCancelNetwork : NSObject
- (void)addTask:(Request *)pair;
- (void)removeTask:(NSString *)key;
- (void)removeTask:(NSString *)key completion:(void(^)(void))completion;
@end

NS_ASSUME_NONNULL_END
