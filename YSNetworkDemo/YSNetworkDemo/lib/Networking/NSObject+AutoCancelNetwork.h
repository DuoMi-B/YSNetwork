//
//  NSObject+AutoCancelNetwork.h


#import <Foundation/Foundation.h>
#import "AutoCancelNetwork.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AutoCancelNetwork)
@property (nonatomic, strong , readonly) AutoCancelNetwork *autoCancelNetworkRequests;

@end

NS_ASSUME_NONNULL_END
