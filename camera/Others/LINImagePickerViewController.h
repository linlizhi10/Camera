//
//  LINImagePickerViewController.h
//  camera
//
//  Created by skunk  on 15/7/1.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LINImagePickerFinishPicking<NSObject>

- (void)linImagePickerFinishPickingWithArray:(NSArray *)arr;

@end


@interface LINImagePickerViewController : UIViewController

<UICollectionViewDataSource,
UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *waterView;

/**
 *  set delegate after finish picking
 */
@property (nonatomic, assign) id<LINImagePickerFinishPicking> delegate;

- (IBAction)finishPicking:(id)sender;

@end
