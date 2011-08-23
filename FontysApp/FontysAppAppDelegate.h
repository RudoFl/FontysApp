#import <UIKit/UIKit.h>
#import "Report.h"

@interface FontysAppAppDelegate : NSObject <UIApplicationDelegate>
{
    Report *report;
}

@property (nonatomic, retain) Report *report;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UIViewController *viewController;

@end
