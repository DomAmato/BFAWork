//
//  PhotoboothViewController.m
//  Photobooth
//
//  Created by Dominic Amato on 4/14/13.
//  Copyright (c) 2013 Dominic Amato. All rights reserved.
//

#import "PhotoboothViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface PhotoboothViewController ()
<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (nonatomic,strong) UIImageView *backgroundImage;
@property int arrayIndex;


- (IBAction)cameraButtonAction:(id)sender;

@end

@implementation PhotoboothViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _arrayIndex=-1;
    UIImage *photoboothImg = [UIImage imageNamed:@"photo-booth.png"];
    _backgroundImage = [[UIImageView alloc] initWithImage:photoboothImg];
    [self.view addSubview:_backgroundImage];
    UIView *temp = [[UIView alloc] initWithFrame: CGRectMake(103, 52, photoboothImg.size.width*.36, photoboothImg.size.width*.27)];
    [temp setBackgroundColor:[UIColor blackColor]];
    [_backgroundImage addSubview:temp];
    [_imageArray addObject:temp];
    temp = [[UIView alloc] initWithFrame: CGRectMake(103, 162, photoboothImg.size.width*.36, photoboothImg.size.width*.27)];
    [temp setBackgroundColor:[UIColor blackColor]];
    [_backgroundImage addSubview:temp];
    [_imageArray addObject:temp];
    temp = [[UIView alloc] initWithFrame: CGRectMake(103, 272, photoboothImg.size.width*.36, photoboothImg.size.width*.27)];
    [temp setBackgroundColor:[UIColor blackColor]];
    [_backgroundImage addSubview:temp];
    [_imageArray addObject:temp];
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    [self.imagePickerController setDelegate:self];
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        [_cameraButton setEnabled:NO];
        [_cameraButton setAlpha:0.5];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self.imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        NSArray *mediaType = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
        [self.imagePickerController setMediaTypes:mediaType];
        [self presentViewController:self.imagePickerController
                           animated:YES
                         completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *cameraImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (_arrayIndex>2) {
        _arrayIndex=-1;
    }
    [[_imageArray objectAtIndex:++_arrayIndex] setImage:cameraImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)cameraButtonAction:(id)sender {
    [self showCamera];
}

@end
