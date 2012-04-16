//
//  HTTPResult.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPResult : NSObject
@property (nonatomic, retain) id result;
@property (nonatomic, retain) NSData* data;
@property (nonatomic, retain) NSError* error;
@property int responseCode;
@end
