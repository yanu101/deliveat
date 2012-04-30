//
//  NewLoginViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
@class MBProgressHUD;
@class APIThread;
@interface NewLoginViewController : UIViewController <UITableViewDataSource, UITableViewDataSource, UITextFieldDelegate, IAPIThread> {
    MBProgressHUD* loading;
    APIThread* getVendorThread;
    APIThread* loginThread;
}
@property (strong, nonatomic) UITextField* prevTextField;
@property (strong, nonatomic) IBOutlet UITableView* tableView;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)showKeyboard:(id)sender;
- (IBAction)signUpAction:(id)sender;
- (IBAction)submitAction:(id)sender;

@end
