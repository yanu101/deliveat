//
//  CartViewController.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CartViewController.h"
#import "MenuOrder.h"
#import "AppDelegate.h"
#import "AppFactory.h"
#import "VendorMenuItem.h"
#import "Vendor.h"
#import "CartCell.h"
#import "TotalCartCell.h"
#import "MenuOrderItem.h"
#import "iToast.h"
#import "MBProgressHUD.h"
#import "APIThread.h"
#import "HTTPRequestParameter.h"

@interface CartViewController ()

@end

@implementation CartViewController
@synthesize menuOrder, dictMenuOrder, keys;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) normalize {
    NSMutableArray* items = self.menuOrder.menuOrderItems;
    NSLog(@"items : %@", items);
    for(int i=0;i<[items count];i++) {
        MenuOrderItem* moi = [items objectAtIndex:i];
        
        if(![keys containsObject:moi.item.vendor]) {
            [keys addObject:moi.item.vendor];
        }
        NSMutableArray* arrayItem = [[NSMutableArray alloc] init];
        id obj = [self.dictMenuOrder objectForKey:[NSString stringWithFormat:@"%d",moi.item.vendor.ID]];
        if(obj) {
            arrayItem = obj;
        }
        [arrayItem addObject:moi];
        [self.dictMenuOrder setObject:arrayItem forKey:[NSString stringWithFormat:@"%d",moi.item.vendor.ID]];
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    checkoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Checkout" style:UIBarButtonItemStylePlain target:self action:@selector(checkoutButtonAction)];
    self.navigationItem.rightBarButtonItem = checkoutButton;
}
- (void) checkoutButtonAction {
    
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    
    checkoutThread = [[APIThread alloc] init];
    checkoutThread.delegate = self;
    HTTPRequestParameter* param = [[HTTPRequestParameter alloc] init];
    param.api = [appFactory getAPI];
    [checkoutThread performSelectorInBackground:@selector(doCheckout:) withObject:param];
//    [checkoutThread doCheckout:param];
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];	
	loading.labelText = @"Check Outing";
    [loading show:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    self.menuOrder = appFactory.menuOrder;
    
    self.keys = [[NSMutableArray alloc] init];
    self.dictMenuOrder = [[NSMutableDictionary alloc] init];
    [self normalize];
    
    NSLog(@"Token : %@", appFactory.token);
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
    NSLog(@"num of section : %d", [self.keys count]);
    return [self.keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    Vendor* vendor = [self.keys objectAtIndex:section];
    
    NSMutableArray* arrayItem = [self.dictMenuOrder objectForKey:[NSString stringWithFormat:@"%d", vendor.ID]];
    NSLog(@"Dict : %@", self.dictMenuOrder);
//    NSLog(@"numberOfRowsInSection : %@ , Size : %d", arrayItem, [arrayItem count]);
    return [arrayItem count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    Vendor* vendor = [self.keys objectAtIndex:indexPath.section];
    
    NSMutableArray* arrayItem = [self.dictMenuOrder objectForKey:[NSString stringWithFormat:@"%d", vendor.ID]];
    
    if(indexPath.row == [arrayItem count]) {
        TotalCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TotalCartCell"];
        double total = 0;
        for(int i=0;i<[arrayItem count];i++) {
            MenuOrderItem* moi = [arrayItem objectAtIndex:i];
            VendorMenuItem *vmi = moi.item;
            total +=(moi.numOfOrder * vmi.price);
        }
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
        NSNumber *score = [[NSNumber alloc] initWithDouble:total];
        [numFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        
        cell.total.text = [numFormatter stringFromNumber: score];
        return cell;
    } else {
        CartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartCell"];
        MenuOrderItem* moi = [arrayItem objectAtIndex:indexPath.row];
        VendorMenuItem *vmi = moi.item;
        
        CGSize  textSize = { 220.0, 10000.0 };
        
        CGSize size = [vmi.desc sizeWithFont:[UIFont boldSystemFontOfSize:13]
                           constrainedToSize:textSize 
                               lineBreakMode:UILineBreakModeClip];
        CGRect newRect = cell.desc.frame;
        newRect.size.height = size.height;
        cell.desc.frame = newRect;
        cell.desc.numberOfLines = 0;
        
        cell.desc.text = vmi.desc;
        
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
        NSNumber *score = [[NSNumber alloc] initWithDouble:vmi.price];
        [numFormatter setNumberStyle: NSNumberFormatterDecimalStyle];
        
        cell.price.text = [NSString stringWithFormat:@"%d x %@", moi.numOfOrder, [numFormatter stringFromNumber: score]];
        // Configure the cell...
        
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Vendor* vendor = [self.keys objectAtIndex:indexPath.section];
    
    NSMutableArray* arrayItem = [self.dictMenuOrder objectForKey:[NSString stringWithFormat:@"%d", vendor.ID]];
    if(indexPath.row == [arrayItem count]) {
        return 25;
    }
    MenuOrderItem* moi = [arrayItem objectAtIndex:indexPath.row];
    VendorMenuItem *vmi = moi.item;
    
    CGSize  textSize = { 220.0, 10000.0 };
    
	CGSize size = [vmi.desc sizeWithFont:[UIFont boldSystemFontOfSize:13]
                       constrainedToSize:textSize 
                           lineBreakMode:UILineBreakModeClip];
    
    return MAX(25, size.height + 15);
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Vendor* vendor = [self.keys objectAtIndex:section];
    return vendor.name;
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
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    }
}

#pragma iapithread - apithread delegate
- (void)apiThread:(APIThread *)apiThread failed:(NSError *)error {
    

}
- (void)done {
    [loading show:NO];
    [loading done];
    
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    
    [appFactory resetMenuOrder];
    self.menuOrder = appFactory.menuOrder;
    self.keys = [[NSMutableArray alloc] init];
    self.dictMenuOrder = [[NSMutableDictionary alloc] init];
    [self.tableView reloadData];

}
- (void)apiThread:(APIThread *)apiThread receivedResult:(HTTPResult *)result {
//    [self performSelectorOnMainThread:@selector(done) withObject:nil waitUntilDone:YES];
    [self done];

}
@end
