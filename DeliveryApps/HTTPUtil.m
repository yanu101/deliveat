//
//  HTTPUtil.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HTTPUtil.h"
#import "HTTPRequest.h"
#import "HTTPResult.h"
@implementation HTTPUtil
- (HTTPResult *)makeSyncHttpConnectionWithUrl:(NSString *)url andMethod:(NSString *)reqMethod andReqHeader:(NSMutableDictionary *)headers andBodyContent:(NSData*)bodyContent andContentType:(NSString*)contentType {
    NSURL* nsurl = [[NSURL alloc] initWithString:url];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:nsurl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    NSHTTPURLResponse* response = nil;
    NSError* error = nil;
    
    [request setHTTPMethod:reqMethod];
    
    if(contentType) {
//        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
        [request setValue:contentType forHTTPHeaderField:@"Accept"];
    }
    
    if ([headers count] > 0) {
        for (NSString *key in headers.allKeys)
        {
            [request addValue:[headers valueForKey:key] forHTTPHeaderField:key];
        }
    }
    
    if(bodyContent) {
        [request addValue:[NSString stringWithFormat:@"%d", bodyContent.length] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody:bodyContent];
    }
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    int statusCode = response.statusCode;
    HTTPResult *result = [[HTTPResult alloc] init];
    
    if(statusCode == 200) {
        error = nil;
    }
    result.error = error;
    result.data = data;
    result.responseCode = statusCode;
    
    return result;
}
@end
