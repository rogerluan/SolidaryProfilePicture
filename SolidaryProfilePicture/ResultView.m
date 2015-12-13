//
//  ResultView.m
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 12/1/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "ResultView.h"

@implementation ResultView


#pragma mark - IBAction

/**
 *  @author Roger Oba
 *
 *  Dismisses the result view..
 *
 *  @param sender Close button.
 */
- (IBAction)closeResultView:(id)sender {
    [self.delegate resultAlertDidClose:(ResultAlert*)self.superview.superview];
}

/**
 *  @author Roger Oba
 *
 *  Saves the image to camera roll.
 *
 *  @param sender Save button.
 */
- (IBAction)saveImage:(id)sender {
    [self.delegate resultAlertDidSave:(ResultAlert*)self.superview.superview];
}

/**
 *  @author Roger Oba
 *
 *  Opens the export options.
 *
 *  @param sender Export button.
 */
- (IBAction)exportImage:(id)sender {
    [self.delegate resultAlertDidExport:(ResultAlert*)self.superview.superview];
}

@end
