#import "SettingsAccount.h"

@implementation SettingsAccount

@synthesize usernameInput, passwordInput, accountInput, accountPicker, accountTypes;

- (void)viewDidLoad
{
    [self setTitle:@"Account"];
    [super viewDidLoad];
    
    [table setBackgroundColor:[UIColor clearColor]];
    
    self.accountTypes = [[NSArray alloc] initWithObjects:@"Student", @"Werknemer", @"Relatie", nil];
    
    self.accountPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320, 270)];
    self.accountPicker.delegate = self;
    self.accountPicker.dataSource = self;
    [self.view addSubview:self.accountPicker];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveUserData:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if([indexPath row] == 0)
    {
        [cell.textLabel setText:@"PCN"];
        self.usernameInput = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 44)];
        [self.usernameInput setKeyboardType:UIKeyboardTypeNumberPad];
        [self.usernameInput setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self.usernameInput setText:[prefs objectForKey:@"username"]];
        [cell addSubview:self.usernameInput];
    }
    else if([indexPath row] == 1)
    {
        [cell.textLabel setText:@"Wachtwoord"];
        self.passwordInput = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 44)];
        [self.passwordInput setSecureTextEntry:YES];
        [self.passwordInput setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self.passwordInput setText:[prefs objectForKey:@"password"]];
        [cell addSubview:self.passwordInput];
    }
    else
    {
        [cell.textLabel setText:@"Type"];
        self.accountInput = [[UITextField alloc] initWithFrame:CGRectMake(130, 0, 180, 44)];
        [self.accountInput setText:[prefs objectForKey:@"accounttype"]];
        self.accountInput.inputView = accountPicker;
        [self.accountInput setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [cell addSubview:self.accountInput];
    }     
    return cell;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.accountTypes count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.accountTypes objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.accountInput setText:[self.accountTypes objectAtIndex:row]];
}

- (IBAction)saveUserData:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:[usernameInput text] forKey:@"username"];
    if([savePasswordSwitch isOn])
        [prefs setObject:[passwordInput text] forKey:@"password"];
    else
        [prefs setObject:@"" forKey:@"password"];
    [prefs setObject:[accountInput text] forKey:@"accounttype"];
    
    [usernameInput resignFirstResponder];
    [passwordInput resignFirstResponder];
    [accountInput resignFirstResponder];
}

- (void)dealloc
{
    [usernameInput release];
    [passwordInput release];
    [accountInput release];
    [accountTypes release];
    [accountPicker release];
    [super dealloc];
}

@end
