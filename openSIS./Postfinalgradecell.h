//
//  Postfinalgradecell.h
//  openSiS
//
//  Created by os4ed on 11/23/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Postfinalgradecell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_name;
@property (strong, nonatomic) IBOutlet UILabel *lbl_id;
@property (strong, nonatomic) IBOutlet UILabel *lbl_grades;
@property (strong, nonatomic) IBOutlet UIImageView *btn_comment;
@property (strong, nonatomic) IBOutlet UIButton *btn_grades;
@property (strong, nonatomic) IBOutlet UIView *view_grades;
@property (strong, nonatomic) IBOutlet UILabel *lbl_percent;
@property (strong, nonatomic) IBOutlet UIButton *btn_comment_toclick;



@end
