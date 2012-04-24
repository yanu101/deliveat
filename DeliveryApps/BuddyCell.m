//
//  BuddyCell.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BuddyCell.h"
#import "Resource.h"
#import "BuddyItem.h"
#import "Vendor.h"
#import <QuartzCore/QuartzCore.h>
@implementation BuddyCell


@synthesize dataCollection, delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        // Initialization code
    }
    return self;
}
- (void)buildUI {
    if(!dataCollection) {
        return;
    }
    for (UIView *subview in [self contentView].subviews) {
        [subview removeFromSuperview];
    }
    int i = 0;
    int currentRow = 0;
    int n = [dataCollection count];
    
    int xItem = BUDDY_ITEM_MARGIN, yItem = BUDDY_ITEM_MARGIN;
    while(i < n) {
        yItem = (BUDDY_ITEM_MARGIN)*(currentRow+1) +  currentRow*(HEIGHT_CELL_ITEM);
        for(int j=0;j<2;j++) {
            xItem = (BUDDY_ITEM_MARGIN)*(j+1) +  j*(WIDTH_CELL_ITEM);
            if(i >= n) break;
            Vendor* vendor = (Vendor*)[dataCollection objectAtIndex:i];
            BuddyItem *view = [[BuddyItem alloc] initWithFrame:CGRectMake(xItem, yItem, WIDTH_CELL_ITEM, HEIGHT_CELL_ITEM)];
            view.delegate = delegate;
            view.vendor = vendor;
            [view setCookie:vendor];
            view.labelName.text = vendor.name;
            
            [view layer].cornerRadius = 10;
            view.clipsToBounds = YES;
            [view layer].borderColor = [[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1] CGColor];
            [view layer].borderWidth = 3;

            [view commit];
            [[self contentView] addSubview:view];
            i++;
            
        }
        currentRow +=1;
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
