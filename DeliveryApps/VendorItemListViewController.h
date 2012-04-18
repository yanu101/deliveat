//
//  VendorItemListViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Vendor;
@interface VendorItemListViewController : UITableViewController

@property (strong, nonatomic) Vendor* vendor;
@property (strong, nonatomic) NSMutableArray* items;
@end
