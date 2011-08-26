#import <UIKit/UIKit.h>
#import "Report.h"

@interface FHICTAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) Report *report;

- (void)loginComplete;
- (NSString *)competentieForShortcode:(NSString *)shortCode;

@end
