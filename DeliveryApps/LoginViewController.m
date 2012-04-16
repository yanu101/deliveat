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

#import "HTTPRequest.h"
#import "APIThread.h"
#import "AppFactory.h"
#import "HTTPResult.h"
#import "HTTPRequestParameter.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize username, password, buttonLogin, sampleWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loginAction:(id)sender {
//    if([username.text length] == 0) {
//        return;
//    }
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    APIThread* apiThread = [[APIThread alloc] init];
    apiThread.delegate = self;
    HTTPRequestParameter* param = [[HTTPRequestParameter alloc] init];
    param.api = [appFactory getAPI];
    
    [apiThread performSelectorInBackground:@selector(getVendors:) withObject:param];
    
    [self performSegueWithIdentifier:@"Login" sender:@""];
    NSLog(@"masuk sini");
}
- (void)signupAction:(id)sender {
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Login"])
    {
        return;
        // Get reference to the destination view controller
                
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
- (void) apiThread:(APIThread*)apiThread receivedResult:(HTTPResult*)result {
    NSString* dataStr = [NSString stringWithUTF8String:[result.data bytes]];
    
    NSLog(@"DAPET data nya gak ya : %d  %@", [result.data length], dataStr);
}
@end
