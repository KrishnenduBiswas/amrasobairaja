//
//  EnrollinfoViewController.h
//  openSiS
//
//  Created by os4ed on 4/8/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnrollinfoViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>
{
    IBOutlet UILabel * clndrname,*rolling;
    IBOutlet UITableView *tabl_enrol;
}

@end
