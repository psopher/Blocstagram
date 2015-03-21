//
//  BLCDatasource.m
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCDatasource.h"
#import "BLCUser.h"
#import "BLCMedia.h"
#import "BLCComment.h"

//Below for Exercise 36 and Beyond
//#import <AFNetworking/AFNetworking.h>
//Above for Exercise 36 and Beyond

//Below for Exercise 32 and Beyond
#import "BLCLoginViewController.h"
//Above for Exercise 32 and Beyond

//Below for Exercise 34 and Beyond
#import <UICKeyChainStore.h>
//Above for Exercise 34 and Beyond

//Below for Exercise 43 and Beyond
//#define isPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//Above for Exercise 43 and Beyond

@interface BLCDatasource ()
//Below for Exercise 30 and beyond
{
    NSMutableArray *_mediaItems;
}
//Above for Exercise 30 and beyond

//Below for Exercise 32 and Beyond
@property (nonatomic, strong) NSString *accessToken;
//Above for Exercise 32 and Beyond

@property (nonatomic, strong) NSArray *mediaItems;

//Below for Exercise 31 and beyond
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isLoadingOlderItems;
//Above for Exercise 31 and beyond

//Below for Exercise 33 and Beyond
@property (nonatomic, assign) BOOL thereAreNoMoreOlderMessages;
//Above for Exercise 33 and Beyond

//Below for Exercise 36 and Beyond
//@property (nonatomic, strong) AFHTTPRequestOperationManager *instagramOperationManager;
//Above for Exercise 36 and Beyond

@end

@implementation BLCDatasource

//Below for Exercise 43 and Beyond
//NSString *const BLCImageFinishedNotification = @"BLCImageFinishedNotification";
//Above for Exercise 43 and Beyond

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        //Below used through Exercise 31
//        [self addRandomData];
        //Above used through Exercise 31
        
        //Below for Exercise 32 and 33
//        [self registerForAccessTokenNotification];
        //Above for Exercise 32 and 33
        
        //Below for Exercise 36 and Beyond
//        NSURL *baseURL = [NSURL URLWithString:@"https://api.instagram.com/v1/"];
//        self.instagramOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
//        
//        AFJSONResponseSerializer *jsonSerializer = [AFJSONResponseSerializer serializer];
//        
//        AFImageResponseSerializer *imageSerializer = [AFImageResponseSerializer serializer];
//        imageSerializer.imageScale = 1.0;
//        
//        AFCompoundResponseSerializer *serializer = [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:@[jsonSerializer, imageSerializer]];
//        self.instagramOperationManager.responseSerializer = serializer;
        //Above for Exercise 36 and Beyond
        
        //Below for Exercise 34 and beyond
        self.accessToken = [UICKeyChainStore stringForKey:@"access token"];
        
        if (!self.accessToken) {
            [self registerForAccessTokenNotification];
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *fullPath = [self pathForFilename:NSStringFromSelector(@selector(mediaItems))];
                NSArray *storedMediaItems = [NSKeyedUnarchiver unarchiveObjectWithFile:fullPath];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (storedMediaItems.count > 0) {
                        NSMutableArray *mutableMediaItems = [storedMediaItems mutableCopy];
                        
                        [self willChangeValueForKey:@"mediaItems"];
                        self.mediaItems = mutableMediaItems;
                        [self didChangeValueForKey:@"mediaItems"];
                    } else {
                        [self populateDataWithParameters:nil completionHandler:nil];
                    }
                });
            });
        }
        //Above for Exercise 34 and beyond
    }
    
    return self;
}

//Below for Exercise 32 and Beyond
- (void) registerForAccessTokenNotification {
    [[NSNotificationCenter defaultCenter] addObserverForName:BLCLoginViewControllerDidGetAccessTokenNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.accessToken = note.object;
        
        //Below is for Exercise 34 and beyond
        [UICKeyChainStore setString:self.accessToken forKey:@"access token"];
        //Above is for Exercise 34 and beyond

        //Below for Exercise 32 only
//        [self populateDataWithParameters:nil];
        //Above for Exercise 32 only
        
        //Below for Exercise 33 and Beyond
        [self populateDataWithParameters:nil completionHandler:nil];
        //Above for Exercise 33 and Beyond
    }];
}
//Above for Exercise 32 and Beyond

