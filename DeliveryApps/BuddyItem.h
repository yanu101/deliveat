//
//  BuddyItem.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "Protocols.h"
#import "Vendor.h"
@interface BuddyItem : UIView<IComponent, IImageRuntimeStorageListener> {
    id cookie;
    UIImageView *myImageView;
}
@property (strong, nonatomic) id<IFieldChangeListener> delegate;
@property (strong, nonatomic) IBOutlet UIButton* avatarImageButton;
@property (strong, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) Vendor* vendor;
@property (strong, nonatomic) UITableView* tableView;


- (void) commit;
@end
