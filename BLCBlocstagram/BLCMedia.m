//
//  BLCMedia.m
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCMedia.h"
#import "BLCUser.h"
#import "BLCComment.h"

@implementation BLCMedia

//Below for Exercise 33 and Beyond
- (instancetype) initWithDictionary:(NSDictionary *)mediaDictionary {
    self = [super init];
    
    if (self) {
        self.idNumber = mediaDictionary[@"id"];
        self.user = [[BLCUser alloc] initWithDictionary:mediaDictionary[@"user"]];
        NSString *standardResolutionImageURLString = mediaDictionary[@"images"][@"standard_resolution"][@"url"];
        NSURL *standardResolutionImageURL = [NSURL URLWithString:standardResolutionImageURLString];
        
        if (standardResolutionImageURL) {
            self.mediaURL = standardResolutionImageURL;
            
        //Below for Exercise 37 and Beyond
//            self.downloadState = BLCMediaDownloadStateNeedsImage;
//        } else {
//            self.downloadState = BLCMediaDownloadStateNonRecoverableError;
        //Above for Exercise 37 and Beyond
        }
        
        NSDictionary *captionDictionary = mediaDictionary[@"caption"];
        
        // Caption might be null (if there's no caption)
        if ([captionDictionary isKindOfClass:[NSDictionary class]]) {
            self.caption = captionDictionary[@"text"];
        } else {
            self.caption = @"";
        }
        
        NSMutableArray *commentsArray = [NSMutableArray array];
        
        for (NSDictionary *commentDictionary in mediaDictionary[@"comments"][@"data"]) {
            BLCComment *comment = [[BLCComment alloc] initWithDictionary:commentDictionary];
            [commentsArray addObject:comment];
        }
        
        self.comments = commentsArray;
        
        //Below for Exercise 38 and Beyond
//        BOOL userHasLiked = [mediaDictionary[@"user_has_liked"] boolValue];
//        
//        self.likeState = userHasLiked ? BLCLikeStateLiked : BLCLikeStateNotLiked;
        //Above for Exercise 38 and Beyond
    }
    
    return self;
}
//Above for Exercise 33 and Beyond

//Below for Exercise 34 and Beyond
#pragma mark - NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        self.idNumber = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(idNumber))];
        self.user = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(user))];
        self.mediaURL = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(mediaURL))];
        self.image = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(image))];
        
        //Below for Exercise 37 and Beyond
//        if (self.image) {
//            self.downloadState = BLCMediaDownloadStateHasImage;
//        } else if (self.mediaURL) {
//            self.downloadState = BLCMediaDownloadStateNeedsImage;
//        } else {
//            self.downloadState = BLCMediaDownloadStateNonRecoverableError;
//        }
        //Above for Exercise 37 and Beyond
        
        self.caption = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(caption))];
        self.comments = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(comments))];
        
        //Below for Exercise 38 and Beyond
//        self.likeState = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(likeState))];
        //Above for Exercise 38 and Beyond
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.idNumber forKey:NSStringFromSelector(@selector(idNumber))];
    [aCoder encodeObject:self.user forKey:NSStringFromSelector(@selector(user))];
    [aCoder encodeObject:self.mediaURL forKey:NSStringFromSelector(@selector(mediaURL))];
    [aCoder encodeObject:self.image forKey:NSStringFromSelector(@selector(image))];
    [aCoder encodeObject:self.caption forKey:NSStringFromSelector(@selector(caption))];
    [aCoder encodeObject:self.comments forKey:NSStringFromSelector(@selector(comments))];
    
    //Below for Exercise 38 and Beyond
//    [aCoder encodeInteger:self.likeState forKey:NSStringFromSelector(@selector(likeState))];
    //Above for Exercise 38 and Beyond
    
}
//Above for Exercise 34 and Beyond

@end
