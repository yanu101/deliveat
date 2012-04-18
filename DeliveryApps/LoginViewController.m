//
//  LoginViewController.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"
#import "MBProgressHUD.h"
#import "VendorParser.h"
#import "HTTPRequest.h"
#import "APIThread.h"
#import "AppFactory.h"
#import "HTTPResult.h"
#import "HTTPRequestParameter.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "Vendor.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize username, password, buttonLogin, sampleWebView;
APIThread* getVendorThread;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loginAction:(id)sender {
//    if([username.text length] == 0 || [password.text length] == 0) {
//        return;
//    }
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
    [username resignFirstResponder];
    [password resignFirstResponder];
}
- (void)signupAction:(id)sender {
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"LoginSegue"])
    {
        AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        AppFactory* appFactory = [appDelegate getAppFactory];
        
        appFactory.vendors = sender;
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
        
//    sampleWebView.delegate = self;
//    [sampleWebView loadHTMLString:@"<html><body style=\"background-color: #ff0000; color: #FFFFFF; font-family: Helvetica; font-size: 10pt; width: 300px; word-wrap: break-word;\">YANUAR RAHMAN<br><a href=\"http://www.google.com\">Google</a></body></html>" baseURL:nil];
//    [sampleWebView layer].cornerRadius = 10;
//    sampleWebView.clipsToBounds = YES;
//    [sampleWebView layer].borderColor = [[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1] CGColor];
//    [sampleWebView layer].borderWidth = 3;
	// Do any additional setup after loading the view.
}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    return NO;
//}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void) apiThread:(APIThread*)apiThread failed:(NSError *) error {
    
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
@end
