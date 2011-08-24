#import "LoginWindow.h"
#import "Result.h"
#import "ResultsView.h"

@implementation LoginWindow

@synthesize accountTypes, accountInput, accountPicker, usernameInput, passwordInput, loginButton, url, app, results, periods, currentPeriod;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.app = (FontysAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    periods = [[NSMutableArray alloc] init];
    
    self.accountTypes = [[NSArray alloc] initWithObjects:@"Student", @"Alumnus", @"Employee", @"Relation", nil];
    
    self.accountPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 480, 320, 270)];
    self.accountPicker.delegate = self;
    self.accountPicker.dataSource = self;
    [self.view addSubview:self.accountPicker];
    
    authSucces = YES;
    
    self.url = @"https://dpf-hi.fontys.nl/ReportServer?%2fStudentResulaat%2fStudentResultaat&rs%3aFormat=XML";
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
        
        
        [cell addSubview:self.usernameInput];
    }
    else if([indexPath row] == 1)
    {
        self.passwordInput = [[UITextField alloc] initWithFrame:cellContentRect];
        [self.passwordInput setSecureTextEntry:YES];
        [self.passwordInput setPlaceholder:@"Password"];
        [self.passwordInput setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
        
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
    NSLog(@"Starting authentication");
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
        [self parseXML];
        ResultsView *resultsView = [[ResultsView alloc] initWithNibName:@"ResultsView" bundle:nil];
        [self presentModalViewController:resultsView animated:NO];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}

- (void)parseXML
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:YES];
    [parser setShouldReportNamespacePrefixes:YES];
    [parser setShouldResolveExternalEntities:YES];
    [parser parse];
    [parser release];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"Report"])
    {        
        Student *student = [[Student alloc] init];
        student.student = [attributeDict objectForKey:@"studNaam"];
        student.study = [attributeDict objectForKey:@"studieNaam"];
        student.pcn = [[attributeDict objectForKey:@"studPcn"] intValue];
        student.studentnumber = [[attributeDict objectForKey:@"studNr"] intValue];
        student.slb1 = [attributeDict objectForKey:@"slb1Naam"];
        student.slb2 = [attributeDict objectForKey:@"slb2Naam"];
        student.asses11 = [attributeDict objectForKey:@"asse1PNaam"];
        student.asses12 = [attributeDict objectForKey:@"asse2PNaam"];
        student.asses21 = [attributeDict objectForKey:@"asse1PNaam2"];
        student.asses22 = [attributeDict objectForKey:@"asse2PNaam2"];
        student.asses31 = [attributeDict objectForKey:@"asse1PNaam3"];
        student.asses32 = [attributeDict objectForKey:@"asse2PNaam3"];        
        app.report.student = student;
        [student release];
    }
    
    if([elementName isEqualToString:@"table1_periodeNaam"])
    {
        Period *period = [[Period alloc] init];
        period.description = [attributeDict objectForKey:@"Textbox25"];
        currentPeriod = period;
        results = [[NSMutableArray alloc] init];
    }
    
    if([elementName isEqualToString:@"Detail"])
    {
        Result *result = [[Result alloc] init];
        result.course = [attributeDict objectForKey:@"vakNaam"];
        result.description = [attributeDict objectForKey:@"beschrijving"];
        result.result = [attributeDict objectForKey:@"resultaat"];
        result.SBU = [[attributeDict objectForKey:@"SBU"] intValue];
        result.comment = [attributeDict objectForKey:@"Opmerking"];
        result.A1 = [attributeDict objectForKey:@"A1"];
        result.A2 = [attributeDict objectForKey:@"A2"];
        result.A3 = [attributeDict objectForKey:@"A3"];
        result.B1 = [attributeDict objectForKey:@"B1"];
        result.B2 = [attributeDict objectForKey:@"B2"];
        result.B3 = [attributeDict objectForKey:@"B3"];
        result.B4 = [attributeDict objectForKey:@"B4"];
        result.B5 = [attributeDict objectForKey:@"B5"];
        [results addObject:result];
        [result release];
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"table1_periodeNaam"])
    {
        currentPeriod.results = results;
        [periods addObject:currentPeriod];
    }
    if([elementName isEqualToString:@"Report"])
    {
        app.report.periods = [[NSArray alloc] initWithArray:periods];
        NSLog(@"parsed %d periods", [app.report.periods count]);
        NSInteger resultcount = 0;
        for(Period *p in app.report.periods)
        {
            resultcount += [p.results count];
        }
        NSLog(@"parsed %d results", resultcount);
    }
}

- (void)describeDictionary:(NSDictionary *)dict
{ 
    NSArray *keys;
    int i, count;
    id key, value;
    
    keys = [dict allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [dict objectForKey: key];
        NSLog (@"Key: %@ for value: %@", key, value);
    }
}

- (void)dealloc
{
    [accountTypes release];
    [results release];
    [periods release];
    [currentPeriod release];
    [accountInput release];
    [accountPicker release];
    [usernameInput release];
    [passwordInput release];
    [loginButton release];
    [url release];
    [app release];
    [super dealloc];
}

@end
