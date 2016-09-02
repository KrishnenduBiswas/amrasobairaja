//
//  SearchVC.h
//  openSiS
//
//  Created by os4ed on 4/5/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchVC : UIViewController<UISearchBarDelegate,UITableViewDelegate>
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
