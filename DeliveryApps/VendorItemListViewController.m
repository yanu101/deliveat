//
//  VendorItemListViewController.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VendorItemListViewController.h"
#import "Vendor.h"
#import "VendorItemListCell.h"
#import "VendorMenuItem.h"
#import "OrderViewController.h"

@interface VendorItemListViewController ()

@end

@implementation VendorItemListViewController
@synthesize vendor, items;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather-background.png"]]; 
//    self.tableView.backgroundColor = [UIColor clearColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.items count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    VendorItemListCell *cell = (VendorItemListCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    VendorMenuItem *vmi = [self.items objectAtIndex:indexPath.row];
//    cell.name.text = vmi.name;
    
    CGSize  textSize = { 220.0, 10000.0 };
    
	CGSize size = [vmi.desc sizeWithFont:[UIFont boldSystemFontOfSize:13]
                       constrainedToSize:textSize 
                           lineBreakMode:UILineBreakModeClip];
    int normalHeight = PADDING*2 + MARGIN_TEXT*3 + TITLE_HEIGHT*3 + STAR_IMAGE_HEIGHT;
    int expectedHeight = PADDING*2 + MARGIN_TEXT*3 + TITLE_HEIGHT*2 + size.height + STAR_IMAGE_HEIGHT;//MARGIN*3 + TITLE_HEIGHT + size.height;
    return MAX(normalHeight, expectedHeight);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    VendorItemListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    VendorMenuItem *vmi = [self.items objectAtIndex:indexPath.row];
    cell.name.text = vmi.name;
    
    CGSize  textSize = { 220.0, 10000.0 };
    
	CGSize size = [vmi.desc sizeWithFont:[UIFont boldSystemFontOfSize:13]
					  constrainedToSize:textSize 
						  lineBreakMode:UILineBreakModeClip];
    NSLog(@"Frame : %f, %f", cell.desc.frame.size.width, cell.desc.frame.size.height);
    cell.desc.frame = CGRectMake(cell.desc.frame.origin.x, cell.desc.frame.origin.y, cell.desc.frame.size.width, size.height);
    NSLog(@"Frame : %f, %f", cell.desc.frame.size.width, cell.desc.frame.size.height);
    cell.desc.font = [UIFont systemFontOfSize:13];
    cell.desc.numberOfLines = 0;
    
    cell.price.frame = CGRectMake(cell.price.frame.origin.x, cell.desc.frame.origin.y + size.height + MARGIN_TEXT, cell.price.frame.size.width, cell.price.frame.size.height);
    
//    [cell.desc sizeToFit];
//    [cell layoutSubviews];
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *score = [[NSNumber alloc] initWithDouble:vmi.price];
    [numFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
    
    
    cell.price.text = [numFormatter stringFromNumber: score];
    cell.desc.text = vmi.desc;
    
    cell.vendorMenuItem = vmi;
    [cell commit];
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"OrderSegue"]) {
        NSIndexPath* index = [self.tableView indexPathForSelectedRow];
        VendorMenuItem *vmi = [self.items objectAtIndex:index.row];
        NSLog(@" vmi.vendor = self.vendor %@", self.vendor);
        vmi.vendor = self.vendor;
        OrderViewController* ovc = segue.destinationViewController;
        ovc.vendorMenuItem = vmi;
        
        NSLog(@"Index Row : %d", index.row);
//        NSIndexPath* index = [NSIndexPath indexPathForRow:<#(NSInteger)#> inSection:<#(NSInteger)#>]
    }
}
@end
