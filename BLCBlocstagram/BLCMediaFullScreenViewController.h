//
//  BLCMediaFullScreenViewController.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 3/15/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

//For Exercise 35 and Beyond

@class BLCMedia;

@interface BLCMediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

//Below for Exercise 41 and Beyond
//@property (nonatomic, strong) BLCMedia *media;
//Above for Exercise 41 and Beyond

- (instancetype) initWithMedia:(BLCMedia *)media;

- (void) centerScrollView;

//Below for Exercise 41 and Beyond
//- (void) recalculateZoomScale;
//Above for Exercise 41 and Beyond

@end
