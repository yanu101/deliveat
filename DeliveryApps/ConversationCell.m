//
//  ConversationCell.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConversationCell.h"

@implementation ConversationCell

@synthesize messageContentView, timeLabel, bgImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 20)];
        timeLabel.textAlignment = UITextAlignmentCenter;
        timeLabel.font = [UIFont systemFontOfSize:11.0];
        timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:timeLabel];
        
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:bgImageView];
        
        messageContentView = [[UITextView alloc] init];
        messageContentView.backgroundColor = [UIColor clearColor];
        messageContentView.editable = NO;
        messageContentView.scrollEnabled = NO;
//        [messageContentView sizeToFit];
        [self.contentView addSubview:messageContentView];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
