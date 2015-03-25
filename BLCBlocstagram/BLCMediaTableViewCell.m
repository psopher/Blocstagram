//
//  BLCMediaTableViewCell.m
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/10/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//


#import "BLCMediaTableViewCell.h"
#import "BLCMedia.h"
#import "BLCComment.h"
#import "BLCUser.h"
#import "BLCDatasource.h"

#import "BLCLikeButton.h"

//Below for Exercise 39 and Beyond
//#import "BLCComposeCommentView.h"
//Above for Exercise 39 and Beyond

//Below for Exercise 43 and Beyond
//#define isPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//Above for Exercise 43 and Beyond

//Below for Exercise 35 Through Exercise 38
@interface BLCMediaTableViewCell () <UIGestureRecognizerDelegate>
//Above for Exercise Through Exercise 38

//Below for Exercise 39 and Beyond
//@interface BLCMediaTableViewCell () <UIGestureRecognizerDelegate, BLCComposeCommentViewDelegate>
//Above for Exercise 39 and Beyond

@property (nonatomic, strong) UIImageView *mediaImageView;
@property (nonatomic, strong) UILabel *usernameAndCaptionLabel;
@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) NSLayoutConstraint *imageHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *usernameAndCaptionLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *commentLabelHeightConstraint;

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;

@property (nonatomic, strong) UITapGestureRecognizer *doubleTouch;

@property (nonatomic, strong) BLCLikeButton *likeButton;

//Below for Exercise 39 and Beyond
//@property (nonatomic, strong) BLCComposeCommentView *commentView;
//Above for Exercise 39 and Beyond

@end

static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *usernameLabelGray;
static UIColor *commentLabelGray;
static UIColor *linkColor;
static NSParagraphStyle *paragraphStyle;

@implementation BLCMediaTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mediaImageView = [[UIImageView alloc] init];
        
        self.mediaImageView.userInteractionEnabled = YES;
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
        self.tapGestureRecognizer.delegate = self;
        [self.mediaImageView addGestureRecognizer:self.tapGestureRecognizer];
        
        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressFired:)];
        self.longPressGestureRecognizer.delegate = self;
        [self.mediaImageView addGestureRecognizer:self.longPressGestureRecognizer];
        
        self.doubleTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTouchFired:)];
        self.doubleTouch.numberOfTouchesRequired = 2;
        
        [self addGestureRecognizer:self.doubleTouch];
        
        self.usernameAndCaptionLabel = [[UILabel alloc] init];
        self.commentLabel = [[UILabel alloc] init];
        self.commentLabel.numberOfLines = 0;
        
        self.likeButton = [[BLCLikeButton alloc] init];
        [self.likeButton addTarget:self action:@selector(likePressed:) forControlEvents:UIControlEventTouchUpInside];
        self.likeButton.backgroundColor = usernameLabelGray;
        
        //Below for Exercise 39 and Beyond
//        self.commentView = [[BLCComposeCommentView alloc] init];
//        self.commentView.delegate = self;
        //Above for Exercise 39 and Beyond
        
        //Below for Exercise 38 only
        for (UIView *view in @[self.mediaImageView, self.usernameAndCaptionLabel, self.commentLabel, self.likeButton]) {
        //Above for Exercise 38 only
        
        //Below for Exercise 39 and Beyond
//        for (UIView *view in @[self.mediaImageView, self.usernameAndCaptionLabel, self.commentLabel, self.likeButton, self.commentView]) {
        //Above for Exercise 39 and Beyond
        
            
            [self.contentView addSubview:view];
            
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        //Below for Exercise 38 only
        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_mediaImageView, _usernameAndCaptionLabel, _commentLabel, _likeButton);
        //Above for Exercise 38 only
        
        //Below for Exercise 39 Through 42
//        NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_mediaImageView, _usernameAndCaptionLabel, _commentLabel, _likeButton, _commentView);
        //Above for Exercise 39 Through 42
        
        //Below for Exercise 29 Through 42
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mediaImageView]|" options:kNilOptions metrics:nil views:viewDictionary]];
        //Above for Exercise 29 Through 42
        
        //Below for Exercise 43 and Beyond
