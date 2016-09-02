//
//  S_msg_groupViewController.h
//  openSiS
//
//  Created by os4ed on 5/5/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "mailview.h"
#import "takeattendance.h"
#import "UIImageView+PhotoFrame.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "ip_url.h"
#import "TeacherDashboardViewController.h"
#import "CellTableViewCell1.h"
#import "attendencedetail.h"
#import "SBJSON.h"
#import "NSString+SBJSON.h"
#import "NSObject+SBJSON.h"
#import "Base64.h"
//#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "msg1.h"
#import "MessageGroupsCell.h"
#import "EditGroupController.h"
#import "AddGroupController.h"
#import "ShowGroupMembersController.h"
#import "SlideViewController.h"
#import "out1.h"
#import "mailview.h"
#import "composeViewController.h"
#import "Month1ViewController.h"
#import "SettingsMenu.h"
#import "msg1.h"
#import "TeacherDashboardViewController.h"

@interface S_msg_groupViewController : UIViewController
{
    
    NSMutableArray *search_ary_data,*attendance_value;
    NSString *inbox_data;
    IBOutlet UITextField *search_txt;
    IBOutlet UILabel *lbl_show,*s_lbl;
    UIDatePicker *datePicker1;
    IBOutlet  UITextField *txt_click_calender;
    NSString *str_hidden_date;
    IBOutlet UILabel *lbl_date,*show_title;
    NSInteger   selectedIndexpath;
    
    NSString *total_msg,*staff_id,*SYEAR,*CURRENT_SCHOOL_ID;
    NSMutableArray *ary_data;
    IBOutlet UIImageView *img_profile;
    IBOutlet UIView *newView,*baseView, *topView, *labelView, *bottomView;
    IBOutlet UIButton *Xbutton;
    int  slidewidth,slideheight;
    int flag,k,change,incdecheight,scroller;
    float z;
    IBOutlet UITextField *currentSchool,*schoolYear,*term,*subject,*course,*coursePeriod, *courseperiodName,*txt_shorting;
    IBOutlet UIImageView *profileImage;
    IBOutlet UILabel *lbl_username, *lbl_useremail, *lbl_currentDate, *lbl_lvlview_drop, *lbl_notification1,*lbl_notification2,*lbl_cell_date;
    
    UIPickerView *selectcustomerpicker;
    
    NSMutableArray *c_school,*c_school_title,*c_school_id,*school_year,*school_year_title,*school_year_id,*marking_period,*marking_period_title,*marking_period_id,*subject_ary,*subject_title,*subject_id,*course_ary,*course_title,*course_id,*course_period_ary,*course_period_title,*course_period_id,*ary_data1,*atten_id,*state_code,*arr_data_code;
    
    NSString *str_c_school_id123,*school_year123,*period123,*sub123,*cou123,*coperiod;
    IBOutlet UITableView *mtable;
    
    IBOutlet UIImageView *img;
    IBOutlet UILabel *lbl;
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count,*msg_count_tab;
    IBOutlet UIView *transparentView;
    NSString *flag123;
    
    BOOL s,y,t,su,c,c_a,c_ap;
    
    NSString *short_term_p,*school_id_p,*school_year_p,*school_sub_p,*str_course_p;
    NSString *old_sc,*old_year,*old_term,*old_sub,*old_co;
    
    IBOutlet UIPickerView *pick12;
    IBOutlet UIView *view1236;
    
    NSArray * sortedArray;
}

@property(strong,nonatomic)UILabel *s_lbl;
@property(strong,nonatomic) NSString *school_id,*school_year1,*str_term1,*str_sub1,*str_cou1,*str_cp1;
@property(strong,nonatomic)NSString *school_name,*school_year_name,*school_term,*school_sub,*school_course,*school_courseperiod,*school_courseperiodname;



@property(strong,nonatomic)NSMutableDictionary *dic,*dic_techinfo;

@property(strong,nonatomic)NSString *str_date,*cpv_id,*staff_id,*STR_TITLE;



@property(strong,nonatomic) NSMutableArray *arr_data,*ary_data1,*data12,*stu_id,*atten_code;
@property(strong,nonatomic) IBOutlet UIImageView *img_profile;
-(IBAction)click:(id)sender;
-(IBAction)close:(id)sender;

-(IBAction)alertOK:(id)sender;

-(IBAction)add_Group:(id)sender;


@end
