//
//  RegistrationCell.h
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationViewController.h"
@interface RegistrationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *birthDateField;
@property (strong, nonatomic) IBOutlet UITextField *licenseCodeField;
@property (strong, nonatomic) NSDate* currentDate;

@property (strong, nonatomic) RegistrationViewController* registrationViewController;


- (void) buildUI;
- (IBAction)showDatePicker:(id)sender;
- (void)hideDatePickerWithType:(int)type;

//@property (strong, nonatomic) IBOutlet  sexField;
//@property (strong, nonatomic) IBOutlet birthDayField;
//@property (strong, nonatomic) IBOutlet licenseCodeField;
@end
