//
//  CZPickerView.h
//
//  Created by chenzeyu on 9/6/15.
//  Copyright (c) 2015 chenzeyu. All rights reserved.
//

#import "CZPickerView.h"

#define CZP_FOOTER_HEIGHT 44.0
#define CZP_HEADER_HEIGHT 44.0
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
#define CZP_BACKGROUND_ALPHA 0.9
#else
#define CZP_BACKGROUND_ALPHA 0.3
#endif

#import "Pareto_Systems-Swift.h"



typedef void (^CZDismissCompletionCallback)(void);

@interface CZPickerView ()<UISearchBarDelegate>
@property NSString *headerTitle;
@property NSString *cancelButtonTitle;
@property NSString *confirmButtonTitle;
@property UIView *backgroundDimmingView;
@property UIView *containerView;
@property UIView *headerView;
@property UIView *footerview;
@property UISearchBar *Searchview;
@property UITableView *tableView;
@property NSMutableArray *selectedIndexPaths;
@property CGRect previousBounds;
@property NSMutableArray *arrlocal;
@property NSMutableArray *SelectedIndexPathArray;
@property BOOL isFiltered;
@property NSMutableArray *arrsearchresult ;
@property NSMutableArray *filterSelectedIndexPath;

@property NSMutableArray *arrfullname;

@end

@implementation CZPickerView

- (id)initWithHeaderTitle:(NSString *)headerTitle
        cancelButtonTitle:(NSString *)cancelButtonTitle
       confirmButtonTitle:(NSString *)confirmButtonTitle{
    self = [super init];
    if(self){
        if([self needHandleOrientation]){
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector:@selector(deviceOrientationDidChange:)
                                                         name:UIDeviceOrientationDidChangeNotification
                                                       object: nil];
        }
        self.tapBackgroundToDismiss = YES;
        self.needFooterView = NO;
        self.allowMultipleSelection = NO;
        self.animationDuration = 0.5f;
        
        self.confirmButtonTitle = confirmButtonTitle;
        self.cancelButtonTitle = cancelButtonTitle;
        
        self.headerTitle = headerTitle ? headerTitle : @"";
        self.headerTitleColor = [UIColor whiteColor];
        //UIColor.PSNavigaitonController()
        self.headerBackgroundColor = [UIColor colorWithRed:0.0/255 green:82.0/255 blue:155.0/255 alpha:1];
        
        self.cancelButtonNormalColor = [UIColor whiteColor];
        self.cancelButtonHighlightedColor = [UIColor whiteColor];
        self.cancelButtonBackgroundColor = [UIColor colorWithRed:0.0/255 green:82.0/255 blue:155.0/255 alpha:1];
        
        self.confirmButtonNormalColor = [UIColor whiteColor];
        self.confirmButtonHighlightedColor = [UIColor whiteColor];
        self.confirmButtonBackgroundColor = [UIColor colorWithRed:0.0/255 green:82.0/255 blue:155.0/255 alpha:1];
        
        _previousBounds = [UIScreen mainScreen].bounds;
        self.frame = _previousBounds;
    }
    return self;
}

- (void)setupSubviews{
    if(!self.backgroundDimmingView){
        self.backgroundDimmingView = [self buildBackgroundDimmingView];
        [self addSubview:self.backgroundDimmingView];
    }
    
    self.arrsearchresult = [NSMutableArray new];
    self.arrlocal = [[NSMutableArray alloc]init];
    
    self.containerView = [self buildContainerView];
    [self addSubview:self.containerView];
    
    self.tableView = [self buildTableView];
    [self.containerView addSubview:self.tableView];
    
    self.headerView = [self buildHeaderView];
    [self.containerView addSubview:self.headerView];
    
    self.Searchview = [self buildSearchView];
    [self.containerView addSubview:self.Searchview];
    
    self.footerview = [self buildFooterView];
    [self.containerView addSubview:self.footerview];
    
    _arrlocal = [self.dataSource czpickerView:self];
    
    CGRect frame = self.containerView.frame;
    
    self.containerView.frame = CGRectMake(frame.origin.x,
                                          frame.origin.y,
                                          frame.size.width,
                                          self.headerView.frame.size.height+self.Searchview.frame.size.height+ self.tableView.frame.size.height + self.footerview.frame.size.height);
    self.containerView.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height);
    
}

