//
//  FortuneThreeController.m
//  Fortune
//
//  Created by Dominic Amato on 5/1/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import "FortuneThreeController.h"
#import "FortuneDetailViewController.h"

@interface FortuneThreeController()
<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSArray *choices;
@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSNumber *fortune;

@end

@implementation FortuneThreeController

- (void)setFortuneLevel:(id)prevFortune
{
    self.fortune = prevFortune;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [[self navigationItem] setTitle:@"Third Times The Charm"];
    self.choices = [NSArray arrayWithObjects: @"YES",
                    @"NO",
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
    cell.textLabel.highlightedTextColor = [UIColor yellowColor];
    cell.textLabel.backgroundColor = [UIColor greenColor];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    if ([cellText isEqualToString:@"YES"]) {
        [self performSegueWithIdentifier:@"fortuneThree" sender:selectedCell];
    }
    if ([cellText isEqualToString:@"NO"]) {
        [self performSegueWithIdentifier:@"fortuneThree" sender:selectedCell];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
    NSString *newFortune = [self.choices objectAtIndex:[selectedRowIndexPath row]];
    if ([newFortune isEqualToString:@"YES"]) {
        if (self.fortune.intValue == 2) {
            NSNumber *num = [[NSNumber alloc] initWithInt:3];
            [[segue destinationViewController] setFortuneLevel:num];
        }
        if (self.fortune.intValue == 1) {
            NSNumber *num = [[NSNumber alloc] initWithInt:2];
            [[segue destinationViewController] setFortuneLevel:num];
        }
        if (self.fortune.intValue == 0) {
            NSNumber *num = [[NSNumber alloc] initWithInt:1];
            [[segue destinationViewController] setFortuneLevel:num];
        }
        
    }
    if ([newFortune isEqualToString:@"NO"]) {
        if (self.fortune.intValue == 2) {
            NSNumber *num = [[NSNumber alloc] initWithInt:2];
            [[segue destinationViewController] setFortuneLevel:num];
        }
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
