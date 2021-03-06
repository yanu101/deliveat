//
//  VendorDashboardViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "BaseTableViewController.h"
@class Vendor;
@class MBProgressHUD;
@class APIThread;
@interface VendorDashboardViewController : BaseTableViewController<IAPIThread> {
    MBProgressHUD *loading;
    APIThread *getMenuItemThread;
}
@property (strong, nonatomic) Vendor* vendor;
@end
