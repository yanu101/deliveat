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
#import "Utility.h"
@interface NewLoginViewController ()

@end

@implementation NewLoginViewController
@synthesize tableView, prevTextField;
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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

- (IBAction)hideKeyboard:(id)sender {
    UITextField *tf = sender;
    [tf resignFirstResponder];
    
}
- (IBAction)showKeyboard:(id)sender {
}
- (IBAction)signUpAction:(id)sender {
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [Utility scrollScreenBeginEditingInView:self.view inTextField:textField show:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    [Utility scrollScreenBeginEditingInView:self.view inTextField:textField show:NO];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
}
- (IBAction)submitAction:(id)sender {
    
    NSIndexPath *indexPathUsername = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *indexPathPassword = [NSIndexPath indexPathForRow:1 inSection:1];
    NewLoginCellBottom* usernameCell = (NewLoginCellBottom*)[self.tableView cellForRowAtIndexPath:indexPathUsername] ;
    NewLoginCellBottom* passwordCell = (NewLoginCellBottom*)[self.tableView cellForRowAtIndexPath:indexPathPassword] ;
    UITextField *usernameField = usernameCell.field;
    UITextField *passwordField = passwordCell.field;
    if([usernameField.text length] ==0 || [passwordField.text length] == 0) {
        [Utility showAlertWithTitle:@"Alert" andMessage:@"Gak boleh kosong nyong"];
        return;
    }
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
    
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    
    loginThread = [[APIThread alloc] init];
    loginThread.delegate = self;
    HTTPRequestParameter* param = [[HTTPRequestParameter alloc] init];
    param.api = [appFactory getAPI];
    param.regEmail = usernameField.text;
    param.regPass = passwordField.text;
    [loginThread doLogin:param];
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];	
	loading.labelText = @"Sign in";
    [loading show:YES];
    
}
- (void) getVendorAction {
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    
    getVendorThread = [[APIThread alloc] init];
    getVendorThread.delegate = self;
    HTTPRequestParameter* param = [[HTTPRequestParameter alloc] init];
    param.api = [appFactory getAPI];
    
    [getVendorThread performSelectorInBackground:@selector(getVendors:) withObject:param];
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];	
	loading.labelText = @"Loading";
    [loading show:YES];
}
- (void) apiThread:(APIThread*)apiThread failed:(NSError *) error {
    
    [loading show:NO];
    [loading done];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LoginSegue"])
    {
        AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        AppFactory* appFactory = [appDelegate getAppFactory];
        
        appFactory.vendors = sender;
    }
    
}
//- (void) loginSuccess:(id)sender {
//    [self performSegueWithIdentifier:@"LoginSegue" sender:sender];
//}
- (void) apiThread:(APIThread*)apiThread receivedResult:(HTTPResult*)result {
    [loading show:NO];
    [loading done];
    if(apiThread == loginThread) {
        loginThread = nil;
        [self getVendorAction];
    }
    if(apiThread == getVendorThread) {
        
        NSMutableArray* dataVendors = result.result;
        [self performSegueWithIdentifier:@"LoginSegue" sender:dataVendors];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        return 250;
    } 
    if(indexPath.section == 2) {
        return 30;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    //    cell.backgroundColor = indexPath.row % 2 
    //    ? [UIColor colorWithRed: 0.0 green: 0.0 blue: 1.0 alpha: 1.0] 
    //    : [UIColor whiteColor];
    //    cell.textLabel.backgroundColor = [UIColor clearColor];
    //    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        NSString *CellIdentifier = @"BottomCell";
        NewLoginCellBottom *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(indexPath.row == 0) {
            cell.field.placeholder = @"Username";
            cell.field.delegate = self;
            cell.signup.hidden = YES;
            cell.submit.hidden = YES;
            cell.label.hidden = YES;
            cell.tag = 1;
        } else if(indexPath.row == 1){
            cell.field.placeholder = @"Password";
            cell.field.delegate = self;
            cell.field.secureTextEntry = YES;
            cell.signup.hidden = YES;
            cell.submit.hidden = YES;
            cell.label.hidden = YES;
            cell.tag = 2;
            
        }
//        cell.userInteractionEnabled = NO;
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
