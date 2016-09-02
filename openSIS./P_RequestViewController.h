//
//  RequestViewController.h
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_RequestViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>

{

    IBOutlet UITableView *table_reqt;
    
    UIPickerView *pick;
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    NSMutableArray *picary;
    
    NSMutableArray *ary_stdname,*ary_stdid,* ary_stdlist;
    NSString *str_name;
    
    BOOL s_name;

}
@property(strong,nonatomic) NSMutableDictionary *rqstdic;
@property(strong,nonatomic) NSMutableArray *rqstarry;

- (IBAction)click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *mp_text;
- (IBAction)myschdule:(id)sender;
- (IBAction)myrqst:(id)sender;
-(void)setCourseperiodtextfielddata:(NSString*)str;
-(NSString *)getCourseperiodtextfielddata;
@property(strong,nonatomic)NSMutableDictionary *dic,*dic_techinfo;
@property(strong,nonatomic) IBOutlet UIImageView *img_profile;
-(void)fetchdata;
@property (strong, nonatomic) NSString*mptext;


-(IBAction)home:(id)sender;

-(IBAction)action_edit:(id)sender;
-(IBAction)action_delete:(id)sender;
-(IBAction)close:(id)sender;

-(IBAction)addbtn:(id)sender;


@end
