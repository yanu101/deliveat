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
//    NSLog(@"json data : %@", jsonData);
    if(!jsonData) {
        return nil;
    }
    NSArray *items = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
//    NSLog(@"Error : %@", error.description);
//    NSLog(@"items count : %d", [items count]);
    
	for(int i=0;i<[items count];i++) {
        
		Vendor* vendor = [[self class] getVendor:(NSDictionary*)[items objectAtIndex:i]];
		[array addObject:vendor];
	}
	return array;
}
+ (Vendor*) getVendor:(NSDictionary*)dictPayload {

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
    if([dictPayload objectForKey:@"logo_image"]) {
        avatar_url = [dictPayload objectForKey:@"logo_image"];
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
    
    vendor.name = name;
    vendor.description = desc;
//    vendor.createdAt = createdAt;
//    vendor.updatedAt = updatedAt;
    vendor.fullAvatarUrl = [Utility decodeEntities:[avatar_url objectForKey:@"full"]];
    vendor.mediumAvatarUrl = [Utility decodeEntities:[avatar_url objectForKey:@"medium"]];
    vendor.thumbAvatarUrl = [Utility decodeEntities:[avatar_url objectForKey:@"thumb"]];
    NSLog(@"\n\n");
    return vendor;
}
@end
