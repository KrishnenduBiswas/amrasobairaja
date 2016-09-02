//
//  Grade_s_ViewController.h
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Grade_s_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
     UIPickerView *selectcustomerpicker;
    NSMutableArray *ary_gradebook;
    BOOL s,y,t,su,c,c_a,c_ap;
    
    NSMutableDictionary *dic,*dic_techinfo;


    IBOutlet UITextField *courseperiodName;
    
  //  NSMutableArray *c_school,*c_school_title,*c_school_id,*school_year,*school_year_title,*school_year_id,*marking_period,*marking_period_title,*marking_period_id,*subject_ary,*subject_title,*subject_id,*course_ary,*course_title,*course_id,*course_period_title,*course_period_id,*ca_cp_id;
    
    NSString *str_c_school_id123,*school_year123,*period123,*sub123,*cou123;
}
- (IBAction)click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txt_mark;
@property (strong, nonatomic) IBOutlet UITableView *gradtab;
@property(strong,nonatomic) NSString *school_id,*school_year1,*str_term1,*str_sub1,*str_cou1,*str_cp1,*profile,*mptext;
-(IBAction)home:(id)sender;
-(void)setCourseperiodtextfielddata:(NSString*)str;
-(NSString *)getCourseperiodtextfielddata;
@end
