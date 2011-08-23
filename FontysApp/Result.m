#import "Result.h"

@implementation Result

@synthesize course, description, comment, A1, A2, A3, B1, B2, B3, B4, B5, SBU;

- (void) dealloc
{
    [course release];
    [description release];
    [comment release];
    [A1 release];
    [A2 release];
    [A3 release];
    [B1 release];
    [B2 release];
    [B3 release];
    [B4 release];
    [B5 release];
    [super dealloc];
}

@end
