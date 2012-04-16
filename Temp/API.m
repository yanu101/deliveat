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
- (HTTPResult*)getGeneralImage:(NSString*)url {
    HTTPUtil* httpUtil = [[HTTPUtil alloc] init];
    HTTPResult* result = [httpUtil makeSyncHttpConnectionWithUrl:url andMethod:@"GET" andReqHeader:nil andBodyContent:nil andContentType:nil];
    return result;
}
@end
