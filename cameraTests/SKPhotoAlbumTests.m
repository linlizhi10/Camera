//
//  SKPhotoAlbumTests.m
//  camera
//
//  Created by skunk  on 15/5/5.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SKPhotoAlbum.h"
@interface SKPhotoAlbumTests : XCTestCase

@end

@implementation SKPhotoAlbumTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    //XCTAssert(YES, @"Pass");
    SKPhotoAlbum *photo = [[SKPhotoAlbum alloc]init];
    [photo getAllPhotos];
    XCTAssertEqual(0,photo.urlArray.count,@"yes");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