- (void)performContainerAnimation {
    
    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:3.0f options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.containerView.center = self.center;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)show {
    
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    self.frame = mainWindow.frame;
    [self show:mainWindow];
}

- (void)show:(id)container {
    
    self.pickerVisible = YES;
    if (self.allowMultipleSelection && !self.needFooterView) {
        self.needFooterView = self.allowMultipleSelection;
    }
    
    if ([container respondsToSelector:@selector(addSubview:)]) {
        [container addSubview:self];
        
        [self setupSubviews];
        [self performContainerAnimation];
        
        [UIView animateWithDuration:0.3f animations:^{
            self.backgroundDimmingView.alpha = CZP_BACKGROUND_ALPHA;
        }];
    }
}

- (void)reloadData{
    
    [self.tableView reloadData];
}

- (void)dismissPicker:(CZDismissCompletionCallback)completion{
    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:3.0f options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.containerView.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height);
    }completion:^(BOOL finished) {
    }];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.backgroundDimmingView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if(finished){
            if(completion){
                completion();
            }
            self.pickerVisible = NO;
            [self removeFromSuperview];
        }
    }];
}

- (UIView *)buildContainerView{
    CGFloat widthRatio = _pickerWidth ? _pickerWidth / [UIScreen mainScreen].bounds.size.width : 0.8;
    CGAffineTransform transform = CGAffineTransformMake(widthRatio, 0, 0, 0.8, 0, 0);
    CGRect newRect = CGRectApplyAffineTransform(self.frame, transform);
    UIView *cv = [[UIView alloc] initWithFrame:newRect];
    cv.layer.cornerRadius = 6.0f;
    cv.clipsToBounds = YES;
    cv.center = CGPointMake(self.center.x, self.center.y + self.frame.size.height);
    return cv;
}

- (UITableView *)buildTableView{
    CGFloat widthRatio = _pickerWidth ? _pickerWidth / [UIScreen mainScreen].bounds.size.width : 0.8;
    CGAffineTransform transform = CGAffineTransformMake(widthRatio, 0, 0, 0.8, 0, 0);
    CGRect newRect = CGRectApplyAffineTransform(self.frame, transform);
    NSInteger n = [self.dataSource numberOfRowsInPickerView:self];
    CGRect tableRect;
    float heightOffset = CZP_HEADER_HEIGHT + CZP_FOOTER_HEIGHT;
    if(n > 0){
        float height = n * 44.0;
        height = height > newRect.size.height - heightOffset ? newRect.size.height -heightOffset : height;
        tableRect = CGRectMake(0, 88.0, newRect.size.width, height);
    } else {
        tableRect = CGRectMake(0, 88.0, newRect.size.width, newRect.size.height - heightOffset);
    }
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}

- (UIView *)buildBackgroundDimmingView{
    
    UIView *bgView;
    //blur effect for iOS8
    CGFloat frameHeight = self.frame.size.height;
    CGFloat frameWidth = self.frame.size.width;
    CGFloat sideLength = frameHeight > frameWidth ? frameHeight : frameWidth;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
        UIBlurEffect *eff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        bgView = [[UIVisualEffectView alloc] initWithEffect:eff];
        bgView.frame = CGRectMake(0, 0, sideLength, sideLength);
    }
    else {
        bgView = [[UIView alloc] initWithFrame:self.frame];
        bgView.backgroundColor = [UIColor blackColor];
    }
    bgView.alpha = 0.0;
    if(self.tapBackgroundToDismiss){
        //        [bgView addGestureRecognizer:
        //         [[UITapGestureRecognizer alloc] initWithTarget:self
        //                                                 action:@selector(cancelButtonPressed:)]];
    }
    return bgView;
}

