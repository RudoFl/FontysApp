#import "ResultsView.h"
#import "Period.h"
#import "Result.h"
#import "LoginWindow.h"

@implementation ResultsView

@synthesize app;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    app = (FontysAppAppDelegate *)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"periods: %d", [app.report.periods count]);
    return [app.report.periods count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"period: %@", ((Period *)[app.report.periods objectAtIndex:section]).description);
    return [((Period*)[app.report.periods objectAtIndex:section]).results count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return ((Period *)[app.report.periods objectAtIndex:section]).description;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ResultsCell";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    Result *currentResult = [((Period*)[app.report.periods objectAtIndex:[indexPath section]]).results objectAtIndex:[indexPath row]];
    
    [cell.textLabel setText:currentResult.course];
    [cell.detailTextLabel setText:currentResult.description];
    [cell.imageView setImage:[UIImage imageNamed:@"c.png"]];
    
   
    //Result label
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
    resultLabel.textAlignment = UITextAlignmentCenter;
    resultLabel.font = [UIFont systemFontOfSize:24];
    resultLabel.text = [currentResult result];
    [resultLabel setBackgroundColor:[UIColor clearColor]];
    [cell addSubview:resultLabel];
    
    
    Boolean *sufficient = [currentResult isSufficient];
    
    if(sufficient != nil) {
        if(sufficient) {
            // Voldoende
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            resultLabel.textColor = [UIColor colorWithRed:.4 green:.8 blue:0 alpha:1];
        }
        else
        {
            // Onvoldoende
            UIColor *red = [UIColor colorWithRed:1 green:.2 blue:0 alpha:1];
            
            cell.textLabel.textColor = red;
            cell.detailTextLabel.textColor = red; 
            resultLabel.textColor = red;
        }
    } else {
        // Niet beoordeeld
        cell.textLabel.textColor = [UIColor grayColor]; 
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        [cell.imageView setImage:nil];
        cell.indentationWidth = 43;
        cell.indentationLevel = 1;
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dealloc
{
    [app release];
    [super dealloc];
}

@end
