//
//  MenuOrder.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuOrder.h"

@implementation MenuOrder
@synthesize menuOrderItems;
- (id)init {
    self = [super init];
    if(self) {
        self.menuOrderItems = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
