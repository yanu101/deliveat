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
#import "Resource.h"
#import "Utility.h"
#import "HTTPUtil.h"
@implementation APIThread
@synthesize delegate, httpUtil;
- (id)init {
    self = [super init];
    if(self) {
        self.httpUtil = [[HTTPUtil alloc] init];
    }
    return self;
}
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
    dispatch_async(kBgQueue, ^{
        NSError* error = nil;
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE, GET_VENDOR_API]] options:NSDataReadingUncached error:&error];
        HTTPResult* result = [[HTTPResult alloc] init];
        
        if(error) {
            if (delegate && [delegate respondsToSelector:@selector(apiThread:failed:)]) {
                [delegate apiThread:self failed:error];
            }
        } else {
            result.data = data;
            NSString* dataStr = [NSString stringWithUTF8String:[result.data bytes]];
            NSMutableArray* array = [VendorParser getVendors:dataStr];
            if(!array) {
                NSError* error = [NSError errorWithDomain:@"Data Connection Failed" code:1 userInfo:nil];
                [self performSelectorOnMainThread:@selector(error:) withObject:error waitUntilDone:YES];
                return;
            }
            result.result = array;
            if (delegate && [delegate respondsToSelector:@selector(apiThread:receivedResult:)]) {
                [self performSelectorOnMainThread:@selector(success:) withObject:result waitUntilDone:YES];
            }
        }
    });
    
}
- (void) getVendorItems:(HTTPRequestParameter*)param {
    dispatch_async(kBgQueue, ^{
        NSError* error = nil;
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@/items.json",API_BASE,GET_VENDOR_ITEMS_API,param.vendorId]] options:NSDataReadingUncached error:&error];
        HTTPResult* result = [[HTTPResult alloc] init];
        if(error) {
            
            if (delegate && [delegate respondsToSelector:@selector(apiThread:failed:)]) {
                [delegate apiThread:self failed:error];
            }
        } else {
            result.data = data;
            NSString* dataStr = [NSString stringWithUTF8String:[result.data bytes]];
            NSMutableArray* array = [VendoerMenuItemParser getVendorItems:dataStr];
            
            if(!array) {
                NSError* error = [NSError errorWithDomain:@"Data Connection Failed" code:1 userInfo:nil];
                [self performSelectorOnMainThread:@selector(error:) withObject:error waitUntilDone:YES];
                return;
            }
            result.result = array;
            if (delegate && [delegate respondsToSelector:@selector(apiThread:receivedResult:)])
            {
                [self performSelectorOnMainThread:@selector(success:) withObject:result waitUntilDone:YES];
            }
        }
    });
    
}
- (void) doRegistration:(HTTPRequestParameter*)param {
    NSString* body = [NSString stringWithFormat:@"{\"email\" : \"%@\" , \"password\" : \"%@\"}",param.regEmail,param.regPass];
    HTTPResult* result = [httpUtil makeSyncHttpConnectionWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE,REGISTRATION_API] andMethod:@"POST" andReqHeader:nil andBodyContent:[body dataUsingEncoding:NSUTF8StringEncoding] andContentType:@"application/json"];
    if(result.error) {
        if (delegate && [delegate respondsToSelector:@selector(apiThread:failed:)]) {
            [self performSelectorOnMainThread:@selector(error:) withObject:result.error waitUntilDone:YES];
        }
    } else {
        if (delegate && [delegate respondsToSelector:@selector(apiThread:receivedResult:)]) {
            [self performSelectorOnMainThread:@selector(success:) withObject:result waitUntilDone:YES];
        }
    }
}
- (void) doLogin:(HTTPRequestParameter*)param {
    dispatch_async(kBgQueue, ^{
        NSString* body = [NSString stringWithFormat:@"{\"email\" : \"%@\" , \"password\" : \"%@\"}",param.regEmail,param.regPass];
        HTTPResult* result = [httpUtil makeSyncHttpConnectionWithUrl:[NSString stringWithFormat:@"%@%@",API_BASE,LOGIN_API] andMethod:@"POST" andReqHeader:nil andBodyContent:[body dataUsingEncoding:NSUTF8StringEncoding] andContentType:@"application/json"];
        if(result.error) {
            if (delegate && [delegate respondsToSelector:@selector(apiThread:failed:)]) {
                [self performSelectorOnMainThread:@selector(error:) withObject:result.error waitUntilDone:YES];
            }
        } else {
            if (delegate && [delegate respondsToSelector:@selector(apiThread:receivedResult:)]) {
                [self performSelectorOnMainThread:@selector(success:) withObject:result waitUntilDone:YES];
            }
        }
    });
}
- (void)error:(NSError*)error_ {
    [delegate apiThread:self failed:error_];
    [Utility showAlertWithTitle:@"Alert" andMessage:error_.localizedDescription];
}
- (void)success:(HTTPResult*)result {
    [delegate apiThread:self receivedResult:result];
}
@end
