//
//  CartViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "Protocols.h"

@class MenuOrder;
@class APIThread;

@interface CartViewController : BaseTableViewController<IAPIThread> {
    UIBarButtonItem* checkoutButton;
    APIThread *checkoutThread;
    MBProgressHUD* loading;
}
@property (strong, nonatomic) MenuOrder* menuOrder;
@property (strong, nonatomic) NSMutableDictionary* dictMenuOrder;
@property (strong, nonatomic) NSMutableArray* keys;
@end
