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

- isSufficient
{
    if([[self.result lowercaseString] isEqualToString:@"g"] || [[self.result lowercaseString] isEqualToString:@"v"])
    {
        return YES;
    }
    else if([self.result lowercaseString] == @"o")
    {
        return NO;
    }
    else
    {
        int resultint = [self.result intValue];
        double resultdouble = (double)resultint;
        
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
        return nil;
}

@end
