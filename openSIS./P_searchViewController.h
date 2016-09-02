//
//  searchViewController.h
//  openSiS
//
//  Created by EjobIndia on 07/01/16.
//  Copyright (c) 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_searchViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate>
{

     IBOutlet UITableView *mtable;
    IBOutlet UISearchBar *theSearchBar;
    NSMutableArray   *allItemsArray;
    NSMutableArray   * displayItemsArray;

}
@property(strong,nonatomic)NSString *str_v;
@property(strong)NSString *str_search;
@property(strong)NSString *flag_field;
@end
