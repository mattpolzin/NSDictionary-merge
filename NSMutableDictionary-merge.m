

#import "NSMutableDictionary-merge.h"

#define MERGE_DEBUG 1

#if MERGE_DEBUG
#   define MERGE_LOG(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#else
#   define MERGE_LOG(...)
#endif

@implementation NSMutableDictionary (merge)

- (void)mergeWithObj:(NSObject*)obj
{
	if (![obj isKindOfClass:[NSDictionary class]]) {
		NSAssert(@"Attempted to merge objects of different types: %@\n,\n %@", self, obj);
	}
	[self mergeWithDictionary:obj];
}

- (BOOL)canMergeWithObj:(NSObject*)obj
{
	if (![obj isKindOfClass:[NSDictionary class]]) {
		return NO;
	}
	return YES;
}

- (void)mergeWithDictionary:(NSDictionary*)dict
{
	KeyEnumerator* ke = [dict keyEnumerator];
	
	for (id<NSCopying> key in ke) {
		id myObj = [self objectForKey:key];
		id obj = [dict objectForKey:key];
		if (!myObj) {
			// The key was not already in self, so simply add it.
			MERGE_LOG(@"inserted new object for key: %@", key);
			
			[self setObject:obj forKey:key];
		} else {
			// The key already existed in self, so we need to see if the two
			// objects can be merged.
			
			MERGE_LOG(@"attempting merge of objects for key: %@", key);
			
			id<Merge> mergeObj = nil;
			id otherObj = nil;
			if ([myObj respondsToSelector:@selector(canMergeWithObj:)] && [mergeObj canMergeWithObj:obj]) {
				// will myObj merge with obj?
				mergeObj = myObj;
				otherObj = obj;
			} else if ([obj respondsToSelector:@selector(canMergeWithObj:)] && [obj canMergeWithObj:myObj]) {
				// will obj merge with myObj?
				mergeObj = obj;
				otherObj = myObj;
			} else {
				if ([myObj respondsToSelector:@selector(mutableCopy)]) {
					MERGE_LOG(@"creating a mutable copy of obj for key (%@) to see if that copy can be merged.", key);
					id mutableMyObj = [[myObj mutableCopy] autorelease];
					if ([mutableMyObj respondsToSelector:@selector(canMergeWithObj:)] && [mutableMyObj canMergeWithObj:obj]) {
						// will a mutable copy of myObj merge with obj?
						mergeObj = mutableMyObj;
						otherObj = obj;
					}
				}
				if (!mergeObj && [obj respondsToSelector:@selector(mutableCopy)]) {
					MERGE_LOG(@"creating a mutable copy of obj for key (%@) to see if that copy can be merged.", key);
					id mutableObj = [[obj mutableCopy] autorelease];
					if ([mutableObj respondsToSelector:@selector(canMergeWithObj:)] && [mutableObj canMergeWithObj:myObj]) {
						// will a mutable copy of obj merge with myObj?
						mergeObj = mutableObj;
						otherObj = myObj;
					}
				}
			}
			
			if (mergeObj) {
				// we can merge!
				
				NSAssert(otherObj, @"code bug: otherObj is not set even though mergeObj is set!");
				
				[mergeObj mergeWithObj:otherObj];
				[self setObject:mergeObj forKey:key];
				MERGE_LOG(@"merged objects for key: %@", key);
			} else {
				MERGE_LOG(@"objects for key (%@) were not merged because neither of them adheres to the Merge protocol.", key);
			}
		}
	}
}

@end