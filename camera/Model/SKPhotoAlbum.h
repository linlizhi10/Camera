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
@property (nonatomic, retain) NSMutableArray *urlArray;
@property (nonatomic, retain) NSMutableArray *imageArray;

@property (nonatomic, assign) id<SKPhotoAlbumDelegate>photoDelegate;
- (void)getAllPhotos;
@end
