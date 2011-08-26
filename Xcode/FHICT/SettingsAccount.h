#import <UIKit/UIKit.h>

@interface SettingsAccount : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>
{
    UITextField *usernameInput, *passwordInput, *accountInput;
    NSArray *accountTypes; 
    UIPickerView *accountPicker;
    IBOutlet UISwitch *savePasswordSwitch;
    IBOutlet UITableView *table;
}

@property (nonatomic, retain) UITextField *usernameInput;
@property (nonatomic, retain) UITextField *passwordInput;
@property (nonatomic, retain) UITextField *accountInput;
@property (nonatomic, retain) NSArray *accountTypes;
@property (nonatomic, retain) UIPickerView *accountPicker;

- (IBAction)saveUserData:(id)sender;

@end
