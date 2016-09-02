//
//  finalgradecell.m
//  openSiS
//
//  Created by os4ed on 11/6/15.
//  Copyright © 2015 openSiS. All rights reserved.
//

#import "finalgradecell.h"

@implementation finalgradecell

- (void)awakeFromNib {
    // Initialization code
    
    _view_textfield.clipsToBounds = YES;
    _view_textfield.backgroundColor = [UIColor whiteColor];
    [_view_textfield.layer setCornerRadius:2.0f];
    [_view_textfield.layer setBorderWidth:1.0f];
    [_view_textfield.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
   // [self numpadtool];
    
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
