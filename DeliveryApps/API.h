//
//  API.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define GENERAL_GROUP @"GENERAL"
#define API_BASE @"http://www.deliveat.com:3000/"
#define GET_VENDOR_API @"api/vendors.json"
#define GET_VENDOR_ITEMS_API @"api/vendors/"
#define REGISTRATION_API @"api/users"
#define LOGIN_API @"api/users/login"

@class HTTPResult;
//extern NSString* const API_BASE;
//extern NSString* const GET_VENDOR_API;
//extern NSString* const GET_VENDOR_ITEMS_API;
@interface API : NSObject
- (HTTPResult*)getGeneralImage:(NSString*)url;
- (HTTPResult*)getHttpRequest:(NSString*)url andMethod:(NSString*)method;
@end
