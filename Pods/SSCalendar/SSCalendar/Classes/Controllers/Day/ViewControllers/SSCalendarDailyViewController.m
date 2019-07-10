//
//  SSCalendarDailyViewController.m
//  Pods
//
//  Created by Steven Preston on 7/26/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarDailyViewController.h"
#import "SSCalendarDayCell.h"
#import "SSCalendarEventsCell.h"
#import "SSCalendarDayViewController.h"
#import "SSCalendarWeekViewController.h"
#import "SSCalendarWeekHeaderView.h"
#import "SSDayNode.h"
#import "SSConstants.h"
#import "SSDataController.h"
#import "SSEvent.h"
#import "GetOwnCalendarActivity.h"

@interface SSCalendarDailyViewController()<UISearchDisplayDelegate,UISearchBarDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSArray *calActivity;

@property (nonatomic, strong) SSDataController *dataController;

- (void)scrollWeekViewToDay;
- (void)scrollDayViewToDay;
- (void)selectDayInWeekView;
- (void)reloadDayLabel;

@end

@implementation SSCalendarDailyViewController
@synthesize isFromMonthView;

#pragma mark - Lifecycle Methods

- (id)initWithEvents:(NSArray *)events
{
    NSBundle *bundle = [SSCalendarUtils calendarBundle];
    if (self = [super initWithNibName:@"SSCalendarDailyViewController" bundle:bundle]) {
        self.dataController = [[SSDataController alloc] init];
        [_dataController setEvents:events];
        self.years = _dataController.calendarYears;
    }
    return self;
}


- (id)initWithDataController:(SSDataController *)dataController
{
    NSBundle *bundle = [SSCalendarUtils calendarBundle];
    if (self = [super initWithNibName:@"SSCalendarDailyViewController" bundle:bundle]) {
        self.dataController = dataController;
        self.years = _dataController.calendarYears;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
//    [[NSUserDefaults standardUserDefaults] setObject:_listAppointments forKey:@"APPOINTMENTS"];
//    [[NSUserDefaults standardUserDefaults] synchronize];

//    [defs registerDefaults:_listAppointments];
//
//    [defs synchronize];
    
    
    // then we add the button to the navigation bar
    //    self.navigationItem.rightBarButtonItem = myButton;
}
-(void) doTheBackThing {
    
    [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"showingDayView"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [self.navigationController popViewControllerAnimated:true];
}
// method called via selector
- (void) doTheThing {
    if(isListView){
        
        isListView = NO;
        [separatorView setHidden:NO];
        [_weekView setHidden:NO];
        [headerView setHidden:NO];
    }else{
        isListView = YES;
        [_weekView setHidden:YES];
        [separatorView setHidden:YES];
        [headerView setHidden:YES];

    }
}

- (void) serachTapped {
    [_searchBar setHidden:NO];
    [_searchBar becomeFirstResponder];
    [_weekView setHidden:YES];
    
    self.searchDisplayController.active = YES;
    self.searchDisplayController.searchBar.text = @"";
    [self.searchDisplayController.searchBar becomeFirstResponder];
}
- (void) showTestNotification:(NSNotification *) notification
{
    [_dayView reloadData];
    [_weekView reloadData];
//    _dayView.frame = defaultFrame;
//    [separatorView setHidden:NO];
}
- (void) receiveTestNotification:(NSNotification *) notification
{
//    _dayView.frame = CGRectMake(0.0, -100, self.view.frame.size.width, self.view.frame.size.height + 100);
//    [separatorView setHidden:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_searchBar setHidden:YES];
    
    if([ _todayvalue isEqual: @"todayy"]){
        [self today];
    }
    
    self.navigationItem.rightBarButtonItem = nil;
    
    todayBarButtonItem.title = @"Tday";
    //    headerView.backgroundColor = [UIColor colorWithHexString:COLOR_BACKGROUND_OFF_WHITE];
    
    headerView.backgroundColor = [UIColor whiteColor];
    separatorView.backgroundColor = [UIColor colorWithHexString:COLOR_SEPARATOR];
    separatorViewHeightConstraint.constant = [SSDimensions onePixel];
    
    self.weekViewController = [[SSCalendarWeekViewController alloc] initWithView:_weekView];
    _weekView.dataSource = _weekViewController;
    _weekView.delegate = self;
    
    
    self.dayViewController = [[SSCalendarDayViewController alloc] initWithView:_dayView andDict:_listAppointments];
    //    self.listAppointments =
    _dayView.dataSource = _dayViewController;
    _dayView.delegate = self;
    
    _weekViewController.years = _years;
    _dayViewController.days = _weekViewController.days;
    
    defaultFrame = _dayView.frame;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showTestNotification:)
                                                 name:@"showList"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"hideList"
                                               object:nil];
    // first we create a button and set it's properties
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc]init];
    myButton.action = @selector(serachTapped);
    myButton.title = @"";
    myButton.image = [UIImage imageNamed:@"ic_search"];
    myButton.target = self;
    
    // first we create a button and set it's properties
    UIBarButtonItem *listBtn = [[UIBarButtonItem alloc]init];
    listBtn.action = @selector(doTheThing);
    listBtn.title = @"";
    listBtn.image = [UIImage imageNamed:@"ic_list_view"];
    listBtn.target = self;
    
    // self.navigationItem.rightBarButtonItems = @[listBtn];
    
    
    if(isFromMonthView == YES) {
        [self todayPressed:self];
    }
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setTintColor:[UIColor whiteColor]];
    
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:COLOR_SECONDARY], NSForegroundColorAttributeName, [UIFont systemFontOfSize:17.0], NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:COLOR_SECONDARY];
    
    UIView* leftButtonView = [[UIView alloc]initWithFrame:CGRectMake(-20, 0, 140, 50)];
    
    leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.backgroundColor = [UIColor clearColor];
    leftButton.frame = leftButtonView.frame;
    [leftButton setImage:[UIImage imageNamed:@"ic_back_arrow"] forState:UIControlStateNormal];
    //    [leftButton setTitle:_selectedYear forState:UIControlStateNormal];
    leftButton.tintColor = [UIColor colorWithHexString:COLOR_SECONDARY]; //Your desired color.
    leftButton.autoresizesSubviews = YES;
    leftButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    [leftButton addTarget:self action:@selector(doTheBackThing) forControlEvents:UIControlEventTouchUpInside];
    [leftButtonView addSubview:leftButton];
    
    UIBarButtonItem* leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButtonView];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:COLOR_SECONDARY], NSForegroundColorAttributeName, [UIFont systemFontOfSize:17.0], NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:COLOR_SECONDARY];
    
    [_dayView setUserInteractionEnabled:TRUE];
    
    [[NSUserDefaults standardUserDefaults]setBool:true forKey:@"showingDayView"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"showedDailyView"];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"showedDailyView"
     object:self];
    
    [SSStyles hideShadowOnNavigationBar:self.navigationController.navigationBar];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:@"showList"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"hideList"];

    [[NSNotificationCenter defaultCenter] removeObserver:@"hidedDailyView"];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"hidedDailyView"
     object:self];
    
    [SSStyles showShadowOnNavigationBar:self.navigationController.navigationBar];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_weekViewController updateLayoutForBounds:_weekView.bounds];
    // reloadData seems to be required to invalidate the collection view and lay it out correctly. Only needed for 2nd and onwards view loads on a month that has already been viewed.
    [_weekView reloadData];

    [self scrollWeekViewToDay];
    [self scrollDayViewToDay];
    [self selectDayInWeekView];
    [self reloadDayLabel];
}


