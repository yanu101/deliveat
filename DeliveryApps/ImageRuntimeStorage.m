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
    
    NSLog(@"\n\n\nimageRuntimeStorageCollection : %@\n\n\n", imageRuntimeStorageCollection);
    
    NSData *imageData = [imageRuntimeStorageCollection valueForKey:imageUrl];
    if(imageData) {
        return (NSData*)imageData;
    } else {
        if(!delegateCollection) {
            delegateCollection = [[NSMutableDictionary alloc] init];
        }
        [delegateCollection setObject:delegate forKey:imageUrl];
        return nil;
    }
    
}
- (void) runLooping {
    BOOL looping = YES;
    while (looping) {
        if([delegateCollection count] > 0) {
            NSMutableArray *discardedItems = [[NSMutableArray alloc] init];
            for(NSString* imageUrl in delegateCollection) {
                
                id<IImageRuntimeStorageListener> delegate = [delegateCollection objectForKey:imageUrl];
                if(![discardedItems containsObject:imageUrl]) {
                    [discardedItems addObject:imageUrl];
                }
                NSURL* url = [[NSURL alloc] initWithString:imageUrl];
                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:TIME_OUT];
                NSOperationQueue *queue = [[NSOperationQueue alloc] init];
                
                [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
                 {
                     if ([data length] > 0 && error == nil) {
                         [imageRuntimeStorageCollection setObject:data forKey:imageUrl];
                         [delegate imageFetched:data];
                         
                     }
                         
                     
//                     else if ([data length] == 0 && error == nil)
//                         [delegate imageFetched:data];
//                     else if (error != nil)
//                         [delegate imageFetched:data];
                 }];
            }
            for (int i=0;i<[discardedItems count];i++) {
                NSString* key = [discardedItems objectAtIndex:i];
                [delegateCollection removeObjectForKey:key];
            }
        } else {
            [NSThread sleepForTimeInterval:1.0];
        }
    }
}

@end
