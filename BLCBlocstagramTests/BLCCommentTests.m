//
//  BLCCommentTests.m
//  BLCBlocstagram
//
//  Created by Philip Sopher on 4/8/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCCommentTests.h"
#import "BLCComment.h"

@implementation BLCCommentTests

- (void)testThatInitializationWorks
{
    NSDictionary *sourceDictionary = @{@"id": @"8675309",
                                       @"text" : @"Sample Comment"};
    
    BLCComment *testComment = [[BLCComment alloc] initWithDictionary:sourceDictionary];
    
    XCTAssertEqualObjects(testComment.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(testComment.text, sourceDictionary[@"text"], @"The text should be equal");
}

@end
