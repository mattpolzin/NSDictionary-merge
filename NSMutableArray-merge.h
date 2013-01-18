

#import <Foundation/Foundation.h>
#import "MergeProtocol.h"

@interface NSMutableArray (merge) <Merge>

// NOTE that generally speaking, arrays do allow duplicate entries (sets do not)
// but the default for merging arrays here (using mergeWithObj) is to not allow
// duplicate entries because my primary goal in merging arrays is to merge two
// dictionaries created from plists.
- (void)mergeWithArray:(NSArray*)array allowDuplicateEntries:(BOOL)duplicateEntries;

- (void)mergeWithSet:(NSSet*)set allowDuplicateEntries:(BOOL)duplicateEntries;

@end
