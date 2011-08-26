#import <UIKit/UIKit.h>
#import "FHICTAppDelegate.h"

@interface LoginWindow : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, NSXMLParserDelegate>
{
    NSArray *accountTypes;    
    NSMutableArray *results, *periods;
    UITextField *usernameInput, *passwordInput, *accountInput;
    IBOutlet UIButton *loginButton;
    UIPickerView *accountPicker;
    NSString *url;
    bool authSucces;
    FHICTAppDelegate *app;
    Period *currentPeriod;
    IBOutlet UITableView *table;
}

@property (nonatomic, retain) NSArray *accountTypes;
@property (nonatomic, retain) NSMutableArray *results;
@property (nonatomic, retain) NSMutableArray *periods;
@property (nonatomic, retain) UITextField *usernameInput;
@property (nonatomic, retain) UITextField *passwordInput;
@property (nonatomic, retain) UITextField *accountInput;
@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UIPickerView *accountPicker;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) FHICTAppDelegate *app;
@property (nonatomic, retain) Period *currentPeriod;

- (void)parseXML;
- (void)describeDictionary:(NSDictionary *)dict;

- (IBAction)doLogin:(id)sender;

@end
