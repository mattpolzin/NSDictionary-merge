

@protocol Merge

@required
- (void)mergeWithObj:(NSObject*)obj;
- (BOOL)canMergeWithObj:(NSObject*)obj;

@end