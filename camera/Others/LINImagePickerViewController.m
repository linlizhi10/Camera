//
//  LINImagePickerViewController.m
//  camera
//
//  Created by skunk  on 15/7/1.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "LINImagePickerViewController.h"
#import "PhotoCollectionViewCell.h"
#import "SKPhotoAlbum.h"
#import "testTableVC.h"
@interface LINImagePickerViewController ()
/**
 *  store photo data
 */
@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, strong) NSMutableArray * selectedImageArr;

@end
/**
 *  indentifier of reuse of cell
 */
static NSString *cellIdentifier = @"cellI";

@implementation LINImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedImageArr = [[NSMutableArray alloc] init];
    
    [self.waterView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    
    self.waterView.collectionViewLayout = [self setFlowLayout];
    
    /**
     get photo from photo library
     */
    
    SKPhotoAlbum *album = [[SKPhotoAlbum alloc] init];
    
    [album getAllPhotos];
    
    self.dataSource = [NSMutableArray arrayWithArray:album.imageArray];
    
}
- (UICollectionViewFlowLayout *)setFlowLayout
{
    /**
     set collectionview's layout
     */
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize = CGSizeMake(100, 100);
    
    flowLayout.minimumInteritemSpacing = 0;
    
    /**
     *  the space between two line of the items
     */
    flowLayout.minimumLineSpacing = 20;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    return flowLayout;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor clearColor];
//    return cell;
    
    /**
     *  3. 最为关键一步，为cell注册nib文件和reuse identifier， 和直接建立UIViewController不同，我们需要在delegate方法中在注册一遍nib file，让cell能自动识别nib file.
    */
    
    /**
     *  register nib file for the cell
     */
    UINib *nib = [UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:[NSBundle mainBundle]];
    
    [collectionView registerNib:nib forCellWithReuseIdentifier:cellIdentifier];
    //PhotoCollectionViewCell *cell = [[PhotoCollectionViewCell alloc] init];
    
     PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    /**
     *  set the data
     */
    cell.photoImage.image = self.dataSource[indexPath.row];
    
     //NSMutableArray *arr = [NSMutableArray array];
    
    /**
     *  question
     *
     */
    cell.chooseBlock = ^(UIImage *image){
       
        [_selectedImageArr addObject:image];
    };
    cell.unchooseBlock = ^(UIImage *image){
        [_selectedImageArr removeObject:image];
    };
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)chooseD
{
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)finishPicking:(id)sender {
    
    
    
    [self.delegate linImagePickerFinishPickingWithArray:self.selectedImageArr];
        
   
}
@end
