//
//  VendorParser.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Vendor;
@interface VendorParser : NSObject
+ (NSMutableArray*) getVendors:(NSString*)stringPayload;
+ (Vendor*) getVendor:(NSDictionary*)dictPayload;
@end
