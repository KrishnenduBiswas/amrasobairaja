//
//  GradesAssignmentType.h
//  openSiS
//
//  Created by os4ed on 11/17/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradesAssignmentType : UIViewController
{
    NSMutableArray * array_studentgrades,*array_points_value,*ary_com,*lt_grade;
     NSInteger selectedIndexpath;
    NSString *str_s,*assignment_id,*assign_change_id;
    IBOutlet UIView *view_com,*view_hidden;
    BOOL a,b;
    IBOutlet UIView  *search_view;
   IBOutlet UIButton *btn;
    IBOutlet UILabel *name123;
    IBOutlet UITextView *txtview_comment;
     IBOutlet UILabel *lbl_nodatafound;
    NSString *switch_flag;
    IBOutlet UITextField *txt_search;
    
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    

    
    
    
    
}
@property (strong, nonatomic) IBOutlet UIView *view_inactiveswitch;
@property (strong, nonatomic) IBOutlet UISwitch *switch_inactive_students;
@property(strong,nonatomic)IBOutlet UITableView *tablev;
@property(strong,nonatomic)NSString *assign_type_name,*assign_type_id;
@end
