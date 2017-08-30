//
//  ClockViewController.m
//  Clock
//
//  Created by Dominic Amato on 3/2/13.
//  Copyright (c) 2013 University of Wisconsin Milwaukee. All rights reserved.
//

/*
 Goal: 
 Create an animated clock.
 
 Create and schedule an NSTimer to call an -updateClock method. The method should pull the current time either using NSCalendar (for a Gregorian calendar), or CACurrentMediaTime() (for sub-second timing). See the code snippets below for both approaches.
 
 The presentation of time should be a creative exercise. Is your clock a photorealistic analog clock? a digital representation? abstract? The method of deciphering the time does not need to be immediately clear.
 
 You must include animated views in your clock.
 
 While a UILabel with the current time can be part of your clock, it should not be the entire clock. It could be part of a more significant animation.
 
 Remember: there are other ways to represent a number besides displaying text.
 
 Helpful Items:
 UIView
 -transform
 -bounds
 -center
 -frame
 -alpha
 +animateWithDuration:animations:
 +animateWithDuration:delay:options:animations:completion:
 UIImageView
 -animationImages
 -startAnimating
 -stopAnimating;
 -isAnimating;
 NSTimer
 +scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:
 -fire
 -invalidate
 CGAffineTransform
 CGAffineTransformIdentity
 CGAffineTransformMakeTranslation()
 CGAffineTransformMakeRotation()
 CGAffineTransformMakeScale()
 CGAffineTransformTranslate()
 CGAffineTransformRotate()
 CGAffineTransformScale()
 */


