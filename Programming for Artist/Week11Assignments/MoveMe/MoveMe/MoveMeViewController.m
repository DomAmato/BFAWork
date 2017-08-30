//
//  MoveMeViewController.m
//  MoveMe
//
//  Created by Dominic Amato on 4/14/13.
//  Copyright (c) 2013 Dominic Amato. All rights reserved.
//

#import "MoveMeViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface MoveMeViewController ()

@property (nonatomic,strong) CMMotionManager *motionManager;
@property (nonatomic,strong) CMDeviceMotion  *deviceMotion;
@property (nonatomic,strong) CMAttitude      *attitude;
@property (nonatomic,strong) UIImageView     *circle;
@property (nonatomic,strong) NSTimer *timer;


@end

@implementation MoveMeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0
                                                  target:self
                                                selector:@selector(updateDeviceMotion)
                                                userInfo:nil
                                                 repeats:YES];
    _circle = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 40, 40)];
    [_circle setImage:[UIImage imageNamed:@"BlueLEDOn.png"]];
    [_circle setContentMode:UIViewContentModeScaleAspectFit];
    [_circle setCenter:CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/2)];
    [self.view addSubview:_circle];
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:255]];
}

- (void)viewWillAppear:(BOOL)animated {
    if (_motionManager.deviceMotionAvailable) {
        [_motionManager startDeviceMotionUpdates];
    } else {
        NSLog(@"device does not have gyroscope");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateDeviceMotion{
    _deviceMotion = _motionManager.deviceMotion;
    _attitude = _deviceMotion.attitude;
    double moveX = _attitude.pitch;
    double moveY = _attitude.roll;
    if (_circle.frame.origin.x<20 && moveX<0) {
        moveX=0;
    }
    if (_circle.frame.origin.x>self.view.frame.size.width-40 && moveX>0) {
        moveX=0;
    }
    if (_circle.frame.origin.y<20 && moveY<0) {
        moveY=0;
    }
    if (_circle.frame.origin.y>self.view.frame.size.height-40 && moveY>0) {
        moveY=0;
    }
    [_circle setCenter:CGPointMake(_circle.frame.origin.x+20+moveX, _circle.frame.origin.y+20+moveY)];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:(128+(_deviceMotion.userAcceleration.x*128))/255.0 green:(128+(_deviceMotion.userAcceleration.y*128))/255.0 blue:(128+(_deviceMotion.userAcceleration.z*128))/255.0 alpha:255]];

}
- (CMMotionManager *)motionManager {
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
        [_motionManager setDeviceMotionUpdateInterval:1.0 /60];
    }
    return _motionManager;
}

@end
