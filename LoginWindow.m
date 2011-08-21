#import "LoginWindow.h"

@implementation LoginWindow

@synthesize accountTypes, accountInput, accountPicker, usernameInput, passwordInput, loginButton, url;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.accountTypes = [[NSArray alloc] initWithObjects:@"Student", @"Alumnus", @"Employee", @"Relation", nil];
    
    self.accountPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320, 270)];
    self.accountPicker.delegate = self;
    self.accountPicker.dataSource = self;
    [self.view addSubview:self.accountPicker];
    
    authSucces = YES;
    
    url = @"https://dpf-hi.fontys.nl/ReportServer?%2fStudentResulaat%2fStudentResultaat&rs%3aFormat=XML";
}

#pragma mark - Table view data source

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
    CGRect cellContentRect = CGRectMake(15, 0, cell.frame.size.width - 30, cell.frame.size.height); 
    if([indexPath row] == 0)
    {
        self.usernameInput = [[UITextField alloc] initWithFrame:cellContentRect];
        [self.usernameInput setPlaceholder:@"PCN-Number"];
        [self.usernameInput setKeyboardType:UIKeyboardTypeNumberPad];
        [self.usernameInput setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
        [self.usernameInput setText:@"221882"];
        
        [cell addSubview:self.usernameInput];
    }
    else if([indexPath row] == 1)
    {
        self.passwordInput = [[UITextField alloc] initWithFrame:cellContentRect];
        [self.passwordInput setSecureTextEntry:YES];
        [self.passwordInput setPlaceholder:@"Password"];
        [self.passwordInput setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
        [self.passwordInput setText:@"hp-Rudi_4965"];
        
        [cell addSubview:self.passwordInput];
    }
    else
    {
        self.accountInput = [[UITextField alloc] initWithFrame:cellContentRect];
        [self.accountInput setPlaceholder:@"Accounttype"];
        [self.accountInput setText:@"Student"];
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

- (IBAction)doLogin:(id)sender
{    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:30.0];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    [connection release];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge previousFailureCount] == 0) {
        //NSLog(@"received authentication challenge"); 
        NSString *authString;
        if([self.accountInput.text isEqualToString:@"Student"])
        {
            authString = [[self.usernameInput text] stringByAppendingString:@"@student.fontys.nl"];
        }
        else if([self.accountInput.text isEqualToString:@"Alumnus"])
        {
            authString = [[self.usernameInput text] stringByAppendingString:@"@student.fontys.nl"];        
        }
        else if([self.accountInput.text isEqualToString:@"Employee"])
        {
            authString = [[self.usernameInput text] stringByAppendingString:@"@fontys.nl"];        
        }
        else if([self.accountInput.text isEqualToString:@"Relation"])
        {
            authString = [[self.usernameInput text] stringByAppendingString:@"@relatie.fontys.nl"];
        }
        //NSLog(authString);
        NSURLCredential *newCredential = [NSURLCredential credentialWithUser:authString
                                                                    password:self.passwordInput.text
                                                                 persistence:NSURLCredentialPersistenceForSession];
        //NSLog(@"credential created");
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
        //NSLog(@"responded to authentication challenge");    
    }
    else {
        //NSLog(@"previous authentication failure");
        NSLog(@"Login Failed");
        authSucces = NO;
        UIAlertView *failureAlert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                               message:@"The provided username or password is incorrect!"
                                                              delegate:self 
                                                     cancelButtonTitle:@"Dismiss" 
                                                     otherButtonTitles:nil];
        [failureAlert show];
        [failureAlert release];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if(authSucces)
    {
        NSLog(@"Login Succesfull, getting XML feed");
        NSString *XMLData = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
        NSLog(XMLData);
        [XMLData release];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}

- (void)dealloc
{
    [accountTypes release];
    [accountInput release];
    [accountPicker release];
    [usernameInput release];
    [passwordInput release];
    [loginButton release];
    [url release];
    [super dealloc];
}

@end
