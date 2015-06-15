//
//  PhotoEditVC.m
//  camera
//
//  Created by skunk  on 15/3/4.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "PhotoEditVC.h"

@interface PhotoEditVC ()

@end

@implementation PhotoEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _iView.image = _image;
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

- (IBAction)coreControl:(id)sender {
}

- (IBAction)classicalStyleChange:(id)sender {
}

- (IBAction)blackStyleChange:(id)sender {
}
@end