- (UIView *)buildFooterView{
    if (!self.needFooterView){
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    CGRect rect = self.tableView.frame;
    CGRect newRect = CGRectMake(0,
                                rect.origin.y + rect.size.height,
                                rect.size.width,
                                CZP_FOOTER_HEIGHT);
    CGRect leftRect = CGRectMake(0,0, newRect.size.width /2, CZP_FOOTER_HEIGHT);
    CGRect rightRect = CGRectMake(newRect.size.width /2,0, newRect.size.width /2, CZP_FOOTER_HEIGHT);
    
    UIView *view = [[UIView alloc] initWithFrame:newRect];
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:leftRect];
    [cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
    [cancelButton setTitleColor: self.cancelButtonNormalColor forState:UIControlStateNormal];
    [cancelButton setTitleColor:self.cancelButtonHighlightedColor forState:UIControlStateHighlighted];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"Raleway-Bold" size:17.0];
    cancelButton.backgroundColor = self.cancelButtonBackgroundColor;
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:cancelButton];
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:rightRect];
    [confirmButton setTitle:self.confirmButtonTitle forState:UIControlStateNormal];
    [confirmButton setTitleColor:self.confirmButtonNormalColor forState:UIControlStateNormal];
    [confirmButton setTitleColor:self.confirmButtonHighlightedColor forState:UIControlStateHighlighted];
    confirmButton.titleLabel.font = [UIFont fontWithName:@"Raleway-Bold" size:15.0];
    confirmButton.backgroundColor = self.confirmButtonBackgroundColor;
    [confirmButton addTarget:self action:@selector(confirmButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:confirmButton];
    return view;
}

- (UIView *)buildHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, CZP_HEADER_HEIGHT)];
    view.backgroundColor = self.headerBackgroundColor;
    
    UIFont *headerFont = [UIFont fontWithName:@"Raleway-Bold" size:19.0];
    
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName: self.headerTitleColor,
                           NSFontAttributeName:headerFont
                           };
    NSAttributedString *at = [[NSAttributedString alloc] initWithString:self.headerTitle attributes:dict];
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    label.attributedText = at;
    [label sizeToFit];
    [view addSubview:label];
    label.center= view.center;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width - button.frame.size.width - 20, 6, button.frame.size.width, button.frame.size.height)];
    [button addTarget:self action:@selector(doneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button sizeToFit];
    button.frame = CGRectMake(0,0,0,0);
    [view addSubview:button];
    
    return view;
}

- (void)doneButtonAction
{
    if(_isFiltered) {
        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"FilteredObject"];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"FilteredObject"];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self dismissPicker:^{
        if(self.allowMultipleSelection && [self.delegate respondsToSelector:@selector(czpickerView:didConfirmWithItemsAtRows:withoutBool:)]){
            //  [self.delegate czpickerView:self didConfirmWithItemsAtRows:[self selectedRows]];
            [self.delegate czpickerView:self didConfirmWithItemsAtRows:[self selectedRows] withoutBool:self.isFiltered];
        }
        if(self.allowMultipleSelection && [self.delegate respondsToSelector:@selector(czpickerView:didConfirmWithItemsAtRows:withBool:arrayvalue:)]){
            //  [self.delegate czpickerView:self didConfirmWithItemsAtRows:[self selectedRows]];
            if(self.isFiltered){
                [self.delegate czpickerView:self didConfirmWithItemsAtRows:[self selectedRowswithFilter] withBool:self.isFiltered arrayvalue:self.arrlocal];
            }
            self.isFiltered = NO;
        }
        
        else if(!self.allowMultipleSelection && [self.delegate respondsToSelector:@selector(czpickerView:didConfirmWithItemAtRow:)]){
            if(!self.isFiltered){
                if (self.selectedIndexPaths.count > 0){
                    NSInteger row = ((NSIndexPath *)self.selectedIndexPaths[0]).row;
                    [self.delegate czpickerView:self didConfirmWithItemAtRow:row];
                }
            }
            else{
                if (self.SelectedIndexPathArray.count > 0){
                    NSInteger row = ((NSIndexPath *)self.SelectedIndexPathArray[0]).row;
                    [self.delegate czpickerView:self didConfirmWithItemAtRow:row];
                }
            }
        }
    }];
}

