//
//  BLCCropImageViewController.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 3/18/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

//For Exercise 41 and Beyond

#import <UIKit/UIKit.h>
#import "BLCMediaFullScreenViewController.h"

@class BLCCropImageViewController;

@protocol BLCCropImageViewControllerDelegate <NSObject>

- (void) cropControllerFinishedWithImage:(UIImage *)croppedImage;

@end

@interface BLCCropImageViewController : BLCMediaFullScreenViewController

- (instancetype) initWithImage:(UIImage *)sourceImage;

@property (nonatomic, weak) NSObject <BLCCropImageViewControllerDelegate> *delegate;

@end
