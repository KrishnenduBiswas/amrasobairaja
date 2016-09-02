//
//  CellTableViewCell.h
//  openSiS
//
//  Created by os4ed on 9/9/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellTableViewCell : UITableViewCell

@property(strong,nonatomic)IBOutlet UILabel *lbl_title,*lbl_period,*lbl_room,*lbl_term,*lbl_time, *lbl_time2;
@property(strong,nonatomic)IBOutlet UILabel *day1,*day2,*day3,*day4,*day5,*day6,*day7;

@end
