#import <Foundation/Foundation.h>
#import "Result.h";

@interface Period : NSObject
{
    NSString *description;
    NSArray *results;
}

- (void) addResult:(Result *)result;

@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSArray *results;
@end
