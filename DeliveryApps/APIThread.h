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
@class HTTPUtil;
@interface APIThread : NSObject

@property (strong, nonatomic) id<IAPIThread> delegate;
@property (strong, nonatomic) HTTPUtil* httpUtil;
- (id)init;
- (void) getDataImageWithParam:(HTTPRequestParameter*)param;
- (void) getVendors:(HTTPRequestParameter*)param;
- (void) getVendorItems:(HTTPRequestParameter*)param;
- (void) doRegistration:(HTTPRequestParameter*)param;
- (void) doLogin:(HTTPRequestParameter*)param;
- (void) doCheckout:(HTTPRequestParameter*)param;
@end
