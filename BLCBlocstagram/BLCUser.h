//
//  BLCUser.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Below used Through Exercise 33
//@interface BLCUser : NSObject
//Above used Through Exercise 33

//Below for Exercise 34 and Beyond
@interface BLCUser : NSObject <NSCoding>
//Above for Exercise 34 and Beyond

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSURL *profilePictureURL;
@property (nonatomic, strong) UIImage *profilePicture;

//Below for Exercise 33 and Beyond
- (instancetype) initWithDictionary:(NSDictionary *)userDictionary;
//Above for Exercise 33 and Beyond

@end
