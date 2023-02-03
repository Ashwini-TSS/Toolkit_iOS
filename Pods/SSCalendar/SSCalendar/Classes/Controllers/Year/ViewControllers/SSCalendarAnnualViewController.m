//
//  SSCalendarAnnualViewController.m
//  Pods
//
//  Created by Steven Preston on 7/19/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//
//@objc public class login


#import "SSCalendarAnnualViewController.h"
#import "SSCalendarMonthlyViewController.h"
#import "SSCalendarAnnualDataSource.h"
#import "SSYearNode.h"
#import "SSMonthNode.h"
#import "SSConstants.h"
#import "SSDataController.h"
#import "SSCalendarCountCache.h"
#import "SSCalendarAnnualHeaderView.h"
#import "GetOwnCalendarActivity.h"
#import "SSEvent.h"
@class Weeklyviewcontroller;
@interface SSCalendarAnnualViewController()<UISearchDisplayDelegate,UISearchBarDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) SSDataController *dataController;
@property NSArray *calActivity;

@end

@implementation SSCalendarAnnualViewController

- (id)initWithEvents:(NSArray *)events
{
    addEvents = events;
    NSLog(@"%lu",(unsigned long)addEvents.count);
    
    NSBundle *bundle = [SSCalendarUtils calendarBundle];
    if (self = [super initWithNibName:@"SSCalendarAnnualViewController" bundle:bundle]) {
        
        self.dataController = [[SSDataController alloc] init];
        [_dataController setEvents:events];
    }
    return self;
}
- (IBAction)tappedFilter:(id)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:@"tappedFilter"];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"tappedFilter"
     object:self];
    
}
- (IBAction)tappedToday:(id)sender {
    
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
    
   // [self gotoInitialNextPage];
    
//    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
//    [[NSNotificationCenter defaultCenter]
//     postNotificationName:@"yearPicked"
//     object:[NSString stringWithFormat:@"%li", (long)[components1 year]]];
    
    //
    //    NSMutableArray *addYears = [NSMutableArray new];
    //
    //    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
    //                            stringForKey:@"selectedYear"];
    //    SSYearNode *yearNode = [[SSYearNode alloc] initWithValue:[@"2018" integerValue]];
    //    NSLog(@"%@",yearNode.days);
    
}

- (IBAction)tappedDay:(id)sender {
}
- (IBAction)tappedWeek:(id)sender {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

-(void)setupEventNames{
    //    SSYearNode *year = _dataSource.years[0];
    //    NSLog(@"Year",year.)
    
}
// method called via selector
- (void) doTheThing {
    //    _searchBar.tex
    [_searchBar setHidden:NO];
    [_searchBar becomeFirstResponder];
    [_yearView setHidden:YES];
    
    self.searchDisplayController.active = YES;
    self.searchDisplayController.searchBar.text = @"";
    [self.searchDisplayController.searchBar becomeFirstResponder];
    //    [self searchBar:_searchBar textDidChange: @""];
    
    
    NSLog(@"Doing the thing");
    
}
-(void)scrollToCureentYear {
    NSDateComponents *components = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
    
    int indexx = 0;
    
    NSInteger monthCount = 0;
    for (SSYearNode *year in _dataController.calendarYears)
    {
        if (year.value == components.year)
        {
            monthCount = monthCount + components.month - 1;
            break;
        }
        else
        {
            indexx = indexx + 1;
            monthCount = monthCount + year.months.count;
        }
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:indexx];
    [self scrollToIndexPath:indexPath updateTitle:YES];
}
//isFromMonthView

-(void)gotoInitialNextPage {
    
    NSDateComponents *components = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
    
    int indexx = 0;
    
    for (SSYearNode *year in _dataController.calendarYears)
    {
        if (year.value == components.year)
        {
            //            NSInteger section = 7 * year.months.count + indexPath.row;
            //            NSIndexPath *startingIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            
            //            NSLog(@"%ld",[(long)[components month] - 1]);
            NSInteger currentMonth = [components month];
            
            currentMonth = currentMonth - 1;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentMonth inSection:indexx];
            [self scrollToIndexPath:indexPath updateTitle:YES];
            
            SSYearNode *year = _dataSource.years[indexPath.section];
            
            GetOwnCalendarModel *model = [[ GetOwnCalendarModel alloc]initWithDictionary:_listAppointments];
            
            NSKeyedArchiver *archeive = [NSKeyedArchiver archivedDataWithRootObject:model];
            [NSUserDefaults.standardUserDefaults setObject:archeive forKey:@"userSelectedModel"];
            [NSUserDefaults.standardUserDefaults synchronize];
            
            
            SSCalendarMonthlyViewController *viewController = [[SSCalendarMonthlyViewController alloc] initWithDataController:_dataController];
            viewController.listAppointments = _listAppointments;
            viewController.selectedYear = self.title;
            //            viewController.isFromMonthView = YES;
            NSInteger section = indexPath.section * year.months.count + indexPath.row;
            NSIndexPath *startingIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            
            viewController.startingIndexPath = startingIndexPath;
            [[NSUserDefaults standardUserDefaults]setObject:_listAppointments forKey:@"appointmentPobject"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self.navigationController pushViewController:viewController animated:NO];
            
            break;
        } else
        {
            indexx = indexx + 1;
            
        }
    }
    
}

