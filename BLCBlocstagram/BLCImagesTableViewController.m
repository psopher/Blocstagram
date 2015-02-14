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
        self.images = [NSMutableArray array];
        //Above for exercise 26 only
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Below for exercise 26 only
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [self.images addObject:image];
        }
    }
    //Above for exercise 26 only
    
    //Below for code through exercise 27
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];
    //Above for code through exercise 27
    
    //Below for code through exercise 27
    [self.tableView registerClass:[BLCMediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
    //Above for code through exercise 27
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//Below is Exercise 27 assignment
//- (void) items {
//    return [BLCDatasource sharedInstance].mediaItems;
//}
//Above is Exercise 27 assignment

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //Below for exercise 26 only
    return self.images.count;
    //Above for exercise 26 only
    
    //Below for exercise 27 and beyond
//    return [self items].count;
//    return [BLCDatasource sharedInstance].mediaItems.count;
    //Above for exercise 27 and beyond
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Below used through exercise 27
//    static NSInteger imageViewTag = 1234;
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    
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
    //Above used through exercise 27
    
    //Below for exercise 26 only
//    UIImage *image = self.images[indexPath.row];
//    imageView.image = image;
    //Above for exercise 26 only
    
    //Below for exercise 27
//    BLCMedia *item = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
//    imageView.image = item.image;
    //Above for exercise 27
    
    //Below for exercise 28 and beyond
    BLCMediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    cell.mediaItem = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
    //Above for exercise 28 and beyond
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Below for exercise 26 only
//    UIImage *image = self.images[indexPath.row];
    //Above for exercise 26 only
    
    //Below for exercise 27 and beyond
    BLCMedia *item = [BLCDatasource sharedInstance].mediaItems[indexPath.row];
    //Above for exercise 27 and beyond
    
    //Below for exercise 27 only
//    UIImage *image = item.image;
//    return (CGRectGetWidth(self.view.frame) / image.size.width) * image.size.height;
    //Above for exercise 27 only
    
    //Below for exercise 28 and beyond
    return [BLCMediaTableViewCell heightForMediaItem:item width:CGRectGetWidth(self.view.frame)];
    //Above for exercise 28 and beyond
}

//Assignment for Exercise 26
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}


//Assignment for Exercise 26
// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.images = [NSMutableArray array];
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.images removeObjectAtRow:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}


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
