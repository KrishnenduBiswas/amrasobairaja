//
//  GradesTotalCell.h
//  openSiS
//
//  Created by subhajit halder on 17/11/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Gradest : UITableViewCell
@property (strong, nonatomic)IBOutlet UITextField *txt_value;
@property (strong, nonatomic)IBOutlet  UIButton *marks,*note;
@property (strong, nonatomic) IBOutlet UIImageView *imageview_profile;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name,*lbl_st,*lbl_sa,*lbl_cs,*lbl_ca;;
@property (strong, nonatomic) IBOutlet UILabel *lbl_id;
@property (strong, nonatomic) IBOutlet UILabel *lbl_points;
@property (strong, nonatomic) IBOutlet UILabel *lbl_grades;
@property (strong, nonatomic) IBOutlet UILabel *lbl_char_grade,*letter_grade;

@property (strong, nonatomic) IBOutlet UIImageView *imageview_comment;

@end