- (UISearchBar *)buildSearchView{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,CZP_HEADER_HEIGHT, self.tableView.frame.size.width, CZP_HEADER_HEIGHT)]; //give your frame x,y and width and height
    searchBar.placeholder = @"Search";
    [searchBar setReturnKeyType:UIReturnKeyDone];
    searchBar.delegate = self;
    return searchBar;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.tableView resignFirstResponder];
}

//-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
//    searchBar.text = @"";
//    [searchBar endEditing:YES];
//}

- (IBAction)cancelButtonPressed:(id)sender{
    [self dismissPicker:^{
        if([self.delegate respondsToSelector:@selector(czpickerViewDidClickCancelButton:)]){
            [self.delegate czpickerViewDidClickCancelButton:self];
        }
    }];
}

- (IBAction)confirmButtonPressed:(id)sender{
    if(_isFiltered) {
        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"FilteredObject"];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"FilteredObject"];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];

    [self dismissPicker:^{
        if(self.allowMultipleSelection && [self.delegate respondsToSelector:@selector(czpickerView:didConfirmWithItemsAtRows:withoutBool:)]){
            //  [self.delegate czpickerView:self didConfirmWithItemsAtRows:[self selectedRows]];
            [self.delegate czpickerView:self didConfirmWithItemsAtRows:[self selectedRows] withoutBool:self.isFiltered];
        }
        if(self.allowMultipleSelection && [self.delegate respondsToSelector:@selector(czpickerView:didConfirmWithItemsAtRows:withBool:arrayvalue:)]){
            //  [self.delegate czpickerView:self didConfirmWithItemsAtRows:[self selectedRows]];
            if(self.isFiltered){
            [self.delegate czpickerView:self didConfirmWithItemsAtRows:[self selectedRowswithFilter] withBool:self.isFiltered arrayvalue:self.arrlocal];
            }
            self.isFiltered = NO;
        }
        
        else if(!self.allowMultipleSelection && [self.delegate respondsToSelector:@selector(czpickerView:didConfirmWithItemAtRow:)]){
            if(!self.isFiltered){
                if (self.selectedIndexPaths.count > 0){
                    NSInteger row = ((NSIndexPath *)self.selectedIndexPaths[0]).row;
                    [self.delegate czpickerView:self didConfirmWithItemAtRow:row];
                }
            }
            else{
                if (self.SelectedIndexPathArray.count > 0){
                    NSInteger row = ((NSIndexPath *)self.SelectedIndexPathArray[0]).row;
                    [self.delegate czpickerView:self didConfirmWithItemAtRow:row];
                }
            }
        }
    }];
}

- (NSArray *)selectedRows {
    if(!self.isFiltered){
        NSMutableArray *rows = [NSMutableArray new];
        for (NSIndexPath *ip in self.selectedIndexPaths) {
            [rows addObject:@(ip.row)];
        }
        return rows;
    }
    else {
        NSMutableArray *rows = [NSMutableArray new];
        for (NSIndexPath *ip in self.SelectedIndexPathArray) {
            [rows addObject:@(ip.row)];
        }
        return rows;
    }
}

