//
//  EnrollinfoViewController.h
//  openSiS
//
//  Created by os4ed on 4/8/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_EnrollinfoViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>
{
    IBOutlet UILabel * clndrname,*rolling;
    IBOutlet UITableView *tabl_enrol;
}

@property(strong,nonatomic)NSString * st_id,*ssssyr,*schoolid;
@end
