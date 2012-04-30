//
//  NewRegistrationViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
@class MBProgressHUD;
@interface NewRegistrationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, IAPIThread> {
    MBProgressHUD* loading;
    APIThread* getVendorThread;
    APIThread* registrationThread;
}
@property (strong, nonatomic) IBOutlet UITableView* tableView;

- (IBAction)doRegistration:(id)sender;
@end
