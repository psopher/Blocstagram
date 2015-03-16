//
//  BLCMedia.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Below for Exercise 38 and Beyond
#import "BLCLikeButton.h"
//Above for Exercise 38 and Beyond

//Below for Exercise 37 and Beyond
typedef NS_ENUM(NSInteger, BLCMediaDownloadState) {
    BLCMediaDownloadStateNeedsImage             = 0,
    BLCMediaDownloadStateDownloadInProgress     = 1,
    BLCMediaDownloadStateNonRecoverableError    = 2,
    BLCMediaDownloadStateHasImage               = 3
};
//Above for Exercise 37 and Beyond

@class BLCUser;

//Below for Exercise 33 and Beyond
//@interface BLCMedia : NSObject
//Above for Exercise 33 and Beyond

//Below for Exercise 34 and Beyond
@interface BLCMedia : NSObject <NSCoding>
//Above for Exercise 34 and Beyond

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) BLCUser *user;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSArray *comments;

//Below for Exercise 37 and Beyond
@property (nonatomic, assign) BLCMediaDownloadState downloadState;
//Above for Exercise 37 and Beyond

//Below for Exercise 38 and Beyond
@property (nonatomic, assign) BLCLikeState likeState;
//Above for Exercise 38 and Beyond

//Below for Exercise 33 and beyond
- (instancetype) initWithDictionary:(NSDictionary *)mediaDictionary;
//Above for Exercise 33 and Beyond

@end
