//
//  BLCMediaFullScreenViewController.m
//  BLCBlocstagram
//
//  Created by Philip Sopher on 3/15/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

//For Exercise 35 and Beyond

#import "BLCMediaFullScreenViewController.h"
#import "BLCMedia.h"

//Below for Exercise 43 and Beyond
//#define isPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//Above for Exercise 43 and Beyond

@interface BLCMediaFullScreenViewController () <UIScrollViewDelegate>

//Below used Through Exercise 40
@property (nonatomic, strong) BLCMedia *media;
//Above used Through Exercise 40

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;

//Below for Exercise 43 and Beyond
//@property (nonatomic, strong) UITapGestureRecognizer *tapBehind;
//Above for Exercise 43 and Beyond

@end

@implementation BLCMediaFullScreenViewController

- (instancetype) initWithMedia:(BLCMedia *)media {
    self = [super init];
    
    if (self) {
        self.media = media;
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [UIScrollView new];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    
    self.imageView = [UIImageView new];
    self.imageView.image = self.media.image;
    
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.media.image.size;
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
    
    self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapFired:)];
    self.doubleTap.numberOfTapsRequired = 2;
    
    [self.tap requireGestureRecognizerToFail:self.doubleTap];
    
    //Below for Exercise 43 and Beyond
//    if (isPhone == NO) {
//        self.tapBehind = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBehindFired:)];
//        self.tapBehind.cancelsTouchesInView = NO;
//    }
    //Above for Exercise 43 and Beyond
    
    [self.scrollView addGestureRecognizer:self.tap];
    [self.scrollView addGestureRecognizer:self.doubleTap];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
    
//Below for Exercise 41 and Beyond
//    [self recalculateZoomScale];
//}
//
//- (void) recalculateZoomScale {
//Above for Exercise 41 and Beyond
    
    CGSize scrollViewFrameSize = self.scrollView.frame.size;
    CGSize scrollViewContentSize = self.scrollView.contentSize;
    
    //Below for Exercise 41 and Beyond
//    scrollViewContentSize.height /= self.scrollView.zoomScale;
//    scrollViewContentSize.width /= self.scrollView.zoomScale;
    //Above for Exercise 41 and Beyond
    
    CGFloat scaleWidth = scrollViewFrameSize.width / scrollViewContentSize.width;
    CGFloat scaleHeight = scrollViewFrameSize.height / scrollViewContentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1;
}

- (void)centerScrollView {
    [self.imageView sizeToFit];
    
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - CGRectGetWidth(contentsFrame)) / 2;
    } else {
        contentsFrame.origin.x = 0;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - CGRectGetHeight(contentsFrame)) / 2;
    } else {
        contentsFrame.origin.y = 0;
    }
    
    self.imageView.frame = contentsFrame;
}

#pragma mark - UIScrollViewDelegate

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self centerScrollView];
    
    //Below for Exercise 43 and Beyond
//    if (isPhone == NO) {
//        [[[[UIApplication sharedApplication] delegate] window] addGestureRecognizer:self.tapBehind];
//    }
    //Above for Exercise 43 and Beyond
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Below for Exercise 43 and Beyond
//- (void) viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    
//    if (isPhone == NO) {
//        [[[[UIApplication sharedApplication] delegate] window] removeGestureRecognizer:self.tapBehind];
//    }
//}
//
//- (void) tapBehindFired:(UITapGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateEnded) {
//        CGPoint location = [sender locationInView:nil]; // Passing nil gives us coordinates in the window
//        CGPoint locationInVC = [self.presentedViewController.view convertPoint:location fromView:self.view.window];
//        
//        if ([self.presentedViewController.view pointInside:locationInVC withEvent:nil] == NO) {
//            // The tap was outside the VC's view
//            
//            if (self.presentingViewController) {
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }
//        }
//    }
//}
//Above for Exercise 43 and Beyond

#pragma mark - Gesture Recognizers

- (void) tapFired:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) doubleTapFired:(UITapGestureRecognizer *)sender {
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        CGPoint locationPoint = [sender locationInView:self.imageView];
        
        CGSize scrollViewSize = self.scrollView.bounds.size;
        
        CGFloat width = scrollViewSize.width / self.scrollView.maximumZoomScale;
        CGFloat height = scrollViewSize.height / self.scrollView.maximumZoomScale;
        CGFloat x = locationPoint.x - (width / 2);
        CGFloat y = locationPoint.y - (height / 2);
        
        [self.scrollView zoomToRect:CGRectMake(x, y, width, height) animated:YES];
    } else {
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
