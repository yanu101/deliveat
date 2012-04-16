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

@end
