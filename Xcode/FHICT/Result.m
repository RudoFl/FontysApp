#import "Result.h"

@implementation Result

@synthesize course, description, result, comment, A1, A2, A3, B1, B2, B3, B4, B5, SBU;

- (void) dealloc
{
    [course release];
    [description release];
    [result release];
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

- (Boolean) isSufficient
{
    if([[self.result lowercaseString] isEqualToString:@"g"] || [[self.result lowercaseString] isEqualToString:@"v"])
    {
        return true;
    }
    else if([[self.result lowercaseString] isEqualToString:@"o"])
    {
        return false;
    }
    else
    {
        int resultint = [self.result intValue];
        double resultdouble = (double)[self.result doubleValue];
        
        if(resultint > 10)
        {
            resultdouble = resultint / 10;
        }
        else
        {
            resultdouble = resultint;
        }
        
        if (resultdouble > 5.5) {
            return YES;
        }
        else if (resultdouble > 0)
        {
            return NO;
        }

    }
    return NULL;
}

- (NSInteger)competentieCount
{
    return [[self passedCompetenties] count] + [[self failedCompetenties] count];
}

- (NSArray*)passedCompetenties
{
    NSMutableArray *mCompetenties = [[NSMutableArray alloc] init];
    if([[self.A1 lowercaseString] isEqualToString:@"g"] || [[self.A1 lowercaseString] isEqualToString:@"v"])
        [mCompetenties addObject:@"A1"];
    if([[self.A2 lowercaseString] isEqualToString:@"g"] || [[self.A2 lowercaseString] isEqualToString:@"v"])
        [mCompetenties addObject:@"A2"];
    if([[self.A3 lowercaseString] isEqualToString:@"g"] || [[self.A3 lowercaseString] isEqualToString:@"v"])
        [mCompetenties addObject:@"A3"];
    if([[self.B1 lowercaseString] isEqualToString:@"g"] || [[self.B1 lowercaseString] isEqualToString:@"v"])
        [mCompetenties addObject:@"B1"];
    if([[self.B2 lowercaseString] isEqualToString:@"g"] || [[self.B2 lowercaseString] isEqualToString:@"v"])
        [mCompetenties addObject:@"B2"];
    if([[self.B3 lowercaseString] isEqualToString:@"g"] || [[self.B3 lowercaseString] isEqualToString:@"v"])
        [mCompetenties addObject:@"B3"];
    if([[self.B4 lowercaseString] isEqualToString:@"g"] || [[self.B4 lowercaseString] isEqualToString:@"v"])
        [mCompetenties addObject:@"B4"];
    if([[self.B5 lowercaseString] isEqualToString:@"g"] || [[self.B5 lowercaseString] isEqualToString:@"v"])
        [mCompetenties addObject:@"B5"];
    NSArray *competenties = [[NSArray alloc] initWithArray:mCompetenties];
    [mCompetenties release];
    return [competenties autorelease];
}

- (NSArray*)failedCompetenties
{
    NSMutableArray *mCompetenties = [[NSMutableArray alloc] init];
    if([[self.A1 lowercaseString] isEqualToString:@"o"])
        [mCompetenties addObject:@"A1"];
    if([[self.A2 lowercaseString] isEqualToString:@"o"])
        [mCompetenties addObject:@"A2"];
    if([[self.A3 lowercaseString] isEqualToString:@"o"])
        [mCompetenties addObject:@"A3"];
    if([[self.B1 lowercaseString] isEqualToString:@"o"])
        [mCompetenties addObject:@"B1"];
    if([[self.B2 lowercaseString] isEqualToString:@"o"])
        [mCompetenties addObject:@"B2"];
    if([[self.B3 lowercaseString] isEqualToString:@"o"])
        [mCompetenties addObject:@"B3"];
    if([[self.B4 lowercaseString] isEqualToString:@"o"])
        [mCompetenties addObject:@"B4"];
    if([[self.B5 lowercaseString] isEqualToString:@"o"])
        [mCompetenties addObject:@"B5"];
    NSArray *competenties = [[NSArray alloc] initWithArray:mCompetenties];
    [mCompetenties release];
    return [competenties autorelease];
}

@end
