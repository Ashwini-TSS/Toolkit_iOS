//
//  CalendarController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 20/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import SSCalendar
var StrCondition : String!
class CalendarController: UIViewController {
    
    var isdrag : Bool = false
    @IBOutlet weak var btnListView: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var calendarView: UIView!
    var getCalendarActivityList:[GetCalendarListActivity] = []
    var appointmentResults:[GetAppointmentTypesResult] = []
    var appointmentIDList:NSMutableArray = []
    var appointmentColorList:NSMutableArray = []
    var pushed:Bool = false
    var appointmentDict:NSDictionary = [:]
    var parseFilterList : [String] = []
    var parseUserList : [String] = []
    var isalldayevent : String = "false"
    
    var indexvalue : Int = 0
    var  dummyobj : DummyModal!

    var appointmentColor : NSMutableArray = []
    var appointmentIDD : NSMutableArray = []
    
    var isalldayeventcondition : String!
    var items: [[DropdownItem]]!
    var showSection: Bool = true
    var selectedRow: Int = 0
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    var isList:Bool = false
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    @IBOutlet weak var btnDropDown: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItem()
        self.title = ""
        
        UserDefaults.standard.removeObject(forKey: "filterarray")
        
        UserDefaults.standard.set("no", forKey: "DAYALL")
        
        SSStyles.applyNavigationBarStyles()
        
        self.navigationController?.navigationBar.backgroundColor = .red

        self.navigationController?.navigationBar.barTintColor = .black

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
       // self.demoactivity()
        
