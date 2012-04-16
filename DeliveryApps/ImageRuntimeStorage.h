//
//  ImageRuntimeStorage.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocols.h"
#import "HTTPRequest.h"

@interface ImageRuntimeStorage : NSObject {
    NSMutableArray* imageRuntimeStorageCollection;
}
@property (strong, nonatomic) NSMutableArray* imageRuntimeStorageCollection;
@property (strong, nonatomic) NSMutableDictionary* delegateCollection;

- (NSData*) getImageWithImageURL:(NSString*)imageUrl andImageType:(int)imageType andDelegate:(id<IImageRuntimeStorageListener>) delegate;

@end

