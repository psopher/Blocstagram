//
//  BLCImagesTableViewController.m
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCImagesTableViewController.h"

//Below for exercise 27 and beyond
#import "BLCDatasource.h"
#import "BLCMedia.h"
#import "BLCUser.h"
#import "BLCComment.h"
//Above for exercise 27 and beyond

//Below for exercise 28 and beyond
#import "BLCMediaTableViewCell.h"
//Above for exercise 28 and beyond

//Below for Exercise 35 and Beyond
#import "BLCMediaFullScreenViewController.h"
#import "BLCMediaFullScreenAnimator.h"
//Above for Exercise 35 and Beyond

//Below for Exercise 40 and Beyond
//#import "BLCCameraViewController.h"
//Above for Exercise 40 and Beyond

//Below for Exercise 41 and Beyond
//#import "BLCImageLibraryViewController.h"
//Above for Exercise 41 and Beyond

//Below for Exercise 42 and Beyond
//#import "BLCPostToInstagramViewController.h"
//Above for Exercise 42 and Beyond

//Below for Exercise 43 and Beyond
//#define isPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//Above for Exercise 43 and Beyond

//Below used Through Exercise 34
//@interface BLCImagesTableViewController ()
//Above used Through Exercise 34

//Below for Exercise 35 and 39
@interface BLCImagesTableViewController () <BLCMediaTableViewCellDelegate, UIViewControllerTransitioningDelegate>
//Above for Exercise 35 and 39

//Below for Exercise 40 only
//@interface BLCImagesTableViewController () <BLCMediaTableViewCellDelegate, UIViewControllerTransitioningDelegate, BLCCameraViewControllerDelegate>
//Above for Exercise 40 only

//Below for Exercise 41 and Beyond
//@interface BLCImagesTableViewController () <BLCMediaTableViewCellDelegate, UIViewControllerTransitioningDelegate, BLCCameraViewControllerDelegate, BLCImageLibraryViewControllerDelegate>
//Above for Exercise 41 and Beyond

//Below for Exercise 35 and Beyond
@property (nonatomic, weak) UIImageView *lastTappedImageView;
//Above for Exercise 35 and Beyond

//Below for Exercise 39 and Beyond
//@property (nonatomic, weak) UIView *lastSelectedCommentView;
//@property (nonatomic, assign) CGFloat lastKeyboardAdjustment;
//Above for Exercise 39 and Beyond

//Below for Exercise 43 and Beyond
//@property (nonatomic, strong) UIPopoverController *cameraPopover;
//Above for Exercise 43 and Beyond

@end

@implementation BLCImagesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    
    self = [super initWithStyle:style];
    if (self) {
        //Below for exercise 26 only
//        self.images = [NSMutableArray array];
        //Above for exercise 26 only
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Below for exercise 26 only
//    for (int i = 1; i <= 10; i++) {
//        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
//        UIImage *image = [UIImage imageNamed:imageName];
//        if (image) {
//            [self.images addObject:image];
//        }
//    }
    //Above for exercise 26 only
    
    //Below for exercises 26 and 27
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];
    //Above for exercises 26 and 27
    
    //Below for Exercise 30 and beyond
    [[BLCDatasource sharedInstance] addObserver:self forKeyPath:@"mediaItems" options:0 context:nil];
    //Above for Exercise 30 and beyond
    
    //Below for Exercise 31 and beyond
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidFire:) forControlEvents:UIControlEventValueChanged];
    //Above for Exercise 31 and beyond
    
    //Below is Assignment for Exercise 34. Stays in Code for Exercise 34 and Beyond
    
    //I think this method works, but it would be easier if I could just call the refreshControlDidFire: method
    //Above is Assignment for Exercise 34. Stays in Code for Exercise 34 and Beyond
    
    //Below for exercise 28 and beyond
    [self.tableView registerClass:[BLCMediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
    //Above for exercise 28 and beyond
    
    //Below for Exercise 39 and Beyond
//    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    //Above for Exercise 39 and Beyond
    
    //Below for Exercise 40 and Beyond
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ||
//        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
//        UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraPressed:)];
//        self.navigationItem.rightBarButtonItem = cameraButton;
//    }
    //Above for Exercise 40 and Beyond
    
    //Below for Exercise 39 and Beyond
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
    //Above for Exercise 39 and Beyond
    
    //Below for Exercise 43 and Beyond
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(imageDidFinish:)
//                                                 name:BLCImageFinishedNotification
//                                               object:nil];
    //Above for Exercise 43 and Beyond
    
}

//Below for Exercise 33 and beyond
- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BLCMedia *item = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
    if (item.image) {
        //Below used Through Exercise 38
        return 350;
        //Above used Through Exercise 38
        
        //Below for Exercise 39 and Beyond
//        return 450;
        //Above for Exercise 39 and Beyond
        
    } else {
        
        //Below used Through Exercise 38
        return 150;
        //Above used Through Exercise 38
        
        //Below for Exercise 39 and Beyond
//        return 250;
        //Above for Exercise 39 and Beyond
    }
}
//Above for Exercise 33 and beyond

