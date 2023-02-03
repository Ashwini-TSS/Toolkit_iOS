//
//  SSCalendarMonthlyViewController.m
//  Pods
//
//  Created by Steven Preston on 7/24/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarMonthlyViewController.h"
#import "SSCalendarAnnualViewController.h"
#import "SSCalendarMonthlyDataSource.h"
#import "SSCalendarDailyViewController.h"
#import "SSCalendarDayCell.h"
#import "SSYearNode.h"
#import "SSDayNode.h"
#import "SSConstants.h"
#import "SSDataController.h"
#import "SSCalendarCountCache.h"
#import "GetOwnCalendarActivity.h"
#import "MonthListAppointmentCell.h"
#import "SSEvent.h"
@class Weeklyviewcontroller;
@class CalendarController;

@interface SSCalendarMonthlyViewController()<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) SSDataController *dataController;
@property NSArray *calActivity;
@property SSCalendarDayCell *daycell;
@property BOOL *isFirstToday;
@property BOOL *isScrolledUP;
@property (nonatomic, strong) IBOutlet UICollectionView *customyearView;
@property (nonatomic, strong) NSIndexPath *customIndexpath;
- (void)scrollToIndexPath:(NSIndexPath *)indexPath updateTitle:(BOOL)updateTitle;

@end

