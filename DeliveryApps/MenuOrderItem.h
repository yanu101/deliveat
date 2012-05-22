//
//  MenuOrderItem.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VendorMenuItem;
@interface MenuOrderItem : NSObject
@property (strong, nonatomic) VendorMenuItem* item;
@property int numOfOrder;
@end
