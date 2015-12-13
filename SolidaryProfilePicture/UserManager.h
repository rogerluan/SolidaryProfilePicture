//
//  UserManager.h
//  Doctor
//
//  Created by Roger Luan on 11/13/15.
//  Copyright © 2015 GoDoctor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ProfilePictureBlock)(NSError* _Nullable error, UIImage* _Nullable profilePicture);
typedef void(^LoginCompletionBlock)(NSError* _Nullable error);

@interface UserManager : NSObject

/**
 *  @author Roger Oba
 *
 *  Fetches the facebook profile picture from the current user.
 *
 *  @param completion The completion block to call when the request completes.
 */
+ (void)fetchFacebookProfilePictureFromCurrentUser:(ProfilePictureBlock _Nonnull)completion;

@end
