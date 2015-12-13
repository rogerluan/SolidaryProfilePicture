//
//  ResultAlert.h
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 12/1/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <CustomIOSAlertView/CustomIOSAlertView.h>
#import <UIKit/UIKit.h>
#import "ResultView.h"

@interface ResultAlert : CustomIOSAlertView

@property (strong,nonatomic) UIImage *resultImage;

- (instancetype)initWithImage:(UIImage*)image;

@end
