//
//  PictureManager.m
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 11/24/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "PictureManager.h"
#import "UserManager.h"
#import "UIImage+Alpha.h"
#import "UIImagePickerController+Block.h"
#import <DZNPhotoPickercontroller/Classes/DZNPhotoPickerController.h>
//#import <DZNPhotoPickerController/Classes/UIImagePickerController/UIImagePickerControllerExtended.h>
#import "ViewControllerUtil.h"
#import <KVNProgress.h>

@implementation PictureManager

#pragma mark - Initialization -

+ (instancetype)new {
    PictureManager *thisSelf = [super new];
    
    if (thisSelf) {
        thisSelf.allowsWebContent = YES;
        thisSelf.allowsSocialContent = YES;
    }
    
    return thisSelf;
}

- (instancetype)init {
    if (!(self = [super init])) { return nil; }
    
    self.allowsWebContent = YES;
    self.allowsSocialContent = YES;
    
    return self;
}

#pragma mark - Methods -

- (void)showPictureReplacementOptionsWithCompletion:(PictureReplacementBlock)completion {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Change Picture", nil) message:NSLocalizedString(@"Where would you like to fetch your picture from?", nil) preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Take Photo", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *picker = [UIImagePickerController new];
        
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.finalizationBlock = ^(UIImagePickerController *picker, NSDictionary *info) {
            [picker dismissViewControllerAnimated:YES completion:nil];
            completion([info objectForKey:UIImagePickerControllerEditedImage],nil);
        };
        
        picker.cancellationBlock = ^(UIImagePickerController *picker) {
            NSLog(@"Cancelled.");
            [picker dismissViewControllerAnimated:YES completion:nil];
        };
        
        [[ViewControllerUtil topViewController] presentViewController:picker animated:YES completion:nil];
    }];
    
    
    UIAlertAction *cameraRollAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Camera Roll", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        picker.finalizationBlock = ^(UIImagePickerController *picker, NSDictionary *info) {
            [picker dismissViewControllerAnimated:YES completion:nil];
            completion([info objectForKey:UIImagePickerControllerEditedImage],nil);
        };
        
        picker.cancellationBlock = ^(UIImagePickerController *picker) {
            NSLog(@"Cancelled.");
            [picker dismissViewControllerAnimated:YES completion:nil];
        };
        
        [[ViewControllerUtil topViewController] presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction *webImageAction = nil;
    if (self.allowsWebContent) {
         webImageAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Search Web", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            DZNPhotoPickerController *picker = [DZNPhotoPickerController new];
            picker.supportedServices = DZNPhotoPickerControllerServiceFlickr;
            picker.allowsEditing = YES;
            picker.cropMode = DZNPhotoEditorViewControllerCropModeSquare;
            picker.enablePhotoDownload = YES;
            picker.supportedLicenses = DZNPhotoPickerControllerCCLicenseBY_ALL;
            picker.allowAutoCompletedSearch = YES;
            
            picker.finalizationBlock = ^(DZNPhotoPickerController *picker, NSDictionary *info) {
                [picker dismissViewControllerAnimated:YES completion:nil];
                [KVNProgress showWithStatus:NSLocalizedString(@"Loading...", nil)];
                completion([info objectForKey:UIImagePickerControllerEditedImage],nil);
            };
            
            picker.failureBlock = ^(DZNPhotoPickerController *picker, NSError *error) {
                completion(nil,error);
            };
            
            picker.cancellationBlock = ^(DZNPhotoPickerController *picker) {
                NSLog(@"Cancelled.");
                [picker dismissViewControllerAnimated:YES completion:nil];
            };
            
             [[ViewControllerUtil topViewController] presentViewController:picker animated:YES completion:nil];
        }];
    }
    
    UIAlertAction *facebookAction = nil;
    if (self.allowsSocialContent) {
        facebookAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Facebook", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [UserManager fetchFacebookProfilePictureFromCurrentUser:^(NSError *error, UIImage *profilePicture) {
                if (!error && profilePicture) {
                    completion(profilePicture,nil);
                }
                else {
                    NSLog(@"Failed to fetch profile picture. [PictureManager showPictureReplacementOptionsInTarget:]");
                    completion(nil,error);
                }
            }];
        }];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel") style:UIAlertActionStyleCancel handler:nil];
    
    
    [alert addAction:takePhotoAction];
    [alert addAction:cameraRollAction];
    if (webImageAction) {
        [alert addAction:webImageAction];
    }
    if (facebookAction) {
        [alert addAction:facebookAction];
    }
    [alert addAction:cancelAction];
    [[ViewControllerUtil topViewController] presentViewController:alert animated:YES completion:nil];
}

- (UIImage*)resultImageFromImage:(UIImage *)mainImage withImage:(UIImage *)watermarkImage {
    UIImage *watermarkWithAlpha = [[UIImage alloc] initImage:watermarkImage withAlpha:0.4];
    
    //Now re-drawing your  Image using drawInRect method
    UIGraphicsBeginImageContext(mainImage.size);
    [mainImage drawInRect:CGRectMake(0, 0, mainImage.size.width, mainImage.size.height)];
    [watermarkWithAlpha drawInRect:CGRectMake(0, 0, mainImage.size.width, mainImage.size.height)];
    
    // now merging two images into one
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

@end
