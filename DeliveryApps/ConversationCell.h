//
//  ConversationCell.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationCell : UITableViewCell

@property (nonatomic, retain) UITextView* messageContentView;
@property (nonatomic, retain) UIImageView* bgImageView;
@property (nonatomic, retain) UILabel* timeLabel;


@end
