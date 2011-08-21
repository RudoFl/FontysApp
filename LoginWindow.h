#import <UIKit/UIKit.h>

@interface LoginWindow : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSArray *accountTypes;
    UITextField *usernameInput, *passwordInput, *accountInput;
    IBOutlet UIButton *loginButton;
    UIPickerView *accountPicker;
    NSString *url;
    bool authSucces;
}

@property (nonatomic, retain) NSArray *accountTypes;
@property (nonatomic, retain) UITextField *usernameInput;
@property (nonatomic, retain) UITextField *passwordInput;
@property (nonatomic, retain) UITextField *accountInput;
@property (nonatomic, retain) UIButton *loginButton;
@property (nonatomic, retain) UIPickerView *accountPicker;
@property (nonatomic, retain) NSString *url;

- (IBAction)doLogin:(id)sender;

@end