//Below used through Exercise 31
//- (void) addRandomData {
//    NSMutableArray *randomMediaItems = [NSMutableArray array];
//    
//    for (int i = 1; i <= 10; i++) {
//        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
//        UIImage *image = [UIImage imageNamed:imageName];
//        
//        if (image) {
//            BLCMedia *media =[[BLCMedia alloc] init];
//            media.user = [self randomUser];
//            media.image = image;
//            
//            NSUInteger commentCount = arc4random_uniform(10);
//            NSMutableArray *randomComments = [NSMutableArray array];
//            
//            for (int i = 0; i <= commentCount; i++) {
//                BLCComment *randomComment = [self randomComment];
//                [randomComments addObject:randomComment];
//            }
//            
//            media.comments = randomComments;
//            
//            [randomMediaItems addObject:media];
//        }
//    }
//    
//    self.mediaItems = randomMediaItems;
//}
//
//- (BLCUser *) randomUser {
//    BLCUser *user = [[BLCUser alloc] init];
//    
//    user.userName = [self randomStringOfLength:arc4random_uniform(10)];
//    
//    NSString *firstName = [self randomStringOfLength:arc4random_uniform(7)];
//    NSString *lastName = [self randomStringOfLength:arc4random_uniform(12)];
//    user.fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
//    
//    return user;
//}
//
//- (NSString *) randomSentenceWithMaximumNumberOfWords:(NSUInteger) len {
//        NSMutableString *randomSentence = [[NSMutableString alloc] init];
//    
//        NSUInteger wordCount = arc4random_uniform(len);
//    
//    
//        for (int i  = 0; i <= wordCount; i++) {
//                NSString *randomWord = [self randomStringOfLength:arc4random_uniform(12)];
//                [randomSentence appendFormat:@"%@ ", randomWord];
//            }
//    
//    
//        return [NSString stringWithString:randomSentence];
//    }
//
//- (BLCComment *) randomComment {
//    BLCComment *comment = [[BLCComment alloc] init];
//    
//    comment.from = [self randomUser];
//    
//    NSUInteger wordCount = arc4random_uniform(20);
//    
//    NSMutableString *randomSentence = [[NSMutableString alloc] init];
//    
//    for (int i = 0; i <= wordCount; i++) {
//        NSString *randomWord = [self randomStringOfLength:arc4random_uniform(12)];
//        [randomSentence appendFormat:@"%@ ", randomWord];
//    }
//    
//    comment.text = randomSentence;
//    
//    return comment;
//}
//
//- (NSString *) randomStringOfLength:(NSUInteger) len {
//    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
//    
//    NSMutableString *s = [NSMutableString string];
//    for (NSUInteger i = 0U; i < len; i++) {
//        u_int32_t r = arc4random_uniform((u_int32_t)[alphabet length]);
//        unichar c = [alphabet characterAtIndex:r];
//        [s appendFormat:@"%C", c];
//    }
//    return [NSString stringWithString:s];
//}
//Above used through Exercise 31

//Below for Exercise 30 and beyond

#pragma mark - Key/Value Observing

- (NSUInteger) countOfMediaItems {
    return self.mediaItems.count;
}

- (id) objectInMediaItemsAtIndex:(NSUInteger)index {
    return [self.mediaItems objectAtIndex:index];
}

- (NSArray *) mediaItemsAtIndexes:(NSIndexSet *)indexes {
    return [self.mediaItems objectsAtIndexes:indexes];
}

- (void) insertObject:(BLCMedia *)object inMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems insertObject:object atIndex:index];
}

- (void) removeObjectFromMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems removeObjectAtIndex:index];
}

