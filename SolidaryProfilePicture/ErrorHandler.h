//
//  ErrorHandler.h
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 11/24/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ErrorHandler : NSObject

+ (void)showAlertFromError:(NSError*)error;

@end
