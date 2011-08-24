#import "Report.h"

@implementation Report

@synthesize student, periods;

- (void) dealloc
{
    [student release];
    [periods release];
    [super dealloc];
}
@end
