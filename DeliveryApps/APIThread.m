//
//  APIThread.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "APIThread.h"
#import "Protocols.h"
#import "HTTPRequestParameter.h"
#import "HTTPResult.h"
#import "API.h"
#import "Vendor.h"
#import "VendoerMenuItemParser.h"
#import "VendorParser.h"

@implementation APIThread
@synthesize delegate;

- (void) getDataImageWithParam:(HTTPRequestParameter*)param {
    HTTPResult* result = [param.api getGeneralImage:@"http://stackoverflow.com/questions/917932/retrieve-httpresponse-httprequest-status-codes-iphone-sdk"];
    if(result.error) {
        if (delegate && [delegate respondsToSelector:@selector(apiThread:failed:)]) {
            [delegate apiThread:self failed:result.error];
        }
    } else {
        if (delegate && [delegate respondsToSelector:@selector(apiThread:receivedResult:)]) {
            [delegate apiThread:self receivedResult:result];
        } 
    }
    
}
- (void) getVendors:(HTTPRequestParameter*)param {
    HTTPResult* result = [param.api getHttpRequest:[NSString stringWithFormat:@"%@%@", API_BASE, GET_VENDOR_API] andMethod:@"GET"];
    if(result.error) {
        if (delegate && [delegate respondsToSelector:@selector(apiThread:failed:)]) {
            [delegate apiThread:self failed:result.error];
        }
    } else {
        if (delegate && [delegate respondsToSelector:@selector(apiThread:receivedResult:)]) {
            
            NSString* dataStr = [NSString stringWithUTF8String:[result.data bytes]];
            NSMutableArray* array = [VendorParser getVendors:dataStr];
            result.result = array;
            
            [delegate apiThread:self receivedResult:result];
        } 
    }
    
}
- (void) getVendorItems:(HTTPRequestParameter*)param {
    
    NSLog(@"getVendorItems URL : %@%@%@/items.json",API_BASE,GET_VENDOR_ITEMS_API,param.vendorId);
    HTTPResult* result = [param.api getHttpRequest:[NSString stringWithFormat:@"%@%@%@/items.json",API_BASE,GET_VENDOR_ITEMS_API,param.vendorId] andMethod:@"GET"];
    if(result.error) {
        if (delegate && [delegate respondsToSelector:@selector(apiThread:failed:)]) {
            [delegate apiThread:self failed:result.error];
        }
    } else {
        if (delegate && [delegate respondsToSelector:@selector(apiThread:receivedResult:)]) {
            
            NSString* dataStr = [NSString stringWithUTF8String:[result.data bytes]];
//            NSLog(@"Data Vendor Items : %@", dataStr);
            NSMutableArray* array = [VendoerMenuItemParser getVendorItems:dataStr];
            result.result = array;
            
            [delegate apiThread:self receivedResult:result];
        } 
    }
    
}

@end
