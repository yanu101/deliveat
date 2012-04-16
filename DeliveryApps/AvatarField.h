//
//  AvatarField.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
@interface AvatarField : UIView <IComponent> {
    UIButton *avatarButton;
}

@property (strong, nonatomic) id changeListener;
@property (strong, nonatomic) UIImage* avatarImage;
@property (strong, nonatomic) UILabel* avatarLabel;

@end
