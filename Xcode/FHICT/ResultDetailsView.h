#import <UIKit/UIKit.h>
#import "Result.h"
#import "FHICTAppDelegate.h"

@interface ResultDetailsView : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    Result *currentResult;
    IBOutlet UITableView *table;
    FHICTAppDelegate *app;
}

- (void)loadResult:(Result *)result;

@end
