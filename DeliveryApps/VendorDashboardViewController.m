//
//  VendorDashboardViewController.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VendorDashboardViewController.h"
#import "VendorDashboardCellSubMenu.h"
#import "VendorDashboardCellTop.h"
#import "VendorItemListViewController.h"
#import "Vendor.h"
#import "MBProgressHUD.h"
#import "AppFactory.h"
#import "AppDelegate.h"
#import "APIThread.h"
#import "HTTPRequestParameter.h"
#import "HTTPResult.h"
@interface VendorDashboardViewController ()

@end

@implementation VendorDashboardViewController

@synthesize vendor;
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
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if(indexPath.row == 0) {
        return 207;
    } else {
        return 53;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"CellTop";
    if(indexPath.row == 0) {
        VendorDashboardCellTop* cellTop = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cellTop.vendor = vendor;
        [cellTop commit];
//        cellTop.vendorLogo.image = 
        cellTop.labelVendor.text = vendor.name;
        
        cellTop.accessoryType = UITableViewCellAccessoryNone;
        cellTop.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cellTop.clipsToBounds = NO;
        cellTop.contentView.clipsToBounds = NO;
        
        return cellTop;
    } else {
        NSArray* arrayMenu = [[NSArray alloc] initWithObjects:@"Menu", @"Review", @"Promo", nil];
        CellIdentifier = @"CellMenu";
        VendorDashboardCellSubMenu *cellMenu = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cellMenu.labelMenu.text = [arrayMenu objectAtIndex:indexPath.row-1];
        
        cellMenu.accessoryType = UITableViewCellAccessoryNone;
//        cellMenu.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cellMenu.clipsToBounds = NO;
        cellMenu.contentView.clipsToBounds = NO;
        return cellMenu;
    }
    
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
    NSString* idIndex = [NSString stringWithFormat:@"%d", indexPath.row-1];
    if(indexPath.row-1 == 0) {
        AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        AppFactory* appFactory = [appDelegate getAppFactory];
        getMenuItemThread = [[APIThread alloc] init];
        getMenuItemThread.delegate = self;
        HTTPRequestParameter* param = [[HTTPRequestParameter alloc] init];
        param.api = [appFactory getAPI];
        param.vendorId = @"1";
        [getMenuItemThread performSelectorInBackground:@selector(getVendorItems:) withObject:param];
        loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];	
        loading.labelText = @"Loading";
        [loading show:YES];

    }
//    [self performSegueWithIdentifier:@"VendorItem" sender:idIndex];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"VendorItem"])
    {
        
        // Get reference to the destination view controller
        VendorItemListViewController *vc = [segue destinationViewController];
        vc.items = sender;
        // Pass any objects to the view controller here, like...
        
        
    }
}
- (void)apiThread:(APIThread *)apiThread failed:(NSError *)error {
    
}
- (void) getMenuVendorItemSuccess:(id)sender {
    [self performSegueWithIdentifier:@"VendorItem" sender:sender];
}
- (void) apiThread:(APIThread*)apiThread receivedResult:(HTTPResult*)result {
    [loading show:NO];
    [loading done];
    if(apiThread == getMenuItemThread) {
        
        NSMutableArray* dataVendors = result.result;
        if(!dataVendors || [dataVendors count] == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" 
                                                                message:@"Data Connection Failed" 
                                                               delegate:nil 
                                                      cancelButtonTitle:@"Ok" 
                                                      otherButtonTitles:nil];
            [alertView show];
            return;
        }
        [self performSelectorOnMainThread:@selector(getMenuVendorItemSuccess:) withObject:dataVendors waitUntilDone:YES];
    }
}
@end
