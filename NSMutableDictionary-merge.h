

#import <Foundation/Foundation.h>
#import "MergeProtocol.h"

@interface NSMutableDictionary (merge) <Merge>

- (void)mergeWithDictionary:(NSDictionary*)dict;

@end