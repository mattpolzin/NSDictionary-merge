

#import <Foundation/Foundation.h>
#import "MergeProtocol.h"
#import "NSMutableDictionary-merge.h"

@interface NSDictionary (merge)

// This is a convenience method. It creates a mutable copy of self, merges with
// dict, and then returns the autoreleased result of the merge. The dictionary
// this method is called upon does not get altered.
- (NSMutableDictionary*)mergeMutableCopyWithDictionary:(NSDictionary*)dict;

@end