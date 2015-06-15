//
//  PhotoShow.h
//  camera
//
//  Created by skunk  on 15/3/4.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoShow : UIViewController
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{


}
@property (strong, nonatomic) NSMutableArray *arrImage;
@property (strong, nonatomic) NSMutableArray *arrPhotoName;
@property (weak, nonatomic) IBOutlet UICollectionView *waterView;
@property (strong, nonatomic) NSString *testInfo;

@end
