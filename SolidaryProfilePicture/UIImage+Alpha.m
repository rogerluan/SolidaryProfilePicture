//
//  UIImage+Alpha.m
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 11/24/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "UIImage+Alpha.h"

@implementation UIImage (Alpha)

- (instancetype)initImage:(UIImage*)image withAlpha:(CGFloat)alpha {
    if (!(self = [super init])) { return nil; }
    
    self = image;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    self = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return self;
}

- (CGFloat)alpha {
    return self.alpha;
}

@end