- (void)refresh
{
    [_weekView reloadData];
    [self selectDayInWeekView];
    BOOL requestMade = NO;//[[SSDataController shared] requestEventsWithYear:_day.year Month:_day.month];
    if (requestMade)
    {
        [_dayView reloadData];
    }
}


#pragma mark - Setter Methods

- (void)setDay:(SSDayNode *)day
{
    _day = day;

    BOOL requestMade = NO;//[[SSDataController shared] requestEventsWithYear:_day.year Month:_day.month];
    if (requestMade)
    {
        [_dayView reloadData];
    }
}


#pragma mark - UI Action Methods

- (IBAction)tappedToday:(id)sender {
    NSDateComponents *components = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
    for (SSDayNode *day in _weekViewController.days)
    {
        if ([day isEqualToDateComponents:components])
        {
            self.day = day;
            [self scrollWeekViewToDay];
            [self scrollDayViewToDay];
            [self selectDayInWeekView];
            [self reloadDayLabel];
            break;
        }
    }
}
- (IBAction)tappedFilter:(id)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:@"tappedFilter"];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"tappedFilter"
     object:self];
}
- (IBAction)todayPressed:(id)sender
{
    NSDateComponents *components = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
    for (SSDayNode *day in _weekViewController.days)
    {
        if ([day isEqualToDateComponents:components])
        {
            self.day = day;
            [self scrollWeekViewToDay];
            [self scrollDayViewToDay];
            [self selectDayInWeekView];
            [self reloadDayLabel];
            break;
        }
    }
}

-(void)today {
    NSDateComponents *components = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    
    for (SSDayNode *day in _weekViewController.days)
    {
        if ([day isEqualToDateComponents:components])
        {
            self.day = day;
            [self scrollWeekViewToDay];
            [self scrollDayViewToDay];
            [self selectDayInWeekView];
            [self reloadDayLabel];
            break;
        }
    }
}


#pragma mark - UI Helper Methods

- (void)scrollWeekViewToDay
{
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) _weekView.collectionViewLayout;
    
    NSInteger row = [SSCalendarUtils numberOfDaysFrom:_weekViewController.startDate To:_day.date];
    row = row - row % 7;
    
    _weekView.contentOffset = CGPointMake(row * layout.itemSize.width, 0);
}


