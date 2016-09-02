//
//  Final_grade_TableViewCell.h
//  openSiS
//
//  Created by os4ed on 4/22/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Final_grade_TableViewCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UILabel * c_title,*grdtitle,*grdrange,*teacher;
@property(strong,nonatomic)IBOutlet UIImageView *btn_comment;

@end