#import "ClockViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ClockViewController
@synthesize secondImgArray = _secondImgArray;
@synthesize minuteImgArray = _minuteImgArray;
@synthesize hourImgArray = _hourImgArray;
@synthesize dayImgArray = _dayImgArray;
@synthesize monthImgArray = _monthImgArray;
@synthesize yearImgArray = _yearImgArray;
@synthesize gregorianCalendar = _gregorianCalendar;
@synthesize dateComponents = _dateComponents;
@synthesize clockFace = _clockFace;
@synthesize hourHand = _hourHand;
@synthesize minuteHand = _minuteHand;
@synthesize secondHand = _secondHand;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _secondImgArray = [[NSMutableArray alloc] init];
    _minuteImgArray = [[NSMutableArray alloc] init];
    _hourImgArray = [[NSMutableArray alloc] init];
    _dayImgArray = [[NSMutableArray alloc] init];
    _monthImgArray = [[NSMutableArray alloc] init];
    _yearImgArray = [[NSMutableArray alloc] init];
    _clockFace = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ClockFace.png"]];
    _minuteHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MinuteHand.png"]];
    _hourHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HourHand.png"]];
    _secondHand = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SecondHand.png"]];
    [_clockFace setFrame:CGRectMake(110, 300, 150, 150)];
    [_clockFace setContentMode:UIViewContentModeScaleAspectFit];
    [_hourHand.layer setAnchorPoint:CGPointMake(0.5, .92)];
    [_hourHand setFrame:CGRectMake(_clockFace.center.x-12.5, _clockFace.frame.origin.y+10, 25, 70)];
    [_hourHand setContentMode:UIViewContentModeScaleAspectFit];
    [_minuteHand .layer setAnchorPoint:CGPointMake(0.5, .92)];
    [_minuteHand setFrame:CGRectMake(_clockFace.center.x-12.5, _clockFace.frame.origin.y, 25, 80)];
    [_minuteHand setContentMode:UIViewContentModeScaleAspectFit];
    [_secondHand .layer setAnchorPoint:CGPointMake(0.5, .92)];
    [_secondHand setFrame:CGRectMake(_clockFace.center.x-12.5, _clockFace.frame.origin.y+5, 25, 75)];
    [_secondHand setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:_clockFace];
    [self.view addSubview:_hourHand];
    [self.view addSubview:_minuteHand];
    [self.view addSubview:_secondHand];

    [NSTimer scheduledTimerWithTimeInterval:0.5
                                     target:self
                                   selector:@selector(updateAll:)
                                   userInfo:nil
                                    repeats:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.view setBackgroundColor:[UIColor blackColor]];
    _gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    _dateComponents = [_gregorianCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
    for (int i=0; i<6; i++) {
        UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50*i, 45, 45)];
        [temp setImage:[UIImage imageNamed:@"RedLEDOff.png"]];
        [temp setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:temp];
        [_secondImgArray addObject:temp];
    }
    for (int i=0; i<6; i++) {
        UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(55, 50*i, 45, 45)];
        [temp setImage:[UIImage imageNamed:@"OrangeLEDOff.png"]];
        [temp setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:temp];
        [_minuteImgArray addObject:temp];
    }
    for (int i=0; i<5; i++) {
        UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(110, 50*i, 45, 45)];
        [temp setImage:[UIImage imageNamed:@"YellowLEDOff.png"]];
        [temp setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:temp];
        [_hourImgArray addObject:temp];
    }
    for (int i=0; i<5; i++) {
        UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(165, 50*i, 45, 45)];
        [temp setImage:[UIImage imageNamed:@"GreenLEDOff.png"]];
        [temp setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:temp];
        [_dayImgArray addObject:temp];
    }
    for (int i=0; i<4; i++) {
        UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(220, 50*i, 45, 45)];
        [temp setImage:[UIImage imageNamed:@"BlueLEDOff.png"]];
        [temp setContentMode:UIViewContentModeScaleAspectFit];
        [self.view addSubview:temp];
        [_monthImgArray addObject:temp];
    }
    for (int i=0; i<11; i++) {
        UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(275, 43*i, 40, 40)];
        [temp setImage:[UIImage imageNamed:@"PurpleLEDOff.png"]];
        [temp setContentMode:UIViewContentModeScaleAspectFit];
        [_yearImgArray addObject:temp];
        [self.view addSubview:temp];
    }
    unsigned short year = [_dateComponents year];
    unsigned short month = [_dateComponents month];
    unsigned short day = [_dateComponents day];
    unsigned short hour = [_dateComponents hour];
    unsigned short minute = [_dateComponents minute];
    unsigned short second = [_dateComponents second];
    NSArray *clockArray = [[NSArray alloc] initWithArray: [self updateClock:year]];
    [self updateYear:clockArray];
    clockArray = [[NSArray alloc] initWithArray: [self updateClock:month]];
    [self updateMonth:clockArray];
    clockArray = [[NSArray alloc] initWithArray: [self updateClock:day]];
    [self updateDay:clockArray];
    clockArray = [[NSArray alloc] initWithArray: [self updateClock:hour]];
    [self updateHour:clockArray];
    clockArray = [[NSArray alloc] initWithArray: [self updateClock:minute]];
    [self updateMinute:clockArray];
    clockArray = [[NSArray alloc] initWithArray: [self updateClock:second]];
    [self updateSecond:clockArray];
    CGAffineTransform transform = _minuteHand.transform;
    transform = CGAffineTransformRotate(transform, ((minute+(second*1/60.0))*M_PI / 30.0));
    
    //begin the rotation from the current state:
    [UIView animateWithDuration:0.0
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [_minuteHand setTransform:transform];
                     }
                     completion:nil];
    CGAffineTransform transform2 = _hourHand.transform;
    transform2 = CGAffineTransformRotate(transform2, ((hour+(minute*1/60.0))*M_PI / 6.0));
    
    //begin the rotation from the current state:
    [UIView animateWithDuration:0.0
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [_hourHand setTransform:transform2];
                     }
                     completion:nil];
    transform = _secondHand.transform;
    transform = CGAffineTransformRotate(transform, (second*M_PI / 30.0));
    
    //begin the rotation from the current state:
    [UIView animateWithDuration:0.0
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [_secondHand setTransform:transform];
                     }
                     completion:nil];
    [self updateAnalogSecond];
    [self updateAnalogMinute];
    [self updateAnalogHour];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [_yearImgArray removeAllObjects];
    [_monthImgArray removeAllObjects];
    [_dayImgArray removeAllObjects];
    [_hourImgArray removeAllObjects];
    [_minuteImgArray removeAllObjects];
    [_secondImgArray removeAllObjects];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(NSMutableArray *)updateClock:(unsigned short)time
{
    NSMutableArray *binaryClock = [[NSMutableArray alloc] init];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    unsigned int binary;
    binary = 1<<(sizeof(time) * 8 - 1);
    while (binary > 0) 
    {
        if (time & binary)
            [temp addObject:[NSNumber numberWithInt:1]];
        else
            [temp addObject:[NSNumber numberWithInt:0]];
        binary >>= 1;
    }
    for(int i=0;i<16;i++){
        [binaryClock addObject:[temp objectAtIndex:15-i]];
    }
    return binaryClock;
}
-(void)updateYear:(NSArray *)year
{
    for(int i=0;i<[_yearImgArray count];i++){
        if ([[year objectAtIndex:i] compare:[NSNumber numberWithInt:1]]==NSOrderedSame){
            [[_yearImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"PurpleLEDOn.png"]];
        } else if ([[year objectAtIndex:i] compare:[NSNumber numberWithInt:0]]==NSOrderedSame){
            [[_yearImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"PurpleLEDOff.png"]];
        }
    }
}
-(void)updateMonth:(NSArray *)month
{
    for(int i=0;i<[_monthImgArray count];i++){
        if ([[month objectAtIndex:i] compare:[NSNumber numberWithInt:1]]==NSOrderedSame){
            [[_monthImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"BlueLEDOn.png"]];
        } else if ([[month objectAtIndex:i] compare:[NSNumber numberWithInt:0]]==NSOrderedSame){
            [[_monthImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"BlueLEDOff.png"]];
        }
    }
}
-(void)updateDay:(NSArray *)day
{
    for(int i=0;i<[_dayImgArray count];i++){
        if ([[day objectAtIndex:i] compare:[NSNumber numberWithInt:1]]==NSOrderedSame){
            [[_dayImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"GreenLEDOn.png"]];
        } else if ([[day objectAtIndex:i] compare:[NSNumber numberWithInt:0]]==NSOrderedSame){
            [[_dayImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"GreenLEDOff.png"]];
        }
    }
}
-(void)updateHour:(NSArray *)hour
{
    for(int i=0;i<[_hourImgArray count];i++){
        if ([[hour objectAtIndex:i] compare:[NSNumber numberWithInt:1]]==NSOrderedSame){
            [[_hourImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"YellowLEDOn.png"]];
        } else if ([[hour objectAtIndex:i] compare:[NSNumber numberWithInt:0]]==NSOrderedSame){
            [[_hourImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"YellowLEDOff.png"]];
        }
    }
}
-(void)updateMinute:(NSArray *)minute
{
    for(int i=0;i<[_minuteImgArray count];i++){
        if ([[minute objectAtIndex:i] compare:[NSNumber numberWithInt:1]]==NSOrderedSame){
            [[_minuteImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"OrangeLEDOn.png"]];
        } else if ([[minute objectAtIndex:i] compare:[NSNumber numberWithInt:0]]==NSOrderedSame){
            [[_minuteImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"OrangeLEDOff.png"]];
        }
    }
}
-(void)updateSecond:(NSArray *)second
{
    for(int i=0;i<[_secondImgArray count];i++){
        if ([[second objectAtIndex:i] compare:[NSNumber numberWithInt:1]]==NSOrderedSame){
            [[_secondImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"RedLEDOn.png"]];
        } else if ([[second objectAtIndex:i] compare:[NSNumber numberWithInt:0]]==NSOrderedSame){
            [[_secondImgArray objectAtIndex:i] setImage:[UIImage imageNamed:@"RedLEDOff.png"]];
        }
    }
}