        // TODO: you code here
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
       // UIApplication.statusBarBackgroundColor = .blue
    }
    @IBAction func tappedSearch(_ sender: Any) {
        let controller:SearchCalendarController = self.storyboard?.instantiateViewController(withIdentifier: "SearchCalendarController") as! SearchCalendarController
        controller.getCalendarActivityList = getCalendarActivityList
        controller.appointmentResults = appointmentResults
        controller.appointmentIDList = appointmentIDList
        controller.appointmentColorList = appointmentColorList
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func pushToActivity(notfication: NSNotification) {
        //        NotificationCenter.default.removeObserver(self)
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "pushToActivity"), object: nil)
        // NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "pushToActivity1"), object: nil)
        let dictObject:NSDictionary = notfication.object as! NSDictionary
        let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: dictObject as! [String : Any])
        let controller:UpdatenewtaskVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewtaskVC") as? UpdatenewtaskVC)!
        controller.openedActivties = getAddress
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @objc func Allday(notfication: NSNotification) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Allday"), object: nil)
        isalldayeventcondition = "yes"
        isalldayevent =  notfication.object! as! String
    }
    
    
    @objc func pushToActivity1(notfication: NSNotification) {
        let dictObject:NSDictionary = notfication.object as! NSDictionary
        
        if let getData = UserDefaults.standard.object(forKey: "nowSelected") as? String {
            print(getData)
            if getData != "no" {
                UserDefaults.standard.set("no", forKey: "nowSelected")
                StrCondition = "first"
            }
        }
        
        if(StrCondition == "first"){
            StrCondition = "Second"
            OperationQueue.main.addOperation {
                let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: dictObject as! [String : Any])
                if let controller = self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewappointmentVC") as? UpdatenewappointmentVC {
                    controller.Editvalue = "edit"
                    controller.EditCondition = "calendar"
                    if(self.isalldayevent == "true"){
                        controller.isallday = "true"
                        self.isalldayevent = "false"
                    }
                    else{
                        controller.isallday = "false"
                    }
                    controller.openedActivties = getAddress
                    controller.passCalendarActivityList = self.getCalendarActivityList
                    let nvc: UINavigationController = UINavigationController(rootViewController: controller)
                    nvc.navigationBar.tintColor = .black
                    nvc.navigationBar.barTintColor = .black
                    nvc.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = nvc
                    
                    UINavigationBar.appearance().barTintColor = UIColor.PSNavigaitonBlack()
                    UINavigationBar.appearance().tintColor = .white
                    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                    UINavigationBar.appearance().isTranslucent = false
                    
                    let yourBackImage = UIImage(named: "ic_back_arrow")
                    UINavigationBar.appearance().tintColor = .white//.blue as you required
                    UINavigationBar.appearance().backIndicatorImage = yourBackImage
                    UINavigationBar.appearance().backIndicatorTransitionMaskImage = yourBackImage
                    UINavigationBar.appearance().topItem?.title = "      "
                    UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .normal)
                    UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: UIControlState.highlighted)
                    UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for:UIBarMetrics.default)
                    //                    self.navigationController?.pushViewController(controller, animated: true)
                }
                //                let controller:NewAppointmentsController = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentsController") as? NewAppointmentsController)!
            }
        }
    }
    @objc func menuButtonTapped(sender: UIBarButtonItem) {
        slideMenuController()?.openLeft()
    }
    
    @IBAction func tappedListView(_ sender: Any) {
        if isList {
            btnListView.setImage(UIImage.init(named:"ic_list_view"), for: .normal)
            isList = false
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showList"), object: nil, userInfo: nil)
        }else{
            btnListView.setImage(UIImage.init(named:"ic_selected_list"), for: .normal)
            isList = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "hideList"), object: nil, userInfo: nil)
        }
    }
    @objc func calendarButtonTapped(sender: UIBarButtonItem) {
        
        let pastYear = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        let futureYear = Calendar.current.date(byAdding: .year, value: +100, to: Date())
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY"
        let pastYearr = dateformatter.string(from: pastYear!)
        let futureYearr = dateformatter.string(from: futureYear!)
        
        let intPastYear = (pastYearr as NSString).integerValue
        let intFutureYear = (futureYearr as NSString).integerValue
        
        let listYears:NSMutableArray = []
        
        for index in intPastYear..<intFutureYear {
            listYears.add("\(index)")
        }
        
        var pickerValue:String = ""
        
        if let values = UserDefaults.standard.object(forKey: "selectedYear") {
            pickerValue = values as! String
        }
        
        // Strings Picker
        DPPickerManager.shared.showPicker(title: "Pick Year", selected: pickerValue, strings: listYears as! [String]) { (value, index, cancel) in
            if !cancel {
                
                startTime = "\(value!)-01-01"
                endTime = "\(value!)-12-31"
                selectedYear = value!
                // TODO: you code here
                self.getAppointmentTypesList()
                
            }
        }
    }
    
    
    @IBAction func tappedTab(_ sender: Any) {
        
        if addPreviousControllers.count > 0 {
            //            var menuView: DropdownMenu?
            //            let addItems:NSMutableArray = []
            //
            //            for index in 0..<addPreviousControllers.count {
            //                let item1 = DropdownItem(title: addPreviousControllers[index] as! String)
            //                addItems.add(item1)
            //            }
            //            items = [addItems] as! [[DropdownItem]]
            //            menuView = DropdownMenu(navigationController: navigationController!, items: addItems as! [DropdownItem], selectedRow: 10)
            //
            //            menuView?.topOffsetY = CGFloat(0.0)
            //            //menuView?.separatorStyle = .none
            //            menuView?.zeroInsetSeperatorIndexPaths = [IndexPath(row: 1, section: 0)]
            //            menuView?.delegate = self
            //            menuView?.rowHeight = 50
            //            menuView?.showMenu()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "tappedFilter"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "yearPicked"), object: nil)
        
    }
    @objc func methodOfReceivedNotification(notification: Notification){
        if pushed {
            pushed = false
            return
        }
        pushed = true
        self.navigationItem.title = ""
        
        let controller:FilterController = self.storyboard?.instantiateViewController(withIdentifier: "FilterController") as! FilterController
        UserDefaults.standard.set("calendar", forKey: "condi")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @objc func yearReceivedNotification(notification: Notification){
        //        self.title = notification.object as? String
        self.title = "Calendar"
    }
    @objc func showListView(notification: Notification){
        btnListView.setTitle("", for: .normal)
        btnListView.setImage(UIImage.init(named:"ic_list_view"), for: .normal)
    }
    @objc func hideListView(notification: Notification){
        btnListView.setTitle("", for: .normal)
        btnListView.setImage(nil, for: .normal)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //        btnListView.image = UIImage()
        //        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "tappedFilter"), object: nil)
        
        getAppointmentTypesList()
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "yearPicked"), object: nil)
        
        //        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "pushToActivity1"), object: nil)
        
        //        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "yearPicked"), object: nil)
        
        if isFromLogin {
            isFromLogin = false
            self.slideMenuController()?.openLeft()
        }
        
        btnListView.setTitle("", for: .normal)
        btnListView.setImage(nil, for: .normal)
        
        NavigationHelper().setupScreen(vc: self)
        
        let tabView = NavigationHelper().setupBarSqureImage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            //            let setupImage:UIImage = tabView.takeScreenshot()
            //            self.btnDropDown.image = setupImage
        }
        //        self.btnDropDown
        NotificationCenter.default.addObserver(self, selector: #selector(self.showListView(notification:)), name: Notification.Name("showedDailyView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideListView(notification:)), name: Notification.Name("hidedDailyView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("tappedFilter"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.yearReceivedNotification(notification:)), name: Notification.Name("yearPicked"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getDragMenthods), name: Notification.Name("dragappointment"), object: nil)
        
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(pushToActivity),
                                       name: .pushToActivity,
                                       object: nil)
        
        let notificationCenter1 = NotificationCenter.default
        notificationCenter1.addObserver(self,
                                        selector: #selector(pushToActivity1),
                                        name: Notification.Name(
                                            rawValue: "pushToActivity1"),
                                        object: nil)
        
        let notificationCenter2 = NotificationCenter.default
        notificationCenter2.addObserver(self,
                                        selector: #selector(Allday),
                                        name: Notification.Name(
                                            rawValue: "Allday"),
                                        object: nil)
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY"
        let monthsToAdd = 0
                let daysToAdd = 0
                let yearsToAdd = -1
        var dateComponent = DateComponents()
               
               dateComponent.month = monthsToAdd
               dateComponent.day = daysToAdd
               dateComponent.year = yearsToAdd
               
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: Date())!
        let currentYear = dateformatter.string(from: futureDate)

