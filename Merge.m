

#import "Merge.h"

#define MERGE_DEBUG 1

#if MERGE_DEBUG
#   define MERGE_LOG(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#else
#   define MERGE_LOG(...)
#endif

@implementation Merge

+ (BOOL)mergeObj:(NSObject<Merge>*)obj1 withObj:(NSObject<Merge>*)obj2 result:(NSObject**)result
{
	NSObject<Merge>* mergeObj = nil;
	id otherObj = nil;
	if ([obj1 respondsToSelector:@selector(canMergeWithObj:)] && [obj1 canMergeWithObj:obj2] && [obj1 respondsToSelector:@selector(isMutableObj)] && [obj1 isMutableObj]) {
		// will obj1 merge with obj2?
		mergeObj = obj1;
		otherObj = obj2;
	} else if ([obj2 respondsToSelector:@selector(canMergeWithObj:)] && [obj2 canMergeWithObj:obj1] && [obj2 respondsToSelector:@selector(isMutableObj)] && [obj2 isMutableObj]) {
		// will obj merge with obj1?
		mergeObj = obj2;
		otherObj = obj1;
	} else {
		if ([obj1 respondsToSelector:@selector(mutableCopy)]) {
			MERGE_LOG(@"creating a mutable copy of obj1 to see if that copy can be merged.");
			id mutableobj1 = [[obj1 mutableCopy] autorelease];
			if ([mutableobj1 respondsToSelector:@selector(canMergeWithObj:)] && [mutableobj1 canMergeWithObj:obj2]) {
				// will a mutable copy of obj1 merge with obj2?
				mergeObj = mutableobj1;
				otherObj = obj2;
			}
		}
		if (!mergeObj && [obj2 respondsToSelector:@selector(mutableCopy)]) {
			MERGE_LOG(@"creating a mutable copy of obj2 to see if that copy can be merged.");
			id mutableobj2 = [[obj2 mutableCopy] autorelease];
			if ([mutableobj2 respondsToSelector:@selector(canMergeWithObj:)] && [mutableobj2 canMergeWithObj:obj1]) {
				// will a mutable copy of obj2 merge with obj1?
				mergeObj = mutableobj2;
				otherObj = obj1;
			}
		}
	}
	
	if (mergeObj) {
		// we can merge!
		
		NSAssert(otherObj, @"code bug: otherObj is not set even though mergeObj is set!");
		
		[mergeObj mergeWithObj:otherObj];
		MERGE_LOG(@"merged objects");
		
		*result = mergeObj;
		return YES;
	}
	MERGE_LOG(@"objects were not merged.");
	
	return NO;
}

@end