//
//  BLCDatasource.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BLCMedia;

typedef void (^BLCNewItemCompletionBlock)(NSError *error);

@interface BLCDatasource : NSObject

//Below for Exercise 43 and Beyond
//extern NSString *const BLCImageFinishedNotification;
//Above for Exercise 43 and Beyond

+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *mediaItems;

@property (nonatomic, strong, readonly) NSString *accessToken;
+ (NSString *) instagramClientID;

- (void) deleteMediaItem:(BLCMedia *)item;

- (void) requestNewItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;
- (void) downloadImageForMediaItem:(BLCMedia *)mediaItem;

- (void) downloadImageForMediaItem:(BLCMedia *)mediaItem;

//Below for Exercise 38 and Beyond
//- (void) toggleLikeOnMediaItem:(BLCMedia *)mediaItem;
//Above for Exercise 38 and Beyond

//Below for Exercise 39 and Beyond
//- (void) commentOnMediaItem:(BLCMedia *)mediaItem withCommentText:(NSString *)commentText;
//Above for Exercise 39 and Beyond

@end
