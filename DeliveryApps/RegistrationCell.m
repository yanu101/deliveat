//
//  RegistrationCell.m
//  TestJabberClient
//
//  Created by Yanuar Rahman on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegistrationCell.h"

@implementation RegistrationCell
@synthesize usernameField, passwordField, datePicker, registrationViewController, licenseCodeField, birthDateField, currentDate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        NSLog(@"masuk sini gak sih ");
        
    }
    return self;
}
- (void)buildUI {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)showDatePicker:(id)sender {
    datePicker.hidden = NO;
    datePicker.date = [NSDate date];
    registrationViewController.leftButton.title = @"Cancel";
    registrationViewController.rightButton.title = @"Done";
    registrationViewController.navigationItem.rightBarButtonItem = registrationViewController.rightButton;
    
}
- (void)hideDatePickerWithType:(int)type {
    
    datePicker.hidden = YES;
    
    registrationViewController.leftButton.title = @"Back";
    registrationViewController.rightButton.title = @"Submit";
    registrationViewController.navigationItem.rightBarButtonItem = registrationViewController.rightButton;
    if(type == 1) {
        self.currentDate = datePicker.date;
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[self currentDate]];
        NSInteger day = [components day];
        NSInteger month = [components month];
        NSInteger year = [components year];
        self.birthDateField.text = [NSString stringWithFormat:@"%d / %d / %d", day , month, year];

    }
}
@end
