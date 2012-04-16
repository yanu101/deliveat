//
//  HTTPUtil.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HTTPResult;
@interface HTTPUtil : NSObject
- (HTTPResult *)makeSyncHttpConnectionWithUrl:(NSString *)url andMethod:(NSString *)reqMethod andReqHeader:(NSMutableDictionary *)headers andBodyContent:(NSData*)bodyContent andContentType:(NSString*)contentType;

@end