- (void)scrollDayViewToDay
{
    if ([_dayViewController.day isEqual:_day])
    {
        return;
    }
    [_dayViewController scrollToDay:_day animated:YES];
}


- (void)selectDayInWeekView
{
    NSInteger row = [SSCalendarUtils numberOfDaysFrom:_weekViewController.startDate To:_day.date];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    [_weekView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
}


- (void)reloadDayLabel
{
    //TODO: Constant
    NSDate *date = [_day date];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"yearPicked"
     object:[NSString stringWithFormat:@"%@",[StellarConversionUtils stringFromDate:date withFormat:@"MMM d, yyyy"]]];
    [leftButton setTitle:[NSString stringWithFormat:@"%@",[StellarConversionUtils stringFromDate:date withFormat:@"MMM d, yyyy"]] forState:UIControlStateNormal];
//    _dateLabel.text = [StellarConversionUtils stringFromDate:date withFormat:@"EEEE MMMM d, yyyy"];
}


#pragma mark - UICollectionViewDelegateMethods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _weekView)
    {
        SSCalendarDayCell *cell = (SSCalendarDayCell *) [collectionView cellForItemAtIndexPath:indexPath];
        self.day = cell.day;

        [self scrollDayViewToDay];
        [self reloadDayLabel];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _weekView)
    {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) _weekView.collectionViewLayout;
    
        NSInteger sundayIndex = (NSInteger) (_weekView.contentOffset.x / layout.itemSize.width);
        NSInteger weekdayIndex = _day.weekday;
        NSInteger index = sundayIndex + weekdayIndex;
        
        self.day = [_weekViewController.days objectAtIndex:index];
        
        [self scrollDayViewToDay];
        [self selectDayInWeekView];
        [self reloadDayLabel];
    }
    else if (scrollView == _dayView)
    {
        NSInteger index = (NSInteger) (_dayView.contentOffset.x / _dayView.bounds.size.width);
        SSDayNode *day = [_dayViewController.visibleDays objectAtIndex:index];
        
        self.day = day;
        _dayViewController.day = day;
        [_dayViewController reloadDay];
        
        [self scrollWeekViewToDay];
        [self selectDayInWeekView];
        [self reloadDayLabel];
    }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == _dayView)
    {
        [_dayViewController reloadDay];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _dayView)
    {
        return _dayView.bounds.size;
    }
    else
    {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) _weekView.collectionViewLayout;
        return layout.itemSize;
    }
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    if(searchBar.text.length == 0){
        [_searchBar setHidden:YES];
        [_weekView setHidden:NO];
    }
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSString *preStr = [NSString stringWithFormat:@"(name BEGINSWITH[cd] '%@')", searchText];
    NSPredicate *sPredicate = [NSPredicate predicateWithFormat:preStr];
    searchResults = [_addEvents filteredArrayUsingPredicate:sPredicate];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [_searchBar setHidden:YES];
    [_weekView setHidden:NO];
    
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResults count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    SSEvent *event = searchResults[indexPath.row];
    cell.textLabel.text = event.name;
    
    NSString *getStr = event.startTime;
    
    NSArray *sep = [getStr componentsSeparatedByString:@"!@#"];
    
    NSString *startTime = @"";
    NSString *endTime = @"";
    
    if (sep.count > 0 ){
        startTime = sep[0];
        if (sep.count > 1 ){
            startTime = [NSString stringWithFormat:@"%@",sep[0]];
            endTime = [NSString stringWithFormat:@"%@",sep[1]];
        }
        if (sep.count > 2) {
            //            nameLabel.backgroundColor = [UIColor colorWithHexString:[NSString stringWithFormat:@"#%@",sep[2]]];
        }
    }else{
        startTime = event.startTime;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@    %@",startTime,event.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@       %@",endTime,event.desc];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GetOwnCalendarModel *model = [[ GetOwnCalendarModel alloc]initWithDictionary:_listAppointments];
    _calActivity = model.activities;
    
    SSEvent *event = searchResults[indexPath.row];
    NSLog(@"AppointmentTypeID : %@",event.contact);
    [[NSUserDefaults standardUserDefaults]setObject:event.contact forKey:@"appointmentTypeID"];
     [[NSUserDefaults standardUserDefaults]synchronize];

    for (int k=0; k<_calActivity.count; k++) {
        GetOwnCalendarActivity *model = _calActivity[k];
        NSString *strType = [NSString stringWithFormat:@"%@",model.type];
        if (model.activity.idField == event.location) {
            
            if ([strType isEqualToString:@"Task"]) {
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"pushToActivity"
                 object:model.toDictionary];
            }else{
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"pushToActivity1"
                 object:model.toDictionary];
            }
        }
    }

}
@end
