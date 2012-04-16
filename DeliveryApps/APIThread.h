//
//  APIThread.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
@class API;
@class HTTPRequestParameter;
@interface APIThread : NSObject

@property (strong, nonatomic) id<IAPIThread> delegate;
- (void) getDataImageWithParam:(HTTPRequestParameter*)param;
- (void) getVendors:(HTTPRequestParameter*)param;
@end
