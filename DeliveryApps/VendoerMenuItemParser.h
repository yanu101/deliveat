//
//  VendoerMenuItemParser.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VendorMenuItem;
@interface VendoerMenuItemParser : NSObject
+ (NSMutableArray*) getVendorItems:(NSString*)stringPayload;
+ (VendorMenuItem*) getVendorItem:(NSDictionary*)dictPayload;
@end
