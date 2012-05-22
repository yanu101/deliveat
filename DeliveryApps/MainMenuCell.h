//
//  MainMenuCell.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
@class Vendor;
@interface MainMenuCell : UITableViewCell<IImageRuntimeStorageListener>
@property (strong, nonatomic) IBOutlet UIImageView* icon;
@property (strong, nonatomic) IBOutlet UILabel* title;
@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) Vendor* vendor;
- (void)commit;
@end
