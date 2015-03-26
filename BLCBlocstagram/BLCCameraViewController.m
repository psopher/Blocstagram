//
//  BLCCameraViewController.m
//  BLCBlocstagram
//
//  Created by Philip Sopher on 3/17/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "BLCCameraToolbar.h"
#import "BLCImageUtilities.h"

//Below for Exercise 41 and Beyond
//#import "BLCCropBox.h"
//#import "BLCImageLibraryViewController.h"
//Above for Exercise 41 and Beyond

//Below for Exercise 40 only
@interface BLCCameraViewController () <BLCCameraToolbarDelegate, UIAlertViewDelegate>
//Above for Exercise 40 only

//Below for Exercise 41 and Beyond
//@interface BLCCameraViewController () <BLCCameraToolbarDelegate, UIAlertViewDelegate, BLCImageLibraryViewControllerDelegate>
//Above for Exercise 41 and Beyond


@property (nonatomic, strong) UIView *imagePreview;

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;

//Below for Exercise 40 only
@property (nonatomic, strong) NSArray *horizontalLines;
@property (nonatomic, strong) NSArray *verticalLines;
//Above for Exercise 40 only

//Below for Exercise 41 and Beyond
//@property (nonatomic, strong) BLCCropBox *cropBox;
//Above for Exercise 41 and Beyond

@property (nonatomic, strong) UIToolbar *topView;
@property (nonatomic, strong) UIToolbar *bottomView;

@property (nonatomic, strong) BLCCameraToolbar *cameraToolbar;

@end

@implementation BLCCameraViewController

#pragma mark - Build View Hierarchy

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createViews];
    [self addViewsToViewHierarchy];
    [self setupImageCapture];
    [self createCancelButton];
}

- (void) createCancelButton {
    UIImage *cancelImage = [UIImage imageNamed:@"x"];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:cancelImage style:UIBarButtonItemStyleDone target:self action:@selector(cancelPressed:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void) setupImageCapture {
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetHigh;
    
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.captureVideoPreviewLayer.masksToBounds = YES;
    [self.imagePreview.layer addSublayer:self.captureVideoPreviewLayer];
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
                
                NSError *error = nil;
                AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
                if (!input) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription message:error.localizedRecoverySuggestion delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"OK button") otherButtonTitles:nil];
                    [alert show];
                } else {
                    [self.session addInput:input];
                    
                    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
                    self.stillImageOutput.outputSettings = @{AVVideoCodecKey: AVVideoCodecJPEG};
                    
                    [self.session addOutput:self.stillImageOutput];
                    
                    [self.session startRunning];
                }
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Camera Permission Denied", @"camera permission denied title")
                                                                message:NSLocalizedString(@"This app doesn't have permission to use the camera; please update your privacy settings.", @"camera permission denied recovery suggestion")
                                                               delegate:self
                                                      cancelButtonTitle:NSLocalizedString(@"OK", @"OK button")
                                                      otherButtonTitles:nil];
                [alert show];
            }
        });
    }];
}

- (void) addViewsToViewHierarchy {
    
    //Below for Exercise 40 only
    NSMutableArray *views = [@[self.imagePreview, self.topView, self.bottomView] mutableCopy];
    [views addObjectsFromArray:self.horizontalLines];
    [views addObjectsFromArray:self.verticalLines];
    //Above for Exercise 40 only
    
    //Below for Exercise 41 and Beyond
//    NSMutableArray *views = [@[self.imagePreview, self.cropBox, self.topView, self.bottomView] mutableCopy];
    //Above for Exercise 41 and Beyond
    
    [views addObject:self.cameraToolbar];
    
    for (UIView *view in views) {
        [self.view addSubview:view];
    }
}

- (void) createViews {
    self.imagePreview = [UIView new];
    self.topView = [UIToolbar new];
    self.bottomView = [UIToolbar new];
    
    //Below for Exercise 41 and Beyond
//    self.cropBox = [BLCCropBox new];
    //Above for Exercise 41 and Beyond
    
    self.cameraToolbar = [[BLCCameraToolbar alloc] initWithImageNames:@[@"rotate", @"road"]];
    self.cameraToolbar.delegate = self;
    UIColor *whiteBG = [UIColor colorWithWhite:1.0 alpha:.15];
    self.topView.barTintColor = whiteBG;
    self.bottomView.barTintColor = whiteBG;
    self.topView.alpha = 0.5;
    self.bottomView.alpha = 0.5;
}

//Below for Exercise 40 only
- (NSArray *) horizontalLines {
    if (!_horizontalLines) {
        _horizontalLines = [self newArrayOfFourWhiteViews];
    }
    
    return _horizontalLines;
}

- (NSArray *) verticalLines {
    if (!_verticalLines) {
        _verticalLines = [self newArrayOfFourWhiteViews];
    }
    
    return _verticalLines;
}

- (NSArray *) newArrayOfFourWhiteViews {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [array addObject:view];
    }
    
    return array;
}
//Above for Exercise 40 only


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.delegate cameraViewController:self didCompleteWithImage:nil];
}

#pragma mark - Event Handling