//Below for Exercise 31 and beyond
- (void) refreshControlDidFire:(UIRefreshControl *) sender {
    [[BLCDatasource sharedInstance] requestNewItemsWithCompletionHandler:^(NSError *error) {
        [sender endRefreshing];
    }];
}
//Above for Exercise 31 and beyond

//Below for exercise 30 and beyond
- (void) dealloc
{
    [[BLCDatasource sharedInstance] removeObserver:self forKeyPath:@"mediaItems"];
    
    //Below is for Exercise 39 and Beyond
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //Above is for Exercise 39 and Beyond
}

//Below for Exercise 39 and Beyond
//- (void)viewWillAppear:(BOOL)animated {
//    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
//    if (indexPath) {
//        [self.tableView deselectRowAtIndexPath:indexPath animated:animated];
//    }
//}
//
//- (void) viewWillDisappear:(BOOL)animated {
//    
//}
//Above for Exercise 39 and Beyond

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [BLCDatasource sharedInstance] && [keyPath isEqualToString:@"mediaItems"]) {
        int kindOfChange = [change[NSKeyValueChangeKindKey] intValue];
        
        if (kindOfChange == NSKeyValueChangeSetting) {
            // Someone set a brand new images array
            [self.tableView reloadData];
        } else if (kindOfChange == NSKeyValueChangeInsertion ||
                   kindOfChange == NSKeyValueChangeRemoval ||
                   kindOfChange == NSKeyValueChangeReplacement) {
            // We have an incremental change: inserted, deleted, or replaced images
            
            // Get a list of the index (or indices) that changed
            NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
            
            // Convert this NSIndexSet to an NSArray of NSIndexPaths (which is what the table view animation methods require)
            NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
            [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [indexPathsThatChanged addObject:newIndexPath];
            }];
            
            // Call `beginUpdates` to tell the table view we're about to make changes
            [self.tableView beginUpdates];
            
            // Tell the table view what the changes are
            if (kindOfChange == NSKeyValueChangeInsertion) {
                [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeRemoval) {
                [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeReplacement) {
                [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            // Tell the table view that we're done telling it about changes, and to complete the animation
            [self.tableView endUpdates];
        }
    }
}
//Above for Exercise 30 and beyond

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

#pragma mark - Table view data source

//Below is Exercise 27 assignment
- (NSArray *) items {

    return [BLCDatasource sharedInstance].mediaItems;
}
//Above is Exercise 27 assignment

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //Below for exercise 26 only
//    return self.images.count;
    //Above for exercise 26 only
    
    //Below for exercise 27 and beyond
    NSLog(@"%i", [self items].count);
    return [self items].count;
//    return [BLCDatasource sharedInstance].mediaItems.count;
    //Above for exercise 27 and beyond
}

////Below for Exercise 30 and beyond
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        BLCMedia *item = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
        [[BLCDatasource sharedInstance] deleteMediaItem:item];
    }
}
//Above for Exercise 30 and beyond

//Below for Exercise 31 and beyond
- (void) infiniteScrollIfNecessary {
    NSIndexPath *bottomIndexPath = [[self.tableView indexPathsForVisibleRows] lastObject];
    
    if (bottomIndexPath && bottomIndexPath.row == [BLCDatasource sharedInstance].mediaItems.count - 1) {
        // The very last cell is on screen
        [[BLCDatasource sharedInstance] requestOldItemsWithCompletionHandler:nil];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self infiniteScrollIfNecessary];
}
//Above for Exercise 31 and beyond

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Below used for exercises 26 and 27
//    static NSInteger imageViewTag = 1234;
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
//    
//    UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:imageViewTag];
//    
//    if (!imageView) {
//        imageView = [[UIImageView alloc] init];
//        imageView.contentMode = UIViewContentModeScaleToFill;
//        
//        imageView.frame = cell.contentView.bounds;
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        
//        imageView.tag = imageViewTag;
//        [cell.contentView addSubview:imageView];
//    }
    //Above used for exercises 26 and 27
    
    //Below for exercise 26 only
