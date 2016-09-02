//
//  TeacherDashboardViewController.h
//  openSiS
//
//  Created by EjobIndia on 17/08/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SlideViewController.h"
@interface attendence : UIViewController<UIGestureRecognizerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSString *flag123;
      SlideViewController *slide;
    BOOL s,y,t,su,c,c_a,c_ap;
   
    NSString *short_term_p,*school_id_p,*school_year_p,*school_sub_p,*str_course_p;
    NSString *old_sc,*old_year,*old_term,*old_sub,*old_co,*old_cp_id;
    NSString *total_msg,*staff_id,*SYEAR,*CURRENT_SCHOOL_ID;
    NSMutableArray *ary_data;
    IBOutlet UIImageView *img_profile;
    IBOutlet UIView *newView,*baseView, *topView, *labelView, *bottomView;
    IBOutlet UIButton *Xbutton;
    int  slidewidth,slideheight,flag,k;
    IBOutlet UITextField *currentSchool,*schoolYear,*term,*subject,*course,*coursePeriod, *courseperiodName;
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *lbl_username, *lbl_useremail, *lbl_currentDate, *lbl_lvlview_drop, *lbl_notification1,*lbl_notification2,*lbl_cell_date;
 
     UIPickerView *selectcustomerpicker;
    
    NSMutableArray *c_school,*c_school_title,*c_school_id,*school_year,*school_year_title,*school_year_id,*marking_period,*marking_period_title,*marking_period_id,*subject_ary,*subject_title,*subject_id,*course_ary,*course_title,*course_id,*course_period_ary,*course_period_title,*course_period_id;
    
    NSString *str_c_school_id123,*school_year123,*period123,*sub123,*cou123,*coperiod;
    IBOutlet UITableView *mtable;
    
    IBOutlet UIImageView *img;
    IBOutlet UILabel *lbl;
   
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi;
    IBOutlet UIView *transparentView;
    IBOutlet UILabel *msg_count_tab;
}

@property(strong,nonatomic)NSString *flag_pass_data;
@property(strong,nonatomic) NSString *school_id,*school_year1,*str_term1,*str_sub1,*str_cou1,*str_cp1;
@property(strong,nonatomic)NSString *school_name,*school_year_name,*school_term,*school_sub,*school_course,*school_courseperiod,*school_courseperiodname;
@property(strong,nonatomic)NSMutableDictionary *dic,*dic_techinfo;
@property(strong,nonatomic) IBOutlet UIImageView *img_profile;
-(IBAction)click:(id)sender;
-(IBAction)close:(id)sender;
-(IBAction)ok:(id)sender;
-(IBAction)logout:(id)sender;
-(IBAction)alertOK:(id)sender;
@end