- (void) replaceObjectInMediaItemsAtIndex:(NSUInteger)index withObject:(id)object {
    [_mediaItems replaceObjectAtIndex:index withObject:object];
}

- (void) deleteMediaItem:(BLCMedia *)item {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
    [mutableArrayWithKVO removeObject:item];
}
//Above for Exercise 30 and beyond

//Below for Exercise 31 and beyond
- (void) requestNewItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler {
    
    //Below for Exercise 33 and beyond
    self.thereAreNoMoreOlderMessages = NO;
    //Above for Exercise 33 and beyond
    
    if (self.isRefreshing == NO) {
        self.isRefreshing = YES;
        
        //Below is for Exercise 31 only
//        BLCMedia *media = [[BLCMedia alloc] init];
//        media.user = [self randomUser];
//        media.image = [UIImage imageNamed:@"10.jpg"];
//        media.caption = [self randomSentenceWithMaximumNumberOfWords:7];
//        
//        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
//        [mutableArrayWithKVO insertObject:media atIndex:0];
        //Above is for Exercise 31 only
        
        //Below used through exercise 32
//        self.isRefreshing = NO;
        //Above used through exercise 32
        
        //Below is for Exercise 33 and Beyond. This is the assignment for exercise 33.
        NSString *minID = [[NSString alloc] init];
        if (self.mediaItems.count > 0) {
            NSString *minID = [[self.mediaItems firstObject] idNumber];
        };
        NSDictionary *parameters = @{@"min_id": minID};
        //Above is for Exercise 33 and Beyond. This is the assignment for exercise 33.
        
        //Below is used through Exercise 32
//        if (completionHandler) {
//            completionHandler(nil);
//        }
        //Above used through Exercise 32
        
        //Below is for Exercise 33 and Beyond
        [self populateDataWithParameters:parameters completionHandler:^(NSError *error) {
            self.isRefreshing = NO;
            
            if (completionHandler) {
                completionHandler(error);
            }
        }];
        //Above is for Exercise 33 and Beyond
    }
}

- (void) requestOldItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler {
    //Below used through Exercise 32
//    if (self.isLoadingOlderItems == NO) {
    //Above used through Exercise 32
    
    //Below used for Exercise 33 and Beyond
    if (self.isLoadingOlderItems == NO && self.thereAreNoMoreOlderMessages == NO) {
        self.isLoadingOlderItems = YES;
        
        NSString *maxID = [[self.mediaItems lastObject] idNumber];
        NSDictionary *parameters = @{@"max_id": maxID};
    //Above used for Exercise 33 and Beyond
        
        //Below used through exercise 32
//        self.isLoadingOlderItems = YES;
        //Above used through exercise 32
        
        //Below is for Exercise 31 only
//        BLCMedia *media = [[BLCMedia alloc] init];
//        media.user = [self randomUser];
//        media.image = [UIImage imageNamed:@"%d.jpg"];
//        media.caption = [self randomSentenceWithMaximumNumberOfWords:7];
//
//        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
//        [mutableArrayWithKVO addObject:media];
        //Above is for Exercise 31 only
        
        //Below used through exercise 32
//        self.isLoadingOlderItems = NO;
//        
//        if (completionHandler) {
//            completionHandler(nil);
//        }
        //Above used through exercise 32
        
        //Below for Exercise 33 and beyond
        [self populateDataWithParameters:parameters completionHandler:^(NSError *error) {
            self.isLoadingOlderItems = NO;
            
            if (completionHandler) {
                completionHandler(error);
            }
        }];
        //Above for Exercise 33 and beyond
    }
}
//Above for Exercise 31 and beyond

//Below for Exercise 32 and beyond

+ (NSString *) instagramClientID {
    return @"960ec6009fe44fd4b5706a6bde466d28";
}

////Below for Exercise 32
//- (void) populateDataWithParameters:(NSDictionary *)parameters {
//Above for Exercise 32
    
