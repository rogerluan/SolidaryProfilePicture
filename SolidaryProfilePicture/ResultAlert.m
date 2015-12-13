//
//  ResultAlert.m
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 12/1/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "ResultAlert.h"
#import "ResultView.h"

const static CGFloat kMotionEffectExtent = 20.0;

@implementation ResultAlert

- (instancetype)initWithImage:(UIImage*)image {
    if (!(self = [super init])) { return nil; }
    
    ResultView *containerView = [[[NSBundle mainBundle] loadNibNamed:@"ResultView" owner:self options:nil] firstObject];;
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    //without this line, the image frame messes up below
    containerView.frame = CGRectMake(0,0, screenFrame.size.width-40, 500);//temporary placeholder height
    
    [containerView.resultImageButton setImage:image forState:UIControlStateNormal];
    
    //update layout so we can change the frame accordingly
    [containerView layoutIfNeeded];
    
    //update the frame height so it has only the necessary size
    containerView.frame = CGRectMake(0,0, screenFrame.size.width-40, containerView.resultImageButton.frame.origin.y+containerView.resultImageButton.frame.size.height+30+44+30);
    
    self.resultImage = image;
    self.buttonTitles = nil;
    self.containerView = containerView;
    
    return self;
}


/**
 *  @author Roger Oba
 *
 *  Adds parallax effect to the alert view.
 */
- (void)applyMotionEffects {
    UIInterpolatingMotionEffect *horizontalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                    type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalEffect.minimumRelativeValue = @(-kMotionEffectExtent);
    horizontalEffect.maximumRelativeValue = @( kMotionEffectExtent);
    
    UIInterpolatingMotionEffect *verticalEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                  type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalEffect.minimumRelativeValue = @(-kMotionEffectExtent);
    verticalEffect.maximumRelativeValue = @( kMotionEffectExtent);
    
    UIMotionEffectGroup *motionEffectGroup = [[UIMotionEffectGroup alloc] init];
    motionEffectGroup.motionEffects = @[horizontalEffect, verticalEffect];
    
    [self.dialogView addMotionEffect:motionEffectGroup];
}

/**
 *  @author Roger Oba
 *
 *  Removes the default dialog view appearance.
 */
- (void)resetDialogViewAppearance {
    self.dialogView.layer.borderWidth = 0;
    self.dialogView.layer.borderColor = [UIColor clearColor].CGColor;
    self.dialogView.layer.cornerRadius = 15.0;
    self.dialogView.clipsToBounds = YES;
}

- (void)show {
    [super show];
    [self applyMotionEffects];
    [self resetDialogViewAppearance];
}

- (void)setDelegate:(id<ResultViewDelegate>)delegate {
    ResultView *containerView = (ResultView*)self.containerView;
    containerView.delegate = delegate;
}

@end
