//
//  MenuOrder.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MenuOrderVendor;
@interface MenuOrder : NSObject
@property (strong, nonatomic) NSMutableArray* menuOrderItems;
- (id)init;
@end
