

#import <Foundation/Foundation.h>
#import "MergeProtocol.h"

@interface NSMutableSet (merge) <Merge>

- (void)mergeWithSet:(NSSet*)set;
- (void)mergeWithArray:(NSArray*)array;

@end
