//
//  PhotoCollectionViewCell.m
//  camera
//
//  Created by skunk  on 15/7/1.
//  Copyright (c) 2015年 linlizhi. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

/**
 *  rewrite selected method
 *
 *  @param selected selected description
 */
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.selectedButton.hidden = !self.selectedButton.hidden;
    @try {
        if (self.selectedButton.hidden) {
            self.unchooseBlock(self.photoImage.image);
        }else{            
            self.chooseBlock(self.photoImage.image);
        }
    }
    @catch (NSException *exception) {
        
    }
   
}
@end
