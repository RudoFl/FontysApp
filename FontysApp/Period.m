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

- (void) addResult:(Result *)result;
{
    NSMutableArray *tempresults = [[NSMutableArray alloc] initWithArray:self.results];
    [tempresults addObject:result];
    self.results = [tempresults copy];
    [tempresults release];
}

- (void) dealloc
{
    [description release];
    [results release];
    [super dealloc];
}

@end
