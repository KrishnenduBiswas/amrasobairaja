//
//  MsgvwViewController.h
//  openSiS
//
//  Created by os4ed on 5/4/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgvwViewController : UIViewController
{
    NSString    * student_id,*view_select,*s_year,*s_year_id ,*inbox_data , * term_flag;
    IBOutlet  UIWebView *webview;
    IBOutlet UITextView *text_visew;
    IBOutlet UIView *top_view,*msg_view,*ppt_view;
    IBOutlet UILabel *rece_name,*lbl_id,*msg_name;
    IBOutlet UILabel *BCC;
    int flag;
    NSString *str;
    NSMutableData *myData ;
}
@property (strong, nonatomic) IBOutlet UITableView *table_setup;
@property (strong, nonatomic)NSString *MAIL_ID,*view_select;
-(NSString *)stringByStrippingHTML;

-(IBAction)extra:(id)sender;


@end
