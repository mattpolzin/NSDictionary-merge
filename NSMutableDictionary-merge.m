

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
			
			MERGE_LOG(@"merged objects for key: %@", key);
			
			if ([obj isKindOfClass:[myObj class]] || [myObj isKindOfClass:[obj class]]) {
				// This means it is possible the two objects adhere to the merge
				// protocol and can be merged that way.
				
				id myNewObj = myObj;
				if ([myNewObj respondsToSelector:@selector(mutableCopy)]) {
					myNewObj = [[myNewObj mutableCopy] autorelease];
				}
				
				if ([myNewObj respondsToSelector:@selector(mergeWithObj:)]) {
					[myNewObj mergeWithObj:obj];
					[self setObject:myNewObj forKey:key];
				} else {
					MERGE_LOG(@"objects for key (%@) were not merged because at least one of them does not adhere to the Merge protocol.", key);
				}
				
			} else {
				MERGE_LOG(@"objects for key (%@) were not of same kind of class. No merge was possible.", key);
			}
		}
	}
}

@end