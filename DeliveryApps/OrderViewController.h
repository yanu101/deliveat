//
//  OrderViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
@class VendorMenuItem;
@interface OrderViewController : BaseTableViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    UIBarButtonItem* orderButton;
    UIBarButtonItem* selectNumofOrderButton;
    NSMutableArray* numOfOrder;
    NSString* myNumOfOrder;
}
- (IBAction)selectNumOfOrderButtonAction:(id)sender;
@property (strong, nonatomic) VendorMenuItem* vendorMenuItem;
@end
