//
//  MainMenuCell.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuCell.h"
#import "Vendor.h"
#import "AppFactory.h"
#import "AppDelegate.h"
#import "ImageRuntimeStorage.h"

@implementation MainMenuCell
@synthesize icon, title, delegate, vendor, tableView;
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
- (void) commit {
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    
    ImageRuntimeStorage *imgRuntimeStg = [appFactory getImageRuntimeStorage];
    
    
    NSData* dataImg = [imgRuntimeStg getImageWithImageURL:self.vendor.thumbAvatarUrl andImageType:0 andDelegate:self];
    if(dataImg) {
        UIImage* img = [UIImage imageWithData:dataImg];
        icon.image = img;
    }
}
- (void)imageFetched:(NSData *)imageData {
    UIImage* img = [UIImage imageWithData:imageData];
    icon.image = img;
    if(self.tableView) {
        [self.tableView reloadData];
    }
}
@end
