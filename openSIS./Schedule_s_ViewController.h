//
//  Schedule_s_ViewController.h
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Schedule_s_ViewController : UIViewController<UITextFieldDelegate>
{
    UIPickerView *pick;
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    NSMutableArray *picary;
}
- (IBAction)click:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *mp_text;
- (IBAction)myschdule:(id)sender;
- (IBAction)myrqst:(id)sender;
- (IBAction)home:(id)sender;
-(void)setCourseperiodtextfielddata:(NSString*)str;
-(NSString *)getCourseperiodtextfielddata;
@property(strong,nonatomic)NSMutableDictionary *dic,*dic_techinfo;
@property(strong,nonatomic) IBOutlet UIImageView *img_profile;
-(void)fetchdata;
@property (strong, nonatomic) NSString*mptext;

@end
