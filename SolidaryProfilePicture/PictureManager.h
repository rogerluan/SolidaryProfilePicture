//
//  PictureManager.h
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 11/24/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^PictureReplacementBlock)(UIImage *image, NSError *error);

@protocol PictureManagerDelegate;

@interface PictureManager : NSObject

@property (strong,nonatomic) id<PictureManagerDelegate> delegate;
@property (assign,nonatomic) BOOL allowsWebContent;
@property (assign,nonatomic) BOOL allowsSocialContent;

+ (instancetype)new;
- (instancetype)init;


- (void)showPictureReplacementOptionsWithCompletion:(PictureReplacementBlock)completion;
- (UIImage*)resultImageFromImage:(UIImage*)main withImage:(UIImage*)watermark;

@end

@protocol PictureManagerDelegate <NSObject>

- (void)pictureManager:(PictureManager*)pictureManager didChoosePicture:(UIImage*)image;

@end