//        [self createConstraints];
        //Above for Exercise 43 and Beyond
        
        //Below for Exercise 38 Through 42
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_usernameAndCaptionLabel][_likeButton(==38)]|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:viewDictionary]];
        //Above for Exercise 38 Through 42
        
        //Below for Exercise 29 Through 42
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_commentLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
        //Above for Exercise 29 Through 42
        
        //Below for Exercise 39 Through 42
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_commentView]|" options:kNilOptions metrics:nil views:viewDictionary]];
        //Above for Exercise 39 Through 42
        
        //Below for Exercise 29 Through Exercise 38
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mediaImageView][_usernameAndCaptionLabel][_commentLabel]"
        //Above for Exercise 29 Through Exercise 38
                                          
        //Below for Exercise 39 Through 42
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mediaImageView][_usernameAndCaptionLabel][_commentLabel][_commentView(==100)]"
        //Above for Exercise 39 Through 42
        
        //Below for Exercise 29 Through 42
                                                                                 options:kNilOptions
                                                                                 metrics:nil
                                                                                   views:viewDictionary]];
        
        self.imageHeightConstraint = [NSLayoutConstraint constraintWithItem:_mediaImageView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:368];
        
        
        self.usernameAndCaptionLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_usernameAndCaptionLabel
                                                                                    attribute:NSLayoutAttributeHeight
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:nil
                                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                                   multiplier:1
                                                                                     constant:100];
        
        self.commentLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_commentLabel
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:100];
        
        [self.contentView addConstraints:@[self.imageHeightConstraint, self.usernameAndCaptionLabelHeightConstraint, self.commentLabelHeightConstraint]];
        //Above for exercise 29 Through 42
    }
    return self;
}

//Below for Exercise 43 and Beyond
//- (void) createCommonConstraints {
//    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_mediaImageView, _usernameAndCaptionLabel, _commentLabel, _likeButton, _commentView);
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_usernameAndCaptionLabel][_likeButton(==38)]|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:viewDictionary]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_commentLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_commentView]|" options:kNilOptions metrics:nil views:viewDictionary]];
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mediaImageView][_usernameAndCaptionLabel][_commentLabel][_commentView(==100)]"
//                                                                             options:kNilOptions
//                                                                             metrics:nil
//                                                                               views:viewDictionary]];
//    
//    self.imageHeightConstraint = [NSLayoutConstraint constraintWithItem:_mediaImageView
//                                                              attribute:NSLayoutAttributeHeight
//                                                              relatedBy:NSLayoutRelationEqual
//                                                                 toItem:nil
//                                                              attribute:NSLayoutAttributeNotAnAttribute
//                                                             multiplier:1
//                                                               constant:100];
//    
//    
//    self.usernameAndCaptionLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_usernameAndCaptionLabel
//                                                                                attribute:NSLayoutAttributeHeight
//                                                                                relatedBy:NSLayoutRelationEqual
//                                                                                   toItem:nil
//                                                                                attribute:NSLayoutAttributeNotAnAttribute
//                                                                               multiplier:1
//                                                                                 constant:100];
//    
//    self.commentLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_commentLabel
//                                                                     attribute:NSLayoutAttributeHeight
//                                                                     relatedBy:NSLayoutRelationEqual
//                                                                        toItem:nil
//                                                                     attribute:NSLayoutAttributeNotAnAttribute
//                                                                    multiplier:1
//                                                                      constant:100];
//    
//    [self.contentView addConstraints:@[self.imageHeightConstraint, self.usernameAndCaptionLabelHeightConstraint, self.commentLabelHeightConstraint]];
//}
//Above for Exercise 43 and Beyond

+ (void)load {
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    usernameLabelGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1];
    commentLabelGray = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1];
    linkColor = [UIColor colorWithRed:0.345 green:0.324 blue:0.427 alpha:1];
    
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -20.0;
    mutableParagraphStyle.paragraphSpacingBefore = 5;
    
    paragraphStyle = mutableParagraphStyle;
}

- (NSAttributedString *) usernameAndCaptionString {
    CGFloat usernameFontSize = 15;
    
    NSString *baseString = [NSString stringWithFormat:@"%@ %@", self.mediaItem.user.userName, self.mediaItem.caption];
    
    NSMutableAttributedString *mutableUsernameAndCaptionString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:usernameFontSize], NSParagraphStyleAttributeName : paragraphStyle}];
    
    NSRange usernameRange = [baseString rangeOfString:self.mediaItem.user.userName];
    [mutableUsernameAndCaptionString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:usernameFontSize] range:usernameRange];
    [mutableUsernameAndCaptionString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
    
    return mutableUsernameAndCaptionString;
}

