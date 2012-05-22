//
//  VendorMenuItem.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Vendor;
@interface VendorMenuItem : NSObject 
@property int ID;
@property (strong, nonatomic) Vendor* vendor;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* desc;
@property (strong, nonatomic) NSString* thumbUrl;
@property (strong, nonatomic) NSArray* logoImages;
@property (strong, nonatomic) NSArray* dahboardImages;
@property double price;

@end