//Below for Exercise 33 and beyond
- (void) populateDataWithParameters:(NSDictionary *)parameters completionHandler:(BLCNewItemCompletionBlock)completionHandler {
//Above for Exercise 33 and beyond
    if (self.accessToken) {
        // only try to get the data if there's an access token
        
        //Below used Through Exercise 35
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            // do the network request in the background, so the UI doesn't lock up
            
            NSMutableString *urlString = [NSMutableString stringWithFormat:@"https://api.instagram.com/v1/users/self/feed?access_token=%@", self.accessToken];
            
            for (NSString *parameterName in parameters) {
                // for example, if dictionary contains {count: 50}, append `&count=50` to the URL
                [urlString appendFormat:@"&%@=%@", parameterName, parameters[parameterName]];
            }
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            if (url) {
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                NSURLResponse *response;
                NSError *webError;
                NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&webError];
                
                //Below for Exercise 32 only
//                NSError *jsonError;
//                NSDictionary *feedDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
//                
//                if (feedDictionary) {
                //Above for Exercise 32 only
                
                //Below for Exercise 33 and Beyond
                if (responseData) {
                    NSError *jsonError;
                    NSDictionary *feedDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
                        
                    if (feedDictionary) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                                // done networking, go back on the main thread
                            [self parseDataFromFeedDictionary:feedDictionary fromRequestWithParameters:parameters];
                            if (completionHandler) {
                                completionHandler(nil);
                            }
                        });
                    } else if (completionHandler) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completionHandler(jsonError);
                        });
                    }
                } else if (completionHandler) {
                //Above for Exercise 33 and Beyond
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        //Below for Exercise 32 only
//                        [self parseDataFromFeedDictionary:feedDictionary fromRequestWithParameters:parameters];
                        //Above for Exercise 32 only
                        
                        //Below for Exercise 33 and Beyond
                        completionHandler(webError);
                        //Above for Exercise 33 and Beyond
                    });
                }
            }
        });
        //Above used Through Exercise 35
        
        //Below for Exercise 36 and Beyond
//        NSMutableDictionary *mutableParameters = [@{@"access_token": self.accessToken} mutableCopy];
//        
//        [mutableParameters addEntriesFromDictionary:parameters];
//        
//        [self.instagramOperationManager GET:@"users/self/feed"
//                                 parameters:mutableParameters
//                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//                                            [self parseDataFromFeedDictionary:responseObject fromRequestWithParameters:parameters];
//                                            
//                                            if (completionHandler) {
//                                                completionHandler(nil);
//                                            }
//                                        }
//                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                        if (completionHandler) {
//                                            completionHandler(error);
//                                        }
//                                    }];
        //Above for Exercise 36 and Beyond
    }
}

