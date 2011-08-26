#import "ResultDetailsView.h"

@implementation ResultDetailsView

- (void)loadResult:(Result *)result
{
    currentResult = result;
    app = (FHICTAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[table setBackgroundColor:[UIColor clearColor]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }
    else
        return [currentResult competentieCount];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 1 && [currentResult competentieCount] != 0)
        return @"Competenties";
    else
        return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UIColor *red = [UIColor colorWithRed:1 green:.2 blue:0 alpha:1];
    
    if([indexPath section] == 0)
    {
        [cell.textLabel setText:currentResult.course];
        [cell.detailTextLabel setText:currentResult.description];
        [cell.imageView setImage:[UIImage imageNamed:@"result_frame.png"]];
        
        //Result label
        UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 3, 38, 40)];
        [resultLabel setTextAlignment:UITextAlignmentCenter];
        [resultLabel setFont:[UIFont systemFontOfSize:24]];
        [resultLabel setText:[currentResult result]];
        [resultLabel setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:resultLabel];
        
        
        Boolean sufficient = [currentResult isSufficient];
        
        if(sufficient != NULL) {
            if(sufficient) {
                // Voldoende
                [cell.textLabel setTextColor:[UIColor blackColor]];
                [cell.detailTextLabel setTextColor:[UIColor grayColor]];
                [resultLabel setTextColor:[UIColor colorWithRed:.4 green:.8 blue:0 alpha:1]];
            }
            else
            {
                // Onvoldoende                
                [cell.textLabel setTextColor:red];
                [cell.detailTextLabel setTextColor:red]; 
                [resultLabel setTextColor:red];
            }
        } else {
            // Niet beoordeeld
            [cell.textLabel setTextColor:[UIColor grayColor]]; 
            [cell.detailTextLabel setTextColor:[UIColor lightGrayColor]];
            [cell.imageView setImage:nil];
            [cell setIndentationWidth:43];
            [cell setIndentationLevel:1];
        }

    }
    else
    {
        int compcount = [[currentResult passedCompetenties] count];
        int row = [indexPath row];
        if([indexPath row] > [[currentResult passedCompetenties] count])
        {
            [cell.textLabel setTextColor:red];
            [cell.textLabel setText:[app competentieForShortcode:[[currentResult passedCompetenties] objectAtIndex:[indexPath row] - [[currentResult passedCompetenties] count]]]];
        }
        else
        {
            [cell.textLabel setText:[app competentieForShortcode:[[currentResult passedCompetenties] objectAtIndex:[indexPath row]]]];
        }
    }
    
    return cell;
}

@end
