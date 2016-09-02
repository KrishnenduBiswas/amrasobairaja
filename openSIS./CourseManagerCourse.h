//
//  CourseManagerCourse.h
//  openSiS
//
//  Created by os4ed on 1/12/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseManagerCourse : UIViewController
{
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
}
@property (strong) NSString *subject_id;
@property(strong,nonatomic)NSString *str_header_lbl;
@end
