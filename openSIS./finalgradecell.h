//
//  finalgradecell.h
//  openSiS
//
//  Created by os4ed on 11/6/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface finalgradecell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *label_title, *label_name;
@property (strong, nonatomic) IBOutlet UIView *view_textfield;
@property (strong, nonatomic) IBOutlet UITextField *text_text;
@property(strong,nonatomic)IBOutlet UIButton *btn;


@end
