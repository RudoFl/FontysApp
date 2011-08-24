#import <Foundation/Foundation.h>

@interface Result : NSObject
{
    NSString *course, *description, *result, *comment, *A1, *A2, *A3, *B1, *B2, *B3, *B4, *B5;
    NSInteger SBU;
}

@property (nonatomic, retain) NSString *course;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *result;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSString *A1;
@property (nonatomic, retain) NSString *A2;
@property (nonatomic, retain) NSString *A3;
@property (nonatomic, retain) NSString *B1;
@property (nonatomic, retain) NSString *B2;
@property (nonatomic, retain) NSString *B3;
@property (nonatomic, retain) NSString *B4;
@property (nonatomic, retain) NSString *B5;
@property (nonatomic, assign) NSInteger SBU;

@end