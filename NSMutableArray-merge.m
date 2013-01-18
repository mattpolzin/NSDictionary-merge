

#import "NSMutableArray-merge.h"
#import "Merge.h"

#define MERGE_DEBUG 1

#if MERGE_DEBUG
#   define MERGE_LOG(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#else
#   define MERGE_LOG(...)
#endif

@implementation NSMutableArray (merge)

- (void)mergeWithObj:(NSObject *)obj
{
	if (![obj isKindOfClass:[NSDictionary class]]) {
		NSAssert(@"Attempted to merge objects of different types: %@\n,\n %@", [self description], [obj description]);
	}
	[self mergeWithArray:(NSArray*)obj allowDuplicateEntries:NO];
}

- (BOOL)canMergeWithObj:(NSObject *)obj
{
	if (![obj isKindOfClass:[NSArray class]]) {
		return NO;
	}
	return YES;
}

- (void)mergeWithArray:(NSArray *)array allowDuplicateEntries:(BOOL)duplicateEntries
{
	for (id entry in array) {
		if (duplicateEntries || ![self containsObject:entry]) {
			[self addObject:entry];
		}
	}
}

@end
