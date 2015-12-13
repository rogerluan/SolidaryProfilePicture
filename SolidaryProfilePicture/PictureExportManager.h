//
//  PictureExportManager.h
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 11/24/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PictureExportManager : NSObject

/**
 *  @author Roger Oba
 *
 *  Displays an UIActivityViewController with the available sharing options.
 *
 *  @param image Image that's going to be shared.
 */
- (void)displayExportOptionsWithImage:(UIImage*)image;

/**
 *  @author Roger Oba
 *
 *  Saves the given image to the device's camera roll.
 *
 *  @param image Image that's going to be saved.
 */
- (void)saveImageToCameraRoll:(UIImage*)image;

@end
