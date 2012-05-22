//
//  VendorParser.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VendorParser.h"
#import "Vendor.h"
#import "Utility.h"
@implementation VendorParser

+ (NSMutableArray*) getVendors:(NSString*)stringPayload {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    NSError *error;
    NSData *jsonData = [stringPayload dataUsingEncoding:NSUTF8StringEncoding];
    if(!jsonData) {
        return nil;
    }
    NSArray *items = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    
	for(int i=0;i<[items count];i++) {
        
		Vendor* vendor = [[self class] getVendor:(NSDictionary*)[items objectAtIndex:i]];
		[array addObject:vendor];
	}
	return array;
}
+ (Vendor*) getVendor:(NSDictionary*)dictPayload {

    int ID;
    if([dictPayload objectForKey:@"id"]) {
        ID = [[Utility decodeEntities:[dictPayload objectForKey:@"id"]] intValue];
    }
    NSLog(@"Vendor ID %d", ID);
    
    NSString* name;
    if([dictPayload objectForKey:@"name"]) {
        name = [Utility decodeEntities:[dictPayload objectForKey:@"name"]];
    }
    NSLog(@"Name : %@", name);
    NSString* desc;
    if([dictPayload objectForKey:@"description"]) {
        desc = [Utility decodeEntities:[dictPayload objectForKey:@"description"]];
    }
    NSLog(@"Desc : %@", desc);
    NSDictionary* avatar_url;
    NSDictionary* dashboard_url;
    if([dictPayload objectForKey:@"logo_image"]) {
        avatar_url = [dictPayload objectForKey:@"logo_image"];
    }
    if([dictPayload objectForKey:@"dashboard_image"]) {
        dashboard_url = [dictPayload objectForKey:@"dashboard_image"];
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
    
    Vendor* vendor = [[Vendor alloc] init];
    vendor.ID = ID;
    vendor.name = name;
    vendor.description = desc;
//    vendor.createdAt = createdAt;
//    vendor.updatedAt = updatedAt;
    vendor.fullAvatarUrl = [Utility decodeEntities:[avatar_url objectForKey:@"full"]];
    vendor.mediumAvatarUrl = [Utility decodeEntities:[avatar_url objectForKey:@"medium"]];
    vendor.thumbAvatarUrl = [Utility decodeEntities:[avatar_url objectForKey:@"thumb"]];
    
    vendor.dbFullAvatarUrl = [Utility decodeEntities:[dashboard_url objectForKey:@"full"]];
    vendor.dbMediumAvatarUrl = [Utility decodeEntities:[dashboard_url objectForKey:@"medium"]];
    vendor.dbThumbAvatarUrl = [Utility decodeEntities:[dashboard_url objectForKey:@"thumb"]];
    NSLog(@"\n\n");
    return vendor;
}
@end
