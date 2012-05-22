//
//  OrderCell.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderCell.h"
#import "AppFactory.h"
#import "AppDelegate.h"
#import "ImageRuntimeStorage.h"

@implementation OrderCell
@synthesize image, desc, buttonSelectNumOfOrder, title, picker, labelNumOf, urlImage;

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
    
    
    NSData* dataImg = [imgRuntimeStg getImageWithImageURL:urlImage andImageType:0 andDelegate:self];
    if(dataImg) {
        UIImage* img = [UIImage imageWithData:dataImg];
        [image setImage:img];
        
    }
}
- (void)imageFetched:(NSData *)imageData {
    UIImage* img = [UIImage imageWithData:imageData];
    [image setImage:img];
    
}
@end
