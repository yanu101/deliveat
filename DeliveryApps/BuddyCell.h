//
//  BuddyCell.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuddyCell : UITableViewCell

@property (strong, nonatomic) NSMutableArray* dataCollection;
@property (strong, nonatomic) id delegate;
- (void)buildUI;
@end
