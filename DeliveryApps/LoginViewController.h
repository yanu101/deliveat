//
//  LoginViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
@class MBProgressHUD;
@interface LoginViewController : UIViewController <UIWebViewDelegate, IAPIThread> {
    MBProgressHUD* loading;
}

@property (strong, nonatomic) IBOutlet UITextField* username;
@property (strong, nonatomic) IBOutlet UITextField* password;
@property (strong, nonatomic) IBOutlet UIButton* buttonLogin;

@property (strong, nonatomic) IBOutlet UIWebView *sampleWebView;

- (IBAction)loginAction:(id)sender;
- (IBAction)signupAction:(id)sender;
//@property (strong, nonatomic) IBOutlet* uite

@end
