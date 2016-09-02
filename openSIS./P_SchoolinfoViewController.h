//
//  SchoolinfoViewController.h
//  openSiS
//
//  Created by os4ed on 4/18/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_SchoolinfoViewController.h"
@interface P_SchoolinfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{

NSMutableArray *c_school,*c_school_title,*c_school_id,*school_year,*school_year_title,*school_year_id,*marking_period,*marking_period_title,*marking_period_id,*subject_ary,*subject_title,*subject_id,*course_ary,*course_title,*course_id,*course_period_ary,*course_period_title,*course_period_id,*ca_cp_id;
    
    BOOL s,y,t,su,c,c_a,c_ap;
    NSString *flag123,*cp_flag;

    NSMutableArray *ary_stdname,*ary_stdid,* ary_stdlist;
    NSString *str_name;
    
    BOOL s_name;
    
    
    
    
    
}

-(IBAction)click:(id)sender;
-(void)setCourseperiodtextfielddata:(NSString*)str;
-(NSString *)getCourseperiodtextfielddata;
@property (strong, nonatomic) NSString*mptext;




@end
