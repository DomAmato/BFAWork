//
//  main.m
//  Week3Assignments
//
//  Created by Dominic Amato on 2/9/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"
#import "Tumbler.h"

int main (int argc, const char * argv[])
{

    @autoreleasepool {
        
        Dice *dice = [[Dice alloc] init];
        NSLog(@"%@", dice.roll);
        Tumbler *tumbler1 = [[Tumbler alloc] init];
        Tumbler *tumbler2 = [[Tumbler alloc] init];
        for (int i=0; i<6; i++) {
            [tumbler1 addDice];
        }
        [tumbler2 addDice:[[NSNumber alloc] initWithInt:36]];
        float t1Avg=0;
        float t2Avg=0;
        for (int i =0; i<10000; i++) {
            t1Avg+=[[tumbler1 rollDie ]intValue];
            t2Avg+=[[tumbler2 rollDie ]intValue];
        }
        t1Avg=t1Avg/10000.0;
        t2Avg=t2Avg/10000.0;
        NSLog(@"6 six sided die: %@", [tumbler1 rollDie]);
        NSLog(@"thirty-six sided die: %@", [tumbler2 rollDie]);
        NSLog(@"6 six sided die average= %f", t1Avg);
        NSLog(@"thirty-six sided die average= %f", t2Avg);

    }
    return 0;
}

