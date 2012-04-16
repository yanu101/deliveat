//
//  Protocols.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageRuntimeStorage;
@class Resource;
@class APIThread;
@class HTTPRequest;
@class HTTPResult;
@class Message;
@interface Protocols : NSObject

@end
@protocol IAPIThread <NSObject>

- (void) apiThread:(APIThread*)apiThread failed:(NSError *) error;
- (void) apiThread:(APIThread*)apiThread receivedResult:(HTTPResult*)result;

@end
@protocol IAppFactory

- (ImageRuntimeStorage*) getImageRuntimeStorage;
- (Resource*) getResource;
- (APIThread*) getApiThread;

@end

@protocol IComponent <NSObject>

- (void) setCookie:(id)cookie;
- (id)getCookie;

@end

@protocol IFieldChangeListener

- (void)fieldChanged:(id<IComponent>)component;

@end

@protocol IImageRuntimeStorageListener

- (void) imageFetched:(NSData*)imageData;

@end

@protocol HTTPRequestDelegate <NSObject>

@optional
- (void) request:(HTTPRequest *)request initialized:(NSURL *) url;
- (void) request:(HTTPRequest *)request connected:(NSURLResponse *)response;
- (void) request:(HTTPRequest *)request failed:(NSError *) error;
- (void) request:(HTTPRequest *)request receivedData:(NSData *)data;
- (void) request:(HTTPRequest *)request receivedChallenge:(NSURLAuthenticationChallenge *)challenge;
- (void) request:(HTTPRequest *)request authenticationFailed:(NSURLAuthenticationChallenge *)challenge;
@end