-(void) updateAll:(BOOL) b{
    _dateComponents = [_gregorianCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:[NSDate date]];
    unsigned short year = [_dateComponents year];
    unsigned short month = [_dateComponents month];
    unsigned short day = [_dateComponents day];
    unsigned short hour = [_dateComponents hour];
    unsigned short minute = [_dateComponents minute];
    unsigned short second = [_dateComponents second];
    NSArray *clockArray = [[NSArray alloc] initWithArray: [self updateClock:year]];
    [self updateYear:clockArray];
    clockArray = [[NSArray alloc] initWithArray: [self updateClock:month]];
    [self updateMonth:clockArray];
    clockArray = [[NSArray alloc] initWithArray: [self updateClock:day]];
    [self updateDay:clockArray];
    clockArray = [[NSArray alloc] initWithArray: [self updateClock:hour]];
    [self updateHour:clockArray];
    clockArray = [[NSArray alloc] initWithArray: [self updateClock:minute]];
    [self updateMinute:clockArray];
    clockArray = [[NSArray alloc] initWithArray: [self updateClock:second]];
    [self updateSecond:clockArray];
    if(second==0 && minute ==0) {
        [self reset];
        CGAffineTransform transform = _minuteHand.transform;
        transform = CGAffineTransformRotate(transform, (minute*M_PI / 30.0));
        
        //begin the rotation from the current state:
        [UIView animateWithDuration:0.0
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [_minuteHand setTransform:transform];
                         }
                         completion:nil];
        CGAffineTransform transform2 = _hourHand.transform;
        transform2 = CGAffineTransformRotate(transform2, (hour*M_PI / 6.0));
        
        //begin the rotation from the current state:
        [UIView animateWithDuration:0.0
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [_hourHand setTransform:transform2];
                         }
                         completion:nil];
        transform = _secondHand.transform;
        transform = CGAffineTransformRotate(transform, (second*M_PI / 30.0));
        
        //begin the rotation from the current state:
        [UIView animateWithDuration:0.0
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [_secondHand setTransform:transform];
                         }
                         completion:nil];
    }

}
-(void) updateAnalogSecond{
    CGAffineTransform transform = _secondHand.transform;
    transform = CGAffineTransformRotate(transform, M_PI-.001);
    
    //begin the rotation from the current state:
    [UIView animateWithDuration:30.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [_secondHand setTransform:transform];
                     }
                     completion:^(BOOL finished){[self updateAnalogSecond];}];
}
-(void) updateAnalogMinute{
    CGAffineTransform transform = _minuteHand.transform;
    transform = CGAffineTransformRotate(transform, M_PI-.001);
    
    //begin the rotation from the current state:
    [UIView animateWithDuration:1800.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [_minuteHand setTransform:transform];
                     }
                     completion:^(BOOL finished){[self updateAnalogMinute];}];
}
-(void) updateAnalogHour{
    CGAffineTransform transform = _hourHand.transform;
    transform = CGAffineTransformRotate(transform, (M_PI-.001));
    
    //begin the rotation from the current state:
    [UIView animateWithDuration:43200.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [_hourHand setTransform:transform];
                     }
                     completion:^(BOOL finished){[self updateAnalogHour];}];
}


- (IBAction)UpdateClock:(id)sender {
    [self updateAll:YES];
}
- (void)reset {
    /*
     remember: to cancel an animation, use the NSObject class
     method cancelPreviousPerformRequestsWithTarget:
     */
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [UIView animateWithDuration:0.0 animations:^{
        [_secondHand setTransform:CGAffineTransformIdentity];
        [_minuteHand setTransform:CGAffineTransformIdentity];
        [_hourHand setTransform:CGAffineTransformIdentity];

    }];
}
@end
