//
//  BLCMediaTableViewCell.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/10/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCMedia, BLCMediaTableViewCell, BLCComposeCommentView;

@protocol BLCMediaTableViewCellDelegate <NSObject>

- (void) cell:(BLCMediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;
- (void) cell:(BLCMediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;

- (void) cellDidPressLikeButton:(BLCMediaTableViewCell *)cell;

- (void) cellWillStartComposingComment:(BLCMediaTableViewCell *)cell;
- (void) cell:(BLCMediaTableViewCell *)cell didComposeComment:(NSString *)comment;

@end

@interface BLCMediaTableViewCell : UITableViewCell

@property (nonatomic, strong) BLCMedia *mediaItem;

@property (nonatomic, weak) id <BLCMediaTableViewCellDelegate> delegate;

@property (nonatomic, strong, readonly) BLCComposeCommentView *commentView;

@property (nonatomic, strong) UIImageView *mediaImageView;

+ (CGFloat) heightForMediaItem:(BLCMedia *)mediaItem width:(CGFloat)width;

- (void) stopComposingComment;

@end
