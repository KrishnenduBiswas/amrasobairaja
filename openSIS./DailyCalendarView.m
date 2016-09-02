
//
#import "DailyCalendarView.h"
#import "NSDate+CL.h"
#import "UIColor+CL.h"

@interface DailyCalendarView()
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIView *dateLabelContainer;
@end


#define DATE_LABEL_SIZE 28
#define DATE_LABEL_FONT_SIZE 13

@implementation DailyCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.dateLabel];
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
    }
    
    return _dateLabel;
}




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

