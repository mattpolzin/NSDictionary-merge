

#import <Foundation/Foundation.h>
#import "MergeProtocol.h"

@interface Merge

// Merge obj1 with obj2 if possible. If successful, returns YES; otherwise NO.
// If successful, result points to the merged object. Note that this method may
// merge obj1 into obj2 or obj2 into obj1, depending on which direction supports
// the merge. Whichever object is merged INTO, may not be preserved; it will
// either become the merged result or a mutable copy of it will become the
// merged result. In other words, if the merge is successful, result will
// point to either obj1, obj2, a mutable copy of obj1, or a mutable copy of
// obj2. This is because a mutable copy of obj1 or obj2 is only created if obj1
// and obj2 cannot be merged as-is.
+ (BOOL)mergeObj:(NSObject<Merge>*)obj1 withObj:(NSObject<Merge>*)obj2 result:(NSObject**)result;

@end