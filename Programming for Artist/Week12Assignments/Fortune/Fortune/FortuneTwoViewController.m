//
//  FortuneTwoViewController.m
//  Fortune
//
//  Created by Dominic Amato on 5/1/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import "FortuneTwoViewController.h"
#import "FortuneThreeController.h"

@interface FortuneTwoViewController()
<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSArray *choices;
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSNumber *fortune;

@end

@implementation FortuneTwoViewController

- (void)setFortuneLevel:(id)prevFortune
{
    self.fortune = prevFortune;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    [[self navigationItem] setTitle:@"Second Chance"];
    self.choices = [NSArray arrayWithObjects: @"1",
                                              @"0",
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
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    cell.textLabel.backgroundColor = [UIColor redColor];
    cell.textLabel.textColor = [UIColor yellowColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    if ([cellText isEqualToString:@"1"]) {
        [self performSegueWithIdentifier:@"fortuneTwo" sender:selectedCell];
    }
    if ([cellText isEqualToString:@"0"]) {
        [self performSegueWithIdentifier:@"fortuneTwo" sender:selectedCell];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
    NSString *newFortune = [self.choices objectAtIndex:[selectedRowIndexPath row]];
    if ([newFortune isEqualToString:@"1"]) {
        if (self.fortune.intValue == 1) {
            NSNumber *num = [[NSNumber alloc] initWithInt:2];
            [[segue destinationViewController] setFortuneLevel:num];
        }
        if (self.fortune.intValue == 0) {
            NSNumber *num = [[NSNumber alloc] initWithInt:1];
            [[segue destinationViewController] setFortuneLevel:num];
        }
        
    }
    if ([newFortune isEqualToString:@"0"]) {
        if (self.fortune.intValue == 1) {
            NSNumber *num = [[NSNumber alloc] initWithInt:1];
            [[segue destinationViewController] setFortuneLevel:num];
        }
        if (self.fortune.intValue == 0) {
            NSNumber *num = [[NSNumber alloc] initWithInt:0];
            [[segue destinationViewController] setFortuneLevel:num];
        }
    }
}
@end
