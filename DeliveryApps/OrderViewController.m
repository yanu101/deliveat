//
//  OrderViewController.m
//  DeliveryApps
//
//  Created by Yanuar Rahman on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"
#import "VendorMenuItem.h"
#import "iToast.h"
#import "AppDelegate.h"
#import "AppFactory.h"
#import "MenuOrder.h"
#import "MenuOrderItem.h"


@interface OrderViewController ()

@end

@implementation OrderViewController
@synthesize vendorMenuItem;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.rightBarButtonItem = orderButton;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    myNumOfOrder = @"1";
    orderButton = [[UIBarButtonItem alloc] initWithTitle:@"Order" style:UIBarButtonItemStylePlain target:self action:@selector(orderButtonAction)];
    selectNumofOrderButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(numOfOrderButtonAction)];
    numOfOrder = [[NSMutableArray alloc] initWithCapacity:20];
    
    for(int i=0;i<20;i++) {
        [numOfOrder addObject:[NSString stringWithFormat:@"%d", (i+1)]];
    }
//    self.navigationController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"leather-background.png"]]; 
//    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
#pragma mark - Right Bar Button Action 
- (void) orderButtonAction {
    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    AppFactory* appFactory = [appDelegate getAppFactory];
    MenuOrderItem *item = [[MenuOrderItem alloc] init];
    item.numOfOrder = [myNumOfOrder intValue];
    item.item = self.vendorMenuItem;
    NSLog(@"number of order : %d", item.numOfOrder);
    NSLog(@"Desc : %@", item.item.desc);
    NSLog(@"Price : %f", item.item.price);
    
    
    
    [appFactory.menuOrder.menuOrderItems addObject:item];
    
    [[[iToast makeText:NSLocalizedString(@"Your order has been successfully added to chart.", @"")] 
      setGravity:iToastGravityCenter] show];
}
- (void) numOfOrderButtonAction {
    self.navigationItem.rightBarButtonItem = orderButton;
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    OrderCell* cell = [self.tableView cellForRowAtIndexPath:index];
    cell.picker.hidden = YES;
    cell.labelNumOf.hidden = NO;
    cell.buttonSelectNumOfOrder.hidden = NO;
    cell.desc.hidden = NO;
    cell.buttonSelectNumOfOrder.titleLabel.text = @"1";
    self.navigationItem.hidesBackButton = NO;
    cell.buttonSelectNumOfOrder.titleLabel.text = myNumOfOrder;
    
    
}
#pragma mark - Select Num of Order Button Action 

- (IBAction)selectNumOfOrderButtonAction:(id)sender {
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    OrderCell* cell = [self.tableView cellForRowAtIndexPath:index];
    
    cell.picker.hidden = NO;
    cell.labelNumOf.hidden = YES;
    cell.buttonSelectNumOfOrder.hidden = YES;
    cell.desc.hidden = YES;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = selectNumofOrderButton;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize  textSize = { 220.0, 10000.0 };
    
	CGSize size = [vendorMenuItem.desc sizeWithFont:[UIFont boldSystemFontOfSize:17]
                                  constrainedToSize:textSize 
                                      lineBreakMode:UILineBreakModeClip];
    
    return 8 + 21 + 8 + 128 + 19 + 21 + 8 + size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.title.text = vendorMenuItem.name;
    cell.urlImage = vendorMenuItem.thumbUrl;
    [cell commit];
    CGSize  textSize = { 220.0, 10000.0 };
    
	CGSize size = [vendorMenuItem.desc sizeWithFont:[UIFont boldSystemFontOfSize:17]
                       constrainedToSize:textSize 
                           lineBreakMode:UILineBreakModeClip];
    CGRect newRect = cell.desc.frame;
    newRect.size.height = size.height;
    
    cell.desc.frame = newRect;
    cell.desc.numberOfLines = 0;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
//	size = [myNumOfOrder sizeWithFont:[UIFont boldSystemFontOfSize:15]
//                                  constrainedToSize:textSize 
//                                      lineBreakMode:UILineBreakModeClip];
//    newRect = cell.buttonSelectNumOfOrder.titleLabel.frame;
//    cell.buttonSelectNumOfOrder.titleLabel.frame = newRect;
    cell.buttonSelectNumOfOrder.titleLabel.textAlignment = UITextAlignmentCenter;
    cell.buttonSelectNumOfOrder.titleLabel.text = myNumOfOrder;
    
    NSLog(@"Desc %@", vendorMenuItem.desc);
    cell.desc.text = vendorMenuItem.desc;
    // Configure the cell...
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


#pragma mark - Picker view data source
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    myNumOfOrder = [NSString stringWithFormat:@"%d", row+1];
    
    
//    NSLog(@"select");
    //    pickerView.hidden = YES;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return [numOfOrder objectAtIndex:row];
//}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    //I have taken two components thats why I have set frame of my "label" accordingly. you can set the frame of the label depends on number of components you have... 
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 145, 45)];
    
    //For right alignment of text,You can set the UITextAlignmentRight of the label.  
    //No need to set alignment to UITextAlignmentLeft because it is defaulted to picker data display behavior.
    
    [label setTextAlignment:UITextAlignmentCenter];
    label.opaque=NO;
    label.backgroundColor=[UIColor clearColor];
    label.textColor = [UIColor blackColor];
    UIFont *font = [UIFont boldSystemFontOfSize:20];
    label.font = font;
    label.text = [numOfOrder objectAtIndex:row];
    return label;
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    
//}
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    return 100; 
//}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [numOfOrder count];
}
@end
