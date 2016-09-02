//
//  RequestTableViewCell.h
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title_lbl;
@property (strong, nonatomic) IBOutlet UILabel *wthtchr;
@property (strong, nonatomic) IBOutlet UILabel *prd_on;
@property (strong, nonatomic) IBOutlet UILabel *wthouttchr;
@property (strong, nonatomic) IBOutlet UILabel *prd_noton;

@end
