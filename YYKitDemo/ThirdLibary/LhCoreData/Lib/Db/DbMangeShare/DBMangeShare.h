#import <Foundation/Foundation.h>
@interface DBMangeShare : NSObject{
}
@property(nonatomic,strong)  NSMutableDictionary* tableDict;
@property(nonatomic,strong)  NSOperationQueue *queue;
+(DBMangeShare*)sharedDBMange;
@end
