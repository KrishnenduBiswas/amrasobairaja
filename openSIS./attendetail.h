//
//  ScheduleMainViewController.h
//  openSiS
//
//  Created by os4ed on 9/10/15.
//  Copyright (c) 2015 openSiS. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CellTableViewCell.h"

@interface attendetail : UIViewController<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    
   // IBOutlet UITextField *text_markingPeriod;
    
    IBOutlet UITableView *table;
    IBOutlet UIView *baseView;
    int  slidewidth,slideheight,flag,k,change,incdecheight,scroller;
    float z;
    IBOutlet UILabel *msg_count_tab;
    NSMutableArray *ary,*ary_period_list,*ary_days;
    UISwipeGestureRecognizer *swipeup,*swipedown;
    
    
    

    
    
    
    
    
}




-(IBAction)click:(id)sender;


@end
