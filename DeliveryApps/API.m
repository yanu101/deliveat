//
//  API.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "API.h"
#import "HTTPUtil.h"
#import "HTTPResult.h"
@implementation API

//NSString* const API_BASE = @"http://www.deliveat.com:3000/";
//NSString* const GET_VENDOR_API = @"api/vendors.json";
//NSString* const GET_VENDOR_ITEMS_API = @"api/vendors/"; //api/vendors/$id/items.json

- (HTTPResult*)getGeneralImage:(NSString*)url {
    HTTPUtil* httpUtil = [[HTTPUtil alloc] init];
    HTTPResult* result = [httpUtil makeSyncHttpConnectionWithUrl:url andMethod:@"GET" andReqHeader:nil andBodyContent:nil andContentType:nil];
    return result;
}
- (HTTPResult*)getHttpRequest:(NSString*)url andMethod:(NSString*)method {
    HTTPUtil* httpUtil = [[HTTPUtil alloc] init];
    HTTPResult* result = [httpUtil makeSyncHttpConnectionWithUrl:url andMethod:method andReqHeader:nil andBodyContent:nil andContentType:nil];
    return result;
}
@end
