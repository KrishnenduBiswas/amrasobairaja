
//
#import "P_DailyCalendarView.h"
#import "NSDate+CL.h"
#import "UIColor+CL.h"
#import "S_attendence_weekViewController.h"
#import "AppDelegate.h"

@interface P_DailyCalendarView()
{
    
    NSString* state;
    
    S_attendence_weekViewController*obj;
    
    
    
}
@property (nonatomic, strong) UILabel *dateLabel,*presentlabel;
@property (nonatomic, strong) UIView *dateLabelContainer;
@end


#define DATE_LABEL_SIZE 28
#define DATE_LABEL_FONT_SIZE 13

@implementation P_DailyCalendarView
@synthesize str;

- (id)initWithFrame:(CGRect)frame
{
    
    
    obj=[[S_attendence_weekViewController alloc]init];
    
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.dateLabel];
        [self addSubview:self.presentlabel];
        [self addSubview:self.dateLabelContainer];
        
        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dailyViewDidClick:)];
        [self addGestureRecognizer:singleFingerTap];
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    return self;
}
-(UIView *)dateLabelContainer
{
    
    /* corner radius bondo korlam tai malta round thaklona then height change kore line kore dilam, sathe opoero
     self.datelabel ta lagalam, r
     */
    if(!_dateLabelContainer){
        float x = (self.bounds.size.width - DATE_LABEL_SIZE)/2;
        _dateLabelContainer = [[UIView alloc] initWithFrame:CGRectMake(x+2, 24, DATE_LABEL_SIZE-4, 2)];
        _dateLabelContainer.backgroundColor =  [UIColor colorWithRed:0.129f green:0.608f blue:0.910f alpha:1.00f];
        // _dateLabelContainer.layer.cornerRadius = DATE_LABEL_SIZE/2;
        _dateLabelContainer.clipsToBounds = YES;
        
        //[_dateLabelContainer addSubview:self.dateLabel];
        
        //[self.dateLabel addSubview:_dateLabelContainer];
    }
    return _dateLabelContainer;
}
-(UILabel *)dateLabel
{
    
    
    
    
    if(!_dateLabel){
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        float x = (self.bounds.size.width - DATE_LABEL_SIZE)/2;
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, DATE_LABEL_SIZE, DATE_LABEL_SIZE)];
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.textColor = [UIColor blackColor];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        //_dateLabel.layer.borderWidth = 1.0f;
        // _dateLabel.layer.borderColor = [[UIColor colorWithHex:0x7aa248] CGColor];
        _dateLabel.font = [UIFont systemFontOfSize:DATE_LABEL_FONT_SIZE];
        
        
        
        
        
        
        AppDelegate*appdel=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        
        for (int i=0; i<appdel.dateary.count; i++) {
            if ([_dateLabel.text isEqual:[appdel.dateary objectAtIndex:i]]) {
                NSLog(@"matched");
            }
        }

        
        
        
        
        
        
        
        
        
        
    }
    
    return _dateLabel;
}

-(UILabel*)presentlabel
{
    
    
    
    if(!_presentlabel){
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //str=[obj performSelector:@selector(loaddatax1) withObject:nil];
        
        
        str=@"A";
        NSLog(@"rrrrrrrrr%@",str);
        
        float x = (self.bounds.size.width - DATE_LABEL_SIZE-5)/2;
        _presentlabel.text=str;
        _presentlabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 30, DATE_LABEL_SIZE+5, DATE_LABEL_SIZE-12)];
        if ([_presentlabel.text isEqualToString:@"A"]) {
        _presentlabel.backgroundColor = [UIColor redColor];
        }
        else if ([_presentlabel.text isEqualToString:@"P"]) {
            _presentlabel.backgroundColor = [UIColor greenColor];
        }
         else if ([_presentlabel.text isEqualToString:@"T"]) {
            _presentlabel.backgroundColor = [UIColor orangeColor];
        }
        _presentlabel.backgroundColor = [UIColor greenColor];
        _presentlabel.textColor = [UIColor whiteColor];
        _presentlabel.textAlignment = NSTextAlignmentCenter;
        _presentlabel.text=str;
        _presentlabel.font = [UIFont systemFontOfSize:DATE_LABEL_FONT_SIZE-2];
    }
    
    return _presentlabel;

    
    
    
    
    
}



//-(void)checking:(NSString*)date second:(NSString*)statecode
//{
//    
//    
//    
//    
//            NSDateFormatter * dff1=[[NSDateFormatter alloc]init];
//            [dff1 setDateFormat:@"yyyy-MM-dd"];
//            NSDate*date1=[dff1 dateFromString:date];
//    
//    
//            NSDateFormatter * dff=[[NSDateFormatter alloc]init];
//            [dff setDateFormat:@"dd"];
//            NSString*dayonly=[dff stringFromDate:date1];
//    
//    
//            NSLog(@"%@",dayonly);
//     
//    
//    state=statecode;
//    
//    
//    //[self presentlabel];
//
//    
//    
//    
//    
//    
//    
//    
//    
//    
//}
//






















-(void)setDate:(NSDate *)date
{
    _date = date;
    
    [self setNeedsDisplay];
}
-(void)setBlnSelected: (BOOL)blnSelected
{
    _blnSelected = blnSelected;
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.dateLabel.text = [self.date getDateOfMonth];
    
}

-(void)markSelected:(BOOL)blnSelected
{
    //    DLog(@"mark date selected %@ -- %d",self.date, blnSelected);
    // if([self.date isDateToday]){
    self.dateLabelContainer.backgroundColor = (blnSelected)?[UIColor colorWithHex:0x219BE8]: [UIColor clearColor];
    
    self.dateLabel.textColor = (blnSelected)?[UIColor colorWithHex:0x717171]:[UIColor colorWithHex:0x717171];
    // }else{
    //   self.dateLabelContainer.backgroundColor = (blnSelected)?[UIColor whiteColor]: [UIColor clearColor];
    
    //    self.dateLabel.textColor = (blnSelected)?[UIColor colorWithRed:52.0/255.0 green:161.0/255.0 blue:255.0/255.0 alpha:1.0]:[self colorByDate];
    //}
    
    
    
    
}
-(UIColor *)colorByDate
{
    return [self.date isPastDate]?[UIColor colorWithHex:0x00000]:[UIColor  blackColor];
}

-(void)dailyViewDidClick: (UIGestureRecognizer *)tap
{
    [self.delegate dailyCalendarViewDidSelect: self.date];
}
@end

