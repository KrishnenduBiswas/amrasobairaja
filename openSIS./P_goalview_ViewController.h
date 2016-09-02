//
//  P_goalview_ViewController.h
//  openSiS
//
//  Created by os4ed on 6/30/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_goalview_ViewController : UIViewController
{
    IBOutlet UITableView * tbl;
    IBOutlet UILabel*lbll,*main_title;
}


@property(strong,nonatomic)NSString * st_id,*ssssyr,*schoolid,*prog_title;
@property(strong,nonatomic) NSDictionary*dict;
@end