@implementation SSCalendarMonthlyViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    }
    //  customTbl.frame = CGRectMake(0, 0, halfView.frame.size.width,44 * tableData.count+700);
    return tableData.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    SSEvent *event = [SSEvent alloc];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        event = searchResults[indexPath.row];
    }else{
        event = tableData[indexPath.row];
    }
    
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
    
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 15.0 ];
    cell.textLabel.font  = myFont;
    cell.detailTextLabel.font  = myFont;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@     %@",endTime,event.desc]];
    [text addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor] range: NSMakeRange(0,7)];
    [text addAttribute: NSForegroundColorAttributeName value: [UIColor grayColor] range: NSMakeRange(13, event.desc.length)];
    [cell.detailTextLabel setAttributedText: text];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@     %@",startTime,event.name];
    // cell.detailTextLabel.text = [NSString stringWithFormat:@"%@     %@",endTime,event.desc];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SSEvent *event = [SSEvent alloc];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        event = searchResults[indexPath.row];
        for (int k=0; k<_calActivity.count; k++) {
            GetOwnCalendarActivity *model = _calActivity[k];
            NSString *strType = [NSString stringWithFormat:@"%@",model.type];
            if (model.activity.idField == event.location) {
                
                if ([strType isEqualToString:@"Task"]) {
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"pushToActivity"
                     object:model.toDictionary];
                }else{
//                    if(event.isAllday){
//                        [[NSNotificationCenter defaultCenter]
//                         postNotificationName:@"Allday"
//                         object:@"true"];
//                    }
                    [[NSUserDefaults standardUserDefaults]setObject:_calActivity forKey:@"appointmentPobject"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"pushToActivity1"
                     object:model.toDictionary];
                    
                }
            }
        }
        [_searchBar setHidden:YES];
        [_yearView setHidden:NO];
    }else{
        SSEvent *event = tableData[indexPath.row];
        for (int k=0; k<_calActivity.count; k++) {
            GetOwnCalendarActivity *model = _calActivity[k];
            NSString *strType = [NSString stringWithFormat:@"%@",model.type];
            if (model.activity.idField == event.location) {
                
                if ([strType isEqualToString:@"Task"]) {
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"pushToActivity"
                     object:model.toDictionary];
                }else{
//                    if(event.isAllday){
//                        [[NSNotificationCenter defaultCenter]
//                         postNotificationName:@"Allday"
//                         object:@"true"];
//                    }
                    [[NSUserDefaults standardUserDefaults]setObject:_calActivity forKey:@"appointmentPobject"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"pushToActivity1"
                     object:model.toDictionary];
                }
            }
        }
    }
}
-(NSString*)convertDateFormat:(NSString*)strDate {
    if (strDate.length == 0 ) {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    
    NSDate *date = [formatter dateFromString:strDate];
    
    if (date) {
        formatter.dateFormat = @"hh:mm a";
        formatter.locale = formatter.locale;
        NSString *dateString = [formatter stringFromDate:date];
        return dateString;
    }
    return @"";
}
#pragma mark - Lifecycle Methods

- (id)initWithEvents:(NSArray *)events
{
    NSBundle *bundle = [SSCalendarUtils calendarBundle];
    if (self = [super initWithNibName:@"SSCalendarAnnualViewController" bundle:bundle]) {
        self.dataController = [[SSDataController alloc] init];
        [_dataController setEvents:events];
        self.years = _dataController.calendarYears;
    }
    return self;
}


- (id)initWithDataController:(SSDataController *)dataController
{
    NSBundle *bundle = [SSCalendarUtils calendarBundle];
    if (self = [super initWithNibName:@"SSCalendarAnnualViewController" bundle:bundle]) {
        self.dataController = dataController;
        self.years = _dataController.calendarYears;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}




- (void) doTheBackThing {
    
    [self.navigationController popViewControllerAnimated:true];
}

-(void) getAppointmentInfo{
    GetOwnCalendarModel *model = [[GetOwnCalendarModel alloc]initWithDictionary:_listAppointments];
    _calActivity = model.activities;
    [[NSUserDefaults standardUserDefaults]setObject:_calActivity forKey:@"appointmentPobject"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    //    NSKeyedArchiver *archeive = [NSKeyedArchiver archivedDataWithRootObject:model];
    //    [NSUserDefaults.standardUserDefaults setObject:archeive forKey:@"userSelectedModel"];
    //    [NSUserDefaults.standardUserDefaults synchronize];
}

// method called via selector
- (void) doTheThing {
    if (isListTapped){

        btnList.image = [UIImage imageNamed:@"ic_list_view"];
        isListTapped = NO;
        [customTbl removeFromSuperview];

    }else{
        btnList.image = [UIImage imageNamed:@"ic_selected_list"];

        isListTapped = YES;
        halfView = [UIView new];
        halfView.backgroundColor = [UIColor whiteColor];
        halfView.frame = CGRectMake(0.0, self.view.frame.size.height / 2, self.view.frame.size.width, self.view.frame.size.height);
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Weeklyviewcontroller *sb = (Weeklyviewcontroller *)[storyboard instantiateViewControllerWithIdentifier:@"Weeklyviewcontroller"];
        NSDate * date1 = [NSDate date];
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"dd-MM-yyyy"];
        NSString *date = [df stringFromDate:date1];
        NSString * str = [NSString stringWithFormat: @"%@", date];
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"selectDay"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //[sb willMoveToParentViewController:self];
        [self.view addSubview:sb];
       

//        customTbl = [[UITableView alloc]initWithFrame:CGRectMake(0.0, self.view.frame.size.height / 2, self.view.frame.size.width, self.view.frame.size.height/2)];
//
//        customTbl.delegate = self;
//        customTbl.dataSource = self;
//
//        // [halfView addSubview:customTbl];
//        [self.view addSubview:customTbl];
//
//
//        NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
//
//        NSDateComponents *components = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
//
//        NSInteger monthCount = 0;
//        for (SSYearNode *year in _years)
//        {
//            if (year.value == components.year)
//            {
//                monthCount = monthCount + components.month - 1;
//                break;
//            }
//            else
//            {
//                monthCount = monthCount + year.months.count;
//            }
//        }
//
//        NSInteger currentMonth = [components1 day];
//
//        //    currentMonth = currentMonth + 1;
//
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentMonth inSection:monthCount];
//        SSCalendarDayCell *cell = (SSCalendarDayCell *) [_yearView cellForItemAtIndexPath:indexPath];
//        tableData = cell.day.events;
//        [customTbl reloadData];
    }
    
}



- (void) serachTapped {
    [_searchBar setHidden:NO];
    [_searchBar becomeFirstResponder];
    [_yearView setHidden:YES];
    
    self.searchDisplayController.active = YES;
    self.searchDisplayController.searchBar.text = @"";
    [self.searchDisplayController.searchBar becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    self.customyearView = nil;
    self.customIndexpath  = nil;
    [self getAppointmentInfo];
    self.isScrolledUP = false;
    [_searchBar setHidden:YES];
    //    _tblList.delegate = self;
    //    _tblList.dataSource = self;
    
    todayBarButtonItem.title = @"Today";
    
    // separatorView.backgroundColor = [UIColor colorWithHexString:COLOR_SEPARATOR];
    separatorViewHeightConstraint.constant = [SSDimensions onePixel];
    
    self.dataSource = [[SSCalendarMonthlyDataSource alloc] initWithView:_yearView];
    _yearView.dataSource = _dataSource;
    _yearView.delegate = self;
    
    _dataSource.years = _years;
    
    [self refresh];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSArray *visibleCells = [_yearView visibleCells];
        
        for (SSCalendarDayCell *cell in visibleCells)
        {
            if (cell.day != nil && cell.frame.origin.y >= 0)
            {
                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                NSString *monthName = [[df monthSymbols] objectAtIndex:(cell.day.month-1)];
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"yearPicked"
                 object:[NSString stringWithFormat:@"%@ %@",monthName,[NSString stringWithFormat:@"%li", (long)cell.day.year]]];
                break;
            }
        }
    });
    
    // first we create a button and set it's properties
    btnSearch = [[UIBarButtonItem alloc]init];
    btnSearch.action = @selector(serachTapped);
    btnSearch.title = @"";
    btnSearch.image = [UIImage imageNamed:@"ic_search"];
    btnSearch.target = self;
    
    UIView* leftButtonView = [[UIView alloc]initWithFrame:CGRectMake(-40, 0, 110, 50)];
    
    UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.backgroundColor = [UIColor clearColor];
    leftButton.frame = leftButtonView.frame;
    [leftButton setImage:[UIImage imageNamed:@"ic_back_arrow"] forState:UIControlStateNormal];
    [leftButton setTitle:_selectedYear forState:UIControlStateNormal];
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
    
    
    if(_isFromMonthView) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self todayPressed:self];
        });
        
    }
   
    
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
    [_dataSource updateLayoutForBounds:_yearView.bounds];
    
    if (_startingIndexPath != nil)
    {
        [self scrollToIndexPath:_startingIndexPath updateTitle:YES];
        self.startingIndexPath = nil;
    }
}

