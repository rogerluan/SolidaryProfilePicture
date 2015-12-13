//
//  ViewController.m
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 11/23/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "ViewController.h"
#import "PictureManager.h"
#import "ErrorHandler.h"
#import "PictureExportManager.h"
#import <DZNPhotoPickercontroller/Classes/DZNPhotoPickerController.h>
#import "Constants.h"
#import <KVNProgress.h>
#import "ResultAlert.h"

@interface ViewController () <ResultViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *mainImageButton;
@property (strong, nonatomic) IBOutlet UIButton *watermarkImageButton;

@property (strong,nonatomic) UIVisualEffectView *blurEffectView;
@property (strong, nonatomic) PictureManager *pictureManager;
@property (strong, nonatomic) PictureExportManager *pictureExportManager;

@end

@implementation ViewController

+ (void)initialize {
    [super initialize];
    
    [DZNPhotoPickerController registerService:DZNPhotoPickerControllerServiceFlickr
                                  consumerKey:kFlickrConsumerKey
                               consumerSecret:kFlickrConsumerSecret
                                 subscription:DZNPhotoPickerControllerSubscriptionFree];
//    
//    [DZNPhotoPickerController registerService:DZNPhotoPickerControllerServiceInstagram
//                                  consumerKey:kInstagramConsumerKey
//                               consumerSecret:kInstagramConsumerSecret
//                                 subscription:DZNPhotoPickerControllerSubscriptionFree];
//    
//    [DZNPhotoPickerController registerService:DZNPhotoPickerControllerServiceGoogleImages
//                                  consumerKey:kGoogleConsumerKey
//                               consumerSecret:kGoogleConsumerSecret
//                                 subscription:DZNPhotoPickerControllerSubscriptionFree];
//    
//    [DZNPhotoPickerController registerService:DZNPhotoPickerControllerServiceBingImages
//                                  consumerKey:kBingConsumerKey
//                               consumerSecret:kBingConsumerSecret
//                                 subscription:DZNPhotoPickerControllerSubscriptionFree];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pictureManager = [PictureManager new];
    self.pictureExportManager = [PictureExportManager new];
}

- (void)showBlurEffectView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.blurEffectView.frame = self.view.bounds;
    self.blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.blurEffectView];
}

#pragma mark - IBActions -

- (IBAction)changeMainImage:(id)sender {
    self.pictureManager.allowsSocialContent = YES;
    self.pictureManager.allowsWebContent = NO;
    [self.pictureManager showPictureReplacementOptionsWithCompletion:^(UIImage *image, NSError *error) {
        if (image) {
            [self.mainImageButton setImage:image forState:UIControlStateNormal];
            [KVNProgress dismiss];
        }
        else {
            [ErrorHandler showAlertFromError:error];
        }
    }];
}

- (IBAction)changeWatermarkImage:(id)sender {
    self.pictureManager.allowsSocialContent = NO;
    self.pictureManager.allowsWebContent = YES;
    [self.pictureManager showPictureReplacementOptionsWithCompletion:^(UIImage *image, NSError *error) {
        if (image) {
            [self.watermarkImageButton setImage:image forState:UIControlStateNormal];
            [KVNProgress dismiss];
        }
        else {
            [ErrorHandler showAlertFromError:error];
        }
    }];
}

- (IBAction)generateAction:(id)sender {
    [self showBlurEffectView];
    ResultAlert *alert = [[ResultAlert alloc] initWithImage:[self.pictureManager resultImageFromImage:self.mainImageButton.imageView.image withImage:self.watermarkImageButton.imageView.image]];
    alert.delegate = (id)self;
    [alert show];
}

#pragma mark - ResultAlertDelegate Methods -

- (void)resultAlertDidClose:(ResultAlert *)alert {
    [alert close];
    [self.blurEffectView removeFromSuperview];
}

- (void)resultAlertDidSave:(ResultAlert *)alert {
    [self.pictureExportManager saveImageToCameraRoll:alert.resultImage];
    [KVNProgress showSuccessWithStatus:NSLocalizedString(@"Image Saved to Camera Roll!", nil)];
}

- (void)resultAlertDidExport:(ResultAlert *)alert {
    [alert close];
    [self.blurEffectView removeFromSuperview];
    [self.pictureExportManager displayExportOptionsWithImage:alert.resultImage];
}

@end
