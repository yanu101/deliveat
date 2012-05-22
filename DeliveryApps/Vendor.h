//
//  Vendor.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vendor : NSObject
@property int ID;
@property (strong, nonatomic) NSArray* logoImages;
@property (strong, nonatomic) NSString* dashboardImages;

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSDate* createdAt;
@property (strong, nonatomic) NSDate* updatedAt;
@property (strong, nonatomic) NSString* fullAvatarUrl;
@property (strong, nonatomic) NSString* mediumAvatarUrl;
@property (strong, nonatomic) NSString* thumbAvatarUrl;

@property (strong, nonatomic) NSString* dbFullAvatarUrl;
@property (strong, nonatomic) NSString* dbMediumAvatarUrl;
@property (strong, nonatomic) NSString* dbThumbAvatarUrl;




@end
