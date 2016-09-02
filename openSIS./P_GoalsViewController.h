//
//  P_GoalsViewController.h
//  openSiS
//
//  Created by os4ed on 6/30/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_GoalsViewController : UIViewController<UITableViewDelegate>
{
    IBOutlet UITableView * tbl;
    IBOutlet UILabel*lbll;
    IBOutlet UIView*linevw;
}


@property(strong,nonatomic)NSString * st_id,*ssssyr,*schoolid;

@end
