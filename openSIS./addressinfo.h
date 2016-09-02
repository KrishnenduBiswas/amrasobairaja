//
//  EnrollinfoViewController.h
//  openSiS
//
//  Created by os4ed on 4/8/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addressinfo : UIViewController<UITableViewDataSource ,UITableViewDelegate>
{
    IBOutlet UILabel * clndrname,*rolling;
    IBOutlet UITableView *tabl_enrol;
}
@property (strong, nonatomic) IBOutlet UILabel *addrss;
@property (strong, nonatomic) IBOutlet UILabel *street;
@property (strong, nonatomic) IBOutlet UILabel *city;
@property (strong, nonatomic) IBOutlet UILabel *state;
@property (strong, nonatomic) IBOutlet UILabel *zipcode;

@end
