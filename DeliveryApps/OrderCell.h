//
//  OrderCell.h
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
@interface OrderCell : UITableViewCell <IImageRuntimeStorageListener>

- (void)commit;
@property (strong, nonatomic) IBOutlet UILabel* title;
@property (strong, nonatomic) IBOutlet UIImageView* image;
@property (strong, nonatomic) NSString* urlImage;
@property (strong, nonatomic) IBOutlet UILabel* desc;
@property (strong, nonatomic) IBOutlet UILabel* labelNumOf;

@property (strong, nonatomic) IBOutlet UIButton* buttonSelectNumOfOrder;
@property (strong, nonatomic) IBOutlet UIPickerView* picker;


@end
