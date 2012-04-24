//
//  AppFactory.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppFactory.h"
#import "ImageRuntimeStorage.h"
#import "Resource.h"
#import "APIThread.h"
#import "API.h"
#import "Util.h"
@implementation AppFactory
@synthesize imageRuntimeStorage, api, apiThread, util, resource, messageDictionary, vendors;

- (ImageRuntimeStorage*) getImageRuntimeStorage {
    if(!imageRuntimeStorage) {
        imageRuntimeStorage = [[ImageRuntimeStorage alloc] init];
        imageRuntimeStorage.delegateCollection = [[NSMutableDictionary alloc] init];
        imageRuntimeStorage.imageRuntimeStorageCollection = [[NSMutableDictionary alloc] init];
        [imageRuntimeStorage performSelectorInBackground:@selector(runLooping) withObject:nil];
    }
    return imageRuntimeStorage;
}
- (Resource*) getResource {
    if(!resource) {
        resource = [[Resource alloc] init];
    }
    return resource;
}

- (APIThread *)getApiThread {
    if(!apiThread) {
        apiThread = [[APIThread alloc] init];
    }
}
- (API *)getAPI {
    if(!api) {
        api = [[API alloc] init];
    }
    return api;
}
- (Util *)getUtil {
    if(!util) {
        util = [[Util alloc] init];
    }
    return util;
}
//- (NSMutableDictionary*) getMessageDictionary {
//    if(!self.messageDictionary) {
//        self.messageDictionary = [[NSMutableDictionary alloc] init];
//    }
//    return self.messageDictionary;
//}
@end
