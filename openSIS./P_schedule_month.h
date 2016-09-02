//
//  S_schedule_month.h
//  openSiS
//
//  Created by os4ed on 5/23/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_schedule_month : UIViewController
{
    IBOutlet UILabel *label_nodata;
    IBOutlet UIView *view1;
    IBOutlet UILabel *label_titleforthisPage;
    NSString *date_value;
    IBOutlet UIView *view_cal,*view_assign;
    IBOutlet UITextField *txt_cal,*txt_assign;

     NSMutableArray *c_school,*c_school_title,*c_school_id,*school_year,*school_year_title,*school_year_id,*marking_period,*marking_period_title,*marking_period_id,*subject_ary,*subject_title,*subject_id,*course_ary,*course_title,*course_id,*course_period_ary,*course_period_title,*course_period_id,*ca_cp_id;
    
    BOOL s,y,t,su,c,c_a,c_ap;
    NSString *flag123,*cp_flag;
    
    
    
    UIPickerView *  selectcustomerpicker;
    
    IBOutlet UITextField *currentSchool,*schoolYear,*term,*subject,*course,*coursePeriod, *courseperiodName;
    
    BOOL s_name;
    
    
    NSMutableArray *ary_stdname,*ary_stdid,* ary_stdlist;
    NSString *str_name;
    
    
    
    
    NSString *short_term_p,*school_id_p,*school_year_p,*school_sub_p,*str_course_p;
    NSString *old_sc,*old_year,*old_term,*old_sub,*old_co,*old_cp_id;
    

    
}
@property (strong) NSString *studentName;
@property (strong) NSString *studentID;

@end
