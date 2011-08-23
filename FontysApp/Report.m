#import "Report.h"

@implementation Report

@synthesize student, periods;

- (void) addPeriod:(Period *)period
{
    NSMutableArray *tempperiods = [[NSMutableArray alloc] initWithArray:self.periods];
    [tempperiods addObject:period];
    periods = [tempperiods copy];
    [tempperiods release];
}

- (void) dealloc
{
    [student release];
    [periods release];
    [super dealloc];
}
@end
