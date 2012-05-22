//
//  VendorItemListCell.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
@class VendorMenuItem;
@interface VendorItemListCell : UITableViewCell<IImageRuntimeStorageListener>

@property (strong, nonatomic) IBOutlet UIImageView* image;
@property (strong, nonatomic) IBOutlet UILabel* name;
@property (strong, nonatomic) IBOutlet UILabel* desc;
@property (strong, nonatomic) IBOutlet UIImageView* star;
@property (strong, nonatomic) IBOutlet UILabel* price;

@property (strong, nonatomic) VendorMenuItem* vendorMenuItem;

- (void)commit;
@end
