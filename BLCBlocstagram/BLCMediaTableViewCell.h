//
//  BLCMediaTableViewCell.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/10/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

//Below/ for Exercise 35 Through Exercise 38
@class BLCMedia, BLCMediaTableViewCell;
//Above for Exercise 35 Through Exercise 38

//Below for Exercise 39 and Beyond
//@class BLCMedia, BLCMediaTableViewCell, BLCComposeCommentView;
//Above for Exercise 39 and Beyond

@protocol BLCMediaTableViewCellDelegate <NSObject>

- (void) cell:(BLCMediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;
- (void) cell:(BLCMediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;

- (void) cellDidPressLikeButton:(BLCMediaTableViewCell *)cell;

//Below for Exercise 39 and Beyond
//- (void) cellWillStartComposingComment:(BLCMediaTableViewCell *)cell;
//- (void) cell:(BLCMediaTableViewCell *)cell didComposeComment:(NSString *)comment;
//Above for Exercise 39 and Beyond

@end

@interface BLCMediaTableViewCell : UITableViewCell

@property (nonatomic, strong) BLCMedia *mediaItem;

@property (nonatomic, weak) id <BLCMediaTableViewCellDelegate> delegate;

//Below for Exercise 39 and Beyond
//@property (nonatomic, strong, readonly) BLCComposeCommentView *commentView;
//Above for Exercise 39 and Beyond

+ (CGFloat) heightForMediaItem:(BLCMedia *)mediaItem width:(CGFloat)width;

//Below for Exercise 39 and Beyond
//- (void) stopComposingComment;
//Above for Exercise 39 and Beyond

@end
