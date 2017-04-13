#import "DBMangeShare.h"
@implementation DBMangeShare
static DBMangeShare *shareGameModel = nil;
+ (DBMangeShare*)sharedDBMange{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareGameModel = [[DBMangeShare alloc] init];
        shareGameModel.tableDict = [NSMutableDictionary dictionaryWithCapacity:10];
        shareGameModel.queue = [[NSOperationQueue alloc] init];
        shareGameModel.queue.maxConcurrentOperationCount = 3;
    });
	return shareGameModel;
}

@end