//    UIImage *image = self.images[indexPath.row];
//    imageView.image = image;
    //Above for exercise 26 only
    
    //Below for exercise 27 only
//    BLCMedia *item = [self items][indexPath.row];
////    BLCMedia *item = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
//    imageView.image = item.image;
    //Above for exercise 27 only
    
    //Below for exercise 28 and beyond
    BLCMediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    //Above for exercise 28 and beyond
    
    //Below for Exercise 35 and Beyond
    cell.delegate = self;
    //Above for Exercise 35 and Beyond
    
    //Below for exercise 28 and beyond
    cell.mediaItem = [self items][indexPath.row];
    cell.mediaItem = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
    //Above for exercise 28 and beyond
    
    return cell;
}

//Below for Exercise 39 and Beyond
//- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    BLCMediaTableViewCell *cell = (BLCMediaTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    [cell stopComposingComment];
//}
//Above for Exercise 39 and Beyond

//Below for Exercise 37 and Beyond
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BLCMedia *mediaItem = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
    if (mediaItem.downloadState == BLCMediaDownloadStateNeedsImage) {
        [[BLCDatasource sharedInstance] downloadImageForMediaItem:mediaItem];
    }
}
//Above for Exercise 37 and Beyond

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Below for exercise 26 only
//    UIImage *image = self.images[indexPath.row];
//    return (CGRectGetWidth(self.view.frame) / image.size.width) * image.size.height;
    //Above for exercise 26 only
    
//    Below for exercise 27 and beyond
    BLCMedia *item = [self items][indexPath.row];
//    BLCMedia *item = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
    //Above for exercise 27 and beyond
    
    //Below for exercise 27 only
//    UIImage *image = item.image;
//    return (CGRectGetWidth(self.view.frame) / image.size.width) * image.size.height;
    //Above for exercise 27 only
    
    //Below assignment for Exercise 37. Stays in code for Exercise 37 and Beyond
//    UIImage *image = item.image;
//    BLCMedia *imageHeight = MAX(image.size.height, 150);
//    if (image) {
//        return [BLCMediaTableViewCell heightForMediaItem:imageHeight width:CGRectGetWidth(self.view.frame)];
//    } else {
    //Above assignment for Exercise 37. Stays in code for Exercise 37 and Beyond
    
    //Below for exercise 28 and beyond
    return [BLCMediaTableViewCell heightForMediaItem:item width:CGRectGetWidth(self.view.frame)];
    //Above for exercise 28 and beyond
    
    //Below assignment for Exercise 37. Stays in code for Exercise 37 and Beyond
//    }
    //Above assignment for Exercise 37. Stays in code for Exercise 37 and Beyond
}

//Below for Exercise 35 and Beyond
#pragma mark - BLCMediaTableViewCellDelegate

