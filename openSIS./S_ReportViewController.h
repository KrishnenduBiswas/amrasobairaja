//
//  S_ReportViewController.h
//  openSiS
//
//  Created by os4ed on 4/28/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface S_ReportViewController : UIViewController
{
    IBOutlet UITableView * tbl;
    IBOutlet UILabel * nodatafound;
}
@property(strong,nonatomic) NSString * sel_mp;
-(IBAction)btndate:(UIButton*)sender;
-(void)loaddata;
@end