-(void)gotoNextPage {
    
    NSDateComponents *components = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
    
    int indexx = 0;
    
    for (SSYearNode *year in _dataController.calendarYears)
    {
        if (year.value == components.year)
        {
                      
            
                      //  NSLog(@"%ld",[(long)[components month] - 1]);
            NSInteger currentMonth = [components month];
            
            currentMonth = currentMonth - 1;
            
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentMonth inSection:indexx];
            [self scrollToIndexPath:indexPath updateTitle:YES];
            
//            NSInteger section = 7 * year.months.count + indexPath.row;
//            NSIndexPath *startingIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            SSYearNode *year = _dataSource.years[indexPath.section];
            
            
            SSCalendarMonthlyViewController *viewController = [[SSCalendarMonthlyViewController alloc] initWithDataController:_dataController];
            viewController.selectedYear = self.title;
            
            NSInteger section = indexPath.section * year.months.count + indexPath.row;
            NSIndexPath *startingIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
            
            viewController.startingIndexPath = startingIndexPath;
            
            [self.navigationController pushViewController:viewController animated:NO];
            
            break;
        } else
        {
            indexx = indexx + 1;
            
        }
    }
    
}
-(void)todayPressed {
//    NSDateComponents *components = [[SSCalendarUtils calendar] components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
//
//    int indexx = 0;
//
//    NSInteger monthCount = 0;
//    for (SSYearNode *year in _dataController.calendarYears)
//    {
//        if (year.value == components.year)
//        {
//            monthCount = monthCount + components.month - 1;
//            break;
//        }
//        else
//        {
//            indexx = indexx + 1;
//            monthCount = monthCount + year.months.count;
//        }
//    }
//    //201
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:indexx];
//    //    [self scrollToIndexPath:indexPath updateTitle:YES];
//
//    SSYearNode *year = _dataSource.years[indexPath.section];
//
//
//    SSCalendarMonthlyViewController *viewController = [[SSCalendarMonthlyViewController alloc] initWithDataController:_dataController];
//    viewController.selectedYear = self.title;
//
//    NSInteger section = indexPath.section * year.months.count + indexPath.row;
//    NSIndexPath *startingIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
//
//    viewController.startingIndexPath = startingIndexPath;
//
//    [self.navigationController pushViewController:viewController animated:YES];
    
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
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath updateTitle:(BOOL)updateTitle
{
    [_yearView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) _yearView.collectionViewLayout;
    
    CGPoint offset = _yearView.contentOffset;
    offset.y = offset.y - layout.headerReferenceSize.height;
    _yearView.contentOffset = offset;
    
    if (updateTitle)
    {
        NSInteger year = ((SSYearNode *) [_dataController.calendarYears objectAtIndex:indexPath.section]).value;
        NSLog(@"current year:%@",[NSString stringWithFormat:@"%li", (long)year]);
        self.title = [NSString stringWithFormat:@"%li", (long)year];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    CGFloat total = scrollView.contentSize.height - scrollView.bounds.size.height;
    ////    NSLog(@"========total %f======",total);
    //
    //    CGFloat offset = scrollView.contentOffset.y;
    //    CGFloat percent = offset / total;
    //    NSLog(@"========%f======",percent);
    //
    //    if (self->lastContentOffset > scrollView.contentOffset.y)
    //    {
    //        NSLog(@"Scrolling Up");
    //    }
    //    else if (self->lastContentOffset < scrollView.contentOffset.y)
    //    {
    //        NSLog(@"Scrolling Down");
    //    }
    //
    //    self->lastContentOffset = scrollView.contentOffset.y;
    //
    //    float scrollViewHeight = scrollView.frame.size.height;
    //    float scrollContentSizeHeight = scrollView.contentSize.height;
    //    float scrollOffset = scrollView.contentOffset.y;
    //
    //    if (scrollOffset == 0)
    //    {
    //        NSLog(@"==============start ==========");
    //        // then we are at the top
    //    }
    //    else if (scrollOffset + scrollViewHeight == scrollContentSizeHeight)
    //    {
    //        NSLog(@"==============end ==========");
    //
    //        // then we are at the end
    //    }
    
    NSArray *visibleCells = [_yearView indexPathsForVisibleItems];
    //    NSIndexPath *cell = [[_yearView indexPathsForVisibleItems] objectAtIndex:0];
    
    for (NSIndexPath *cell in visibleCells)
    {
        NSInteger year = ((SSYearNode *) [_dataController.calendarYears objectAtIndex:cell.section]).value;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"yearPicked"
         object:[NSString stringWithFormat:@"%li", (long)year]];
        
        self.title = [NSString stringWithFormat:@"%li", (long)year];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"=========called==========");
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"=========called=====222222=====");
}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//-scrollviewd
-(void)viewWillAppear:(BOOL)animate  {
    [_searchBar setHidden:YES];
    //    var getCalendarActivityList:[GetCalendarListActivity] = []
    
    //    self.title = @"Calendar";
    self.dataSource = [[SSCalendarAnnualDataSource alloc] initWithView:_yearView];
    _yearView.dataSource = _dataSource;
    _yearView.delegate = self;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:COLOR_SECONDARY], NSForegroundColorAttributeName, [UIFont systemFontOfSize:17.0], NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:COLOR_SECONDARY];
    
    _dataSource.years = _dataController.calendarYears;
    
    [_yearView reloadData];
    [_yearView setHidden:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [_yearView setHidden:NO];
        
        [self scrollToCureentYear];
        
        NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"yearPicked"
         object:[NSString stringWithFormat:@"%li", (long)[components1 year]]];
        
      //  [self gotoInitialNextPage];
        
    });
    
    
    
    // first we create a button and set it's properties
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc]init];
    myButton.action = @selector(doTheThing);
    myButton.title = @"";
    myButton.image = [UIImage imageNamed:@"ic_search"];
    myButton.target = self;
    
    // then we add the button to the navigation bar
    // self.navigationItem.rightBarButtonItem = myButton;
    
    [self.whiteBG setFrame:self.view.frame];
    [self.view addSubview:self.whiteBG];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.whiteBG removeFromSuperview];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_dataSource updateLayoutForBounds:_yearView.bounds];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            // nameLabel.backgroundColor = [UIColor colorWithHexString:[NSString stringWithFormat:@"#%@",sep[2]]];
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
    SSEvent *event = [SSEvent alloc];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        event = searchResults[indexPath.row];
        for (int k=0; k<_calActivity.count; k++) {
            GetOwnCalendarActivity *model = _calActivity[k];
            NSString *strType = [NSString stringWithFormat:@"%@",model.type];
            if (model.activity.idField == event.location) {
                
                NSLog(@"AppointmentTypeID : %@",event.contact);
                [[NSUserDefaults standardUserDefaults]setObject:event.contact forKey:@"appointmentTypeID"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
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
    searchResults = [addEvents filteredArrayUsingPredicate:sPredicate];
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

#pragma mark - UICollectionViewDelegateMethods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSYearNode *year = _dataSource.years[indexPath.section];
    
    SSCalendarMonthlyViewController *viewController = [[SSCalendarMonthlyViewController alloc] initWithDataController:_dataController];
    viewController.selectedYear = self.title;
    
    viewController.addEvents = addEvents;
    viewController.listAppointments = _listAppointments;
    NSInteger section = indexPath.section * year.months.count + indexPath.row;
    NSIndexPath *startingIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    
    viewController.startingIndexPath = startingIndexPath;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
