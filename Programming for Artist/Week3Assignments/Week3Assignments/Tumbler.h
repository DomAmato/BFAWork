//
//  Tumbler.h
//  Week3Assignments
//
//  Created by Dominic Amato on 2/9/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dice.h"

@interface Tumbler : NSObject

@property (strong) NSMutableArray *dice;
@property (strong) NSNumber *values;
@property (strong) NSNumber *maxVal;
@property (strong) NSNumber *minVal;

-(NSNumber *)rollDie;
-(void)addDice;
-(void)addDice:(NSNumber *)sides;

@end
