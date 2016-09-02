//
//  P_goalview2_ViewController.h
//  openSiS
//
//  Created by os4ed on 6/30/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_goalview2_ViewController : UIViewController
{
    IBOutlet UITableView * tbl;
    IBOutlet UILabel*lbll,*main_title;
    IBOutlet UILabel*goal_title,*cp,*dateentry,*ppname,*p_name,*p_asses;
}


@property(strong,nonatomic)NSString * st_id,*ssssyr,*schoolid,*goaltitle,*progress_title;

@property(strong,nonatomic) NSDictionary*dict;


@end
