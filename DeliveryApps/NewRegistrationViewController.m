//
//  NewRegistrationViewController.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewRegistrationViewController.h"
#import "NewRegistrationCell.h"
#import "AppFactory.h"
#import "AppDelegate.h"
#import "Utility.h"
#import "APIThread.h"
#import "HTTPRequestParameter.h"
#import "MBProgressHUD.h"
#import "HTTPResult.h"
@interface NewRegistrationViewController ()

@end

@implementation NewRegistrationViewController
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    NewRegistrationCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(indexPath.section == 0) {
        if(indexPath.row == 0){
            cell.createButton.hidden = YES;
            cell.inputField.hidden = NO;
            cell.tag = 0;
            cell.inputField.placeholder = @"Email";
            
//            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            
        } else if(indexPath.row == 1){
            cell.createButton.hidden = YES;
            cell.inputField.hidden = NO;
            cell.tag = 1;
            cell.inputField.placeholder = @"Password";
//            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            
        } else {
            cell.createButton.hidden = YES;
            cell.inputField.hidden = NO;
            cell.tag = 2;
            cell.inputField.placeholder = @"Repeat Password";
        }
        
    } else {
        cell.inputField.hidden = YES;
        cell.createButton.hidden = NO;
        cell.tag = 3;
        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    cell.inputField.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        return 80;
    }
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 3;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"Registration";
    }
    return @"";
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
}
- (IBAction) doRegistration:(id)sender {
    
    NSIndexPath *indexPathUsername = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *indexPathPassword = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *indexPathRepeatPassword = [NSIndexPath indexPathForRow:2 inSection:0];
    
    NewRegistrationCell* usernameCell = (NewRegistrationCell*)[self.tableView cellForRowAtIndexPath:indexPathUsername] ;
    NewRegistrationCell* passwordCell = (NewRegistrationCell*)[self.tableView cellForRowAtIndexPath:indexPathPassword] ;
    NewRegistrationCell* repeatPasswordCell = (NewRegistrationCell*)[self.tableView cellForRowAtIndexPath:indexPathRepeatPassword] ;
    
    UITextField *usernameField = usernameCell.inputField;
    UITextField *passwordField = passwordCell.inputField;
    UITextField *repeatPasswordField = repeatPasswordCell.inputField;
    
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
    [repeatPasswordField resignFirstResponder];
    NSString* pass = passwordField.text;
    NSString* rpass = repeatPasswordField.text;
    if([usernameField.text length] == 0 || [pass length] == 0 || [rpass length] == 0 || !([pass isEqualToString:rpass])) {
        [Utility showAlertWithTitle:@"Alert" andMessage:@"Field cannot be empty"];
        return;
    }
    
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    registrationThread = [[APIThread alloc] init];
    registrationThread.delegate = self;
    HTTPRequestParameter* param = [[HTTPRequestParameter alloc] init];
    param.api = [appFactory getAPI];
    param.regEmail = usernameField.text;
    param.regPass = pass;
    
    [registrationThread doRegistration:param];
//    [registrationThread performSelectorInBackground:@selector(doRegistration:) withObject:param];
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];	
	loading.labelText = @"Registration";
    [loading show:YES];
    
}

- (void) doLogin {
    NSLog(@"masuk do login");
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    getVendorThread = [[APIThread alloc] init];
    getVendorThread.delegate = self;
    HTTPRequestParameter* param = [[HTTPRequestParameter alloc] init];
    param.api = [appFactory getAPI];
    [getVendorThread getVendors:param];
//    [getVendorThread performSelectorInBackground:@selector(getVendors:) withObject:param];
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];	
	loading.labelText = @"Sign in";
    [loading show:YES];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LoginSegue"])
    {
        AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        AppFactory* appFactory = [appDelegate getAppFactory];
        
        appFactory.vendors = sender;
    }
}

- (void)apiThread:(APIThread *)apiThread failed:(NSError *)error {
    
    [loading show:NO];
    [loading done];
//    [Utility showAlertWithTitle:@"Alert" andMessage:@"Error"];
}
- (void)apiThread:(APIThread *)apiThread receivedResult:(HTTPResult *)result {
    [loading show:NO];
    [loading done];
    if(apiThread == registrationThread) {
        registrationThread = nil;
        [self doLogin];
//        [self performSelectorOnMainThread:@selector(doLogin) withObject:nil waitUntilDone:YES];
    }
    
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
        [self performSegueWithIdentifier:@"LoginSegue" sender:dataVendors];
//        [self loginSuccess:dataVendors];
//        [self performSelectorOnMainThread:@selector(loginSuccess:) withObject:dataVendors waitUntilDone:YES];
    }
}
@end
