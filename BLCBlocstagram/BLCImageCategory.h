//
//  BLCImageCategory.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 4/5/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLCImageUtilities : UIImage

- (UIImage *) imageByScalingToSize:(CGSize)size andCroppingWithRect:(CGRect)rect;

@end