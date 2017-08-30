//
//  UnrulySoundboardViewController.m
//  UnrulySoundboard
//
//  Created by Dominic Amato on 4/14/13.
//  Copyright (c) 2013 Dominic Amato. All rights reserved.
//

#import "UnrulySoundboardViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface UnrulySoundboardViewController ()

@property (nonatomic,strong) AVAudioPlayer *bgAudioPlayer;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer1;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer2;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer3;

@property (nonatomic,strong) UIImageView *background;

@property (nonatomic,strong) UIButton *button1;
@property (nonatomic,strong) UIButton *button2;
@property (nonatomic,strong) UIButton *button3;


@end

@implementation UnrulySoundboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSURL *audioPath = [[NSBundle mainBundle] URLForResource:@"1085" withExtension:@"mp3"];
    NSError *error;
    _bgAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioPath error:&error];
    [_bgAudioPlayer setNumberOfLoops:-1];
    [_bgAudioPlayer play];
    
    audioPath = [[NSBundle mainBundle] URLForResource:@"beat" withExtension:@"wav"];
    _audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioPath error:&error];
    
    audioPath = [[NSBundle mainBundle] URLForResource:@"synth" withExtension:@"wav"];
    _audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioPath error:&error];
    
    audioPath = [[NSBundle mainBundle] URLForResource:@"Violet" withExtension:@"mp3"];
    _audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:audioPath error:&error];
    
    _background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    [_background setImage:[UIImage imageNamed:@"background.png"]];
    [self.view addSubview:_background];
    [self.view sendSubviewToBack:_background];

    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button1 setFrame:CGRectMake(0, 0, self.view.frame.size.height/3.0, self.view.frame.size.width)];
    [_button1 addTarget:self
                 action:@selector(button1Pressed)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button1];
    
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button2 setFrame:CGRectMake(self.view.frame.size.height/3.0, 0, self.view.frame.size.height/3.0, self.view.frame.size.width)];
    [_button2 addTarget:self
                 action:@selector(button2Pressed)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button2];
    
    _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button3 setFrame:CGRectMake(2*(self.view.frame.size.height/3.0), 0, self.view.frame.size.height/3.0, self.view.frame.size.width)];
    [_button3 addTarget:self
                 action:@selector(button3Pressed)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button3];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)button1Pressed{
    _audioPlayer1.rate = arc4random_uniform(50)*.1;
    _audioPlayer1.pan = ((float)arc4random_uniform(200)-100)*.01;;
    _audioPlayer1.volume = arc4random_uniform(30)*.1;
    [_audioPlayer1 play];
    NSLog(@"%i", _audioPlayer1.data.length);
}
- (void)button2Pressed{
    _audioPlayer2.rate = arc4random_uniform(50)*.1;
    _audioPlayer2.pan = ((float)arc4random_uniform(200)-100)*.01;;
    _audioPlayer2.volume = arc4random_uniform(30)*.1;
    [_audioPlayer2 play];
}
- (void)button3Pressed{
    _audioPlayer3.rate = arc4random_uniform(50)*.1;
    _audioPlayer3.pan = ((float)arc4random_uniform(200)-100)*.01;;
    _audioPlayer3.volume = arc4random_uniform(30)*.1;
    [_audioPlayer3 play];
}
@end
