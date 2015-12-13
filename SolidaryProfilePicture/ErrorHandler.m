//
//  ErrorHandler.m
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 11/24/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import "ErrorHandler.h"
#import "ViewControllerUtil.h"

@implementation ErrorHandler

+ (void)showAlertFromError:(NSError*)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"An Error Occurred", nil) message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK") style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [[ViewControllerUtil topViewController] presentViewController:alert animated:YES completion:nil];
}

@end
