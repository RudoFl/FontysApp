#import <Foundation/Foundation.h>

@interface Student : NSObject
{
    NSString *study, *student, *slb1, *slb2, *asses11, *asses12, *asses21, *asses22, *asses31, *asses32;
    NSInteger pcn, studentnumber;
}

@property (nonatomic, retain) NSString *student;
@property (nonatomic, retain) NSString *study;
@property (nonatomic, retain) NSString *slb1;
@property (nonatomic, retain) NSString *slb2;
@property (nonatomic, retain) NSString *asses11;
@property (nonatomic, retain) NSString *asses12;
@property (nonatomic, retain) NSString *asses21;
@property (nonatomic, retain) NSString *asses22;
@property (nonatomic, retain) NSString *asses31;
@property (nonatomic, retain) NSString *asses32;
@property (nonatomic, assign) NSInteger pcn;
@property (nonatomic, assign) NSInteger studentnumber;

- (void) discribe;

@end
