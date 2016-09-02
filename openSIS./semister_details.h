//
//  semister_details.h
//  full_json
//
//  Created by os4ed on 2/25/16.
//  Copyright © 2016 os4ed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface semister_details : UIViewController<UITableViewDelegate>
{

    NSMutableDictionary *dic_value;
    NSString *mp_id_inside_touch;
    IBOutlet UIImageView *img_s;
    
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;


}

@property(nonatomic,strong) IBOutlet UILabel * quater_label , *sortname_lbl,* begind_lbl, *end_lbl,*grd_pos_bgn,*grd_pos_end ,*begins,*ends , *semester , *quater;
@property(nonatomic,strong) IBOutlet UIButton * btn12;

@property(nonatomic,strong) IBOutlet UITableView * quater_table;
@property (nonatomic,strong) IBOutlet UISwitch *grade,*exam,*comments;
@property (nonatomic,strong) NSMutableDictionary *  dictionary1;
@property(strong,nonatomic)NSString *str_mp_type;
@property (nonatomic,strong) NSMutableArray *arry_sem;
@end
