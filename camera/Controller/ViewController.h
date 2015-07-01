//
//  ViewController.h
//  camera
//
//  Created by skunk  on 15/3/4.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^finishBlock) (int a, int b);

@interface ViewController : UIViewController
<UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *arrPhotoName;
//相机屏幕
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UIButton *checkPhoto;

@property (weak, nonatomic) IBOutlet UIButton *savePhoto;

@property (weak, nonatomic) IBOutlet UIButton *takePhoto;
//查看
- (IBAction)checkPhoto:(id)sender;

- (IBAction)takePhoto:(id)sender;
//转换前后摄像头
- (IBAction)changeCamera:(id)sender;

- (IBAction)saveThePhoto:(id)sender;

- (IBAction)pickImage:(id)sender;

@property (nonatomic, assign) finishBlock finish;
@end

