//
//  ViewControllerUtil.h
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 11/24/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewControllerUtil : NSObject

#pragma mark - Helper -

/**
 *  @author Roger Oba
 *
 *  Returns a UIViewController instance that represents the view controller that's on the top (visible).
 *
 *  @return The visible UIViewController
 */
+ (UIViewController *)topViewController;

@end