- (void) parseDataFromFeedDictionary:(NSDictionary *) feedDictionary fromRequestWithParameters:(NSDictionary *)parameters {
    //Below for Exercise 32 Only
//    NSLog(@"%@", feedDictionary);
    //Above for Exercise 32 Only
    
////Below for Exercise 33 and Beyond
    NSArray *mediaArray = feedDictionary[@"data"];
    
    NSMutableArray *tmpMediaItems = [NSMutableArray array];
    
    for (NSDictionary *mediaDictionary in mediaArray) {
        BLCMedia *mediaItem = [[BLCMedia alloc] initWithDictionary:mediaDictionary];
        
        if (mediaItem) {
            [tmpMediaItems addObject:mediaItem];
            
            //Below used Through Exercise 37
            [self downloadImageForMediaItem:mediaItem];
            //Above used Through Exercise 37
        }
    }
    
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
    
    if (parameters[@"min_id"]) {
        // This was a pull-to-refresh request
        
        NSRange rangeOfIndexes = NSMakeRange(0, tmpMediaItems.count);
        NSIndexSet *indexSetOfNewObjects = [NSIndexSet indexSetWithIndexesInRange:rangeOfIndexes];
        
        [mutableArrayWithKVO insertObjects:tmpMediaItems atIndexes:indexSetOfNewObjects];
    } else if (parameters[@"max_id"]) {
        // This was an infinite scroll request
        
        if (tmpMediaItems.count == 0) {
            // disable infinite scroll, since there are no more older messages
            self.thereAreNoMoreOlderMessages = YES;
        }
        
        [mutableArrayWithKVO addObjectsFromArray:tmpMediaItems];
    } else {
        [self willChangeValueForKey:@"mediaItems"];
        self.mediaItems = tmpMediaItems;
        [self didChangeValueForKey:@"mediaItems"];
    }
//Above for Exercise 33 and Beyond
    
    //Below for Exercise 34 and Beyond
    if (tmpMediaItems.count > 0) {
        // Write the changes to disk
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSUInteger numberOfItemsToSave = MIN(self.mediaItems.count, 50);
            NSArray *mediaItemsToSave = [self.mediaItems subarrayWithRange:NSMakeRange(0, numberOfItemsToSave)];
            
            NSString *fullPath = [self pathForFilename:NSStringFromSelector(@selector(mediaItems))];
            NSData *mediaItemData = [NSKeyedArchiver archivedDataWithRootObject:mediaItemsToSave];
            
            NSError *dataError;
            BOOL wroteSuccessfully = [mediaItemData writeToFile:fullPath options:NSDataWritingAtomic | NSDataWritingFileProtectionCompleteUnlessOpen error:&dataError];
            
            if (!wroteSuccessfully) {
                NSLog(@"Couldn't write file: %@", dataError);
            }
        });
        
    }
    //Above for Exercise 34 and Beyond
}
//Above for Exercise 32 and beyond

//Below for Exercise 33 and Beyond
- (void) downloadImageForMediaItem:(BLCMedia *)mediaItem {
    if (mediaItem.mediaURL && !mediaItem.image) {
        
        //Below Used Through Exercise 35
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURLRequest *request = [NSURLRequest requestWithURL:mediaItem.mediaURL];
            
            NSURLResponse *response;
            NSError *error;
            NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            if (imageData) {
                UIImage *image = [UIImage imageWithData:imageData];
                
                if (image) {
                    mediaItem.image = image;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
                        NSUInteger index = [mutableArrayWithKVO indexOfObject:mediaItem];
                        [mutableArrayWithKVO replaceObjectAtIndex:index withObject:mediaItem];
                    });
                }
            } else {
                NSLog(@"Error downloading image: %@", error);
            }
        });
        //Above Used Through Exercise 35
        
        //Below for Exercise 37 and Beyond
//        mediaItem.downloadState = BLCMediaDownloadStateDownloadInProgress;
        //Above for Exercise 37 and Beyond
        
        //Below for Exercise 36 and Beyond
//        [self.instagramOperationManager GET:mediaItem.mediaURL.absoluteString
//                                 parameters:nil
//                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                        if ([responseObject isKindOfClass:[UIImage class]]) {
//                                            mediaItem.image = responseObject;
//                                            
//                                            //Below for Exercise 37 and Beyond
//                                            mediaItem.downloadState = BLCMediaDownloadStateHasImage;
//                                            //Above for Exercise 37 and Beyond
//                                            
//                                            NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
//                                            NSUInteger index = [mutableArrayWithKVO indexOfObject:mediaItem];
//                                            [mutableArrayWithKVO replaceObjectAtIndex:index withObject:mediaItem];
//                                            
//                                            //Below for Exercise 37 and Beyond
//                                        } else {
//                                            mediaItem.downloadState = BLCMediaDownloadStateNonRecoverableError;
//                                            //Above for Exercise 37 and Beyond
//                                        }
//                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                        NSLog(@"Error downloading image: %@", error);
//                                        
//                                        //Below for Exercise 37 and Beyond
//                                        mediaItem.downloadState = BLCMediaDownloadStateNonRecoverableError;
//                                        
//                                        if ([error.domain isEqualToString:NSURLErrorDomain]) {
//                                            // A networking problem
//                                            if (error.code == NSURLErrorTimedOut ||
//                                                error.code == NSURLErrorCancelled ||
//                                                error.code == NSURLErrorCannotConnectToHost ||
//                                                error.code == NSURLErrorNetworkConnectionLost ||
//                                                error.code == NSURLErrorNotConnectedToInternet ||
//                                                error.code == kCFURLErrorInternationalRoamingOff ||
//                                                error.code == kCFURLErrorCallIsActive ||
//                                                error.code == kCFURLErrorDataNotAllowed ||
//                                                error.code == kCFURLErrorRequestBodyStreamExhausted) {
//                                                
//                                                // It might work if we try again
//                                                mediaItem.downloadState = BLCMediaDownloadStateNeedsImage;
//                                            }
//                                        }
//                                        //Above for Exercise 37 and Beyond
//                                    }];
        //Above for Exercise 36 and Beyond
    }
}
//Above for Exercise 33 and Beyond

