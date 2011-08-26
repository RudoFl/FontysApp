#import "Student.h"

@implementation Student

@synthesize student, slb1, slb2, asses11, asses12, asses21, asses22, asses31, asses32, study, pcn, studentnumber;

- (void) discribe
{
    NSLog([NSString stringWithFormat:@"\nHi my name is %@. My PCN-Number is %d and my Studentnumber is %d. \n\n%@ was my first SLB'er and %@ was my second SLB'er.\n\nFor my assesments i've had %@, %@, %@, %@, %@ and %@ as assesors", self.student, self.pcn, self.studentnumber, self.slb1, self.slb2, self.asses11, self.asses12, self.asses21, self.asses22, self.asses31, self.asses32]);
}

- (void) dealloc
{
    [student dealloc];
    [study dealloc];
    [slb1 dealloc];
    [slb2 dealloc];
    [asses11 dealloc];
    [asses12 dealloc];
    [asses21 dealloc];
    [asses22 dealloc];
    [asses31 dealloc];
    [asses32 dealloc];
    [super dealloc];
}

@end
