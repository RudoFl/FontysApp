#import "FHICTAppDelegate.h"
#import "LoginWindow.h"

@implementation FHICTAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize report;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    LoginWindow *loginWindow = [[LoginWindow alloc] initWithNibName:@"LoginWindow" bundle:nil];
    self.window.rootViewController = loginWindow;    
    [loginWindow release];
    
    [self.window makeKeyAndVisible];
    report = [[Report alloc] init];
    return YES;
}

- (void)loginComplete
{
    self.window.rootViewController = self.tabBarController;
}

- (NSString *)competentieForShortcode:(NSString *)shortCode
{
    if([shortCode isEqualToString:@"A1"])
    {
        return @"Professioneel handelen";
    } else if([shortCode isEqualToString:@"A2"])
    {
        return @"Methodisch handelen";
    } else if([shortCode isEqualToString:@"A3"])
    {
        return @"Samenwerken";
    } else if([shortCode isEqualToString:@"B1"])
    {
        return @"Analyseren";
    } else if([shortCode isEqualToString:@"B2"])
    {
        return @"Adviseren";
    } else if([shortCode isEqualToString:@"B3"])
    {
        return @"Ontwerpen";
    } else if([shortCode isEqualToString:@"B4"])
    {
        return @"Realiseren";
    } else if([shortCode isEqualToString:@"B5"])
    {
        return @"Beheren";
    } 
    return @"";
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [report release];
    [super dealloc];
}

@end
