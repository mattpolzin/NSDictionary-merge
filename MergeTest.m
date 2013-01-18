
#import "MergeTest.h"
#import "NSMutableDictionary-merge.h"

@implementation MergeTest

+ (void)mergeTest
{
	NSArray* subArray1 = [NSArray arrayWithObjects:@"string 1", @"string 2", @"string 4", @"string 5", nil];
		NSArray* subArray2 = [NSArray arrayWithObjects:@"string 3", @"string 2", nil];
	
		NSDictionary* subDict1 = [NSDictionary dictionaryWithObjectsAndKeys:@"string A", @"string A", @"string C", @"string C", nil];
		NSDictionary* subDict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"string B", @"string B", nil];
	
		NSMutableDictionary* tmp1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:subDict1, @"subDict", @"stringA", @"string_entry", subArray1, @"array_entry", nil];
		NSDictionary* tmp2 = [NSDictionary dictionaryWithObjectsAndKeys:subDict2, @"subDict", @"stringB", @"string_entry", subArray2, @"array_entry", nil];
	
		NSLog(@"dict1: %@", tmp1);
		NSLog(@"dict2: %@", tmp2);
	
		[tmp1 mergeWithDictionary:tmp2];
	
		NSLog(@"merged dict: %@", tmp1);
}

@end