//
//  BccViewController.h
//  openSiS
//
//  Created by os4ed on 5/2/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BccViewController : UIViewController
{
    NSString    * student_id,*view_select,*s_year,*s_year_id ,*inbox_data , * term_flag;
    NSString *str_selectedgroupID;

    
    
    
}
@property (strong, nonatomic) NSString *str_To;
@property (strong, nonatomic) NSString *stradd1;
@property (strong, nonatomic) NSString *str_cc;
@property (strong, nonatomic) NSString *str_prev_cc;
@property (strong, nonatomic) NSString *str_bcc;
@property (strong, nonatomic) NSString *userIsEditindToField;

@end
