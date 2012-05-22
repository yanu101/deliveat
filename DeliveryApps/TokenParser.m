//
//  TokenParser.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TokenParser.h"
#import "AppDelegate.h"
#import "AppFactory.h"

@implementation TokenParser
+ (NSString *)getToken:(NSString*)payload {
    NSError *error;
    
    NSData *jsonData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    if(!jsonData) {
        return nil;
    }
    NSDictionary *token = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    appFactory.token = [token objectForKey:@"token"];
    NSLog(@"Token : %@", appFactory.token);
    return appFactory.token;
}
@end
