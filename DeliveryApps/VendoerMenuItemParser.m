//
//  VendoerMenuItemParser.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VendoerMenuItemParser.h"
#import "Utility.h"
#import "VendorMenuItem.h"

@implementation VendoerMenuItemParser
+ (NSMutableArray*) getVendorItems:(NSString*)stringPayload {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSError *error;
    
    NSData *jsonData = [stringPayload dataUsingEncoding:NSUTF8StringEncoding];
    if(!jsonData) {
        return nil;
    }
    NSArray *items = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
	for(int i=0;i<[items count];i++) {
		VendorMenuItem* vendor = [[self class] getVendorItem:(NSDictionary*)[items objectAtIndex:i]];
		[array addObject:vendor];
	}
	return array;
}
+ (VendorMenuItem*) getVendorItem:(NSDictionary*)dictPayload {
    
    NSString* name;
    if([dictPayload objectForKey:@"name"]) {
        name = [Utility decodeEntities:[dictPayload objectForKey:@"name"]];
    }
    NSString* desc;
    if([dictPayload objectForKey:@"description"]) {
        desc = [Utility decodeEntities:[dictPayload objectForKey:@"description"]];
    }
    NSDictionary* avatar_url;
    if([dictPayload objectForKey:@"avatar_url"]) {
        avatar_url = [dictPayload objectForKey:@"avatar_url"];
    }
    
    //    double timeStampCreatedAt;
    //    if([dictPayload objectForKey:@"created_at"]) {
    //        NSString* times = [dictPayload objectForKey:@"created_at"];
    //        NSLog(@"Created at string: %@", times);
    //        timeStampCreatedAt = [times doubleValue];
    //    }
    //    NSLog(@"Created at : %@", timeStampCreatedAt);
    //    NSDate* createdAt = [NSDate dateWithTimeIntervalSince1970:timeStampCreatedAt];
    
    //    double timeStampUpdatedAt;
    //    if([dictPayload objectForKey:@"updated_at"]) {
    //        NSString* times = [dictPayload objectForKey:@"updated_at"];
    //        timeStampUpdatedAt = [times doubleValue];
    //    }
    //    NSLog(@"Updated at : %@", timeStampUpdatedAt);
    //    NSDate* updatedAt = [NSDate dateWithTimeIntervalSince1970:timeStampUpdatedAt];
    
    VendorMenuItem* vendorMenuItem = [[VendorMenuItem alloc] init];
    
    vendorMenuItem.name = name;
    vendorMenuItem.desc = desc;
    vendorMenuItem.thumbUrl = [Utility decodeEntities:[avatar_url objectForKey:@"thumb"]];
    return vendorMenuItem;
}
@end
