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
@interface NewLoginViewController : UITableViewController <IAPIThread> {
    MBProgressHUD* loading;
    APIThread* getVendorThread;
}

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)signUpAction:(id)sender;
- (IBAction)submitAction:(id)sender;

@end
