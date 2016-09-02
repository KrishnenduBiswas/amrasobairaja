//
//  SdashboardViewController.h
//  openSiS
//
//  Created by os4ed on 3/8/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface pdashboardViewController : UIViewController<UIGestureRecognizerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

{
      NSMutableArray *ary_stdname,*ary_stdid,* ary_stdlist;
    NSString *str_name;
    
    BOOL s_name;
    BOOL s,y,t,su,c,c_a,c_ap;
    NSString *flag123,*cp_flag;
    
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
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    
    
    
    
}

-(IBAction)msgg:(id)sender;
-(IBAction)settting:(id)sender;
@property(strong,nonatomic) NSString *school_id,*school_year1,*str_term1,*str_sub1,*str_cou1,*str_cp1,*profile;
@property(strong,nonatomic)NSMutableDictionary *dic,*dic_techinfo;
@property(strong,nonatomic) IBOutlet UIImageView *img_profile;
-(void)fetchdata;
-(void)showdata;
-(void)setCourseperiodtextfielddata:(NSString*)str;
-(NSString *)getCourseperiodtextfielddata;




@end
