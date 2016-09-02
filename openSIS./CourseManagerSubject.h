//
//  CourseManagerSubject.h
//  openSiS
//
//  Created by os4ed on 1/12/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseManagerSubject : UIViewController
{
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
}
-(void)accessingtheAppDelegateDictionary;
-(NSString *)getCourseperiodtextfielddata;
@end
