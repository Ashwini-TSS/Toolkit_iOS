//
//  CalendarController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 20/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import SSCalendar
import SocketIO
import CoreData

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
    var didLoadCalled : Bool = false
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    var manager: SocketManager!
     var socket: SocketIOClient!

    @IBOutlet weak var btnDropDown: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItem()
        self.didLoadCalled = true
        self.title = ""
        
        // TODO: you code here
        self.setupCalendarStartAndEndDate()
        getAppointmentTypesList()
        
        UserDefaults.standard.removeObject(forKey: "filterarray")
        
        UserDefaults.standard.set("no", forKey: "DAYALL")
        
        SSStyles.applyNavigationBarStyles()
        let  paskey = self.retriveRecordsFromCoreData()
        if(paskey != "")
        {
            self.connectToSocket(passkey: paskey)
        }
        self.navigationController?.navigationBar.backgroundColor = .red

        self.navigationController?.navigationBar.barTintColor = .black

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
       // self.demoactivity()
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
    
    func getConnectionParam() -> [String: Any] {
        UserDefaults.standard.set("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiaWF0IjoxNzQ0NzEyNDQwfQ.FDsnMamWyOcbYJ77slzg0EKgWMzq07O0YGnVZpmX1YU", forKey: "token")
        UserDefaults.standard.set("1", forKey: "user_id")

        let currtimezone = self.getCurrentTimeZone()
        let tok = UserDefaults.standard.string(forKey: "token")!
        let userIDD =  UserDefaults.standard.string(forKey: "user_id")!
               return ["auth": "\(tok)", "user_id": "\(userIDD)", "timeZone": "\(currtimezone)"]
       }
    
    func getCurrentTimeZone() -> String{
             return TimeZone.current.identifier
      }
    
    func retriveRecordsToolkitIdCoredata(gcalID : String) -> String
    {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
            {
                return ""
            }
            let managedobj = appDelegate.persistentContainer.viewContext
            let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GcalConfig")
            fetchrequest.predicate = NSPredicate(format: "gcalEventID=%@", gcalID)
            do{
                let result = try managedobj.fetch(fetchrequest)
                for data in (result as? [NSManagedObject])!
                {
                    print(data.value(forKey: "toolkitEventID") as! String)
                   let gcalID = data.value(forKey: "toolkitEventID") as? String
                    if(gcalID != "" && gcalID != nil){
                        return gcalID ?? ""
                    }
                }
            }catch{
                print("Error while fetching data")
            }
            return ""
        
    }
        
    func retriveRecordsFromCoreData() -> String
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return ""
        }
        let managedobj = appDelegate.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GcalPasskey")
        do{
            let result = try managedobj.fetch(fetchrequest)
            for data in (result as? [NSManagedObject])!
            {
            print(data.value(forKey: "passkey") as! String)
                let passkey = data.value(forKey: "passkey") as? String ?? ""
                return passkey
            }
            
        }catch{
            print("Error while fetching data")
        }
        return ""
    }
    
    func connectToSocket(passkey : String)
    {
        let socketURL = URL(string: "https://toolkit-gcal.tecnovaters.com")!
        let currtimezone = self.getCurrentTimeZone()

                manager = SocketManager(socketURL: socketURL, config: [.log(true),.extraHeaders(["auth": "Bearer \(passkey)", "user_id": "4", "timeZone": "\(currtimezone)"]),.compress])
                self.socket = manager.defaultSocket

                addHandlers()

                socket.connect()
    }
    
    func addHandlers() {
            socket.on(clientEvent: .connect) {data, ack in
                print("Socket connected ✅, \(ack)")
            }

            socket.on("4") { dataArray, ack in
                print("Received event data: \(dataArray)")
                let dataobj = dataArray[0] as? [String : Any]
                let type = dataobj?["type"] as? String
                let eventypeobj = dataobj?["event"] as? [String : Any]
                let status = eventypeobj?["status"] as? String

                if(type == "google_calendar_event_updated")
                {
                    if(status == "cancelled")
                    {
                        let idd = eventypeobj?["id"] as? String
                        let toolkitid = self.retriveRecordsToolkitIdCoredata(gcalID: idd ?? "")
                        self.DeleteAppointment(toolkitEventID: toolkitid)

                    }else{
                        let idd = eventypeobj?["id"] as? String
                        let location = eventypeobj?["location"] as? String
                        let description = eventypeobj?["description"] as? String
                        let summary = eventypeobj?["summary"] as? String
                        let startobj = eventypeobj?["start"] as? [String : Any]
                        let starttime = startobj?["dateTime"] as? String
                        let endobj = eventypeobj?["end"] as? [String : Any]
                        let endtime = endobj?["dateTime"] as? String
                        
                        let toolkitid = self.retriveRecordsToolkitIdCoredata(gcalID: idd ?? "")
                         
                        self.updateEditedEventsInToolkitCalendar(toolkitID: toolkitid, location: location ?? "", Description: description ?? "", endTime: endtime ?? "", StartTime: starttime ?? "", subject: summary ?? "")
                    }
                }
                else if (type == "google_calendar_event_deleted"){
                    let idd = eventypeobj?["eventId"] as? String
                    let toolkitid = self.retriveRecordsToolkitIdCoredata(gcalID: idd ?? "")
                    self.DeleteAppointment(toolkitEventID: toolkitid)
                }
                
            }

            socket.on(clientEvent: .disconnect) {data, ack in
                print("Socket disconnected ❌")
            }

            socket.on(clientEvent: .error) {data, ack in
                print("Socket error: \(data)")
            }
        }
    
    func DeleteAppointment(toolkitEventID : String){
        
        let parameters = [
            "ObjectId": toolkitEventID,
            "ObjectName": "appointment",
            "OrganizationId": currentOrgID,
            "PassKey": passKey
            ] as [String : Any]
        
        var mainURL:String!
        let headers = [
            "Content-Type": "application/json",
            ]
        
        mainURL = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/delete.json"
        
        let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 7.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers

      
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObj)
                guard let _:Dictionary = jsonObj as? [String:AnyObject] else{
                    return
                }
                let result = try JSON(data: data)
                print(result)
                print(result["ResponseMessage"])
                print("success")
                if(result["ResponseMessage"] == "success"){
                    self.getActivitiesList()
                }else{
                    let alert = UIAlertController(title:result["ResponseMessage"].stringValue, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
                catch {
                    print(error.localizedDescription)
                }
            })
           dataTask.resume()
    }
    
    func updateEditedEventsInToolkitCalendar(toolkitID : String, location : String, Description: String, endTime : String, StartTime: String, subject : String)
    {
           
        let parameters  = [
                "DataObject": [
                    "Location" : location,
                    "Description":Description,
                    "EndTime": endTime,
                    "Id": toolkitID,
                    "StartTime": StartTime,
                    "Subject": subject
                ],
                "OrganizationId": currentOrgID,
                "ObjectName": "appointment",
                "PassKey": passKey
                ] as [String : Any]
                        
                var mainURL:String!
                let headers = [
                    "Content-Type": "application/json",
                    ]
                mainURL = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/modify.json"
                
                let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 7.0)
                
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headers
                if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                    request.httpBody = jsonData
                }
                let configuration = URLSessionConfiguration.default
                let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
                let dataTask11 = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription as Any)
                        return
                    }
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                        print(jsonObj)
                        guard let _:Dictionary = jsonObj as? [String:AnyObject] else{
                            return
                        }
                        let result = try JSON(data: data)
                        print(result)
                        self.getActivitiesList()
                    }catch {
                        print(error.localizedDescription)
                    }
                })
                dataTask11.resume()
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
    
    @IBAction func calendarPickerAction(_ sender: UIBarButtonItem) {
        self.calendarButtonTapped(sender: sender)
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
        UserDefaults.standard.set(true, forKey: "pickeradded") //setObject
        // Strings Picker
        DPPickerManager.shared.showPicker(title: "Pick Year", selected: pickerValue, strings: listYears as! [String]) { (value, index, cancel) in
            if !cancel {
                
                
                startTime = "\(value!)-01-01"
                endTime = "\(value!)-12-31"
                selectedYear = value!
                UserDefaults.standard.set(selectedYear, forKey: "selectedYear")
                // TODO: you code here
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistency

                if let date = dateFormatter.date(from: value ?? "") {
                    var dateComponents = DateComponents()
                    dateComponents.year = 1 // Adding 2 years

                    // Add years to the date
                    if let futureDate = Calendar.current.date(byAdding: dateComponents, to: date) {
                        let formattedFutureDate = dateFormatter.string(from: futureDate) // Convert back to string if needed
                        endTime = "\(formattedFutureDate)-12-31"

                    }
                } else {
                    print("Invalid year format")
                }
                
                if let date = dateFormatter.date(from: value ?? "") {
                    var dateComponents = DateComponents()
                    dateComponents.year = -1 // Minus 2 years

                    // Add years to the date
                    if let futureDate = Calendar.current.date(byAdding: dateComponents, to: date) {
                        let formattedPreviousDate = dateFormatter.string(from: futureDate) // Convert back to string if needed
                        startTime = "\(formattedPreviousDate)-01-01"

                    }
                } else {
                    print("Invalid year format")
                }
                
                self.getAppointmentTypesList()

            }
        }
    }
    
    
    @IBAction func tappedTab(_ sender: Any) {
        if addPreviousControllers.count > 0 {
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let  paskey = self.retriveRecordsFromCoreData()
        if(paskey != "")
        {
            socket.disconnect()
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "tappedFilter"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "yearPicked"), object: nil)
        UserDefaults.standard.set(false, forKey: "pickeradded") //setObject

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
        if(!self.didLoadCalled){
            setupCalendarView()
        }
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
    }
    
    func setupCalendarStartAndEndDate()
    {
        if let selectedcurrentyear = UserDefaults.standard.string(forKey: "selectedYear") {
            
            startTime = "\(selectedcurrentyear)-01-01"
            endTime = "\(selectedcurrentyear)-12-31"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Ensure consistency

            if let date = dateFormatter.date(from: selectedcurrentyear) {
                var dateComponents = DateComponents()
                dateComponents.year = 1 // Adding 2 years

                // Add years to the date
                if let futureDate = Calendar.current.date(byAdding: dateComponents, to: date) {
                    let formattedFutureDate = dateFormatter.string(from: futureDate) // Convert back to string if needed
                    endTime = "\(formattedFutureDate)-12-31"

                }
            } else {
                print("Invalid year format")
            }
            
            if let date = dateFormatter.date(from: selectedcurrentyear) {
                var dateComponents = DateComponents()
                dateComponents.year = -1 // Minus 2 years

                // Add years to the date
                if let futureDate = Calendar.current.date(byAdding: dateComponents, to: date) {
                    let formattedPreviousDate = dateFormatter.string(from: futureDate) // Convert back to string if needed
                    startTime = "\(formattedPreviousDate)-01-01"

                }
            } else {
                print("Invalid year format")
            }
                       
            selectedYear = "\(selectedcurrentyear)"
            UserDefaults.standard.set(selectedcurrentyear, forKey: "selectedYear")
        }
        else{
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "YYYY"
            
            let monthsToAdd1 = 0
            let daysToAdd1 = 0
            let yearsToAdd1 = 0
            var dateComponents = DateComponents()
            
            dateComponents.month = monthsToAdd1
            dateComponents.day = daysToAdd1
            dateComponents.year = yearsToAdd1
            
            let futureDate1 = Calendar.current.date(byAdding: dateComponents, to: Date())!
            let endyear = dateformatter.string(from: futureDate1)
            
            let yearsToAddplus = 1
            dateComponents.year = yearsToAddplus
            
            let futureDateadd = Calendar.current.date(byAdding: dateComponents, to: Date())!
            let plus2 = dateformatter.string(from: futureDateadd)

            let yearsToAddminus = -1
            dateComponents.year = yearsToAddminus
            
            let futureDatemiuns = Calendar.current.date(byAdding: dateComponents, to: Date())!
            let minus2 = dateformatter.string(from: futureDatemiuns)
            
            startTime = "\(minus2)-01-01"
            endTime = "\(plus2)-12-31"
            selectedYear = "\(endyear)"
            UserDefaults.standard.set(endyear, forKey: "selectedYear")
        }
    }
    
    @objc func getDragMenthods()
    {
        self.isdrag = true
        self.getAppointmentTypesList()
    }
    func getAppointmentTypesList(){
        if(self.appointmentColorList.count == 0)
        {
            let json: [String: Any] = ["PageOffset": 1,
                                       "ResultsPerPage": 5000,
                                       "ObjectName":"appointment_type",
                                       "AscendingOrder":true,
                                       "OrderBy":"Name",
                                       "PassKey":passKey,
                                       "OrganizationId":currentOrgID]
            print(json)
            OperationQueue.main.addOperation {
//                  SVProgressHUD.show()
//                MBProgressHUD.showAdded(to: self.view, animated: true)
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
                        self.getActivitiesList()
                        var getModelResult:[GetAppointmentTypesResult] = model.results
                        getModelResult = getModelResult.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending }
                        
                        if model.valid {
                            for index in 0..<model.results.count {
                                self.appointmentIDList.add(getModelResult[index].id)
                                self.appointmentColorList.add(getModelResult[index].calendarColor)
                            }
                        }
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
        else
        {
            OperationQueue.main.addOperation {
//                  SVProgressHUD.show()
//                            MBProgressHUD.showAdded(to: self.view, animated: true)
            }
            self.getActivitiesList()
        }
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
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
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
//        UserDefaults.standard.set(selectedYear, forKey: "selectedYear") //setObject
        
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
        var allYears: Set<String> = []
        
        for activityWrapper in getCalendarActivityList {
            let result = activityWrapper.activity
            
            guard let startTime = result?.startTime else { continue }
            
            let startYear = converYearToString(dateString: startTime)
            guard !startYear.isEmpty,
                  let getYear = Int(startYear),
                  let getMonth = Int(converMonthToString(dateString: startTime)),
                  let getDate = Int(convertDateToString(dateString: startTime)) else { continue }
            
            var startTimeStr = convertTimeToString(dateString: startTime)
            
            if let endTime = result?.endTime {
                let endTimeStr = convertTimeToString(dateString: endTime)
                startTimeStr += "!@#\(endTimeStr)"
                allYears.insert(converYearToString(dateString: endTime))
            } else if let dueTime = result?.DueTime {
                let endTimeStr = convertTimeToString(dateString: dueTime)
                startTimeStr += "!@#\(endTimeStr)"
            }
            
            var color = "a5c2f2"
            var appointmentID = ""
            
            if let appTypeId = result?.appointmentTypeId as? String {
                let swiftArray = appointmentIDList as? [String] ?? []
                
                if let index = swiftArray.firstIndex(where: { $0 == appTypeId }) {
                    color = (appointmentColorList[index] as? String) ?? color
                    appointmentID = appTypeId
                    appointmentColor.add(color)
                    appointmentIDD.add(appTypeId)
                } else {
                    appointmentColor.add(color)
                    appointmentIDD.add("")
                }
            }
            
            startTimeStr += "!@#\(color)"
            
            // Persist data
            let encodedColor = NSKeyedArchiver.archivedData(withRootObject: appointmentColorList)
            UserDefaults.standard.set(encodedColor, forKey: "ColorAppID")
            
            let encodedID = NSKeyedArchiver.archivedData(withRootObject: appointmentIDList)
            UserDefaults.standard.set(encodedID, forKey: "AppointAppID")
            
            let subjectName = result?.subject ?? ""
            let subjectDescription = result?.descriptionField ?? ""
            
            let appointmentTypeID = (result?.appointmentTypeId as? String) ?? ""
            
            let ids = result?.id
            if let idd = ids {
                let event = generateEvent(
                    getYear,
                    month: getMonth,
                    Date: getDate,
                    info: subjectName,
                    desc: subjectDescription,
                    time: startTimeStr,
                    aID: idd,
                    appointmentTypeID: appointmentTypeID,
                    isDay: ((result?.allDay) != nil)
                )
                events.append(event)
            }
            
            allYears.insert(startYear)
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




