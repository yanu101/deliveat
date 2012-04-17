//
//  VendorDashboardCellSubMenu.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Vendor;
@interface VendorDashboardCellSubMenu : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView* icon;
@property (strong, nonatomic) IBOutlet UILabel* labelMenu;
@property (strong, nonatomic) Vendor* vendor;
@end