- (IBAction)tappedFilter:(id)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:@"tappedFilter"];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"tappedFilter"
     object:self];
    
}
- (IBAction)tappedToday:(id)sender {
    [self todayPressed:self];
}

- (void)refresh
{
    SSCalendarCountCache *calendarCounts = _dataController.calendarCountCache;
    if (calendarCounts != nil)
    {
        [_dataController updateCalendarYears];
        [_yearView reloadData];
    }
}


#pragma mark - UI Action Methods

- (IBAction)todayPressed:(id)sender
{
    
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSDateComponents *components = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
    
    NSInteger monthCount = 0;
    for (SSYearNode *year in _years)
    {
        if (year.value == components.year)
        {
            monthCount = monthCount + components.month - 1;
            break;
        }
        else
        {
            monthCount = monthCount + year.months.count;
        }
    }
    
    NSInteger currentMonth = [components1 day];
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentMonth inSection:monthCount];
    self.daycell = (SSCalendarDayCell *) [_yearView cellForItemAtIndexPath:indexPath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    Weeklyviewcontroller *myNewVC = (Weeklyviewcontroller *)[storyboard instantiateViewControllerWithIdentifier:@"Weeklyviewcontroller"];
    NSDate * date1 = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd-MM-yyyy"];
    NSString *date = [df stringFromDate:date1];
    NSString * str = [NSString stringWithFormat: @"%@", date];
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"selectDay"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController pushViewController:myNewVC animated:YES];
    
    //currentMonth = currentMonth + 2;  // Sankar COMMENTED TODAY ISSUE
