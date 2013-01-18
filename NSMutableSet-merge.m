

#import "NSMutableSet-merge.h"
#import "Merge.h"

#define MERGE_DEBUG 1

#if MERGE_DEBUG
#   define MERGE_LOG(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#else
#   define MERGE_LOG(...)
#endif

@implementation NSMutableSet (merge)

- (void)mergeWithObj:(NSObject *)obj
{
	if ([obj isKindOfClass:[NSSet class]]) {
		[self mergeWithSet:(NSSet *)obj];
	} else if ([obj isKindOfClass:[NSArray class]]) {
		[self mergeWithArray:(NSArray*)obj];
	} else {
		[NSException raise:@"MergeException" format:@"Attempted to merge objects of different types: %@\n,\n %@", [self description], [obj description]];
	}
}

- (BOOL)canMergeWithObj:(NSObject *)obj
{
	if ([obj isKindOfClass:[NSSet class]] || [obj isKindOfClass:[NSArray class]]) {
		return YES;
	}
	return NO;
}

- (void)mergeWithSet:(NSSet*)set
{
	[self unionSet:set];
}

- (void)mergeWithArray:(NSArray*)array
{
	[self addObjectsFromArray:array];
}

@end
