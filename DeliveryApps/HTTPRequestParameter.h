//
//  HTTPRequestParameter.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class API;
@interface HTTPRequestParameter : NSObject

@property (nonatomic, strong) API* api;
@property (nonatomic, strong) NSString* vendorId;
@property (nonatomic, strong) NSString* regEmail;
@property (nonatomic, strong) NSString* regPass;
@end
