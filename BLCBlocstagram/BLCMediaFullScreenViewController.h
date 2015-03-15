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

- (instancetype) initWithMedia:(BLCMedia *)media;

- (void) centerScrollView;

@end