//        let currentYear = "2021"
        startTime = "\(currentYear)-01-01"
        endTime = "\(2100)-12-31"
        selectedYear = currentYear
        UserDefaults.standard.set(currentYear, forKey: "selectedYear")
        
    }
    ////// mvcdxwq
    @objc func getDragMenthods()
    {
        self.isdrag = true
        self.getAppointmentTypesList()
    }
    func getAppointmentTypesList(){
        let json: [String: Any] = ["PageOffset": 1,
                                   "ResultsPerPage": 5000,
                                   "ObjectName":"appointment_type",
                                   "AscendingOrder":true,
                                   "OrderBy":"Name",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        OperationQueue.main.addOperation {
            //  SVProgressHUD.show()
            //            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                //                print(json)
                var model = GetAppointmentTypesModel.init(fromDictionary: jsonResponse)
                self.appointmentIDList = []
                self.appointmentColorList = []
                if(!model.valid){
                    self.loginUser()
                }
                else {
                    var getModelResult:[GetAppointmentTypesResult] = model.results
                    getModelResult = getModelResult.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending }
                    
                    if model.valid {
                        for index in 0..<model.results.count {
                            self.appointmentIDList.add(getModelResult[index].id)
                            self.appointmentColorList.add(getModelResult[index].calendarColor)
                        }
                    }
                    self.getActivitiesList()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            OperationQueue.main.addOperation {
                // SVProgressHUD.dismiss()
                //                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
    }
    
    
    func loginUser(){
        var userEmail : String!
        var userPwd : String!
        if let data = UserDefaults.standard.object(forKey: "userEmail") as? String{
            userEmail = data
        }
        if let data = UserDefaults.standard.object(forKey: "userPassword") as? String{
            userPwd = data
        }
        let json: [String: Any] = ["UserName": userEmail,
                                   "Password": userPwd]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: loginURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                let logModel:LoginModel = LoginModel.init(fromDictionary: jsonResponse)
                
                if logModel.valid {
                    passKey = logModel.passKey
                    self.getAppointmentTypesList()
                }else{
                    NavigationHelper.showSimpleAlert(message:logModel.responseMessage)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
   
    
  
    
    
    func getActivitiesList(){
        
        let teamlist = UserDefaults.standard.string(forKey: "filter_team")

        if(self.parseFilterList.count == 0)
        {
            let appoinmentlist = UserDefaults.standard.string(forKey: "filter_appoin")
            if(appoinmentlist != nil && appoinmentlist != "")
            {
                self.parseFilterList = appoinmentlist?.components(separatedBy: ",") ?? []
            }
        }
        
        if (self.parseUserList.count > 0)
        {
            forUsers = self.parseUserList as NSArray
        }
        else if (teamlist != nil && teamlist != "")
        {
            forUsers = teamlist?.components(separatedBy: ",") as NSArray? ?? []
        }else{
            forUsers = []
            forAppointmentTypes = []
        }
       
        let json:[String: Any] = ["ObjectName":"",
                                  "From":startTime,
                                  "To":endTime,
                                  "IncludeAppointments":includeAppointments,
                                  "IncludeTasks":false,
                                  "IncludeAttendees":includeAttendess,
                                  "ForUsers":forUsers,
                                  "ForContacts":[],
                                  "ForCompanies":[],
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: getActivities, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                //                print(json)
                self.getCalendarActivityList = []
                self.appointmentDict = [:]
                var filterdict : [GetCalendarListActivity] = []
                let model = GetCalendarListRootClass.init(fromDictionary: jsonResponse)
                if model.valid {
                    if(self.parseFilterList.count > 0)
                    {
                        for (index,element) in model.activities.enumerated()
                        {
                            let appoinid = element.activity.appointmentTypeId as? String
                            if(appoinid != nil){
                                if(self.parseFilterList.contains(appoinid!))
                                {
                                    filterdict.append((model.activities?[index])!)
                                }}
                        }
                        
                        var abc : GetCalendarListActivity!
                        var sample : GetCalendarListActivity!
                        var dateString : String!
                        for (index,element) in filterdict.enumerated()
                        {
                            var appoinid = element.activity.appointmentTypeId as? String
                            if(appoinid != nil){
                            }
                            else{
                                appoinid = ""
                            }
                            let start : String = element.activity.startTime
                            let end : String = element.activity.endTime
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                            var st_date : Date = dateFormatter.date(from: start)!
                            let en_date : Date = dateFormatter.date(from: end)!
                            let diff = Calendar.current.dateComponents([.day], from: st_date, to: en_date)
                            if diff.day == 0 {
                            } else {
                                for isdex in stride(from: diff.day!, to: 0, by: -1) {
                                    let tomorrow = Calendar.current.date(byAdding:.day,value: 1,to: st_date)
                                    dateString = dateFormatter.string(from: tomorrow!)
                                    st_date = tomorrow!
                                    sample = element.copy() as? GetCalendarListActivity
                                    abc = element.activity.copy() as? GetCalendarListActivity
                                    if(isdex == 1)
                                    {  let date = dateString.components(separatedBy: "T")
                                        if(date.count > 0){
                                            let combinedate = date.first! + "T18:29:00" + ".000Z"
                                            let enddate = date.first! + "T18:29:59" + ".000Z"
                                            abc.startTime = combinedate
                                            abc.endTime = enddate
                                        }
                                    }else
                                    {
                                        let date = dateString.components(separatedBy: "T")
                                        if(date.count > 0){
                                            let combinedate = date.first! + "T18:29:00" + ".000Z"
                                            let enddate = date.first! + "T18:29:59" + ".000Z"
                                            abc.startTime = combinedate
                                            abc.endTime = enddate
                                        }else
                                        {
                                            abc.startTime = dateString
                                        }
                                    }
                                    sample.activity = abc
                                    filterdict.append(sample)
                                }
                            }
                        }
                        self.getCalendarActivityList = filterdict
                        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.getCalendarActivityList)
                        UserDefaults.standard.set(encodedData, forKey: "longterm")
                        
                    }else
                    {
                        var abc : GetCalendarListActivity!
                        var def : GetCalendarListActivity!
                        var sample : GetCalendarListActivity!
                        var dateString : String!
                        
                        
                        for (index,element) in model.activities.enumerated()
                        {
                            let start : String = model.activities[index].activity.startTime
                            let end : String = model.activities[index].activity.endTime
                            
                            var appoinid = element.activity.appointmentTypeId as? String
                            if(appoinid != nil){
                            }
                            else{
                                appoinid = ""
                            }
                            var en_date : Date!
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                            var st_date : Date = dateFormatter.date(from: start)!
                            if let enn_date : Date = dateFormatter.date(from: end){
                                en_date = enn_date
                            }else
                            {
                                en_date = dateFormatter.date(from: "2020-03-08T01:59:00.000Z")
//                                let calendar = Calendar.current
//                                let reducedate = calendar.date(byAdding: .minute, value: -5, to: en_date)
                            }
                           
                            let diff = Calendar.current.dateComponents([.day], from: st_date, to: en_date)
                            if diff.day == 0 {
                                
                            } else {
                                    for isdex in stride(from: diff.day!, to: 0, by: -1) {
                                        let tomorrow = Calendar.current.date(byAdding:.day,value: 1,to: st_date)
                                        dateString = dateFormatter.string(from: tomorrow!)
                                        st_date = tomorrow!
                                        sample = element.copy() as? GetCalendarListActivity
                                        abc = element.activity.copy() as? GetCalendarListActivity
                                        if(isdex == 1)
                                        {  let date = dateString.components(separatedBy: "T")
                                            if(date.count > 0){
                                                let combinedate = date.first! + "T18:29:00" + ".000Z"
                                                let enddate = date.first! + "T18:29:59" + ".000Z"
                                                abc.startTime = combinedate
                                                abc.endTime = enddate
                                            }
                                        }else
                                        {
                                            let date = dateString.components(separatedBy: "T")
                                            if(date.count > 0){
                                                let combinedate = date.first! + "T18:29:00" + ".000Z"
                                                let enddate = date.first! + "T18:29:59" + ".000Z"
                                                abc.startTime = combinedate
                                                abc.endTime = enddate
                                            }else
                                            {
                                                abc.startTime = dateString
                                            }
                                        }
                                        sample.activity = abc
                                        model.activities.append(sample)
                                    }
                        }
                            
                        }
                        self.getCalendarActivityList = model.activities
                        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.getCalendarActivityList)
                        UserDefaults.standard.set(encodedData, forKey: "longterm")
                    }
                    self.getCalendarActivityList = self.getCalendarActivityList.sorted { $0.subject.localizedCaseInsensitiveCompare($1.subject) == ComparisonResult.orderedAscending }
                    self.appointmentDict = jsonResponse
                    if(!self.isdrag){
                    self.setupCalendarView()
                    }
                    self.isdrag = false
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            //            OperationQueue.main.addOperation {
            //                SVProgressHUD.dismiss()
            //            }
        })
    }
    
   
    
    func setupCalendarView(){
        
        for v in calendarView.subviews{
            v.removeFromSuperview()
        }
        UserDefaults.standard.set(selectedYear, forKey: "selectedYear") //setObject
        
        let annualViewController:SSCalendarAnnualViewController = (SSCalendarAnnualViewController(events: generateEvents()))!
        //annualViewController.listAppointments = (appointmentDict as! [AnyHashable : Any])
        //getAppointmentList
        let navigationController = UINavigationController(rootViewController: annualViewController)
        navigationController.navigationBar.isTranslucent = false
        let view1 = navigationController.view
        view1?.frame.size.height = self.calendarView.frame.size.height
        view1?.frame.size.width = self.calendarView.frame.size.width
        self.addChildViewController(navigationController)
        self.calendarView.addSubview(navigationController.view!)
        
        OperationQueue.main.addOperation {
            // SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func tappedBack(_ sender: Any) {
    }
    
    fileprivate func generateEvents() -> [SSEvent] {
        var events: [SSEvent] = []
        
        let allYears:NSMutableArray = []
        
        for index in 0..<getCalendarActivityList.count {
            
            let result:GetCalendarListActivity = getCalendarActivityList[index].activity
            if result.startTime != nil {
                let startTime:String = result.startTime
                let startYear:String = converYearToString(dateString: startTime)
                
                if startYear.count > 0 {
                    
                    
                    let getYear = Int(converYearToString(dateString: startTime))
                    let getMonth = Int(converMonthToString(dateString: startTime))
                    let getDate = Int(convertDateToString(dateString: startTime))
                    
                    var getTime = convertTimeToString(dateString: startTime)
                    
                    
                    if result.endTime != nil {
                        let endTime:String = result.endTime
                        let getEndTime = convertTimeToString(dateString: endTime)
                        getTime = getTime + "!@#\(getEndTime)"
                    }else if result.DueTime != nil {
                        let endTime:String = result.DueTime
                        let getEndTime = convertTimeToString(dateString: endTime)
                        getTime = getTime + "!@#\(getEndTime)"
                    }
                    
                    var getColor:String = ""
                    var getID:String = ""
                    
                    if result.appointmentTypeId != nil {
                        
                        if self.appointmentIDList.contains(result.appointmentTypeId) {
                            let getIndex = self.appointmentIDList.index(of: result.appointmentTypeId)
                            getColor = self.appointmentColorList[getIndex] as! String
                            getID = self.appointmentIDList[getIndex] as! String
                            getTime = getTime + "!@#\(getColor)"
                            appointmentColor.add(getColor)
                            appointmentIDD.add(getID)
                        }else{
                            appointmentIDD.add("")
                            appointmentColor.add("a5c2f2")
                        }
                        
                        let encodedData = NSKeyedArchiver.archivedData(withRootObject: appointmentColorList)
                        UserDefaults.standard.set(encodedData, forKey: "ColorAppID")
                        
                        let encodedData1 = NSKeyedArchiver.archivedData(withRootObject: appointmentIDList)
                        UserDefaults.standard.set(encodedData1, forKey: "AppointAppID")
                    }
                    var subjectName:String = ""
                    var subjectDescription:String = ""
                    
                    if let getSubject:String = result.subject {
                        subjectName = getSubject
                    }
                    if let getSubject:String = result.descriptionField {
                        subjectDescription = getSubject
                    }
                    if let value = result.appointmentTypeId as? String {
                        print(value)
                        if result.appointmentTypeId != nil {
                            events.append(generateEvent(getYear!, month: getMonth!, Date: getDate!, info: subjectName, desc: subjectDescription, time: getTime, aID: result.id!, appointmentTypeID: result.appointmentTypeId! as! String,isDay: result.allDay))
                        }
                    }
                    else{
                        events.append(generateEvent(getYear!, month: getMonth!, Date: getDate!, info: subjectName, desc: subjectDescription, time: getTime, aID: result.id!, appointmentTypeID: "",isDay: result.allDay))
                    }
                }
                
                if !allYears.contains(startYear) {
                    allYears.add(startYear)
                }
            }
            
            if result.endTime != nil {
                let endTime:String = result.endTime
                let endYear:String = converYearToString(dateString: endTime)
                if !allYears.contains(endYear) {
                    allYears.add(endYear)
                }
            }
        }
        return events
    }
    
    fileprivate func generateEvent(_ year: Int,month:Int,Date:Int,info:String,desc:String,time:String,aID:String,appointmentTypeID:String,isDay:Bool) -> SSEvent {
        let event = SSEvent()
        event.startDate = SSCalendarUtils.date(withYear: year, month: month, day: Date)
        event.startTime = time
        event.name = info
        event.desc = desc
        event.location = aID
        event.contact = appointmentTypeID
        //event.isAllday = isDay
        return event
    }
    func converYearToString(dateString:String) -> String{
        if dateString.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        return ""
    }
    func converMonthToString(dateString:String) -> String{
        if dateString.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MM" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        return ""
    }
    func convertDateMonthString(dateString:String) -> String{
        if dateString.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        return ""
    }
    func convertDateToString(dateString:String) -> String{
        if dateString.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        return ""
    }
    func convertTimeToString(dateString:String) -> String{
        if dateString.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "hh:mm a" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        return ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension CalendarController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = nil
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = UIView()
    }
}


extension CalendarController: DropdownMenuDelegate {
    func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        if indexPath.row != items.count - 1 {
            self.selectedRow = indexPath.row
        }
        let indexTitle:String = "\(items[indexPath.section][indexPath.row].title)"
        NavigationHelper().setupRootViewController(senderVC: self, title: indexTitle)
    }
}
extension CalendarController:URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let authMethod = challenge.protectionSpace.authenticationMethod
        
        guard challenge.previousFailureCount < 1, authMethod == NSURLAuthenticationMethodServerTrust,
            let trust = challenge.protectionSpace.serverTrust else {
                completionHandler(.performDefaultHandling, nil)
                return
        }
        completionHandler(.useCredential, URLCredential(trust: trust))
    }
}
extension Notification.Name {
    static let pushToActivity = Notification.Name(
        rawValue: "pushToActivity")
}
extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.tintColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.tintColor = newValue
        }
    }
}




