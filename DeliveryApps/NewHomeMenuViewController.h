//
//  NewHomeMenuViewController.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
#import "Protocols.h"

@interface NewHomeMenuViewController : BaseTableViewController<IFieldChangeListener>
@property (strong, nonatomic) NSMutableArray* dataCollection;

@end
