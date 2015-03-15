//
//  BLCMediaTableViewCell.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/10/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

//For exercise 28 and beyond

//Below used Through Exercise 34
//@class BLCMedia;
//Above used Through Exercise 34

//Below for Exercise 35 and Beyond
@class BLCMedia, BLCMediaTableViewCell;

@protocol BLCMediaTableViewCellDelegate <NSObject>

- (void) cell:(BLCMediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;
- (void) cell:(BLCMediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;

@end
//Above for Exercise 35 and Beyond

@interface BLCMediaTableViewCell : UITableViewCell

@property (nonatomic, strong) BLCMedia *mediaItem;

//Below for Exercise 35 and Beyond
@property (nonatomic, weak) id <BLCMediaTableViewCellDelegate> delegate;
//Above for Exercise 35 and Beyond

+ (CGFloat) heightForMediaItem:(BLCMedia *)mediaItem width:(CGFloat)width;

@end
