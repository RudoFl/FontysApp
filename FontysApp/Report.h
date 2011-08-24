#import <Foundation/Foundation.h>
#import "Student.h"
#import "Period.h"

@interface Report : NSObject
{
    Student *student;
    NSArray *periods;
}

@property (nonatomic, retain) Student *student;
@property (nonatomic, retain) NSArray *periods;

@end