//    if(_customyearView == nil)
//    {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentMonth inSection:monthCount];
//        self.daycell = (SSCalendarDayCell *) [_yearView cellForItemAtIndexPath:indexPath];
//        _customyearView = _yearView;
//        _customIndexpath = indexPath;
//        SSCalendarDailyViewController *viewController = [[SSCalendarDailyViewController alloc] initWithDataController:_dataController];
//        viewController.day = self.daycell.day;
//        [self.navigationController pushViewController:viewController animated:NO];
//    }else{
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentMonth inSection:monthCount];
//        self.daycell = (SSCalendarDayCell *) [_customyearView cellForItemAtIndexPath:indexPath];
//        SSCalendarDailyViewController *viewController = [[SSCalendarDailyViewController alloc] initWithDataController:_dataController];
//        viewController.day = self.daycell.day;
//        [self.navigationController pushViewController:viewController animated:NO];
//    }
}


#pragma mark - UI Helper Methods

- (void)scrollToIndexPath:(NSIndexPath *)indexPath updateTitle:(BOOL)updateTitle
{
    self.isScrolledUP = true;
    [_yearView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) _yearView.collectionViewLayout;
    
    CGPoint offset = _yearView.contentOffset;
    offset.y = offset.y - layout.headerReferenceSize.height;
    _yearView.contentOffset = offset;
    
    if (updateTitle)
    {
        //        NSInteger year = ((SSYearNode *) [_years objectAtIndex:indexPath.section / 12]).value;
        //        self.title = [NSString stringWithFormat:@"%li", (long)year];
    }
    
}


