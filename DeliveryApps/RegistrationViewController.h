//
//  RegistrationViewController.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightButton;
//@property (strong, nonatomic) UIDatePicker* currentShowDatePicker;
//
//@property (strong, nonatomic) IBOutlet UITextField* usernameField;
//@property (strong, nonatomic) IBOutlet UITextField* passwordField;


- (IBAction)leftButtonAction:(id)sender;
- (IBAction)rightButtonAction:(id)sender;
@end
