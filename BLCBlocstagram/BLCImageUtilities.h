//
//  BLCImageUtilities.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 3/17/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

//For Exercise 40 and Beyond

#import <UIKit/UIKit.h>

@interface UIImage (BLCImageUtilities)

- (UIImage *) imageWithFixedOrientation;
- (UIImage *) imageResizedToMatchAspectRatioOfSize:(CGSize)size;
- (UIImage *) imageCroppedToRect:(CGRect)cropRect;

@end