#pragma mark - UICollectionViewDelegateMethods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(isListTapped) {
        SSCalendarDayCell *cell = (SSCalendarDayCell *) [collectionView cellForItemAtIndexPath:indexPath];
        tableData = cell.day.events;
        [customTbl reloadData];
        
    }else{
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        SSCalendarDayCell *cell = (SSCalendarDayCell *) [collectionView cellForItemAtIndexPath:indexPath];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Weeklyviewcontroller *myNewVC = (Weeklyviewcontroller *)[storyboard instantiateViewControllerWithIdentifier:@"Weeklyviewcontroller"];
        NSInteger inStr = cell.day.month ;
        NSDate * month1 = cell.day.date;
        NSDateFormatter* mf = [[NSDateFormatter alloc]init];
        [mf setDateFormat:@"MM"];
        NSString *monthf = [mf stringFromDate:month1];
        NSString *month = [NSString stringWithFormat: @"%ld", (long)inStr];
        NSDate * date1 = cell.day.date;
        NSDateFormatter* df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"dd"];
        NSString *date = [df stringFromDate:date1];
        NSInteger  yea = cell.day.year;
        NSString *year = [NSString stringWithFormat: @"%ld", (long)yea];
        NSString * str = [NSString stringWithFormat: @"%@-%@-%@", date,month,year];
        NSString * str123 = [NSString stringWithFormat: @"%@-%@-%@", year,monthf,date];
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"selectDay"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Goday"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:str123  forKey:@"Godate"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.navigationController pushViewController:myNewVC animated:YES];
//        SSCalendarDailyViewController *viewController = [[SSCalendarDailyViewController alloc] initWithDataController:_dataController];
//        viewController.day = cell.day;
//        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    if ([[_yearView indexPathsForVisibleItems]count] > 0) {
    //        NSIndexPath *ell = [[_yearView indexPathsForVisibleItems]objectAtIndex:0];
    //
    //        SSCalendarDayCell *cell = (SSCalendarDayCell *) [_yearView cellForItemAtIndexPath:ell];
    
    //            SSCalendarDayCell *cell = [customTbl dequeueReusableCellWithIdentifier:@"" forIndexPath:ell]
    //
    //        if (cell.day != nil && cell.frame.origin.y >= 0)
    //        {
    //
    //            UIView* leftButtonView = [[UIView alloc]initWithFrame:CGRectMake(-40, 0, 110, 50)];
    //            NSString *title = [NSString stringWithFormat:@"%li", (long)cell.day.year];
    //            UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //            leftButton.backgroundColor = [UIColor clearColor];
    //            leftButton.frame = leftButtonView.frame;
    //            [leftButton setImage:[UIImage imageNamed:@"ic_back_arrow"] forState:UIControlStateNormal];
    //            [leftButton setTitle:title forState:UIControlStateNormal];
    //            leftButton.tintColor = [UIColor colorWithHexString:COLOR_SECONDARY]; //Your desired color.
    //            leftButton.autoresizesSubviews = YES;
    //            leftButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    //            [leftButton addTarget:self action:@selector(doTheBackThing) forControlEvents:UIControlEventTouchUpInside];
    //            [leftButtonView addSubview:leftButton];
    //            UIBarButtonItem* leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButtonView];
    //            self.navigationItem.leftBarButtonItem = leftBarButton;
    //
    //
    //            NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //            NSString *monthName = [[df monthSymbols] objectAtIndex:(cell.day.month-1)];
    //            [[NSNotificationCenter defaultCenter]
    //             postNotificationName:@"yearPicked"
    //             object:[NSString stringWithFormat:@"%@ %@",monthName,[NSString stringWithFormat:@"%li", (long)cell.day.year]]];
    //            //        break;
    //        }
    //    }
    
    
    NSArray *visibleCells = [_yearView visibleCells];
    
    for (SSCalendarDayCell *cell in visibleCells)
    {
        if (cell.day != nil && cell.frame.origin.y >= 0)
        {
            
            UIView* leftButtonView = [[UIView alloc]initWithFrame:CGRectMake(-40, 0, 110, 50)];
            NSString *title = [NSString stringWithFormat:@"%li", (long)cell.day.year];
            UIButton* leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
            leftButton.backgroundColor = [UIColor clearColor];
            leftButton.frame = leftButtonView.frame;
            [leftButton setImage:[UIImage imageNamed:@"ic_back_arrow"] forState:UIControlStateNormal];
            [leftButton setTitle:title forState:UIControlStateNormal];
            leftButton.tintColor = [UIColor colorWithHexString:COLOR_SECONDARY]; //Your desired color.
            leftButton.autoresizesSubviews = YES;
            leftButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
            [leftButton addTarget:self action:@selector(doTheBackThing) forControlEvents:UIControlEventTouchUpInside];
            [leftButtonView addSubview:leftButton];
            UIBarButtonItem* leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButtonView];
            self.navigationItem.leftBarButtonItem = leftBarButton;
            
            
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            NSString *monthName = [[df monthSymbols] objectAtIndex:(cell.day.month-1)];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"yearPicked"
             object:[NSString stringWithFormat:@"%@ %@",monthName,[NSString stringWithFormat:@"%li", (long)cell.day.year]]];
            break;
        }
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (isListTapped) {
        NSArray *visibleCells = [_yearView visibleCells];
        
        for (SSCalendarDayCell *cell in visibleCells)
        {
            if (cell.day != nil && cell.frame.origin.y >= 0)
            {
                
               // [cell setDayBlackHighlight:cell.day];
                //                [cell setDay:cell.day];
                //                cell.setd
                break;
            }
        }
    }
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    if(searchBar.text.length == 0){
        [_searchBar setHidden:YES];
        [_yearView setHidden:NO];
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
    [_yearView setHidden:NO];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
@end
