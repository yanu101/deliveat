//
//  Utility.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject
+ (void)scrollScreenBeginEditingInView:(UIView*)view inTextField:(UITextField*)textField show:(BOOL)isShow;
+ (CGFloat)scrollScreenBeginEditingInView:(UIView*)view inTextField:(UITextField*)textField withTableView:(UITableView*)table show:(BOOL)isShow;
+ (void)markScreenInView:(UIView*)view show:(BOOL)isShow;
@end
