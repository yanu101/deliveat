//
//  VendorItemListViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
@class Vendor;
#define PADDING 10
#define MARGIN_TEXT 5
#define IMAGE_HEIGHT 52
#define TITLE_HEIGHT 21
#define STAR_IMAGE_HEIGHT 16

@interface VendorItemListViewController : BaseTableViewController

@property (strong, nonatomic) Vendor* vendor;
@property (strong, nonatomic) NSMutableArray* items;
@end
