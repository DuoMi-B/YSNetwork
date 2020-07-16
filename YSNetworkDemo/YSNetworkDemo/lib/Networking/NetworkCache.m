//
//  NetworkCache.m


#import "NetworkCache.h"
#import <CommonCrypto/CommonDigest.h>

@interface NetworkCache ()
@property (nonatomic, strong) YYCache *defaultYYCache;
@end

@implementation NetworkCache
+ (instancetype)defaultCache {
    static NetworkCache * _defaultCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultCache = [[self alloc] init];
    });
    return _defaultCache;
}
- (instancetype)init {
    if (self = [super init]) {
        [self pathName:@"yycache"];
    }
    return self;
}
- (void)pathName:(NSString *)name {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    cachePath = [cachePath stringByAppendingPathComponent:@"com.VSJNetwork.cache"];
    cachePath = [cachePath stringByAppendingPathComponent:name];
    self.defaultYYCache = [[YYCache alloc] initWithPath:cachePath];
}
- (void)saveResponseCache:(id<NSCoding>)responseCache forKey:(NSString *)key {
    [self.defaultYYCache setObject:responseCache forKey:[self cachedFileNameForKey:key]];
}
- (id)getResponseCacheForKey:(NSString *)key {
   return  [self.defaultYYCache objectForKey:[self cachedFileNameForKey:key]];
}
- (void)removeResponseCacheForKey:(NSString *)key {
    [self.defaultYYCache removeObjectForKey:[self cachedFileNameForKey:key]];
}
- (void)removeAllResponseCache {
    [self.defaultYYCache removeAllObjects];
}
- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = key.UTF8String;
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], [key.pathExtension isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", key.pathExtension]];
    return filename;
}
@end
