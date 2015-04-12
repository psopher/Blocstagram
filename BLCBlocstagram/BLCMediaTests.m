//
//  BLCMediaTests.m
//  BLCBlocstagram
//
//  Created by Philip Sopher on 4/12/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCMediaTests.h"
#import "BLCMedia.h"

@implementation BLCMediaTests

- (void)testThatInitializationWorks
{
    NSDictionary *sourceDictionary = @{@"id": @"8675309",
                                       @"user" : @"philipsopher",
                                       @"caption" : @"Homer Simpson"};
    
    BLCMedia *testMedia = [[BLCMedia alloc] initWithDictionary:sourceDictionary];
    
    XCTAssertEqualObjects(testMedia.idNumber, sourceDictionary[@"id"], @"The ID number should be equal");
    XCTAssertEqualObjects(testMedia.user, sourceDictionary[@"user"], @"The username should be equal");
    XCTAssertEqualObjects(testMedia.caption, sourceDictionary[@"full_name"], @"The full name should be equal");
}

@end
