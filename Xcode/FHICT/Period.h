#import <Foundation/Foundation.h>

@interface Period : NSObject
{
    NSString *description;
    NSArray *results;
}

@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSArray *results;

@end
