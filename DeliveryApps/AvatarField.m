//
//  AvatarField.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AvatarField.h"

@implementation AvatarField
#define AVATAR_FIELD_WIDTH 150
#define AVATAR_FIELD_HEIGHT 150
@synthesize avatarImage, avatarLabel, changeListener;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        avatarButton = [[UIButton alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
        
        // Initialization code
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

@end