- (NSArray *)selectedRowswithFilter {
//    Thabresh
    NSMutableArray *rows = [NSMutableArray new];
    for (NSIndexPath *ip in self.selectedIndexPaths) {
         NSLog(@"indexxx : %ld",(long)ip.row);
        [rows addObject:@(ip.row)];
    }
    for (NSIndexPath *ip in self.SelectedIndexPathArray) {
        NSInteger selectedRow = ip.row;
        NSInteger getindex = [_arrlocal indexOfObject:_arrsearchresult[selectedRow]];
        NSLog(@"indexxx : %ld",(long)getindex);
        [rows addObject:@(getindex)];
//        [rows addObject:@(ip.row)];
    }
    return rows;
}


- (void)setSelectedRows:(NSArray *)rows{
    if (![rows isKindOfClass: NSArray.class]) {
        return;
    }
    
    self.selectedIndexPaths = [NSMutableArray new];
    self.SelectedIndexPathArray = [[NSMutableArray alloc]init];
    if(!self.isFiltered){
        for (NSNumber *n in rows){
            NSIndexPath *ip = [NSIndexPath indexPathForRow:[n integerValue] inSection: 0];
            [self.selectedIndexPaths addObject:ip];
        }
    }
    else {
        for (NSNumber *n in rows){
            NSIndexPath *ip = [NSIndexPath indexPathForRow:[n integerValue] inSection: 0];
            [self.SelectedIndexPathArray addObject:ip];
        }
    }
}