- (void) cell:(BLCMediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView {
    self.lastTappedImageView = imageView;
    
    BLCMediaFullScreenViewController *fullScreenVC = [[BLCMediaFullScreenViewController alloc] initWithMedia:cell.mediaItem];
    
    //Below used Through Exercise 42
    fullScreenVC.transitioningDelegate = self;
    fullScreenVC.modalPresentationStyle = UIModalPresentationCustom;
    //Above used Through Exercise 42

    //Below for Exercise 43 and Beyond
//    if (isPhone) {
//        fullScreenVC.transitioningDelegate = self;
//        fullScreenVC.modalPresentationStyle = UIModalPresentationCustom;
//    } else {
//        fullScreenVC.modalPresentationStyle = UIModalPresentationFormSheet;
//    }
    //Above for Exercise 43 and Beyond
    
    [self presentViewController:fullScreenVC animated:YES completion:nil];
}

- (void) cell:(BLCMediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView {
    NSMutableArray *itemsToShare = [NSMutableArray array];
    
    if (cell.mediaItem.caption.length > 0) {
        [itemsToShare addObject:cell.mediaItem.caption];
    }
    
    if (cell.mediaItem.image) {
        [itemsToShare addObject:cell.mediaItem.image];
    }
    
    if (itemsToShare.count > 0) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}

//Below for Exercise 38 and Beyond
//- (void) cellDidPressLikeButton:(BLCMediaTableViewCell *)cell {
//    [[BLCDatasource sharedInstance] toggleLikeOnMediaItem:cell.mediaItem];
//}
//Above for Exercise 38 and Beyond

//Below for Exercise 39 and Beyond
//- (void) cellWillStartComposingComment:(BLCMediaTableViewCell *)cell {
//    self.lastSelectedCommentView = (UIView *)cell.commentView;
//}
//
//- (void) cell:(BLCMediaTableViewCell *)cell didComposeComment:(NSString *)comment {
//    [[BLCDatasource sharedInstance] commentOnMediaItem:cell.mediaItem withCommentText:comment];
//}
//Above for Exercise 39 and Beyond

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    
    BLCMediaFullScreenAnimator *animator = [BLCMediaFullScreenAnimator new];
    animator.presenting = YES;
    animator.cellImageView = self.lastTappedImageView;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    BLCMediaFullScreenAnimator *animator = [BLCMediaFullScreenAnimator new];
    animator.cellImageView = self.lastTappedImageView;
    return animator;
}
//Above for Exercise 35 and Beyond

//Below for Exercise 39 and Beyond
//#pragma mark - Keyboard Handling
//
//- (void)keyboardWillShow:(NSNotification *)notification
//{
//    // Get the frame of the keyboard within self.view's coordinate system
//    NSValue *frameValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
//    CGRect keyboardFrameInScreenCoordinates = frameValue.CGRectValue;
//    CGRect keyboardFrameInViewCoordinates = [self.navigationController.view convertRect:keyboardFrameInScreenCoordinates fromView:nil];
//    
//    // Get the frame of the comment view in the same coordinate system
//    CGRect commentViewFrameInViewCoordinates = [self.navigationController.view convertRect:self.lastSelectedCommentView.bounds fromView:self.lastSelectedCommentView];
//    
//    CGPoint contentOffset = self.tableView.contentOffset;
//    UIEdgeInsets contentInsets = self.tableView.contentInset;
//    UIEdgeInsets scrollIndicatorInsets = self.tableView.scrollIndicatorInsets;
//    CGFloat heightToScroll = 0;
//    
//    CGFloat keyboardY = CGRectGetMinY(keyboardFrameInViewCoordinates);
//    CGFloat commentViewY = CGRectGetMinY(commentViewFrameInViewCoordinates);
//    CGFloat difference = commentViewY - keyboardY;
//    
//    if (difference > 0) {
//        heightToScroll += difference;
//    }
//    
//    if (CGRectIntersectsRect(keyboardFrameInViewCoordinates, commentViewFrameInViewCoordinates)) {
//        // The two frames intersect (the keyboard would block the view)
//        CGRect intersectionRect = CGRectIntersection(keyboardFrameInViewCoordinates, commentViewFrameInViewCoordinates);
//        heightToScroll += CGRectGetHeight(intersectionRect);
//    }
//    
//    if (heightToScroll > 0) {
//        contentInsets.bottom += heightToScroll;
//        scrollIndicatorInsets.bottom += heightToScroll;
//        contentOffset.y += heightToScroll;
//        
//        NSNumber *durationNumber = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
//        NSNumber *curveNumber = notification.userInfo[UIKeyboardAnimationCurveUserInfoKey];
//        
//        NSTimeInterval duration = durationNumber.doubleValue;
//        UIViewAnimationCurve curve = curveNumber.unsignedIntegerValue;
//        UIViewAnimationOptions options = curve << 16;
//        
//        [UIView animateWithDuration:duration delay:0 options:options animations:^{
//            self.tableView.contentInset = contentInsets;
//            self.tableView.scrollIndicatorInsets = scrollIndicatorInsets;
//            self.tableView.contentOffset = contentOffset;
//        } completion:nil];
//    }
//    
//    self.lastKeyboardAdjustment = heightToScroll;
//}
//
//- (void)keyboardWillHide:(NSNotification *)notification
//{
//    UIEdgeInsets contentInsets = self.tableView.contentInset;
//    contentInsets.bottom -= self.lastKeyboardAdjustment;
//    
//    UIEdgeInsets scrollIndicatorInsets = self.tableView.scrollIndicatorInsets;
//    scrollIndicatorInsets.bottom -= self.lastKeyboardAdjustment;
//    
//    NSNumber *durationNumber = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
//    NSNumber *curveNumber = notification.userInfo[UIKeyboardAnimationCurveUserInfoKey];
//    
//    NSTimeInterval duration = durationNumber.doubleValue;
//    UIViewAnimationCurve curve = curveNumber.unsignedIntegerValue;
//    UIViewAnimationOptions options = curve << 16;
//    
//    [UIView animateWithDuration:duration delay:0 options:options animations:^{
//        self.tableView.contentInset = contentInsets;
//        self.tableView.scrollIndicatorInsets = scrollIndicatorInsets;
//    } completion:nil];
//}
//Above for Exercise 39 and Beyond

//Below for Exercise 40 and Beyond

//#pragma mark - Camera, BLCCameraViewControllerDelegate, and BLCImageLibraryViewControllerDelegate
//
//- (void) cameraPressed:(UIBarButtonItem *) sender {
//    
//    //Below for Exercise 41 and Beyond
//    UIViewController *imageVC;
//    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//    //Above for Exercise 41 and Beyond
//    
//    BLCCameraViewController *cameraVC = [[BLCCameraViewController alloc] init];
//    cameraVC.delegate = self;
//    
//    //Below for Exercise 40 only
////    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cameraVC];
//    //Above for Exercise 40 only
//        
//    //Below for Exercise 41 and Beyond
//        imageVC = cameraVC;
//    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
//        BLCImageLibraryViewController *imageLibraryVC = [[BLCImageLibraryViewController alloc] init];
//        imageLibraryVC.delegate = self;
//        imageVC = imageLibraryVC;
//    }
//    
//    if (imageVC) {
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imageVC];
//    //Above for Exercise 41 and Beyond
//    
//    //Below Used Through Exercise 42
////    [self presentViewController:nav animated:YES completion:nil];
//    //Above Used Through Exercise 42
//        
//    //Below for Exercise 43 and Beyond
//        if (isPhone) {
//            [self presentViewController:nav animated:YES completion:nil];
//        } else {
//            self.cameraPopover = [[UIPopoverController alloc] initWithContentViewController:nav];
//            self.cameraPopover.popoverContentSize = CGSizeMake(320, 568);
//            [self.cameraPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//        }
//    //Above for Exercise 43 and Beyond
//        
//    //Below for Exercise 41 and Beyond
//    }
//    //Above for Exercise 41 and Beyond
//    
//    return;
//}
//
////Below for Exercise 42 and Beyond
//- (void) handleImage:(UIImage *)image withNavigationController:(UINavigationController *)nav {
//    if (image) {
//        BLCPostToInstagramViewController *postVC = [[BLCPostToInstagramViewController alloc] initWithImage:image];
//        
//        [nav pushViewController:postVC animated:YES];
//    } else {
//        //Below for Exercise 42 only
////        [nav dismissViewControllerAnimated:YES completion:nil];
//        //Above for Exercise 42 only
//        
//        //Below for Exercise 43 and Beyond
//        if (isPhone) {
//            [nav dismissViewControllerAnimated:YES completion:nil];
//        } else {
//            [self.cameraPopover dismissPopoverAnimated:YES];
//            self.cameraPopover = nil;
//        }
//        //Above for Exercise 43 and Beyond
//    }
//}
////Above for Exercise 42 and Beyond
//
//- (void) cameraViewController:(BLCCameraViewController *)cameraViewController didCompleteWithImage:(UIImage *)image {
//    //Below used Through Exercise 41
////    [cameraViewController dismissViewControllerAnimated:YES completion:^{
////        if (image) {
////            NSLog(@"Got an image!");
////        } else {
////            NSLog(@"Closed without an image.");
////        }
////    }];
//    //Above used Through Exercise 41
//    
//    //Below for Exercise 42 and Beyond
//    [self handleImage:image withNavigationController:cameraViewController.navigationController];
//    //Above for Exercise 42 and Beyond
//}