- (void) cancelPressed:(UIBarButtonItem *)sender {
    [self.delegate cameraViewController:self didCompleteWithImage:nil];
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    self.topView.frame = CGRectMake(0, self.topLayoutGuide.length, width, 44);
    
    CGFloat yOriginOfBottomView = CGRectGetMaxY(self.topView.frame) + width;
    CGFloat heightOfBottomView = CGRectGetHeight(self.view.frame) - yOriginOfBottomView;
    self.bottomView.frame = CGRectMake(0, yOriginOfBottomView, width, heightOfBottomView);
    
    //Below for Exercise 40 only
    CGFloat thirdOfWidth = width / 3;
    
    for (int i = 0; i < 4; i++) {
        UIView *horizontalLine = self.horizontalLines[i];
        UIView *verticalLine = self.verticalLines[i];
        
        horizontalLine.frame = CGRectMake(0, (i * thirdOfWidth) + CGRectGetMaxY(self.topView.frame), width, 0.5);
        
        CGRect verticalFrame = CGRectMake(i * thirdOfWidth, CGRectGetMaxY(self.topView.frame), 0.5, width);
        
        if (i == 3) {
            verticalFrame.origin.x -= 0.5;
        }
        
        verticalLine.frame = verticalFrame;
    }
    //Above for Exercise 40 only
    
    //Below for Exercise 41 and Beyond
//    self.cropBox.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), width, width);
    //Above for Exercise 41 and Beyond
    
    self.imagePreview.frame = self.view.bounds;
    self.captureVideoPreviewLayer.frame = self.imagePreview.bounds;
    
    CGFloat cameraToolbarHeight = 100;
    self.cameraToolbar.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - cameraToolbarHeight, width, cameraToolbarHeight);
}

#pragma mark - BLCCameraToolbarDelegate

- (void) leftButtonPressedOnToolbar:(BLCCameraToolbar *)toolbar {
    AVCaptureDeviceInput *currentCameraInput = self.session.inputs.firstObject;
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    if (devices.count > 1) {
        NSUInteger currentIndex = [devices indexOfObject:currentCameraInput.device];
        NSUInteger newIndex = 0;
        
        if (currentIndex < devices.count - 1) {
            newIndex = currentIndex + 1;
        }
        
        AVCaptureDevice *newCamera = devices[newIndex];
        AVCaptureDeviceInput *newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:newCamera error:nil];
        
        if (newVideoInput) {
            UIView *fakeView = [self.imagePreview snapshotViewAfterScreenUpdates:YES];
            fakeView.frame = self.imagePreview.frame;
            [self.view insertSubview:fakeView aboveSubview:self.imagePreview];
            
            [self.session beginConfiguration];
            [self.session removeInput:currentCameraInput];
            [self.session addInput:newVideoInput];
            [self.session commitConfiguration];
            
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                fakeView.alpha = 0;
            } completion:^(BOOL finished) {
                [fakeView removeFromSuperview];
            }];
        }
    }
}

- (void) rightButtonPressedOnToolbar:(BLCCameraToolbar *)toolbar {
    //Below for Exercise 40 only
    NSLog(@"Photo library button pressed.");
    //Above for Exercise 40 only
    
    //Below for Exercise 41 and Beyond
//    BLCImageLibraryViewController *imageLibraryVC = [[BLCImageLibraryViewController alloc] init];
//    imageLibraryVC.delegate = self;
//    [self.navigationController pushViewController:imageLibraryVC animated:YES];
    //Above for Exercise 41 and Beyond
}

- (void) cameraButtonPressedOnToolbar:(BLCCameraToolbar *)toolbar {
    AVCaptureConnection *videoConnection;
    
    // Find the right connection object
    for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
        for (AVCaptureInputPort *port in connection.inputPorts) {
            if ([port.mediaType isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        if (imageSampleBuffer) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData scale:[UIScreen mainScreen].scale];
            image = [image imageWithFixedOrientation];
            image = [image imageResizedToMatchAspectRatioOfSize:self.captureVideoPreviewLayer.bounds.size];
            
            //Below for Exercise 40 only
            UIView *leftLine = self.verticalLines.firstObject;
            UIView *rightLine = self.verticalLines.lastObject;
            UIView *topLine = self.horizontalLines.firstObject;
            UIView *bottomLine = self.horizontalLines.lastObject;
            
            CGRect gridRect = CGRectMake(CGRectGetMinX(leftLine.frame),
                                         CGRectGetMinY(topLine.frame),
                                         CGRectGetMaxX(rightLine.frame) - CGRectGetMinX(leftLine.frame),
                                         CGRectGetMinY(bottomLine.frame) - CGRectGetMinY(topLine.frame));
            //Above for Exercise 40 only
            
            //Below for Exercise 41 and Beyond
//            CGRect gridRect = self.cropBox.frame;
            //Above for Exercise 41 and Beyond
            
            CGRect cropRect = gridRect;
            cropRect.origin.x = (CGRectGetMinX(gridRect) + (image.size.width - CGRectGetWidth(gridRect)) / 2);
            
            image = [image imageCroppedToRect:cropRect];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate cameraViewController:self didCompleteWithImage:image];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedDescription message:error.localizedRecoverySuggestion delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK button") otherButtonTitles:nil];
                [alert show];
            });
            
        }
    }];
}

//Below for Exercise 41 and Beyond
//#pragma mark - BLCImageLibraryViewControllerDelegate
//
//- (void) imageLibraryViewController:(BLCImageLibraryViewController *)imageLibraryViewController didCompleteWithImage:(UIImage *)image {
//    [self.delegate cameraViewController:self didCompleteWithImage:image];
//}
//Above for Exercise 41 and Beyond

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
