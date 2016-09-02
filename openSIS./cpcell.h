//
//  cpcell.h
//  openSiS
//
//  Created by os4ed on 4/22/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cpcell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *astype_lbl;
@property (strong, nonatomic) IBOutlet UILabel *asdata_lbl;
@property (strong, nonatomic) IBOutlet UILabel *duedate_lbl;
@property (strong, nonatomic) IBOutlet UILabel *percent_lbl;
@property (strong, nonatomic) IBOutlet UILabel *grdrang_lbl;
@property (strong, nonatomic) IBOutlet UILabel *letter_lbl;
@property (strong, nonatomic) IBOutlet UILabel *pointp_lbl;
@property (strong, nonatomic) IBOutlet UILabel *sec_lbl;

@end
