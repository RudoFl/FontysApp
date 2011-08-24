#import "Period.h"

@implementation Period

@synthesize description, results;

- (id)init
{
    self = [super init];
    if (self) {
        results = [[NSArray alloc] init];
    }
    
    return self;
}

- (void) dealloc
{
    [description release];
    [results release];
    [super dealloc];
}

@end
