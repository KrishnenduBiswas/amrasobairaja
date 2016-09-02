//
//  P_LastfinalViewController.h
//  openSiS
//
//  Created by os4ed on 8/4/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface P_LastfinalViewController : UIViewController
{
    IBOutlet UITableView * tbl;
}
@property (nonatomic,weak) IBOutlet UITableView *tblForCollapse;
@property (nonatomic, retain) NSArray *arrayOriginal;
@property (nonatomic, retain) NSMutableArray *arForTable;

-(void)miniMizeThisRows:(NSArray*)ar;

@end
