typedef NS_ENUM(NSInteger, SSCalendarDayCellStyle)
{
    SSCalendarDayCellStyleMonthly,
    SSCalendarDayCellStyleWeekly
};

typedef NS_ENUM(NSInteger, SSCalendarDayCellState)
{
    SSCalendarDayCellStateNone,
    SSCalendarDayCellStateToday,
    SSCalendarDayCellStateEvent,
    SSCalendarDayCellStateHighlight
};

@class SSDayNode;

@interface SSCalendarDayCell : UICollectionViewCell
{
    UIView *separatorView;
}

@property (nonatomic, strong) SSDayNode *day;
@property (nonatomic, assign) SSCalendarDayCellStyle style;
@property (nonatomic, assign) SSCalendarDayCellState state;
@property (nonatomic, strong) IBOutlet UILabel *label;

- (void)setDayBlackHighlight:(SSDayNode *)day;
@end
