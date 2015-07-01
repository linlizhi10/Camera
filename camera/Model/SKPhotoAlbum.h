//
//  SKPhotoAlbum.h
//  camera
//
//  Created by skunk  on 15/5/5.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SKPhotoAlbumDelegate <NSObject>

- (void)photoParseFinished:(NSMutableArray *)arrImage;

@end

@interface SKPhotoAlbum : NSObject

/**
 *  the path of the photo
 */
@property (nonatomic, retain) NSMutableArray *urlArray;

/**
 *  the array contains all the photos
 */
@property (nonatomic, retain) NSMutableArray *imageArray;

/**
 *  the delegate of the SKPhotoAlbum to do something after finish get the data of photos
 */
@property (nonatomic, assign) id<SKPhotoAlbumDelegate>photoDelegate;

/**
 *  to get all the photos from the photo Library
 */
- (void)getAllPhotos;

@end
