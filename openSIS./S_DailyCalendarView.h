//
//  S_DailyCalendarView.h
//  openSiS
//
//  Created by os4ed on 5/13/16.
//  Copyright © 2016 openSiS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DailyCalendarViewDelegate <NSObject>
-(void)dailyCalendarViewDidSelect: (NSDate *)date;

@end
@interface S_DailyCalendarView : UIView
@property (nonatomic, weak) id<DailyCalendarViewDelegate> delegate;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) BOOL blnSelected;
@property(strong,nonatomic)NSString * str;
-(void)markSelected:(BOOL)blnSelected;
-(UILabel*)presentlabel;
-(void)checking:(NSString*)date second:(NSString*)statecode;

@end