- (NSAttributedString *) commentString {
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] init];
    
    for (BLCComment *comment in self.mediaItem.comments) {
        NSString *baseString = [NSString stringWithFormat:@"%@ %@\n", comment.from.userName, comment.text];
        
        NSMutableAttributedString *oneCommentString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : lightFont, NSParagraphStyleAttributeName : paragraphStyle}];
        
        NSRange usernameRange = [baseString rangeOfString:comment.from.userName];
        [oneCommentString addAttribute:NSFontAttributeName value:boldFont range:usernameRange];
        [oneCommentString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
        
        [commentString appendAttributedString:oneCommentString];
    }
    
    return commentString;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
    CGSize usernameLabelSize = [self.usernameAndCaptionLabel sizeThatFits:maxSize];
    CGSize commentLabelSize = [self.commentLabel sizeThatFits:maxSize];
    
    self.usernameAndCaptionLabelHeightConstraint.constant = usernameLabelSize.height + 20;
    self.commentLabelHeightConstraint.constant = commentLabelSize.height + 20;
    
    if (_mediaItem.image) {
        
        //Below used Through Exercise 42
        self.imageHeightConstraint.constant = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
        //Above used Through Exercise 42
        
        //Below for Exercise 43 and Beyond
//        if (isPhone) {
//            self.imageHeightConstraint.constant = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
//        } else {
//            self.imageHeightConstraint.constant = 320;
//        }
        //Above for Exercise 43 and Beyond
    } else {
        self.imageHeightConstraint.constant = CGRectGetWidth(self.contentView.bounds);
    }
    
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(self.bounds));
}

- (void) setMediaItem:(BLCMedia *)mediaItem {
    _mediaItem = mediaItem;
    self.mediaImageView.image = _mediaItem.image;
    self.usernameAndCaptionLabel.attributedText = [self usernameAndCaptionString];
    self.commentLabel.attributedText = [self commentString];
    
    self.likeButton.likeButtonState = mediaItem.likeState;
    
    //Below for Exercise 39 and Beyond
//    self.commentView.text = mediaItem.temporaryComment;
    //Above for Exercise 39 and Beyond
}

+ (CGFloat) heightForMediaItem:(BLCMedia *)mediaItem width:(CGFloat)width {
    BLCMediaTableViewCell *layoutCell = [[BLCMediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
    
    layoutCell.mediaItem = mediaItem;
    
    //Below is for Exercise 29 and beyond
    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));
    
    [layoutCell setNeedsLayout];
    [layoutCell layoutIfNeeded];
    //Above is for Exercise 29 and beyond
    
    //Below used Through Exercise 38
    return CGRectGetMaxY(layoutCell.commentLabel.frame);
    //Above used Through Exercise 38
    
    //Below for Exercise 39 and Beyond
//    return CGRectGetMaxY(layoutCell.commentView.frame);
    //Above for Exercise 39 and Beyond
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:NO animated:animated];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:NO animated:animated];
}

#pragma mark - Liking

- (void) likePressed:(UIButton *)sender {
    [self.delegate cellDidPressLikeButton:self];
}
                                          
//Below for Exercise 39 and Beyond
//#pragma mark - BLCComposeCommentViewDelegate
//                                          
//- (void) commentViewDidPressCommentButton:(BLCComposeCommentView *)sender {
//    [self.delegate cell:self didComposeComment:self.mediaItem.temporaryComment];
//}
//                                          
//- (void) commentView:(BLCComposeCommentView *)sender textDidChange:(NSString *)text {
//    self.mediaItem.temporaryComment = text;
//}
//                                          
//- (void) commentViewWillStartEditing:(BLCComposeCommentView *)sender {
//    [self.delegate cellWillStartComposingComment:self];
//}
//                                          
//- (void) stopComposingComment {
//    [self.commentView stopComposingComment];
//}
//Above for Exercise 39 and Beyond

#pragma mark - Image View

- (void) tapFired:(UITapGestureRecognizer *)sender {
    [self.delegate cell:self didTapImageView:self.mediaImageView];
}

- (void) longPressFired:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.delegate cell:self didLongPressImageView:self.mediaImageView];
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.isEditing == NO;
}

- (void) doubleTouchFired:(UITapGestureRecognizer *)sender {
    if (!self.mediaItem.image) {
        [[BLCDatasource sharedInstance] downloadImageForMediaItem:self.mediaItem];
    }
}

//Below for Exercise 43 and Beyond
//- (void) createConstraints {
//    if (isPhone) {
//        [self createPhoneConstraints];
//    } else {
//        [self createPadConstraints];
//    }
//    
//    [self createCommonConstraints];
//}
//
//- (void) createPadConstraints {
//    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_mediaImageView, _usernameAndCaptionLabel, _commentLabel, _likeButton, _commentView);
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_mediaImageView(==320)]" options:kNilOptions metrics:nil views:viewDictionary]];
//    [self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:self.contentView
//                                                                  attribute:NSLayoutAttributeCenterX
//                                                                  relatedBy:0
//                                                                     toItem:_mediaImageView
//                                                                  attribute:NSLayoutAttributeCenterX
//                                                                 multiplier:1
//                                                                   constant:0]];
//    
//}
//
//- (void) createPhoneConstraints {
//    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_mediaImageView, _usernameAndCaptionLabel, _commentLabel, _likeButton, _commentView);
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mediaImageView]|" options:kNilOptions metrics:nil views:viewDictionary]];
//}
//Above for Exercise 43 and Beyond

@end
