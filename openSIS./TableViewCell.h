//
//  TableViewCell.h
//  Medicines Index & Guide
//
//  Created by os4ed on 7/14/15.
//  Copyright (c) 2015 os4ed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name,*msg1,*date1;


@property (weak, nonatomic) IBOutlet UIButton *show;
//-(IBAction)addvalue:(id)sender;
@end
