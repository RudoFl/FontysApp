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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    /*Result *currentResult = [[((Period*)[app.report.periods objectAtIndex:[indexPath section]]).results objectAtIndex:[indexPath row]] autorelease];
    
    [cell.textLabel setText:currentResult.course];
    [cell.detailTextLabel setText:currentResult.description];*/
    
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
    [resultLabel setFont:[UIFont fontWithName:@"Helvetica" size:30]];
    [resultLabel setTextAlignment:UITextAlignmentCenter];
    [cell addSubview:resultLabel];
    
    UILabel *courseLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 2, 276, 21)];
    [courseLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [cell addSubview:courseLabel];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(44, 23, 276, 21)];
    [descriptionLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [cell addSubview:descriptionLabel];
    
    Result *currentResult = [((Period*)[app.report.periods objectAtIndex:[indexPath section]]).results objectAtIndex:[indexPath row]];
    
    if([[currentResult.result lowercaseString] isEqualToString:@"g"] || [[currentResult.result lowercaseString] isEqualToString:@"v"])
    {
        // Voldoende of goed
        [resultLabel setTextColor:[UIColor greenColor]];
        [resultLabel setText:[currentResult.result uppercaseString]];
    } else if([[currentResult.result lowercaseString] isEqualToString:@"o"])
    {
        // Onvoldoende
        [resultLabel setText:@"O"];
        [resultLabel setTextColor:[UIColor redColor]];
        [descriptionLabel setTextColor:[UIColor redColor]];
        [courseLabel setTextColor:[UIColor redColor]];
        
    } else if([[currentResult.result lowercaseString] isEqualToString:@""])
    {
        // Nog geen resultaat
    } else 
    {
        // Punt is een getal
        double result = [currentResult.result doubleValue];
        if (result < 5.5)
        {
            [resultLabel setTextColor:[UIColor redColor]];
            [descriptionLabel setTextColor:[UIColor redColor]];
            [courseLabel setTextColor:[UIColor redColor]];
        }
        else
        {
            [resultLabel setTextColor:[UIColor greenColor]];
        }
        [resultLabel setText:[NSString stringWithFormat:@"%d", result]];
    }
    [courseLabel setFont:cell.textLabel.font];
    [courseLabel setText:currentResult.course];
    [descriptionLabel setFont:cell.detailTextLabel.font];
    [descriptionLabel setText:currentResult.description];
    
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
