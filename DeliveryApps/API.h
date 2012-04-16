//
//  API.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HTTPResult;
@interface API : NSObject
- (HTTPResult*)getGeneralImage:(NSString*)url;
@end
