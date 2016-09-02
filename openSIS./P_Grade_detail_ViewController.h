//
//  Grade_detail_ViewController.h
//  openSiS
//
//  Created by os4ed on 3/15/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface P_Grade_detail_ViewController : UIViewController<UITableViewDataSource , UITableViewDelegate>
{


    IBOutlet UITableView * tblsec;
    
    
   ;


}
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *mp_text;
@property (strong, nonatomic) NSString* c_id;
@end
