#import "SettingsView.h"
#import "SettingsAccount.h"

@implementation SettingsView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Gegevens";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 8, 310, 30)];
    [detailLabel setFont:[UIFont systemFontOfSize:15]];
    [detailLabel setBackgroundColor:[UIColor clearColor]];
    [detailLabel setTextColor:[UIColor lightGrayColor]];
    [detailLabel setTextAlignment:UITextAlignmentCenter];
    [cell addSubview:detailLabel];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if([indexPath row] == 0)
    {
        [cell.textLabel setText:@"Account"];
        [detailLabel setText:[prefs objectForKey:@"username"]];
    }
    else
    {
        [cell.textLabel setText:@"Klassen"];
    }
    
    [detailLabel release];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == 0)
    {
        SettingsAccount *settingsAccount = [[SettingsAccount alloc] initWithNibName:@"SettingsAccount" bundle:nil];
        [self.navigationController pushViewController:settingsAccount animated:YES];
        [settingsAccount release];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