- (void)unselectAll {
    if(!self.isFiltered){
        self.selectedIndexPaths = [NSMutableArray new];
    }
    else {
        self.SelectedIndexPathArray = [[NSMutableArray alloc]init];
    }
    [self.tableView reloadData];
}



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
  
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length==0)
    {
        _isFiltered=NO;
    }
    else
    {
        _isFiltered=YES;
        NSArray * local = [[NSArray alloc]init];
        _arrlocal = [self.dataSource czpickerView:self];
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchText];
        NSArray *array = [_arrlocal copy];
        local = [array filteredArrayUsingPredicate:resultPredicate];
        _arrsearchresult= [local mutableCopy];
        [[NSUserDefaults standardUserDefaults] setObject:_arrsearchresult forKey:@"filterarray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        NSMutableArray *selectPath = [NSMutableArray new];
        NSMutableArray *paths = [NSMutableArray new];
        
        for (int k=0; k<_selectedIndexPaths.count; k++) {
            NSIndexPath *slctPath = _selectedIndexPaths[k];
            [paths addObject:[NSString stringWithFormat:@"%ld",(long)slctPath.row]];
        }
        for (int k=0; k<_arrsearchresult.count; k++) {
            NSString *dummyName2 = _arrsearchresult[k];
            if ([_arrlocal containsObject:dummyName2]) {
                NSInteger getInt = [_arrlocal indexOfObject:dummyName2];
                [selectPath addObject:[NSString stringWithFormat:@"%ld",(long)getInt]];
            }
        }
//        NSMutableArray *finalPaths = [NSMutableArray new];
//        [finalPaths addObject:paths[getInt]];

        NSMutableArray *dummy = [NSMutableArray new];
        
        NSLog(@"%@",selectPath);
        for (int k=0; k<_arrlocal.count; k++) {
            [dummy addObject:@"0"];
        }
        
        for (int k=0; k<selectPath.count; k++) {
            NSInteger intPath = [selectPath[k] integerValue];
            [dummy replaceObjectAtIndex:intPath withObject:@"1"];
        }
        NSLog(@"%@",dummy);

//        for (int i=0; i<_SelectedIndexPathArray.count; i++) {
//            NSIndexPath *dummyName1 = _SelectedIndexPathArray[i];
//            for (int k=0; k<_arrsearchresult.count; k++) {
//                NSString *dummyName2 = _arrsearchresult[k];
//                if ([_arrlocal containsObject:dummyName2]) {
//                    NSInteger getInt = [_arrlocal indexOfObject:dummyName2];
//                    [selectPath addObject:[NSString stringWithFormat:@"%@,%@",getInt]];
//                }
//
//            }
//        }
        
        
    }
    [self.tableView reloadData];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    //[searchBar resignFirstResponder];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_isFiltered)
    {
        return [_arrsearchresult count];
    }
    if ([self.dataSource respondsToSelector:@selector(numberOfRowsInPickerView:)]) {
        return [self.dataSource numberOfRowsInPickerView:self];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"czpicker_view_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    for(NSIndexPath *ip in self.selectedIndexPaths){
        if(ip.row == indexPath.row){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    if([self.dataSource respondsToSelector:@selector(czpickerView:titleForRow:)] && [self.dataSource respondsToSelector:@selector(czpickerView:imageForRow:)]){
        if(_isFiltered)
        {
            NSString *cellName = [_arrsearchresult objectAtIndex:indexPath.row];
            if ([[self.dataSource czpickerView:self]containsObject:cellName]) {
                NSInteger getIndex = [[self.dataSource czpickerView:self] indexOfObject:cellName];
                cell.accessoryType = UITableViewCellAccessoryNone;

                for(NSIndexPath *ip in self.selectedIndexPaths){
                    if(ip.row == getIndex){
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    }
                }
            }
            cell.textLabel.text = [_arrsearchresult objectAtIndex:indexPath.row];
        }
        else {
            cell.textLabel.text = [self.dataSource czpickerView:self titleForRow:indexPath.row];
        }
        NSArray *dummyArray = [self.dataSource czpickerView:self];

        NSString *currval = [self.dataSource czpickerView:self titleForRow:indexPath.row];
        cell.imageView.image = [self.dataSource czpickerView:self imageForRow:indexPath.row];
        _arrsearchresult = [[NSUserDefaults standardUserDefaults]
                            objectForKey:@"filterarray"];
       
        
    } else if ([self.dataSource respondsToSelector:@selector(czpickerView:attributedTitleForRow:)] && [self.dataSource respondsToSelector:@selector(czpickerView:imageForRow:)]){
        cell.textLabel.attributedText = [self.dataSource czpickerView:self attributedTitleForRow:indexPath.row];
        cell.imageView.image = [self.dataSource czpickerView:self imageForRow:indexPath.row];
    } else if ([self.dataSource respondsToSelector:@selector(czpickerView:attributedTitleForRow:)]) {
        cell.textLabel.attributedText = [self.dataSource czpickerView:self attributedTitleForRow:indexPath.row];
    } else if([self.dataSource respondsToSelector:@selector(czpickerView:titleForRow:)]){
        cell.textLabel.text = [self.dataSource czpickerView:self titleForRow:indexPath.row];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Raleway-Regular" size:17.0];
    
    if(self.checkmarkColor){
        cell.tintColor = self.checkmarkColor;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(!_isFiltered){
        if(!self.selectedIndexPaths){
            self.selectedIndexPaths = [NSMutableArray new];
        }
    }
    else{
        if(!self.SelectedIndexPathArray){
            self.SelectedIndexPathArray = [NSMutableArray new];
        }
    }
    // the row has already been selected
    if(!self.isFiltered){
        if (self.allowMultipleSelection){
            if([self.selectedIndexPaths containsObject:indexPath]){
                [self.selectedIndexPaths removeObject:indexPath];
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                [self.selectedIndexPaths addObject:indexPath];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            
        } else { //single selection mode
            
            if (self.selectedIndexPaths.count > 0){// has selection
                NSIndexPath *prevIp = (NSIndexPath *)self.selectedIndexPaths[0];
                UITableViewCell *prevCell = [tableView cellForRowAtIndexPath:prevIp];
                if(indexPath.row != prevIp.row){ //different cell
                    prevCell.accessoryType = UITableViewCellAccessoryNone;
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    [self.selectedIndexPaths removeObject:prevIp];
                    [self.selectedIndexPaths addObject:indexPath];
                    
                } else {//same cell
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    self.selectedIndexPaths = [NSMutableArray new];
                }
            } else {//no selection
                [self.selectedIndexPaths addObject:indexPath];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            
            if(!self.needFooterView && [self.delegate respondsToSelector:@selector(czpickerView:didConfirmWithItemAtRow:)]){
                [self dismissPicker:^{
                    [self.delegate czpickerView:self didConfirmWithItemAtRow:indexPath.row];
                }];
            }
        }
    }
    else {
        if (self.allowMultipleSelection){
            
            NSString *cellName = [_arrsearchresult objectAtIndex:indexPath.row];
            if ([[self.dataSource czpickerView:self]containsObject:cellName]) {
                //Thabresh
                NSInteger getIndex = [_arrsearchresult indexOfObject:cellName];
//                NSInteger getIndex = [[self.dataSource czpickerView:self] indexOfObject:cellName];

                NSIndexPath *path = [NSIndexPath indexPathForRow:getIndex inSection:0];
                if([self.SelectedIndexPathArray containsObject:path]){
                    [self.SelectedIndexPathArray removeObject:path];
                    cell.accessoryType = UITableViewCellAccessoryNone;
                } else {
                    [self.SelectedIndexPathArray addObject:path];
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }
//            if([self.SelectedIndexPathArray containsObject:indexPath]){
//                [self.SelectedIndexPathArray removeObject:indexPath];
//                cell.accessoryType = UITableViewCellAccessoryNone;
//            } else {
//
//
//                [self.SelectedIndexPathArray addObject:indexPath];
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            }
            
        } else { //single selection mode
            
            if (self.SelectedIndexPathArray.count > 0){// has selection
                NSIndexPath *prevIp = (NSIndexPath *)self.SelectedIndexPathArray[0];
                UITableViewCell *prevCell = [tableView cellForRowAtIndexPath:prevIp];
                if(indexPath.row != prevIp.row){ //different cell
                    prevCell.accessoryType = UITableViewCellAccessoryNone;
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    [self.SelectedIndexPathArray removeObject:prevIp];
                    [self.SelectedIndexPathArray addObject:indexPath];
                    
                } else {//same cell
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    self.SelectedIndexPathArray = [NSMutableArray new];
                }
            } else {//no selection
                [self.SelectedIndexPathArray addObject:indexPath];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            
            if(!self.needFooterView && [self.delegate respondsToSelector:@selector(czpickerView:didConfirmWithItemAtRow:)]){
                [self dismissPicker:^{
                    [self.delegate czpickerView:self didConfirmWithItemAtRow:indexPath.row];
                }];
            }
        }
    }
    // [[NSUserDefaults standardUserDefaults] setObject:_SelectedIndexPathArray forKey:@"selectarray"];
    // [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Notification Handler

- (BOOL)needHandleOrientation{
    NSArray *supportedOrientations = [[[NSBundle mainBundle] infoDictionary]
                                      objectForKey:@"UISupportedInterfaceOrientations"];
    NSMutableSet *set = [NSMutableSet set];
    for(NSString *o in supportedOrientations){
        NSRange range = [o rangeOfString:@"Portrait"];
        if (range.location != NSNotFound) {
            [set addObject:@"Portrait"];
        }
        
        range = [o rangeOfString:@"Landscape"];
        if (range.location != NSNotFound) {
            [set addObject:@"Landscape"]; 
        }
    }
    return set.count == 2;
}

- (void)deviceOrientationDidChange:(NSNotification *)notification{
    CGRect rect = [UIScreen mainScreen].bounds;
    if (CGRectEqualToRect(rect, _previousBounds)) {
        return;
    }
    _previousBounds = rect;
    self.frame = rect;
    for(UIView *v in self.subviews){
        if([v isEqual:self.backgroundDimmingView]) continue;
        
        [UIView animateWithDuration:0.2f animations:^{
            v.alpha = 0.0;
        } completion:^(BOOL finished) {
            [v removeFromSuperview];
            //as backgroundDimmingView will not be removed
            if(self.subviews.count == 1){
                [self setupSubviews];
                [self performContainerAnimation];
            }
        }];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
