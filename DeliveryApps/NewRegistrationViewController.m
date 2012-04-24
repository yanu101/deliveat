//
//  NewRegistrationViewController.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewRegistrationViewController.h"
#import "NewRegistrationCell.h"
@interface NewRegistrationViewController ()

@end

@implementation NewRegistrationViewController
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    NewRegistrationCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(indexPath.section == 0) {
        if(indexPath.row == 0){
            cell.createButton.hidden = YES;
            cell.inputField.hidden = NO;
            cell.tag = 0;
            cell.inputField.placeholder = @"Email";
//            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            
        } else if(indexPath.row == 1){
            cell.createButton.hidden = YES;
            cell.inputField.hidden = NO;
            cell.tag = 1;
            cell.inputField.placeholder = @"Password";
//            cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
            
        } else {
            cell.createButton.hidden = YES;
            cell.inputField.hidden = NO;
            cell.tag = 2;
            cell.inputField.placeholder = @"Repear Password";
        }
        
    } else {
        cell.inputField.hidden = YES;
        cell.createButton.hidden = NO;
        cell.tag = 3;
        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        return 80;
    }
    return 40;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) {
        return 3;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return @"Registration";
    }
    return @"";
}
@end
