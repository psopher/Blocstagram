//
//  BLCComment.h
//  BLCBlocstagram
//
//  Created by Philip Sopher on 2/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BLCUser;

//Below used Through Exercise 33
//@interface BLCComment : NSObject
//Above used Through Exercise 33

//Below for Exercise 34 and Beyond
@interface BLCComment : NSObject <NSCoding>
//Above for Exercise 34 and Beyond

@property (nonatomic, strong) NSString *idNumber;

@property (nonatomic, strong) BLCUser *from;
@property (nonatomic, strong) NSString *text;

//Below for Exercise 33 and Beyond
- (instancetype) initWithDictionary:(NSDictionary *)commentDictionary;
//Above for Exercise 33 and Beyond

@end
