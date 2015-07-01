//
//  PhotoCollectionViewCell.h
//  camera
//
//  Created by skunk  on 15/7/1.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  choosed image
 */
typedef void (^chooseBlock)(UIImage *image);
/**
 *  unchoosed image
 */
typedef void (^unChooseBlock)(UIImage *image);

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

/**
 *  if there is an arr used in block ,the property should be copy
 */

@property (nonatomic, copy) chooseBlock chooseBlock;

@property (nonatomic, copy) unChooseBlock unchooseBlock;

@end
