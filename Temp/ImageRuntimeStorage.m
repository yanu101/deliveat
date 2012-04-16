//
//  ImageRuntimeStorage.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageRuntimeStorage.h"

@implementation ImageRuntimeStorage
#define IMAGE_AVATAR 1
#define IMAGE_GENERAL 2
#define TIME_OUT 60
@synthesize imageRuntimeStorageCollection, delegateCollection;

- (NSData*) getImageWithImageURL:(NSString*)imageUrl andImageType:(int)imageType andDelegate:(id<IImageRuntimeStorageListener>) delegate {
    id imageData = [imageRuntimeStorageCollection valueForKey:imageUrl];
    if(imageData) {
        return (NSData*)imageData;
    } else {
        [delegateCollection setObject:delegate forKey:imageUrl];
        return nil;
    }
    
}
- (void) runLooping {
    BOOL looping = YES;
    while (looping) {
        if([delegateCollection count] > 0) {
            for(NSString* imageUrl in delegateCollection) {
                id<IImageRuntimeStorageListener> delegate = [delegateCollection objectForKey:imageUrl];
                NSURL* url = [[NSURL alloc] initWithString:imageUrl];
                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:TIME_OUT];
                NSOperationQueue *queue = [[NSOperationQueue alloc] init];
                
                [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
                 {
                     if ([data length] > 0 && error == nil)
                         [delegate imageFetched:data];
                     else if ([data length] == 0 && error == nil)
                         [delegate imageFetched:data];
                     else if (error != nil)
                         [delegate imageFetched:data];
                 }];
                
            }
            
            
        } else {
            [NSThread sleepForTimeInterval:5.0];
        }
    }
}

@end
