//
//  searchViewController.h
//  openSiS
//
//  Created by EjobIndia on 07/01/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate>
{

     IBOutlet UITableView *mtable;
    IBOutlet UISearchBar *theSearchBar;
    NSMutableArray   *allItemsArray;
    NSMutableArray   * displayItemsArray;
    
    IBOutlet UITextField *lbl_hidden;
    
    IBOutlet UILabel *notofi,*msg_count_tab;
    IBOutlet UILabel *msg_count;
    


}
@property(strong,nonatomic)NSString *str_v;
@property(strong)NSString *str_search;
@property(strong)NSString *flag_field;
@end
