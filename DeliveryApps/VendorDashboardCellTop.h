//
//  VendorDashboardCellTop.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"

@class Vendor;

@interface VendorDashboardCellTop : UITableViewCell<IImageRuntimeStorageListener>
@property (strong, nonatomic) IBOutlet UIImageView *vendorLogo;
@property (strong, nonatomic) Vendor* vendor;
@property (strong, nonatomic) IBOutlet UILabel* labelVendor;
- (void)commit;
@end
