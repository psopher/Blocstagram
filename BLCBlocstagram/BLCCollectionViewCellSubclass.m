//
//  BLCCollectionViewCellSubclass.m
//  BLCBlocstagram
//
//  Created by Philip Sopher on 4/11/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCCollectionViewCellSubclass.h"
#import "BLCPostToInstagramViewController.h"
#import "BLCPostToInstagramViewController.m"

@implementation BLCCollectionViewCellSubclass

//#pragma mark - UICollectionView delegate and data source
//
//- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.filterImages.count;
//}
//
//- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    
//    static NSInteger imageViewTag = 1000;
//    static NSInteger labelTag = 1001;
//    
//    UIImageView *thumbnail = (UIImageView *)[cell.contentView viewWithTag:imageViewTag];
//    UILabel *label = (UILabel *)[cell.contentView viewWithTag:labelTag];
//    
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.filterCollectionView.collectionViewLayout;
//    CGFloat thumbnailEdgeSize = flowLayout.itemSize.width;
//    
//    if (!thumbnail) {
//        thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thumbnailEdgeSize, thumbnailEdgeSize)];
//        thumbnail.contentMode = UIViewContentModeScaleAspectFill;
//        thumbnail.tag = imageViewTag;
//        thumbnail.clipsToBounds = YES;
//        
//        [cell.contentView addSubview:thumbnail];
//    }
//    
//    if (!label) {
//        label = [[UILabel alloc] initWithFrame:CGRectMake(0, thumbnailEdgeSize, thumbnailEdgeSize, 20)];
//        label.tag = labelTag;
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
//        [cell.contentView addSubview:label];
//    }
//    
//    thumbnail.image = self.filterImages[indexPath.row];
//    label.text = self.filterTitles[indexPath.row];
//    
//    return cell;
//}
//
//- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    self.previewImageView.image = self.filterImages[indexPath.row];
//}


@end
