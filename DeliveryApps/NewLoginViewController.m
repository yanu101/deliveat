//
//  NewLoginViewController.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewLoginViewController.h"
#import "NewLoginCellTop.h"
#import "NewLoginCellBottom.h"
#import "AppFactory.h"
#import "AppDelegate.h"
#import "APIThread.h"
#import "API.h"
#import "HTTPRequestParameter.h"
#import "MBProgressHUD.h"
#import "HTTPResult.h"
@interface NewLoginViewController ()

@end

@implementation NewLoginViewController

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
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = [UIColor whiteColor];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if(section == 0) {
        return 1;
    }
    if(section == 2) {
        return 2;
    }
    return 2;
}
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 1;
//}
- (IBAction)hideKeyboard:(id)sender {
    UITextField *tf = sender;
    [tf resignFirstResponder];
}
- (IBAction)signUpAction:(id)sender {
    
}
- (IBAction)submitAction:(id)sender {
    
    NSIndexPath *indexPathUsername = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *indexPathPassword = [NSIndexPath indexPathForRow:1 inSection:1];
    NewLoginCellBottom* usernameCell = (NewLoginCellBottom*)[self.tableView cellForRowAtIndexPath:indexPathUsername] ;
    NewLoginCellBottom* passwordCell = (NewLoginCellBottom*)[self.tableView cellForRowAtIndexPath:indexPathPassword] ;
    UITextField *usernameField = usernameCell.field;
    UITextField *passwordField = passwordCell.field;
    
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
    
    
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    getVendorThread = [[APIThread alloc] init];
    getVendorThread.delegate = self;
    HTTPRequestParameter* param = [[HTTPRequestParameter alloc] init];
    param.api = [appFactory getAPI];
    
    [getVendorThread performSelectorInBackground:@selector(getVendors:) withObject:param];
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];	
	loading.labelText = @"Sign in";
    [loading show:YES];
    
    
    
    
}
- (void) apiThread:(APIThread*)apiThread failed:(NSError *) error {
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LoginSegue"])
    {
        AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        AppFactory* appFactory = [appDelegate getAppFactory];
        
        appFactory.vendors = sender;
    }
    
}
- (void) loginSuccess:(id)sender {
    [self performSegueWithIdentifier:@"LoginSegue" sender:sender];
}
- (void) apiThread:(APIThread*)apiThread receivedResult:(HTTPResult*)result {
    [loading show:NO];
    [loading done];
    if(apiThread == getVendorThread) {
        
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
        [self performSelectorOnMainThread:@selector(loginSuccess:) withObject:dataVendors waitUntilDone:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return 265;
    } 
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        NSString *CellIdentifier = @"TopCell";
        NewLoginCellTop *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        return cell;
    } else if(indexPath.section == 2) {
        NSString *CellIdentifier = @"BottomCell";
        NewLoginCellBottom *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(indexPath.row == 0){
            cell.field.hidden = YES;
            cell.signup.hidden = NO;
            cell.submit.hidden = YES;
            cell.label.hidden = NO;
            cell.tag = 3;
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            
        } else if(indexPath.row == 1){
            cell.field.hidden = YES;
            cell.signup.hidden = YES;
            cell.submit.hidden = NO;
            cell.label.hidden = YES;
            cell.tag = 4;
            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            
        }
        return cell;
    } else {
        NSString *CellIdentifier = @"BottomCell";
        NewLoginCellBottom *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        cell.backgroundView = 
        // Configure the cell...
        
        
        if(indexPath.row == 0) {
            cell.field.placeholder = @"Username";
            cell.signup.hidden = YES;
            cell.submit.hidden = YES;
            cell.label.hidden = YES;
            cell.tag = 1;
        } else if(indexPath.row == 1){
            cell.field.placeholder = @"Password";
            cell.field.secureTextEntry = YES;
            cell.signup.hidden = YES;
            cell.submit.hidden = YES;
            cell.label.hidden = YES;
            cell.tag = 2;
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
