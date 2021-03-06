//
//  VendorDashboardCellTop.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VendorDashboardCellTop.h"
#import "AppFactory.h"
#import "AppDelegate.h"
#import "Vendor.h"
#import "ImageRuntimeStorage.h"

@implementation VendorDashboardCellTop
@synthesize labelVendor, vendor, vendorLogo;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)commit {
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    
    ImageRuntimeStorage *imgRuntimeStg = [appFactory getImageRuntimeStorage];
   
    NSData* dataImg = [imgRuntimeStg getImageWithImageURL:self.vendor.thumbAvatarUrl andImageType:0 andDelegate:self];
    UIImage* img = [UIImage imageWithData:dataImg];
    self.vendorLogo.image =  img;
    
}
- (void)imageFetched:(NSData *)imageData {
    UIImage* img = [UIImage imageWithData:imageData];
    self.vendorLogo.image =  img;
//    [avatarImageButton setBackgroundImage:img forState:UIControlStateNormal];
    
}
@end
