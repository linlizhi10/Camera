//
//  PhotoEditVC.h
//  camera
//
//  Created by skunk  on 15/3/4.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoEditVC : UIViewController

@property (assign, nonatomic) UIImage *image;

@property (weak, nonatomic) IBOutlet UIImageView *iView;
@property (weak, nonatomic) IBOutlet UIButton *classStyle;
@property (weak, nonatomic) IBOutlet UIButton *modenStyle;
@property (weak, nonatomic) IBOutlet UIButton *anotherStyle;

@end
