//
//  BuddyItem.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BuddyItem.h"
#import "Resource.h"
#import "ImageRuntimeStorage.h"
#import "AppFactory.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#define LABEL_HEIGHT (HEIGHT_CELL_ITEM - HEIGHT_AVATAR_IMAGE_ITEM)
@implementation BuddyItem

@synthesize avatarImageButton, labelName, delegate, vendor, tableView;

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        avatarImageButton = [[UIButton alloc] init];
        [avatarImageButton setBackgroundImage:[UIImage imageNamed:@"defaultIcon.png"] forState:UIControlStateNormal];
        avatarImageButton.backgroundColor = [UIColor whiteColor];
        [avatarImageButton addTarget:self action:@selector(avatarImageButtonAction) forControlEvents:UIControlEventTouchUpInside];
//        avatarImageButton.backgroundColor = [UIColor clearColor];
        labelName = [[UILabel alloc] init];
        labelName.font = [UIFont systemFontOfSize:14];
        labelName.backgroundColor = [UIColor blackColor];
        labelName.textColor = [UIColor whiteColor];
        labelName.textAlignment = UITextAlignmentCenter;
//        myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        [self addSubview:myImageView];
        [self addSubview:avatarImageButton];
//        [avatarImageButton layer].cornerRadius = 7;
//        avatarImageButton.clipsToBounds = YES;
        [self addSubview:labelName];
        
        
        
    }
    return self;
}

//-(void) drawRect:(CGRect)rect {
//    UIGraphicsBeginImageContext(self.frame.size);
//    
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(currentContext, 1.0); //or whatever width you want
//    CGContextSetRGBStrokeColor(currentContext, 0.6, 0.6, .6, 1.0);
//    
//    CGRect myRect = CGContextGetClipBoundingBox(currentContext);  
//    //printf("rect = %f,%f,%f,%f\n", myRect.origin.x, myRect.origin.y, myRect.size.width, myRect.size.height);
//    
//    float myShadowColorValues[] = {0,0,0,1};
//    CGColorSpaceRef myColorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef colorRef = CGColorCreate(myColorSpace, myShadowColorValues);
//    CGContextSetShadowWithColor(currentContext, CGSizeMake(0, -1), 3, colorRef);
//    // CGContextSetShadow(currentContext, CGSizeMake(0, -1), 3);
//    
//    CGContextStrokeRect(currentContext, myRect);
//    UIImage *backgroundImage = (UIImage *)UIGraphicsGetImageFromCurrentImageContext();
//    
//    [myImageView setImage:backgroundImage];
//    
//    
//    UIGraphicsEndImageContext();
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)layoutSubviews {
    CGRect contentRect = self.bounds;
    CGRect frame;
    int x = 0;
    int y = 0;
    frame = CGRectMake(x, y, contentRect.size.width, HEIGHT_AVATAR_IMAGE_ITEM);
    avatarImageButton.frame = frame;
    y +=HEIGHT_AVATAR_IMAGE_ITEM;
    frame = CGRectMake(x, y, contentRect.size.width, LABEL_HEIGHT);
    labelName.frame = frame;
}
- (void)setCookie:(id)cookie_ {
    cookie = cookie_;
}
- (id)getCookie {
    return cookie;
}
- (void) avatarImageButtonAction {
    [self.delegate fieldChanged:self];
}
- (void) commit {
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    
    ImageRuntimeStorage *imgRuntimeStg = [appFactory getImageRuntimeStorage];
    
    
    NSData* dataImg = [imgRuntimeStg getImageWithImageURL:self.vendor.dbThumbAvatarUrl andImageType:0 andDelegate:self];
    if(dataImg) {
        UIImage* img = [UIImage imageWithData:dataImg];
        [avatarImageButton setBackgroundImage:img forState:UIControlStateNormal];
    }
}
- (void)imageFetched:(NSData *)imageData {
    UIImage* img = [UIImage imageWithData:imageData];
    [avatarImageButton setBackgroundImage:img forState:UIControlStateNormal];
    if(self.tableView) {
        [self.tableView reloadData];
    }
    
}
@end
