#import <UIKit/UIKit.h>
#import "FontysAppAppDelegate.h"

@interface LoginWindow : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, NSXMLParserDelegate>
{
    NSArray *accountTypes;
    UITextField *usernameInput, *passwordInput, *accountInput;
    IBOutlet UIButton *loginButton;
    UIPickerView *accountPicker;
    NSString *url;
    bool authSucces;
    FontysAppAppDelegate *app;
    Period *currentPeriod;
}

@property (nonatomic, retain) NSArray *accountTypes;
@property (nonatomic, retain) UITextField *usernameInput;
@property (nonatomic, retain) UITextField *passwordInput;
@property (nonatomic, retain) UITextField *accountInput;
@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UIPickerView *accountPicker;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) FontysAppAppDelegate *app;
@property (nonatomic, retain) Period *currentPeriod;

- (void)parseXML;
- (void)describeDictionary:(NSDictionary *)dict;

- (IBAction)doLogin:(id)sender;

@end
