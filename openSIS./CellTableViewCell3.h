//
//  CellTableViewCell.h
//  openSiS
//
//  Created by os4ed on 9/9/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellTableViewCell3 : UITableViewCell
@property(strong,nonatomic)IBOutlet UIImageView *img1;
@property(strong,nonatomic)IBOutlet UIView *tempview;
@property(strong,nonatomic)IBOutlet UIButton *btn;
@property(strong,nonatomic)IBOutlet UILabel *lbl_name,*lbl_id,*atten;

@end
