//
//  BaseTableViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface BaseTableViewController : UITableViewController {
    MBProgressHUD *loadingProgress;
}

@end
