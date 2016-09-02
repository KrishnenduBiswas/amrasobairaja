//
//  SlideViewController.h
//  conceptslider
//
//  Created by os4ed on 10/5/15.
//  Copyright © 2015 os4ed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "TeacherDashboardViewController.h"
@interface SlideViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

{
    
     BOOL dt,b_s,b_y,b_t,b_c,b_sub,b_cp;
    NSString *term_flag,*c_flag,*s_flag,*cp_flag,*sub_flag,*usercourseperiod_var,* coperiod_user;
    BOOL s,y,t,su,c,c_a,c_ap;
    NSString *flag123;
    SlideViewController *slide;
    NSString *short_term_p,*school_id_p,*school_year_p,*school_sub_p,*str_course_p;
    NSString *old_sc,*old_year,*old_term,*old_sub,*old_co,*old_cp_id;
    
    IBOutlet UIView *view_missing_attendence;
    
    IBOutlet UIImageView *img_profile;
    IBOutlet UIView *newView,*baseView, *topView, *labelView, *bottomView;
    IBOutlet UIButton *Xbutton;
    int  slidewidth,slideheight,flag,k;
    IBOutlet UITextField *currentSchool,*schoolYear,*term,*subject,*course,*coursePeriod, *courseperiodName;
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *lbl_username, *lbl_useremail, *lbl_currentDate, *lbl_lvlview_drop, *lbl_notification1,*lbl_notification2;
    IBOutlet UITableView *table;
    UIPickerView *selectcustomerpicker;
    
    NSMutableArray *c_school,*c_school_title,*c_school_id,*school_year,*school_year_title,*school_year_id,*marking_period,*marking_period_title,*marking_period_id,*subject_ary,*subject_title,*subject_id,*course_ary,*course_title,*course_id,*course_period_ary,*course_period_title,*course_period_id,*ca_cp_id;
    
    NSString *str_c_school_id123,*school_year123,*period123,*sub123,*cou123,*coperiod;
    IBOutlet UITableView *mtable;
    
    IBOutlet UIImageView *img;
    IBOutlet UILabel *lbl;
    NSMutableArray *ary_data,*img_ary;
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count,*msg_count_tab;
    NSString *marking_period_type;
}
@property(strong,nonatomic) NSString *school_id,*school_year1,*str_term1,*str_sub1,*str_cou1,*str_cp1,*profile;

//@property(strong,nonatomic) IBOutlet UIImageView *img_profile;

-(void)alldata1;


- (IBAction)close:(id)sender;
- (IBAction)open:(UIView *)superview;
-(void)setrect:(UIView *)superview;
-(IBAction)logout:(id)sender;
- (void)setparentobject:(id)parent parentname:(NSString *)parentname;
- (void)setcourseperiod;







@end












