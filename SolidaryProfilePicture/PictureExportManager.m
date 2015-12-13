//
//  PictureExportManager.m
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 11/24/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "PictureExportManager.h"
#import "ViewControllerUtil.h"
#import "RDActivityViewController.h"

static NSString *URLString = @"http://appstore.com/solidaryProfilePicture";

@interface PictureExportManager() <RDActivityViewControllerDelegate>

@property (strong,nonatomic) UIImage *resultImage;

@end

@implementation PictureExportManager

- (void)displayExportOptionsWithImage:(UIImage *)image {
    
    if (image) {
        self.resultImage = image;
        
        RDActivityViewController *activity = [[RDActivityViewController alloc] initWithDelegate:self];
        activity.excludedActivityTypes = @[UIActivityTypeAddToReadingList,UIActivityTypePrint];
        [[ViewControllerUtil topViewController] presentViewController:activity animated:YES completion:nil];
    }
    else {
        NSLog(@"Invalid image.");
    }
}

- (void)saveImageToCameraRoll:(UIImage*)image {
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

#pragma mark - UIActivityDataSource Method -

-(NSArray*)activityViewController:(NSArray *)activityViewController itemsForActivityType:(NSString *)activityType {

    if ([activityType isEqualToString:UIActivityTypePostToTwitter] || [activityType isEqualToString:UIActivityTypePostToFacebook]) {

        NSString *sharingString = NSLocalizedString(@"I just made a solidary profile picture to support a great cause. #solidaryProfilePicture", nil);
        NSURL *sharingURL = [NSURL URLWithString:URLString];
        return @[sharingString,sharingURL,self.resultImage];
    } else {
        return @[self.resultImage];
    }
}

@end
