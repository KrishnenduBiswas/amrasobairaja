//
//  MyInformationCertificationCell.h
//  openSiS
//
//  Created by subhajit halder on 12/01/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInformationCertificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_Certname;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Certcode;
@property (weak, nonatomic) IBOutlet UILabel *lbl_validfrom;
@property (weak, nonatomic) IBOutlet UILabel *lbl_validThru;
@property (weak, nonatomic) IBOutlet UILabel *lbl_certDesc;
@property (weak, nonatomic) IBOutlet UIButton *edit_btn,*delete_btn;

@property (weak, nonatomic) IBOutlet UIView *HIDDEN_view_table;
@end
