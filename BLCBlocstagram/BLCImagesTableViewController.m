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

@interface BLCImagesTableViewController ()


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
    
    //Below for exercise 28 and beyond
    [self.tableView registerClass:[BLCMediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
    //Above for exercise 28 and beyond
    
}

//Below for Exercise 33 and beyond
- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BLCMedia *item = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
    if (item.image) {
        return 350;
    } else {
        return 150;
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
}

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
    cell.mediaItem = [self items][indexPath.row];
    cell.mediaItem = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
    //Above for exercise 28 and beyond
    
    return cell;
}

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
    
    //Below for exercise 28 and beyond
    return [BLCMediaTableViewCell heightForMediaItem:item width:CGRectGetWidth(self.view.frame)];
    //Above for exercise 28 and beyond
}

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
