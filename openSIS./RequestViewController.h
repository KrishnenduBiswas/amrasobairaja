//
//  RequestViewController.h
//  openSiS
//
//  Created by os4ed on 3/9/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestViewController : UIViewController<UITableViewDataSource ,UITableViewDelegate>

{

    IBOutlet UITableView *table_reqt;

}
@property(strong,nonatomic) NSMutableDictionary *rqstdic;
@property(strong,nonatomic) NSMutableArray *rqstarry;



-(IBAction)home:(id)sender;

-(IBAction)action_edit:(id)sender;
-(IBAction)action_delete:(id)sender;
-(IBAction)close:(id)sender;

-(IBAction)addbtn:(id)sender;


@end
