//
//  API.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HTTPResult;
extern NSString* const API_BASE;
extern NSString* const GET_VENDOR_API;
extern NSString* const GET_VENDOR_ITEMS_API;
@interface API : NSObject
- (HTTPResult*)getGeneralImage:(NSString*)url;
- (HTTPResult*)getHttpRequest:(NSString*)url andMethod:(NSString*)method;
@end
