//
//  UserManager.m
//  Doctor
//
//  Created by Roger Luan on 11/13/15.
//  Copyright © 2015 GoDoctor. All rights reserved.
//

#import "UserManager.h"
#import <FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "SDWebImageDownloader.h"
#import "ViewControllerUtil.h"
#import "KVNProgress.h"

@implementation UserManager

+ (void)fetchFacebookProfilePictureFromCurrentUser:(ProfilePictureBlock _Nonnull)completion {
	if ([FBSDKAccessToken currentAccessToken]) {
        [KVNProgress showWithStatus:NSLocalizedString(@"Loading...", nil)];
		FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"/me" parameters:@{@"fields":@"picture.type(large)"} HTTPMethod:@"GET"];
		[request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
			if (error) {
				NSLog(@"Facebook Profile Picture Error: %@",error);
				completion(error,nil);
			}
			else {
                NSURL *imageURL = [NSURL URLWithString:[[[result objectForKey:@"picture" ]objectForKey:@"data"] objectForKey:@"url"]];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
                    
                    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imageURL options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        //					NSLog(@"Image downloaded: %ld%%",(long)receivedSize/expectedSize);
                    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                        
                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                            if (!error && finished && image) {
                                completion(nil,image);
                            }
                            else if (error) {
                                completion(error,nil);
                            }
                        });
                    }];
                });
            }
		}];
	}
	else {
        [self loginWithFacebookWithCompletion:^(NSError * _Nullable error) {
            if (!error) {
                [self fetchFacebookProfilePictureFromCurrentUser:^(NSError * _Nullable error, UIImage * _Nullable profilePicture) {
                    if (!error && profilePicture) {
                        completion(nil,profilePicture);
                    }
                    else {
                        completion(error,nil);
                    }
                }];
            }
        }];
	}
}

+ (void)loginWithFacebookWithCompletion:(LoginCompletionBlock)completion {
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile"] fromViewController:[ViewControllerUtil topViewController] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
             completion(error);
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
             NSError* error = [[NSError alloc] initWithDomain:NSLocalizedString(@"User Cancelled Login", nil) code:1 userInfo:nil];
             completion(error);
         } else {
             NSLog(@"Logged in");
             completion(nil);
         }
     }];
}

@end
