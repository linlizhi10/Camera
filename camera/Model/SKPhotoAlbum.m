//
//  SKPhotoAlbum.m
//  camera
//
//  Created by skunk  on 15/5/5.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "SKPhotoAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface SKPhotoAlbum()

@end
@implementation SKPhotoAlbum
- (void)getAllPhotos
{
    /*
     　ALAssetsLibrary：代表整个PhotoLibrary，我们可以生成一个它的实例对象，这个实例对象就相当于是照片库的句柄。
     
     　　ALAssetsGroup：照片库的分组，我们可以通过ALAssetsLibrary的实例获取所有的分组的句柄。
     
     　　ALAsset：一个ALAsset的实例代表一个资产，也就是一个photo或者video，我们可以通过他的实例获取对应的subnail或者原图等等。
     */
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];//生成整个photoLibrary句柄的实例
    //NSMutableArray *mediaArray = [[NSMutableArray alloc]init];//存放media的数组
    _urlArray = [[NSMutableArray alloc] init];
    _imageArray = [[NSMutableArray alloc] init];
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                     usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                         //获取所有group
                                         [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                             //从group里面
                                             NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                                             if ([assetType isEqualToString:ALAssetTypePhoto]) {
                                                 NSLog(@"Photo");
                                                 NSString *urlStr = [NSString stringWithFormat:@"%@",result.defaultRepresentation.url];
                                                 [_urlArray addObject:urlStr];
                                                 
                                             }else if ([assetType isEqualToString:ALAssetTypeVideo])
                                             {
                                                 //  NSLog(@"Video");
                                                 
                                             }else if ([assetType isEqualToString:ALAssetTypeUnknown]){
                                                 // NSLog(@"unknown AssetType");
                                             }
                                             
                                             NSDictionary *assetUrls = [result valueForProperty:ALAssetPropertyURLs];
                                             NSUInteger *assetCounter = 0;
                                             for (NSString *assetURLKey in assetUrls) {
                                                 //NSLog(@"Asset URL %lu = %@",(unsigned long)assetCounter,[assetUrls objectForKey:assetURLKey]);
                                             }
                                             NSLog(@"Representation size = %lld",[[result defaultRepresentation] size]);
                                         }];
                                         dispatch_semaphore_signal(sema);
                                         //[self parsePhoto];
                                         
                                     } failureBlock:^(NSError *error) {
                                         NSLog(@"Enumerate the asset group failed");
                                     }];
    });
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    [self parsePhoto];
    
}
- (void)parsePhoto
{
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc]init];
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
    
    
        NSLog(@"urlArray.count is %ld",[self.urlArray count]);
        for (NSString *iUrl in self.urlArray) {
         dispatch_async(queue, ^{
            NSURL *url = [NSURL URLWithString:iUrl];
            [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
                UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
                NSLog(@"image is %@",image);
                
                [_imageArray addObject:image];
                
                dispatch_semaphore_signal(sema);
                
            } failureBlock:^(NSError *error) {
                NSLog(@"error = %@",error);
            }];
             
            });
           dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
    
   
    /**
     *  信号控制 通过dispatch_semaphore_wait信号量控制，使得程序只有执行完了回调，获得sema信号后才会执行dispatch_semaphore_wait后面的代码 放到dispatch_async中可防止把主线程卡死
     有待考究
     
     */
    //dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    NSLog(@"imageArray.count is %ld",_imageArray.count);
}
@end
