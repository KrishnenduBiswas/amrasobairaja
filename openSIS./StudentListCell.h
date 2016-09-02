//
//  StudentListCell.h
//  openSiS
//
//  Created by os4ed on 12/9/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *LABEL_NAME;
@property (strong, nonatomic) IBOutlet UILabel *LABEL_ID;
@property (strong, nonatomic) IBOutlet UILabel *label_grade;
@property (strong, nonatomic)IBOutlet UILabel *s_s_hid,*c_s_hidd,*s_ac,*c_s_a;
@end
