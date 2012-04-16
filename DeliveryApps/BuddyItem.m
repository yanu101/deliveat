//
//  BuddyItem.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BuddyItem.h"
#import "Resource.h"
#define LABEL_HEIGHT 21
@implementation BuddyItem

@synthesize avatarImageButton, labelName, delegate;

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        avatarImageButton = [[UIButton alloc] init];
        [avatarImageButton setBackgroundImage:[UIImage imageNamed:@"defaultIcon.png"] forState:UIControlStateNormal];
        [avatarImageButton addTarget:self action:@selector(avatarImageButtonAction) forControlEvents:UIControlEventTouchUpInside];
        labelName = [[UILabel alloc] init];
        labelName.font = [UIFont systemFontOfSize:14];
        [self addSubview:avatarImageButton];
        [self addSubview:labelName];
        
    }
    return self;
}

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
    y +=HEIGHT_AVATAR_IMAGE_ITEM + BUDDY_ITEM_COLUMN_PADDING;
    frame = CGRectMake(x, y, contentRect.size.width, LABEL_HEIGHT);
    labelName.frame = frame;
}
- (void)setCookie:(id)cookie_ {
    cookie = cookie_;
}
- (id)getCookie {
    return nil;
}
- (void) avatarImageButtonAction {
    [self.delegate fieldChanged:self];
}
@end
