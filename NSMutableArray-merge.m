

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
	if ([obj isKindOfClass:[NSArray class]]) {
		[self mergeWithArray:(NSArray*)obj allowDuplicateEntries:NO];
	} else if ([obj isKindOfClass:[NSSet class]]) {
		[self mergeWithSet:(NSSet *)obj allowDuplicateEntries:NO];
	} else {
		[NSException raise:@"MergeException" format:@"Attempted to merge objects of different types: %@\n,\n %@", [self description], [obj description]];
	}
}

- (BOOL)canMergeWithObj:(NSObject *)obj
{
	if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSSet class]]) {
		return YES;
	}
	return NO;
}

- (BOOL)isMutableObj
{
	BOOL mutable = YES;
	@try {
		[self addObject:[NSNull null]];
	}
	@catch (NSException *exception) {
		mutable = NO;
	}
	
	if (mutable) {
		[self removeObject:[NSNull null]];
	}
	return mutable;
}

- (void)mergeWithArray:(NSArray *)array allowDuplicateEntries:(BOOL)duplicateEntries
{
	for (id entry in array) {
		if (duplicateEntries || ![self containsObject:entry]) {
			[self addObject:entry];
		}
	}
}

- (void)mergeWithSet:(NSSet*)set allowDuplicateEntries:(BOOL)duplicateEntries
{
	for (id entry in set) {
		if (duplicateEntries || ![self containsObject:entry]) {
			[self addObject:entry];
		}
	}
}

@end
