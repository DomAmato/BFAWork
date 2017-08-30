//
//  ClockViewController.h
//  Clock
//
//  Created by Dominic Amato on 3/2/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *secondImgArray;
@property (strong, nonatomic) NSMutableArray *minuteImgArray;
@property (strong, nonatomic) NSMutableArray *hourImgArray;
@property (strong, nonatomic) NSMutableArray *dayImgArray;
@property (strong, nonatomic) NSMutableArray *monthImgArray;
@property (strong, nonatomic) NSMutableArray *yearImgArray;
@property (strong, nonatomic) NSCalendar *gregorianCalendar;
@property (strong, nonatomic) NSDateComponents *dateComponents;
@property (strong, nonatomic) UIImageView *clockFace;
@property (strong, nonatomic) UIImageView *minuteHand;
@property (strong, nonatomic) UIImageView *hourHand;
@property (strong, nonatomic) UIImageView *secondHand;

-(NSMutableArray *)updateClock:(unsigned short)time;
-(void)updateYear:(NSArray *)year;
-(void)updateMonth:(NSArray *)month;
-(void)updateDay:(NSArray *)day;
-(void)updateHour:(NSArray *)hour;
-(void)updateMinute:(NSArray *)minute;
-(void)updateSecond:(NSArray *)second;
- (IBAction)UpdateClock:(id)sender;
-(void) updateAll:(BOOL) b;
-(void) updateAnalogSecond;
-(void) updateAnalogMinute;
-(void) updateAnalogHour;
- (void)reset;

@end
