//
//  ResultView.h
//  SolidaryProfilePicture
//
//  Created by Roger Luan on 12/1/15.
//  Copyright © 2015 Roger Oba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ResultAlert;

@protocol ResultViewDelegate <NSObject>

@optional
- (void)resultAlertDidClose:(ResultAlert*)alert;
- (void)resultAlertDidSave:(ResultAlert*)alert;
- (void)resultAlertDidExport:(ResultAlert*)alert;

@end

@interface ResultView : UIView

@property (assign,nonatomic) id<ResultViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIButton *resultImageButton;

@end
