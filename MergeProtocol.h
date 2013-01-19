

@protocol Merge

@required
- (void)mergeWithObj:(NSObject*)obj;
- (BOOL)canMergeWithObj:(NSObject*)obj;

// sadly, the implementation of this is not very efficient. The only way to
// know for sure if an object of one of Apple's Collection classes is mutable is
// to try to change it. Because of the structuring of the Apple class clusters,
// isKindOfClass and respondsToSelector will not reliably give accurate
// information about mutability.
- (BOOL)isMutableObj;

@end