//Below for Exercise 34 and Beyond
- (NSString *) pathForFilename:(NSString *) filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:filename];
    return dataPath;
}
//Above for Exercise 34 and Beyond

//Below for Exercise 38 and Beyond
//#pragma mark - Liking Media Items
//
//- (void) toggleLikeOnMediaItem:(BLCMedia *)mediaItem {
//    NSString *urlString = [NSString stringWithFormat:@"media/%@/likes", mediaItem.idNumber];
//    NSDictionary *parameters = @{@"access_token": self.accessToken};
//    
//    if (mediaItem.likeState == BLCLikeStateNotLiked) {
//        
//        mediaItem.likeState = BLCLikeStateLiking;
//        
//        [self.instagramOperationManager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            mediaItem.likeState = BLCLikeStateLiked;
//            [self reloadMediaItem:mediaItem];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            mediaItem.likeState = BLCLikeStateNotLiked;
//            [self reloadMediaItem:mediaItem];
//        }];
//        
//    } else if (mediaItem.likeState == BLCLikeStateLiked) {
//        
//        mediaItem.likeState = BLCLikeStateUnliking;
//        
//        [self.instagramOperationManager DELETE:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            mediaItem.likeState = BLCLikeStateNotLiked;
//            [self reloadMediaItem:mediaItem];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            mediaItem.likeState = BLCLikeStateLiked;
//            [self reloadMediaItem:mediaItem];
//        }];
//        
//    }
//    
//    [self reloadMediaItem:mediaItem];
//}
//
//- (void) reloadMediaItem:(BLCMedia *)mediaItem {
//    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
//    NSUInteger index = [mutableArrayWithKVO indexOfObject:mediaItem];
//    [mutableArrayWithKVO replaceObjectAtIndex:index withObject:mediaItem];
//}
//Above for Exercise 38 and Beyond

//Below for Exercise 39 and Beyond
//#pragma mark - Comments
//
//- (void) commentOnMediaItem:(BLCMedia *)mediaItem withCommentText:(NSString *)commentText {
//    if (!commentText || commentText.length == 0) {
//        return;
//    }
//    
//    NSString *urlString = [NSString stringWithFormat:@"media/%@/comments", mediaItem.idNumber];
//    NSDictionary *parameters = @{@"access_token": self.accessToken, @"text": commentText};
//    
//    [self.instagramOperationManager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        mediaItem.temporaryComment = nil;
//        
//        NSString *refreshMediaUrlString = [NSString stringWithFormat:@"media/%@", mediaItem.idNumber];
//        NSDictionary *parameters = @{@"access_token": self.accessToken};
//        [self.instagramOperationManager GET:refreshMediaUrlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            BLCMedia *newMediaItem = [[BLCMedia alloc] initWithDictionary:responseObject];
//            NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
//            NSUInteger index = [mutableArrayWithKVO indexOfObject:mediaItem];
//            [mutableArrayWithKVO replaceObjectAtIndex:index withObject:newMediaItem];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [self reloadMediaItem:mediaItem];
//        }];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        NSLog(@"Response: %@", operation.responseString);
//        [self reloadMediaItem:mediaItem];
//    }];
//}
//Above for Exercise 39 and Beyond

@end
