//
//  mailview.h
//  openSiS
//
//  Created by EjobIndia on 22/12/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mailview : UIViewController

{

    IBOutlet  UIWebView *webview;
    IBOutlet UITextView *text_visew;
    IBOutlet UIView *top_view,*msg_view,*ppt_view;
    IBOutlet UILabel *rece_name,*lbl_id,*msg_name;
    IBOutlet UILabel *BCC;
    int flag;
    NSString *str;
    NSMutableData *myData ;
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    

}
@property (strong, nonatomic) IBOutlet UITableView *table_setup;
@property (strong, nonatomic)NSString *MAIL_ID,*view_select;
-(NSString *)stringByStrippingHTML;

-(IBAction)extra:(id)sender;
@end
