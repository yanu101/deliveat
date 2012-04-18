//
//  VendorItemListCell.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VendorItemListCell.h"

#import "AppFactory.h"
#import "AppDelegate.h"
#import "ImageRuntimeStorage.h"
#import "VendorMenuItem.h"
@implementation VendorItemListCell
@synthesize image, name, desc, vendorMenuItem;
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
    
    
    NSData* dataImg = [imgRuntimeStg getImageWithImageURL:vendorMenuItem.thumbUrl andImageType:0 andDelegate:self];
    if(dataImg) {
        UIImage* img = [UIImage imageWithData:dataImg];
        image.image = img;
    }
}
- (void)imageFetched:(NSData *)imageData {
    UIImage* img = [UIImage imageWithData:imageData];
    image.image = img;
    
}
@end
