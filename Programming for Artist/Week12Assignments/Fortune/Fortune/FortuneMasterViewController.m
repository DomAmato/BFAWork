//
//  FortuneMasterViewController.m
//  Fortune
//
//  Created by Dominic Amato on 5/19/13.
//  Copyright (c) 2013 Dominic Amato. All rights reserved.
//
/*
In the MainStoryboard.storyboard, duplicate or create two new table view controllers. Insert them into the segue chain and connect them with 'push' segues.

Create new files of type UIViewController for the two new table view controllers. You may wish to copy the existing table view methods from the template (from Master Detail Application) or implement them from scratch.

The three table view controllers will present options for the user to select. Each should have just two options, listed as cells in the table view.

When a user selects a cell, it should push the next tableview controller onto the screen. When the final option is selected, a custom label should display the user's fortune.

You will need to pass an object that holds the users choices. Create a custom NSObject to fulfill this role. Pass it in the performSegue:sender method to the [segue destinationViewController].

Helpful Items:
Storyboard:
segue
push
identifier
UITableViewDataSource
tableView:numberOfRowsInSection:
tableView:cellForRowAtIndexPath:
UITableViewDelegate
tableView:didDeselectRowAtIndexPath:
NSIndexPath
row
UIViewController
prepareForSegue:sender
performSegueWithIdentifier:sender:

Extra ++:
1. Customize the table view cells. Change the font, color, size, separator, or other elements.
*/

#import "FortuneMasterViewController.h"
#import "FortuneTwoViewController.h"

@interface FortuneMasterViewController ()
<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSArray *choices;
@property (nonatomic,weak) IBOutlet UITableView *tableView;

@end

@implementation FortuneMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[self navigationItem] setTitle:@"Fortune"];
    self.choices = [NSArray arrayWithObjects: @"True",
                          @"False",
                          nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.choices count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                            forIndexPath:indexPath];
    NSString *cellTitle = [self.choices objectAtIndex:[indexPath row]];
    [cell.textLabel setText:cellTitle];
    cell.textLabel.highlightedTextColor = [UIColor greenColor];
    cell.textLabel.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    if ([cellText isEqualToString:@"True"]) {
        [self performSegueWithIdentifier:@"fortuneOne" sender:selectedCell];
    }
    if ([cellText isEqualToString:@"False"]) {
        [self performSegueWithIdentifier:@"fortuneOne" sender:selectedCell];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
    NSString *newFortune = [self.choices objectAtIndex:[selectedRowIndexPath row]];
    if ([newFortune isEqualToString:@"True"]) {
        NSNumber *num = [[NSNumber alloc] initWithInt:1];
        [[segue destinationViewController] setFortuneLevel:num];
    }
    if ([newFortune isEqualToString:@"False"]) {
        NSNumber *num = [[NSNumber alloc] initWithInt:0];
        [[segue destinationViewController] setFortuneLevel:num];
    }
}
@end
