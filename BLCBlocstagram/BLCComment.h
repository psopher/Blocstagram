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

@interface BLCComment : NSObject

@property (nonatomic, strong) NSString *idNumber;

@property (nonatomic, strong) BLCUser *from;
@property (nonatomic, strong) NSString *text;

//Below for Exercise 33 and Beyond
- (instancetype) initWithDictionary:(NSDictionary *)commentDictionary;
//Above for Exercise 33 and Beyond

@end
