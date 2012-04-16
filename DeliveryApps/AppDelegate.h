//
//  AppDelegate.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppFactory;
@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    AppFactory *appFactory;
}

@property (strong, nonatomic) UIWindow *window;
- (AppFactory*) getAppFactory;
@end
