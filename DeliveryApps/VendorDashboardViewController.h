//
//  VendorDashboardViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Vendor;
@interface VendorDashboardViewController : UITableViewController
@property (strong, nonatomic) Vendor* vendor;
@end
