//
//  AppFactory.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
@class ImageRuntimeStorage;
@class Resource;
@class API;
@class APIThread;
@class Util;
@class MenuOrder;

@class MenuOrderItem;
@interface AppFactory : NSObject<IAppFactory> {
    ImageRuntimeStorage* imageRuntimeStorage;
    Resource* resource;
    API* api;
    APIThread* apiThread;
    Util* util;
    
}
@property (nonatomic, readonly, getter = getImageRuntimeStorage) ImageRuntimeStorage *imageRuntimeStorage;
@property (nonatomic, readonly, getter = getResource) Resource *resource;
@property (nonatomic, readonly, getter = getApiThread) APIThread *apiThread;
@property (nonatomic, readonly, getter = getAPI) API *api;
@property (nonatomic, readonly, getter = getUtil) Util *util;
@property (nonatomic, strong) NSMutableDictionary* messageDictionary;
@property (nonatomic, strong) NSMutableArray* vendors;
@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) MenuOrder* menuOrder;


- (void) resetMenuOrder;
//- (ImageRuntimeStorage*) getImageRuntimeStorage;
//- (Resource*) getResource;
//- (APIThread*) getApiThread;
//- (API*) getAPI;
//- (Util*) getUtil;

@end
