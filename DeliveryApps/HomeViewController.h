//
//  HomeViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "BaseTableViewController.h"
//@class BaseTableViewController;
@interface HomeViewController : BaseTableViewController<IFieldChangeListener>
@property (strong, nonatomic) NSMutableArray* dataCollection;
@end
