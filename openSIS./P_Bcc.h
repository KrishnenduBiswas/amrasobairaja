//
//  Bcc.h
//  openSiS
//
//  Created by os4ed on 1/8/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_Bcc : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{

    NSMutableArray * course_period_title;
    NSString *term_flag;
    NSString *inbox_data;

}
@property (strong, nonatomic) NSString *str_To;
@property (strong, nonatomic) NSString *stradd1;
@property (strong, nonatomic) NSString *str_cc;
@property (strong, nonatomic) NSString *str_prev_cc;
@property (strong, nonatomic) NSString *str_bcc;
@property (strong, nonatomic) NSString *userIsEditindToField;

@end
