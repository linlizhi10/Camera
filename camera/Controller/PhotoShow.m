//
//  PhotoShow.m
//  camera
//
//  Created by skunk  on 15/3/4.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//1. 导入库“AssetsLibrary.framework”
//2.在要用的类中引入头文件：#import<AssetsLibrary/ALAssetsLibrary.h>

#import "PhotoShow.h"
#import "PhotoEditVC.h"
#import "SKPhotoAlbum.h"
#import <AssetsLibrary/AssetsLibrary.h>
#define TESTData 0
#define SCREENWidth [UIScreen mainScreen].bounds.size.width
#define SCREENHeight [UIScreen mainScreen].bounds.size.height

static NSString *SKCellIdentifier = @"cell";
static NSString *SKHeaderIdentifier = @"header";
static NSString *SKFooterIdentifier = @"footer";

@interface PhotoShow ()
@property (nonatomic, retain) NSMutableArray *imageURl;
@end

@implementation PhotoShow
- (id)init
{
    self = [super init];
    if (self) {
        _arrPhotoName = [[NSMutableArray alloc]init];
        //_arrImage = [[NSMutableArray alloc]init];
        _imageURl = [[NSMutableArray alloc]init];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _arrPhotoName = [[NSMutableArray alloc]init];
        //_arrImage = [[NSMutableArray alloc]init];
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _arrPhotoName = [[NSMutableArray alloc]init];
    //_arrImage = [[NSMutableArray alloc]init];
    _imageURl = [[NSMutableArray alloc]init];
    [self loadData];
    
    //设置layout
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=CGSizeMake((SCREENWidth - 40)/3, 100);
    layout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
    //cell之间左右的间隔
    layout.minimumInteritemSpacing = 5;
    //cell上下的间隔
    layout.minimumLineSpacing = 5;
    
    [_waterView setCollectionViewLayout:layout];
    _waterView.delegate = self;
    _waterView.dataSource = self;
    _waterView.backgroundColor = [UIColor clearColor];
    _waterView.userInteractionEnabled=YES;
    //注册cell
    [_waterView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:SKCellIdentifier];
    
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    //NSLog(@"_arrImage.count is %d",_arrImage.count);
    return _arrImage.count;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView
                                dequeueReusableCellWithReuseIdentifier:SKCellIdentifier
                                                    forIndexPath:indexPath];
    
    for (UIView *iView in cell.contentView.subviews) {
        [iView removeFromSuperview];
    }
    UIImageView *iView=[[UIImageView alloc]initWithImage:_arrImage[indexPath.row]];

    iView.backgroundColor = [UIColor redColor];
    iView.frame=CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    [cell.contentView addSubview:iView];
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"click");
//    //UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    PhotoEditVC *photoEdit=[[PhotoEditVC alloc] init];
//    [self presentViewController:photoEdit animated:YES completion:nil];
//    photoEdit.image = _arrImage[indexPath.row];
//}
- (void)loadData
{
//    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    for (int i = _arrPhotoName.count; i>=0; i--) {
//        NSString *path = [NSString stringWithFormat:@"%@/%@",rootPath,@"1"];
//        NSLog(@"path is %@",path);
//        NSData *data = [NSData dataWithContentsOfFile:path];
//        [_arrImage addObject:data];
//    }
    
    SKPhotoAlbum *photoAlbum = [[SKPhotoAlbum alloc]init];
    [photoAlbum getAllPhotos];
    
    self.arrImage = [NSMutableArray arrayWithArray:photoAlbum.imageArray];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