//Above for Exercise 40 and Beyond

//Below for Exercise 41 and Beyond
//- (void) imageLibraryViewController:(BLCImageLibraryViewController *)imageLibraryViewController didCompleteWithImage:(UIImage *)image {
//    
//    //Below for Exercise 41 only
////    [imageLibraryViewController dismissViewControllerAnimated:YES completion:^{
////        if (image) {
////            NSLog(@"Got an image!");
////        } else {
////            NSLog(@"Closed without an image.");
////        }
////    }];
//    //Above for Exercise 41 only
//    
//    //Below for Exercise 42 and Beyond
//    [self handleImage:image withNavigationController:imageLibraryViewController.navigationController];
//    //Above for Exercise 42 and Beyond
//    
//}
//Above for Exercise 41 and Beyond

//Below for Exercise 43 and Beyond
//#pragma mark - Popover Handling
//
//- (void) imageDidFinish:(NSNotification *)notification {
//    if (isPhone) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [self.cameraPopover dismissPopoverAnimated:YES];
//        self.cameraPopover = nil;
//    }
//}
//Above for Exercise 43 and Beyond

//Below is assignment for Exercise 26. It stays in the code through Exercise 29
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.images = [NSMutableArray array];
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.images removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}
//Above is assignment for Exercise 26. It stays in the code through Exercise 29


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
