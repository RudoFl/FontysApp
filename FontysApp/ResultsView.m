#import "ResultsView.h"
#import "Period.h"
#import "Result.h"

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
    
    Result *currentResult = [((Period*)[app.report.periods objectAtIndex:[indexPath section]]).results objectAtIndex:[indexPath row]];
    
    [cell.textLabel setText:currentResult.course];
    [cell.detailTextLabel setText:currentResult.description];
    
    if([[currentResult.result lowercaseString] isEqualToString:@"g"])
    {
        [cell.imageView setImage:[UIImage imageNamed:@"g.png"]];
    } else if([[currentResult.result lowercaseString] isEqualToString:@"v"])
    {
        [cell.imageView setImage:[UIImage imageNamed:@"v.png"]];
    } else if([[currentResult.result lowercaseString] isEqualToString:@"o"])
    {
        [cell.imageView setImage:[UIImage imageNamed:@"o.png"]];
    } else 
    {   
        [cell.imageView setImage:[UIImage imageNamed:@"c.png"]];
        UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
        [resultLabel setTextAlignment:UITextAlignmentCenter];
        [resultLabel setFont:[UIFont fontWithName:@"Arial" size:24]];
        
        int resultint = [currentResult.result intValue];
        double resultdouble = [currentResult.result doubleValue];
        if(resultint > 10)
        {
            resultdouble = resultint / 10;
            [resultLabel setText:[[NSString stringWithFormat:@"%f", resultdouble] substringToIndex:3]];
        }
        else
        {
            if (resultint != 0)
                [resultLabel setText:[NSString stringWithFormat:@"%d", resultint]];
        }
        [resultLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:resultLabel];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)dealloc
{
    [app release];
    [super dealloc];
}

@end
