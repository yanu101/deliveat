//
//  HomeViewController.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "BuddyCell.h"
#import "Resource.h"
#import "VendorDashboardViewController.h"
#import "AppFactory.h"
#import "AppDelegate.h"
#import "MainMenuCell.h"
#import "Vendor.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize dataCollection;
int n = 0;
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
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    dataCollection = appFactory.vendors;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
//    self.tableView.separatorColor = [UIColor redColor];
    
//    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather-background.png"]]; 
//    self.tableView.backgroundColor = [UIColor clearColor];
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
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        n = 4;//[dataCollection count];
        int modulo = n % 2;
        int div = [dataCollection count]/2;
        int h = (HEIGHT_CELL_ITEM+BUDDY_ITEM_MARGIN) * (modulo == 0 ? div : div + 1);
        h+=BUDDY_ITEM_MARGIN;
        return h==0?HEIGHT_CELL_ITEM+7 : h+7;
    }
    return 64;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row == 0) {
        static NSString *CellIdentifier = @"BuddyCell";
        BuddyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.delegate = self;
        cell.dataCollection = self.dataCollection;
        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = NO;
        cell.contentView.clipsToBounds = NO;
        [cell buildUI];
        [cell layoutSubviews];
        
        n = 4;//[dataCollection count];
        int modulo = n % 2;
        int div = [dataCollection count]/2;
        int h = (HEIGHT_CELL_ITEM+BUDDY_ITEM_MARGIN) * (modulo == 0 ? div : div + 1);
        h+=BUDDY_ITEM_MARGIN;
        
        UIImageView *sep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"divider"]];
        sep.frame = CGRectMake(0, h, 320, 7);
        [cell addSubview:sep];
        
        // Configure the cell...
        
        return cell;
    } else {
        static NSString *CellIdentifier = @"MainMenuCell";
        MainMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.delegate = self;
        NSInteger index = indexPath.row;
        NSLog(@"\n\nINDEX : %d\n\n", (index-1));
        Vendor *vendor = [self.dataCollection objectAtIndex:(index-1)];
        cell.vendor = vendor;
        
//        cell.dataCollection = self.dataCollection;
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.clipsToBounds = NO;
//        cell.contentView.clipsToBounds = NO;
        [cell commit];
        UIImageView *sep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"divider"]];
        sep.frame = CGRectMake(0, 57, 320, 7);
        [cell addSubview:sep];
                               
//        [cell layoutSubviews];
        // Configure the cell...
        
        return cell;
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
    Vendor *vendor = [self.dataCollection objectAtIndex:indexPath.row-1];
    
    [self performSegueWithIdentifier:@"VendorDashboard" sender:vendor];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"VendorDashboard"])
    {
        
        // Get reference to the destination view controller
        VendorDashboardViewController *vc = [segue destinationViewController];
        vc.vendor = sender;
        // Pass any objects to the view controller here, like...
        
        
    }
}

#pragma mark - IFieldChangeListener delegate
-(void)fieldChanged:(id<IComponent>)component {
    [self performSegueWithIdentifier:@"VendorDashboard" sender:[component getCookie]];
}
@end
