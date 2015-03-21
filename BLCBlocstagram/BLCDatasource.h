//
//  BLCDatasource.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Below for exercise 30 and beyond
@class BLCMedia;
//Above for exercise 30 and beyond

//Below for exercise 31 and beyond
typedef void (^BLCNewItemCompletionBlock)(NSError *error);
//Abover for exercise 31 and beyond

@interface BLCDatasource : NSObject

//Below for Exercise 43 and Beyond
//extern NSString *const BLCImageFinishedNotification;
//Above for Exercise 43 and Beyond

+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *mediaItems;

//Below for Exercise 32 and beyond
@property (nonatomic, strong, readonly) NSString *accessToken;
+ (NSString *) instagramClientID;
//Above for Exercise 32 and beyond

//Below for exercise 30 and beyond
- (void) deleteMediaItem:(BLCMedia *)item;
//Above for exercise 30 and beyond

//Below for exercise 31 and beyond
- (void) requestNewItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;
//Above for exercise 31 and beyond

//Below for Exercise 37 and Beyond
//- (void) downloadImageForMediaItem:(BLCMedia *)mediaItem;
//Above for Exercise 37 and Beyond

//Below for Exercise 38 and Beyond
//- (void) toggleLikeOnMediaItem:(BLCMedia *)mediaItem;
//Above for Exercise 38 and Beyond

//Below for Exercise 39 and Beyond
//- (void) commentOnMediaItem:(BLCMedia *)mediaItem withCommentText:(NSString *)commentText;
//Above for Exercise 39 and Beyond

@end
