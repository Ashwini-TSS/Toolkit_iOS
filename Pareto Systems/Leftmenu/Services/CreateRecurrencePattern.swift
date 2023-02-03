//
//  CreateRecurrencePattern.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 14/09/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class CreateRecurrencePattern: UITableViewController {
    
    var createMethod:String = "recurring_activity"
    var fromAccounts:Bool = false
    var scheduleTpes:NSArray = ["Appointment","Task"]
    var dateFieldTypes:NSArray = ["Review Date", "Anniversary", "Birthday", "Client Since", "Driver's License Expiry"]
    var removalRules:NSArray = ["Delete All Incomplete","Delete All Unmodified","Delete All Future"]
    var patternNameList:NSMutableArray = []
    var patternIdList:NSMutableArray = []
    
    var patternTypes:NSArray = ["Daily","Weekly","Monthly","Yearly"]
    var activityTypeList:NSArray = ["Appointment","Task"]
    
    var patternMonthsTypes:NSArray = ["Scheduling","Skipping","Moving To Nearest Weekday"]
    var monthTypesList:NSArray = ["First","Second","Third","Fourth","Last"]
    var yearMonthsList:NSArray = []
    var appointmentNameList:NSMutableArray = []
    var appointmentIdList:NSMutableArray = []
    var appointmentColor:NSMutableArray = []
    
    var assigneeNameList:NSMutableArray = []
    var assigneeIDSList:NSMutableArray = []
    
    var linkParentID:String = ""
    
     var accountname : String = ""
    
    var cancelBtn = UIButton()
    var donelBtn = UIButton()
    
    var assigneeTypeList:NSMutableArray = ["Contacts Owner","Owner's Assistant","Specific Person"]
    
    var serviceList:GetServicesListResult!
    var custompicker : UIDatePicker?
    @IBOutlet weak var btnPatternAdd: UIButton!
    @IBOutlet weak var btnRollOver: UIButton!
    @IBOutlet weak var btnAllDayEvent: UIButton!
    @IBOutlet weak var fieldChooseTeammemberes: ACFloatingTextfield!
    @IBOutlet weak var fieldChooseAccounts: ACFloatingTextfield!
    @IBOutlet weak var fieldChooseContacts: ACFloatingTextfield!
    @IBOutlet weak var filedRecurrenceStart: ACFloatingTextfield!
    @IBOutlet weak var filedRecurrenceEnd: ACFloatingTextfield!
    @IBOutlet weak var fieldRemovaRule: ACFloatingTextfield!
    @IBOutlet weak var fieldEndTime: ACFloatingTextfield!
    @IBOutlet weak var fieldStartTime: ACFloatingTextfield!
    @IBOutlet weak var fieldLocation: ACFloatingTextfield!
    @IBOutlet weak var fieldDescription: KMPlaceholderTextView!
    @IBOutlet weak var fieldSubject: ACFloatingTextfield!
    @IBOutlet weak var fieldAppointmentType: ACFloatingTextfield!
    @IBOutlet weak var btnRecureEveryYear: UIButton!
    @IBOutlet weak var lblRecureEceryYear: UILabel!
    @IBOutlet weak var btnAddRecurYear: UIButton!
    @IBOutlet weak var btnRemoveRecurYear: UIButton!
    @IBOutlet weak var fieldRecureYearCount: UITextField!
    @IBOutlet weak var fieldRecurYearPattern: ACFloatingTextfield!
    @IBOutlet weak var btnTheYear: UIButton!
    @IBOutlet weak var fieldMonthYear: UITextField!
    @IBOutlet weak var fieldTheMonth: UITextField!
    @IBOutlet weak var lblRecurEveryMonths: UILabel!
    @IBOutlet weak var lblTheEveryMonths: UILabel!
    @IBOutlet weak var weekDaySelectionYear: WeekdaysSegmentedControl!
    @IBOutlet weak var fieldTheMonthCount: UITextField!
    @IBOutlet weak var fieldMonthCount: UITextField!
    @IBOutlet weak var fieldTheMonthYear: UITextField!
    @IBOutlet weak var lblTheEveryYear: UILabel!
    @IBOutlet weak var btnRemoveTheCount: UIButton!
    @IBOutlet weak var fieldTheEveryYearCount: UITextField!
    @IBOutlet weak var btnTheAddCount: UIButton!
    @IBOutlet weak var monthWeekDayBGSelectioon: WeekdaysSegmentedControl!
    @IBOutlet weak var fieldMonthPattern: ACFloatingTextfield!
    @IBOutlet weak var btnTheMonth: UIButton!
    @IBOutlet weak var btnRecurMonth: UIButton!
    @IBOutlet weak var weekBgSelection: WeekdaysSegmentedControl!
    @IBOutlet weak var fieldWeekCount: UITextField!
    @IBOutlet weak var lblRecurEveryWeekend: UILabel!
    @IBOutlet weak var fieldDayPattern: ACFloatingTextfield!
    @IBOutlet weak var fieldDayCount: UITextField!
    @IBOutlet weak var lblEceryDays: UILabel!
    @IBOutlet weak var fieldCustomPattern: ACFloatingTextfield!
    @IBOutlet weak var fieldPattern: ACFloatingTextfield!
    @IBOutlet weak var btnExisting: UIButton!
    @IBOutlet weak var btnCustom: UIButton!
    @IBOutlet weak var fieldSchedulingType: ACFloatingTextfield!
    
    var patternID:String = ""
    var appointmentID:String = ""
    var lblStartTime:String = ""
    var lblEndTime:String = ""
    var lblRecurrenceStartTime:String = ""
    var lblRecurrenceEndTime:String = ""
    var isAllDay:Bool = false
    var isRollOver:Bool = false
    var assigneeID:String = ""
    var deliverableDate:String = ""
    var weekDays:NSMutableArray = []
    var monthDays:NSMutableArray = []
    var YearDays:NSMutableArray = []
    var ClientClassId:String = ""
    var bottomView = UIView()
    
    var contactList:[ContactListResult] = []
    var teamMembers:[NewAppointmentResult] = []
    var accountsList:[TeamMembersResult] = []
    
    
    var contactsIDList:NSMutableArray = []
    var teamMembersIDList:NSMutableArray = []
    var accountsIDList:NSMutableArray = []
    
    var selectedContacts:NSMutableArray = []
    var selectedTeamMembers:NSMutableArray = []
    var selectedCompanies:NSMutableArray = []
    
    var linkedContactIDList:NSMutableArray = []
    var linkedTeamMemberIDList:NSMutableArray = []
    var linkedAccountsIDList:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Recurring Activity"
        
        cancelBtn.isUserInteractionEnabled = true
        donelBtn.isUserInteractionEnabled = true
        
        fieldChooseAccounts.text = accountname
        
        let monthComponents = Calendar.current.standaloneMonthSymbols
        yearMonthsList = monthComponents as NSArray
        //fieldTheMonthYear
        fieldTheMonth.text = monthTypesList[0] as? String
        fieldCustomPattern.text = patternTypes[0] as? String
        fieldMonthPattern.text = patternMonthsTypes[0] as? String
        fieldDayPattern.text = patternMonthsTypes[0] as? String
        fieldRecurYearPattern.text = patternMonthsTypes[0] as? String
        fieldMonthYear.text = monthTypesList[0] as? String
        if serviceList != nil {
            self.title = "Edit Service"
            
            lblStartTime = serviceList.startTime
            lblEndTime = serviceList.endTime
            
            
            fieldSchedulingType.text = serviceList.deliverableType
//            fieldDate.text = serviceList.contactDateFieldName
            fieldAppointmentType.text = serviceList.appointmentTypeId
            fieldSubject.text = serviceList.subject
            fieldDescription.text = serviceList.descriptionField
            fieldLocation.text = serviceList.location
            fieldStartTime.text = converDateToString(dateString: serviceList.startTime)
            fieldEndTime.text = converDateToString(dateString: serviceList.endTime)
//            fieldDayOffset.text = "\(serviceList.dayOffset!)"
//            fieldAssigneeType.text = serviceList.assigneeType
            fieldCustomPattern.text = serviceList.activityType
            fieldCustomPattern.text = "Daily"
            self.fieldCustomPattern.placeholder = "Activity Type"
            isAllDay = serviceList.allDay
            isRollOver = serviceList.rollOver
            
            if serviceList.allDay {
                btnAllDayEvent.setImage(UIImage.init(named:"ic_check"), for: .normal)
            }else{
                btnAllDayEvent.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
            }
            if serviceList.rollOver {
                btnRollOver.setImage(UIImage.init(named:"ic_check"), for: .normal)
            }else{
                btnRollOver.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
            }
            self.patternID = serviceList.recurrencePatternId!
            let json: [String: Any] = ["ObjectId": serviceList.recurrencePatternId!,
                                       "ObjectName":"recurrence_pattern",
                                       "PassKey":passKey,
                                       "OrganizationId":currentOrgID,
                                       "PageOffset": 1,
                                       "ResultsPerPage": 5000,
                                       "PageOffset":1,
                                       "ResultsPerPage":10000]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL: getURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    
                    let controller = GetServiceInfoModel.init(fromDictionary: jsonResponse)
                    if controller.valid {
                        self.fieldPattern.text = controller.dataObject.name!
                    }
                    if self.serviceList.appointmentTypeId != nil {
                        self.getAppointmentName(appointmentID: self.serviceList.appointmentTypeId!)
                    }
                    self.tableView.reloadData()
                }
            },  onFailure: { error in
                print(error.localizedDescription)
            })
            
        }
        
        if((UserDefaults.standard.object(forKey: "showingDayView")) != nil) {
            
            let vals = UserDefaults.standard.bool(forKey: "Goday")
            if(vals)
            {
                let cdate = UserDefaults.standard.string(forKey: "Godate")!
                let datefor = cdate + "T" + " 12:30:00.000Z"
                filedRecurrenceStart.text = self.convertDateMonthString(dateString: datefor)
                let dart = self.convertStringToDate(dateString: datefor)

                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
                self.lblRecurrenceStartTime = formatter.string(from: dart)
            }else{
            
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:00 a"
            let getStarttTime:String = formatter.string(from: Date())
            fieldStartTime.text = getStarttTime
            //
            formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
            self.lblStartTime = formatter.string(from: Date())
            //
            //
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .hour, value: 1, to: Date())
            formatter.dateFormat = "hh:00 a"
            let getEndTime:String = formatter.string(from: date!)
            
            fieldEndTime.text = getEndTime
            //
            formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
            self.lblEndTime = formatter.string(from: date!)
            //
            formatter.dateFormat = "YYYY-MM-dd"
            let getStartTime:String = formatter.string(from: Date())
            filedRecurrenceStart.text = getStartTime
            
            formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
            self.lblRecurrenceStartTime = formatter.string(from: Date())
            
            UserDefaults.standard.removeObject(forKey: "showingDayView")
            UserDefaults.standard.removeObject(forKey: "eventStartDate")
            }
        }else{
            
            let vals = UserDefaults.standard.bool(forKey: "Goday")
            if(vals)
            {
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:00 a"
                let getStarttTime:String = formatter.string(from: Date())
                fieldStartTime.text = getStarttTime
                
                formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
                self.lblStartTime = formatter.string(from: Date())
                
                let calendar = Calendar.current
                let date = calendar.date(byAdding: .hour, value: 1, to: Date())
                formatter.dateFormat = "hh:00 a"
                let getEndTime:String = formatter.string(from: date!)

                fieldEndTime.text = getEndTime
                formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
                self.lblEndTime = formatter.string(from: date!)
                
                let dater = Date()
                let hour = calendar.component(.hour, from: dater)
                let minutes = calendar.component(.minute, from: dater)
                
                let cdate = UserDefaults.standard.string(forKey: "Godate")!
                let datefor = cdate + "T" + "\(hour):\(minutes):00.000Z"
//                filedRecurrenceStart.text = self.convertDateMonthString(dateString: datefor)
                filedRecurrenceStart.text = cdate
                
                let dart = self.convertStringToDate(dateString: datefor)
                formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
                self.lblRecurrenceStartTime = formatter.string(from: dart)
                
            }else{
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:00 a"
            let getStarttTime:String = formatter.string(from: Date())
            fieldStartTime.text = getStarttTime
//
            formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
            self.lblStartTime = formatter.string(from: Date())
//
//
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .hour, value: 1, to: Date())
            formatter.dateFormat = "hh:00 a"
            let getEndTime:String = formatter.string(from: date!)

            fieldEndTime.text = getEndTime
//
            formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
            self.lblEndTime = formatter.string(from: date!)
//
            formatter.dateFormat = "YYYY-MM-dd"
            let getStartTime:String = formatter.string(from: Date())
            filedRecurrenceStart.text = getStartTime
            
            formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
            self.lblRecurrenceStartTime = formatter.string(from: Date())
            }
        }

        
        setupWeekDay()
        setupMonthlyWeekDay()
        setupYearlyWeekDay()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func setupBottomView() {
        bottomView.removeFromSuperview()
        bottomView = UIView()
        bottomView.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height - 67.0, width: UIScreen.main.bounds.width, height: 67.0)
        bottomView.backgroundColor = UIColor.PSNavigaitonController()
        
       
        cancelBtn.setTitle("Close", for: .normal)
        cancelBtn.frame = CGRect(x: 15.0, y: 9.0, width: 168.0, height: 38)
        cancelBtn.backgroundColor = UIColor.white
        cancelBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        cancelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        cancelBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchUpInside)
        
        bottomView.addSubview(cancelBtn)
        
        
        donelBtn.setTitle("Save", for: .normal)
        donelBtn.frame = CGRect(x: UIScreen.main.bounds.width-182, y: 9.0, width: 168.0, height: 38)
        donelBtn.backgroundColor = UIColor.white
        donelBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        donelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        donelBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchUpInside)
        
        bottomView.addSubview(donelBtn)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.addSubview(bottomView)
    }
    override func viewWillAppear(_ animated: Bool) {
        getContacts()
        setupBottomView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeBottomView()
    }
    
    func removeBottomView(){
        bottomView.removeFromSuperview()
    }
    func getContacts(){
        OperationQueue.main.addOperation {
//            SVProgressHUD.show()
//            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        
        let parameters = [
            "OrderBy": "",
            "ParentId": "",
            "ResultsPerPage": 5000,
            "OrganizationId": currentOrgID,
            "PassKey": passKey,
            "ParentObjectName": "",
            "PageOffset": 1,
            "ObjectName": "contact"
            ] as [String : Any]
        APIManager.sharedInstance.postRequestCall(postURL: getOrgListURL, parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                self.getLinkedAccounts()
                print(json)
                let contactModel = ContactListModel.init(fromDictionary: jsonResponse)
                self.contactList = contactModel.results
                self.contactList = self.contactList.sorted { $0.fullName.localizedCaseInsensitiveCompare($1.fullName) == ComparisonResult.orderedAscending }
                if self.serviceList == nil {
                    for index in 0..<self.contactList.count {
                        let getID = self.contactList[index].id
                        if getID == self.linkParentID {
                            let getContact = self.contactList[index]
                            self.fieldChooseContacts.text = getContact.fullName
                            if self.fieldChooseContacts.text!.count > 0 {
                                self.contactsIDList = []
                                var selectedContacts:[String] = []
                                self.selectedContacts = []
                                if let row = index as? Int {
                                    let getContact = self.contactList[index]
                                    self.contactsIDList.add(getContact.id!)
                                    selectedContacts.append(getContact.fullName)
                                    self.selectedContacts.add(index)
                                }
                            }
                        }
                    }
                    
                }

                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func getLinkedAccounts(){
       
        
        let json: [String: Any] = ["ObjectName": "organization_user",
                                   "SearchTerm": "",
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey,
                                   "PageOffset":1,
                                   "ResultsPerPage":100]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                self.getTeamMembers()
                print(json)
                let respon = json["ResponseMessage"].string
                if(respon == "success"){
                    let contactModel = NewAppointmentModel.init(fromDictionary: jsonResponse)
                    print(contactModel.results)
                    self.teamMembers = contactModel.results
                    if self.serviceList == nil {
                        self.getJson()
                    }
                    
                    for index in 0..<self.teamMembers.count {
                        let getContact = self.teamMembers[index]
                        print(getContact.id)
                        if(getContact.fullName == "SYSTEM ADMINISTRATOR"){
                            self.teamMembers.remove(at:index)
                        }
                    }
                    
                    for index in 0..<self.teamMembers.count {
                        let getContact = self.teamMembers[index]
                        print(getContact.id)
                        if(getContact.id == organizationID){
                           self.fieldChooseTeammemberes.text = getContact.fullName
                        }
                    }
                    
                    
                    //self.teamMembers = self.teamMembers.sorted { $0.fullName.localizedCaseInsensitiveCompare($1.fullName) == ComparisonResult.orderedAscending }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func getJson(){
        
        
        let json: [String: Any] = ["ObjectName": "organization_user",
                                   "ObjectId": currentMasterID,
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                
                print(json)
                let contactModel = getTeammemberModel.init(fromDictionary: jsonResponse)
                print(contactModel.dataObject)
                
                if contactModel.valid{
                    if self.serviceList == nil {
                        self.fieldChooseTeammemberes.text = contactModel.dataObject.fullName
                        if self.fieldChooseTeammemberes.text!.count > 0 {
                            self.teamMembersIDList = []
                            self.selectedTeamMembers = []
                            var selectedContacts:[String] = []
                            
                            self.teamMembersIDList.add(contactModel.dataObject.id!)
                            selectedContacts.append(contactModel.dataObject.fullName)
                            self.fieldChooseTeammemberes.text = contactModel.dataObject.fullName
                        }
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
        
    }
    func getTeamMembers(){
        let json: [String: Any] = ["ObjectName": "company",
                                   "SearchTerm": "",
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey,
                                   "PageOffset":1,
                                   "ResultsPerPage":100]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let contactModel = TeamMembersModel.init(fromDictionary: jsonResponse)
                print(contactModel.results)
                self.accountsList = contactModel.results
                  self.accountsList = self.accountsList.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func getAppointmentName(appointmentID:String){
        self.appointmentID = appointmentID
        let json:[String: Any] = ["SearchTerm": "",
                                  "ObjectName":"appointment_type",
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID,
                                  "PageOffset":1,
                                  "ResultsPerPage":100]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            if self.serviceList != nil {
                if self.serviceList.AssigneeId != nil {
                    self.assigneeName(assignID: self.serviceList.AssigneeId!)
                }
            }
            DispatchQueue.main.async {
                print(json)
                //            fieldAppointmentType.text = serviceList.appointmentTypeId
                
                let getModel = GetPatternAppointmentUsers.init(fromDictionary: jsonResponse)
                print(getModel.responseMessage)
                
                if getModel.valid {
                    
                    let result = getModel.results.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending }

                    for index in 0..<result.count {
                        let patternUser = result[index]
                        if patternUser.id == appointmentID {
                            self.fieldAppointmentType.text = patternUser.name
                        }
                        
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    func assigneeName(assignID:String) {
        assigneeID = assignID
        let json:[String: Any] = ["SearchTerm": "",
                                  "ObjectName":"organization_user",
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID,
                                  "PageOffset":1,
                                  "ResultsPerPage":100]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let getModel = GetPatternAssigneeUsers.init(fromDictionary: jsonResponse)
                print(getModel.responseMessage)
                
                if getModel.valid {
                    for index in 0..<getModel.results.count {
                        let patternUser = getModel.results[index]
                        if patternUser.id == assignID {
//                            self.fieldAssignee.text = patternUser.fullName!
                        }
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    func converDateToString(dateString:String) -> String{
        if dateString.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "hh:mm a" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    
    func setupWeekDay(){
        // customize the control
        weekBgSelection.selectedColor = .blue
        weekBgSelection.deselectedColor = .white
        weekBgSelection.cornerRadius = 5
        weekBgSelection.borderWidth = 2
        weekBgSelection.borderColor = .blue
        weekBgSelection.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        weekBgSelection.setButtonsTitleColor(.black, for: .normal)
        weekBgSelection.setButtonsTitleColor(.white, for: .selected)
        weekBgSelection.setButtonsTitleColor(.blue, for: .highlighted)
        weekBgSelection.tag = 0
        // optionally, set initial values
        weekBgSelection.selectedDays = []
        
        // optionally, set delegate to listen to button events.
        weekBgSelection.delegate = self
    }
    func setupMonthlyWeekDay(){
        // customize the control
        monthWeekDayBGSelectioon.selectedColor = .blue
        monthWeekDayBGSelectioon.deselectedColor = .white
        monthWeekDayBGSelectioon.cornerRadius = 5
        monthWeekDayBGSelectioon.borderWidth = 2
        monthWeekDayBGSelectioon.borderColor = .blue
        monthWeekDayBGSelectioon.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        monthWeekDayBGSelectioon.setButtonsTitleColor(.black, for: .normal)
        monthWeekDayBGSelectioon.setButtonsTitleColor(.white, for: .selected)
        monthWeekDayBGSelectioon.setButtonsTitleColor(.blue, for: .highlighted)
        monthWeekDayBGSelectioon.tag = 1
        // optionally, set initial values
        monthWeekDayBGSelectioon.selectedDays = []
        
        // optionally, set delegate to listen to button events.
        monthWeekDayBGSelectioon.delegate = self
    }
    func setupYearlyWeekDay(){
        // customize the control
        weekDaySelectionYear.selectedColor = .blue
        weekDaySelectionYear.deselectedColor = .white
        weekDaySelectionYear.cornerRadius = 5
        weekDaySelectionYear.borderWidth = 2
        weekDaySelectionYear.borderColor = .blue
        weekDaySelectionYear.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        weekDaySelectionYear.setButtonsTitleColor(.black, for: .normal)
        weekDaySelectionYear.setButtonsTitleColor(.white, for: .selected)
        weekDaySelectionYear.setButtonsTitleColor(.blue, for: .highlighted)
        weekDaySelectionYear.tag = 2
        // optionally, set initial values
        weekDaySelectionYear.selectedDays = []
        
        // optionally, set delegate to listen to button events.
        weekDaySelectionYear.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func tappedCustom(_ sender: Any) {
        btnCustom.setImage(UIImage.init(named:"ic_check"), for: .normal)
        btnExisting.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
        tableView.reloadData()
    }
    
    @IBAction func tappedExisting(_ sender: Any) {
        btnExisting.setImage(UIImage.init(named:"ic_check"), for: .normal)
        btnCustom.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
        tableView.reloadData()
    }
    
    @IBAction func tappedAddPattern(_ sender: Any) {
        let controller:AddRecurrencePattern = self.storyboard?.instantiateViewController(withIdentifier: "AddRecurrencePattern") as! AddRecurrencePattern
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func removeWhiteSpaceFromAString(string:String) -> String{
        let trimmedString = string.trimmingCharacters(in: .whitespaces)
        let contactField = trimmedString.replacingOccurrences(of: " ", with: "")
        return contactField
    }
    func profileUpdateAlert(){
        let alert = UIAlertController(title: "Are you sure want to save the information?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.updateRecurrencePattern()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK:- Save API
    
    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tappedSave(_ sender: Any) {
        if fieldSchedulingType.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please chooose the Activity Type")
            return
        }else if fieldPattern.text?.count == 0 {
//            NavigationHelper.showSimpleAlert(message:"Please enter the \(String(describing: fieldPattern.placeholder!))")
//            return
        }else if fieldSubject.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please enter the \(String(describing: fieldSubject.placeholder!))")
            return
        }else if fieldStartTime.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the \(String(describing: fieldStartTime.placeholder!))")
            return
        }else if fieldEndTime.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the \(String(describing: fieldEndTime.placeholder!))")
            return
        }else if filedRecurrenceStart.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the \(String(describing: filedRecurrenceStart.placeholder!))")
            return
        }
        else if btnExisting.currentImage == UIImage.init(named:"ic_check") && fieldPattern.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the \(String(describing: fieldPattern.placeholder!))")
            return
        }
        profileUpdateAlert()
    }
    func convertStringToDate(dateString : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return Date()

    }
    func convertDateMonthString(dateString:String) -> String{
        if dateString.count == 0 {
            return ""
        }
        //"yyyy-MM-dd hh:mm a"
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy-MM-dd" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    
    func convertTimeString(dateString:String) -> String{
        if dateString.count == 0 {
            return ""
        }
        //"yyyy-MM-dd hh:mm a"
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "hh:mm a" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    func updateRecurrencePattern(){
        cancelBtn.isUserInteractionEnabled = false
        donelBtn.isUserInteractionEnabled = false
        if serviceList != nil {
            let dataObject:NSMutableDictionary = [:]
            
                dataObject.setValue(fieldDescription.text!, forKey: "Description")
                dataObject.setValue(lblEndTime, forKey: "EndTime")
                dataObject.setValue(isRollOver, forKey: "RollOver")
                dataObject.setValue(fieldSchedulingType.text!, forKey: "ActivityType")
                dataObject.setValue(appointmentID, forKey: "AppointmentTypeId")
                dataObject.setValue(lblStartTime, forKey: "StartTime")
                dataObject.setValue(serviceList.sequence, forKey: "Sequence")
                dataObject.setValue(fieldSubject.text!, forKey: "Subject")
                dataObject.setValue(isAllDay, forKey: "AllDay")
                if fieldSchedulingType.text == "Set Date" {
                    dataObject.setValue("StaticDate", forKey: "DeliverableType")
                    dataObject.setValue(deliverableDate, forKey: "DeliverableDate")
                    
                }else{
                    dataObject.setValue(removeWhiteSpaceFromAString(string: fieldSchedulingType.text!), forKey: "DeliverableType")
                    dataObject.setValue("", forKey: "DeliverableDate")
                    
                }
                dataObject.setValue(serviceList.id!, forKey: "Id")
                dataObject.setValue(patternID, forKey: "RecurrencePatternId")
                dataObject.setValue(fieldLocation.text!, forKey: "Location")
                dataObject.setValue(assigneeID, forKey: "AssigneeId")
            
            createService(jsonInput: dataObject)
            return
        }
        
        let dataObject:NSMutableDictionary = [:]
        
        //IF PATTERN TYPE DAILY
        
        if fieldCustomPattern.text == "Daily" {
            dataObject.setValue("Daily", forKey: "PatternType")
            dataObject.setValue("MaintainDay", forKey: "RescheduleAlgorithm")
            dataObject.setValue(false, forKey: "EnableMonthOverlap")
            dataObject.setValue(Int(fieldDayCount.text!), forKey: "Interval")
            
            var statusName:String = "Every "
            
            var countName:String = ""
            if Int(fieldDayCount.text!) == 1 {
                countName = "day"
            }else if Int(fieldDayCount.text!)! > 1{
                countName = fieldDayCount.text!
                countName = (Int(fieldDayCount.text!)?.ordinal)!
                countName = countName + " day"
            }
            statusName = statusName + countName
            
            if fieldDayPattern.text == "Scheduling" {
                dataObject.setValue("Schedule", forKey: "WeekendAvoidanceMode")
                statusName = statusName + " Schedule Weekends"
            }else if fieldDayPattern.text == "Skipping" {
                dataObject.setValue("Skip", forKey: "WeekendAvoidanceMode")
                statusName = statusName + " Skipping Weekends"
            }else if fieldDayPattern.text == "Moving To Nearest Weekday" {
                dataObject.setValue("ReSchedule", forKey: "WeekendAvoidanceMode")
                statusName = statusName + " rescheduling weekends"
            }
            dataObject.setValue(statusName, forKey: "Name")
            dataObject.setValue("First", forKey: "WeekOfMonth")
            dataObject.setValue(0, forKey: "MonthOfYear")
            createRecurrencePattern(jsonInput: dataObject)
        }
        else if  fieldCustomPattern.text == "Weekly" {
            dataObject.setValue("Weekly", forKey: "PatternType")
            dataObject.setValue("MaintainDay", forKey: "RescheduleAlgorithm")
            dataObject.setValue(false, forKey: "EnableMonthOverlap")
            dataObject.setValue(Int(fieldWeekCount.text!), forKey: "Interval")
            dataObject.setValue("Schedule", forKey: "WeekendAvoidanceMode")
            
            
            var statusName:String = "Every "
            
            var countName:String = ""
            if Int(fieldWeekCount.text!) == 1 {
                countName = "week"
            }else if Int(fieldWeekCount.text!)! > 1{
                countName = fieldWeekCount.text!
                countName = (Int(fieldWeekCount.text!)?.ordinal)!
                countName = countName + " week"
            }
            statusName = statusName + countName
            
            if weekDays.count > 0 {
                let weekNames:String = weekDays.componentsJoined(by: ",")
                statusName = statusName + " on \(weekNames)"
            }
            
            var WeekMask : Int! = 0
            
            for index in 0..<weekDays.count {
                let dayyy : String = weekDays[index] as! String
                if(dayyy == "Sun"){
                   WeekMask = WeekMask + 1
                }
                else if(dayyy == "Mon"){
                    WeekMask = WeekMask + 2
                }
                else if(dayyy == "Tue"){
                    WeekMask = WeekMask + 4
                }
                else if(dayyy == "Wed"){
                    WeekMask = WeekMask + 8
                }
                else if(dayyy == "Thu"){
                    WeekMask = WeekMask + 16
                }
                else if(dayyy == "Fri"){
                    WeekMask = WeekMask + 32
                }
                else if(dayyy == "Sat"){
                    WeekMask = WeekMask + 64
                }
            }
            dataObject.setValue(WeekMask, forKey: "DaysOfWeekMask")
            //weekDays
            dataObject.setValue(statusName, forKey: "Name")
            dataObject.setValue("First", forKey: "WeekOfMonth")
            dataObject.setValue(0, forKey: "MonthOfYear")
            createRecurrencePattern(jsonInput: dataObject)
            
        }
        else if  fieldCustomPattern.text == "Monthly" {
                dataObject.setValue("MonthlyN", forKey: "PatternType")
                dataObject.setValue("MaintainDay", forKey: "RescheduleAlgorithm")
                dataObject.setValue(false, forKey: "EnableMonthOverlap")
                dataObject.setValue(Int(fieldMonthCount.text!), forKey: "Interval")
                
                if fieldMonthPattern.text == "Scheduling" {
                    dataObject.setValue("Schedule", forKey: "WeekendAvoidanceMode")
                }else if fieldMonthPattern.text == "Skipping" {
                    dataObject.setValue("Skip", forKey: "WeekendAvoidanceMode")
                }else if fieldMonthPattern.text == "Moving To Nearest Weekday" {
                    dataObject.setValue("ReSchedule", forKey: "WeekendAvoidanceMode")
                }
                dataObject.setValue("First", forKey: "WeekOfMonth")
                dataObject.setValue(0, forKey: "MonthOfYear")
                var statusName:String = "Every "
                
                var countName:String = ""
                if Int(fieldMonthCount.text!) == 1 {
                    countName = "month"
                }else if Int(fieldMonthCount.text!)! > 1{
                    countName = fieldMonthCount.text!
                    countName = (Int(fieldMonthCount.text!)?.ordinal)!
                    countName = countName + " month"
                }
                statusName = statusName + countName + " " + fieldMonthPattern.text! + "weekends"
                
                
                if weekDays.count > 0 {
                    let weekNames:String = weekDays.componentsJoined(by: ",")
                    statusName = statusName + " on \(weekNames)"
                }
                print(statusName)
                dataObject.setValue(statusName, forKey: "Name")
                createRecurrencePattern(jsonInput: dataObject)
                
           
            
            
        } else if  fieldCustomPattern.text == "Yearly" {
            
                dataObject.setValue("AnnuallyN", forKey: "PatternType")
                dataObject.setValue("MaintainDay", forKey: "RescheduleAlgorithm")
                dataObject.setValue(false, forKey: "EnableMonthOverlap")
                dataObject.setValue(Int(fieldRecureYearCount.text!), forKey: "Interval")
                
                if fieldMonthPattern.text == "Scheduling" {
                    dataObject.setValue("Schedule", forKey: "WeekendAvoidanceMode")
                }else if fieldMonthPattern.text == "Skipping" {
                    dataObject.setValue("Skip", forKey: "WeekendAvoidanceMode")
                }else if fieldMonthPattern.text == "Moving To Nearest Weekday" {
                    dataObject.setValue("ReSchedule", forKey: "WeekendAvoidanceMode")
                }
                dataObject.setValue("First", forKey: "WeekOfMonth")
                dataObject.setValue(0, forKey: "MonthOfYear")
                var statusName:String = "Every "
                
                var countName:String = ""
                if Int(fieldRecureYearCount.text!) == 1 {
                    countName = "year"
                }else if Int(fieldRecureYearCount.text!)! > 1{
                    countName = fieldRecureYearCount.text!
                    countName = (Int(fieldRecureYearCount.text!)?.ordinal)!
                    countName = countName + " month"
                }
                statusName = statusName + countName
                
                if weekDays.count > 0 {
                    let weekNames:String = weekDays.componentsJoined(by: ",")
                    statusName = statusName + " on \(weekNames)"
                }
                dataObject.setValue(statusName, forKey: "Name")
                createRecurrencePattern(jsonInput: dataObject)
                
            
                
            
            
        }else{
            
            if btnExisting.currentImage == UIImage.init(named:"ic_check") {
                dataObject.setValue(fieldSchedulingType.text!, forKey: "ActivityType")
            }
            dataObject.setValue(appointmentID, forKey: "AppointmentTypeId")
            dataObject.setValue("Daily", forKey: "PatternType")
            dataObject.setValue(fieldSubject.text!, forKey: "Subject")
            dataObject.setValue(fieldDescription.text!, forKey: "Description")
            dataObject.setValue(fieldLocation.text!, forKey: "Location")
            dataObject.setValue(lblStartTime, forKey: "StartTime")
            dataObject.setValue(lblEndTime, forKey: "EndTime")
            dataObject.setValue(isAllDay, forKey: "AllDay")
            dataObject.setValue(isRollOver, forKey: "RollOver")
            dataObject.setValue(lblRecurrenceStartTime, forKey: "RecurrenceStart")
            dataObject.setValue(lblRecurrenceEndTime, forKey: "RecurrenceEnd")
            
            if fieldRemovaRule.text?.count == 0 {
                if fieldRemovaRule.text == "Delete All Incomplete" {
                    dataObject.setValue("AllIncomplete", forKey: "RecurrenceDeleteMode")
                }else if fieldRemovaRule.text == "Delete All Unmodified" {
                    dataObject.setValue("AllUnmodified", forKey: "RecurrenceDeleteMode")
                }else if fieldRemovaRule.text == "Delete All Future" {
                    dataObject.setValue("AllFuture", forKey: "RecurrenceDeleteMode")
                }
            }
           
                dataObject.setValue(patternID, forKey: "RecurrencePatternId")
                createRecurrencePattern(jsonInput: dataObject)
            
          

        }
        
        print(dataObject)
    }
    
    func createRecurrencePattern(jsonInput:NSDictionary){
        let json:[String:Any] = ["DataObject":jsonInput,
                                 "ObjectName":"recurrence_pattern",
                                 "PassKey":passKey,
                                 "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                        if let dataObj:NSDictionary = jsonResponse["DataObject"] as? NSDictionary {
                            print(dataObj)
                            let getID:String = dataObj.value(forKey: "Id") as! String
                            print(getID)
                            self.createServiceWithRecurrenceID(recID: getID)
                            
                        }
                    }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        print(responseMessage)
                    }
                }else{
                    
                }
                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    func createServiceWithRecurrenceID(recID:String){
        let dataObject:NSMutableDictionary = [:]
        let vals = UserDefaults.standard.bool(forKey: "Goday")
if(vals)
{
    UserDefaults.standard.setValue(false, forKey: "Goday")
    let dstre = self.convertStringToDate(dateString: lblRecurrenceEndTime)
   // let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: dstre)!
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let fdates = formatter.string(from: dstre)
    lblRecurrenceEndTime = fdates
}
  
        dataObject.setValue(recID, forKey: "RecurrencePatternId")
        dataObject.setValue(fieldSchedulingType.text!, forKey: "ActivityType")
        dataObject.setValue(appointmentID, forKey: "AppointmentTypeId")
        dataObject.setValue(fieldSubject.text!, forKey: "Subject")
        dataObject.setValue(fieldDescription.text!, forKey: "Description")
        dataObject.setValue(fieldLocation.text!, forKey: "Location")
        dataObject.setValue(lblStartTime, forKey: "StartTime")
        dataObject.setValue(lblEndTime, forKey: "EndTime")
        dataObject.setValue(isAllDay, forKey: "AllDay")
        dataObject.setValue(isRollOver, forKey: "RollOver")
         dataObject.setValue(lblRecurrenceStartTime, forKey: "RecurrenceStart")
        dataObject.setValue(lblRecurrenceEndTime, forKey: "RecurrenceEnd")
        if fieldRemovaRule.text?.count == 0 {
            if fieldRemovaRule.text == "Delete All Incomplete" {
                dataObject.setValue("AllIncomplete", forKey: "RecurrenceDeleteMode")
            }else if fieldRemovaRule.text == "Delete All Unmodified" {
                dataObject.setValue("AllUnmodified", forKey: "RecurrenceDeleteMode")
            }else if fieldRemovaRule.text == "Delete All Future" {
                dataObject.setValue("AllFuture", forKey: "RecurrenceDeleteMode")
            }
        }
        
        let json:[String:Any] = ["DataObject":dataObject,
                                 "ObjectName":createMethod,
                                 "PassKey":passKey,
                                 "OrganizationId":currentOrgID]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let getModel = ServiceDeliverableModel.init(fromDictionary: jsonResponse)
                if getModel.valid {
                    OperationQueue.main.addOperation {
                        if let getDataObject:NSDictionary = jsonResponse["DataObject"] as? NSDictionary {
                            if let getID:String = getDataObject["Id"] as? String {
                                print(getID)
                                if(self.fieldChooseContacts.text != "")
                                {
                                self.linkAppointmentContacts(rightID: getID)
                                }
                                if(self.fieldChooseTeammemberes.text != ""){
                                   self.linkAppointmentUseres(rightID: getID)
                                }
                            }
                        }
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:getModel.responseMessage!)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    func createService(jsonInput:NSDictionary){
        
        var mainURL:String = createContact
        if serviceList != nil {
            mainURL = modifyURL
        }
        let json:[String:Any] = ["DataObject":jsonInput,
                                 "ObjectName":createMethod,
                                 "PassKey":passKey,
                                 "OrganizationId":currentOrgID]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: mainURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let getModel = ServiceDeliverableModel.init(fromDictionary: jsonResponse)
                if getModel.valid {
                    OperationQueue.main.addOperation {
                        if let getDataObject:NSDictionary = jsonResponse["DataObject"] as? NSDictionary {
                            if let getID:String = getDataObject["Id"] as? String {
                                print(getID)
                                if(self.fieldChooseContacts.text != ""){
                                self.linkAppointmentContacts(rightID: getID)
                                }
                                if(self.fieldChooseTeammemberes.text != ""){
                                    self.linkAppointmentUseres(rightID: getID)
                                }
                            }
                        }
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:getModel.responseMessage!)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    func linkAppointmentContacts(rightID:String){
       
        if contactsIDList.count == 0 {
            if contactList.count > 0 {
                
                let getEachContact = contactList[0]
                
                var contactID:String = getEachContact.id
                if fromAccounts {
                    contactID = linkParentID
                }
                
                let LeftObjectName:String = "recurring_activity"
              
                
                let json: [String: Any] = ["ObjectName": "linker_recurring_activities_contacts",
                                           "LeftId": rightID,
                                           "LeftObjectName": LeftObjectName,
                                           "RightId": contactID,
                                           "RightObjectName": "contact",
                                           "PassKey": passKey,
                                           "OrganizationId": currentOrgID]
                print(json)
                
                APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                    DispatchQueue.main.async {
                        print(json)
                        OperationQueue.main.addOperation {
                            if self.contactsIDList.count > 0 {
                                self.contactsIDList.removeObject(at: 0)
                            }
                            if self.contactsIDList.count == 0 {
                                self.linkAppointmentUseres(rightID: rightID)
                            }else{
                                self.linkAppointmentContacts(rightID: rightID)
                            }
                        }
                    }
                },  onFailure: { error in
                    OperationQueue.main.addOperation {
                       // self.navigationController?.popViewController(animated: true)
//                        NotificationCenter.default.removeObserver(self)
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                    print(error.localizedDescription)
                    NavigationHelper.showSimpleAlert(message:error.localizedDescription)
                })
            }
            return
            
        }
        if contactsIDList.count > 0 {
            let LeftObjectName:String = "recurring_activity"
          
            let json: [String: Any] = ["ObjectName": "linker_recurring_activities_contacts",
                                       "LeftId": rightID,
                                       "LeftObjectName": LeftObjectName,
                                       "RightId": contactsIDList[0],
                                       "RightObjectName": "contact",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)//dfdsg
                    if self.contactsIDList.count > 0 {
                        self.contactsIDList.removeObject(at: 0)
                    }
                    if self.contactsIDList.count == 0 {
                        self.linkAppointmentUseres(rightID: rightID)
                    }else{
                        self.linkAppointmentContacts(rightID: rightID)
                    }
                }
            },  onFailure: { error in
                OperationQueue.main.addOperation {
                 //self.navigationController?.popViewController(animated: true)
//                    NotificationCenter.default.removeObserver(self)

                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }else{
            linkAppointmentUseres(rightID: rightID)
        }
    }
    
    func linkAppointmentUseres(rightID:String){
        
        if teamMembersIDList.count == 0 {
            if contactList.count > 0 {
                
                let getEachContact = contactList[0]
                
                var contactID:String = getEachContact.id
                
                if fromAccounts {
                    contactID = linkParentID
                }
                
                var RightObjectName:String = "organization_user"
                
                let json: [String: Any] = ["ObjectName": "linker_recurring_activities_users",
                                           "LeftId": rightID,
                                           "LeftObjectName": "recurring_activity",
                                           "RightId": contactID,
                                           "RightObjectName": RightObjectName,
                                           "PassKey": passKey,
                                           "OrganizationId": currentOrgID]
                print(json)
                
                APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                    DispatchQueue.main.async {
                        print(json)
                        if self.teamMembersIDList.count > 0 {
                            self.teamMembersIDList.removeObject(at: 0)
                        }
                        self.linkAppointmentCompanies(rightID: rightID)
                    }
                },  onFailure: { error in
                    OperationQueue.main.addOperation {
//                        NotificationCenter.default.removeObserver(self)

                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                    print(error.localizedDescription)
                    NavigationHelper.showSimpleAlert(message:error.localizedDescription)
                })
            }
            return
            
        }
        
        if teamMembersIDList.count > 0 {
            
            var RightObjectName:String = "organization_user"
           
            let json: [String: Any] = ["ObjectName": "linker_recurring_activities_users",
                                       "LeftId": rightID,
                                       "LeftObjectName": "recurring_activity",
                                       "RightId": teamMembersIDList[0],
                                       "RightObjectName": RightObjectName,
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    if self.teamMembersIDList.count > 0 {
                        self.teamMembersIDList.removeObject(at: 0)
                    }
                    self.linkAppointmentUseres(rightID: rightID)
                }
            },  onFailure: { error in
                OperationQueue.main.addOperation {
//                    NotificationCenter.default.removeObserver(self)

                  // self.navigationController?.popViewController(animated: true)
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }else{
            linkAppointmentCompanies(rightID: rightID)
        }
    }
    
    func linkAppointmentCompanies(rightID:String){
        
        if accountsIDList.count == 0 {
            if contactList.count > 0 {
                
                let getEachContact = contactList[0]
                
                var contactID:String = getEachContact.id
                
                if fromAccounts {
                    contactID = linkParentID
                }
                
                let RightObjectName:String = "company"
                
                
                let json: [String: Any] = ["ObjectName": "linker_recurring_activities_companies",
                                           "LeftId": rightID,
                                           "LeftObjectName": "recurring_activity",
                                           "RightId": contactID,
                                           "RightObjectName": RightObjectName,
                                           "PassKey": passKey,
                                           "OrganizationId": currentOrgID]
                print(json)
                
                APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                    DispatchQueue.main.async {
                        print(json)
                        if self.accountsIDList.count > 0 {
                            self.accountsIDList.removeObject(at: 0)
                        }
                        OperationQueue.main.addOperation {
//                            NotificationCenter.default.removeObserver(self)//["Appointment","Task"]
                            var message : String!
                            if(self.fieldSchedulingType.text == "Appointment"){
                                message = "Appointment Saved Successfully"
                            }
                            else {
                                 message = "Task Saved Successfully"
                            }
                            let alert = UIAlertController(title:message, message:nil, preferredStyle: .alert)
                          
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                                let controller = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
                                self.navigationController?.pushViewController(controller, animated: true)

                            }))
                            self.present(alert, animated: true)
                        }
                    }
                },  onFailure: { error in
                    OperationQueue.main.addOperation {
//                        NotificationCenter.default.removeObserver(self)

                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                    print(error.localizedDescription)
                    NavigationHelper.showSimpleAlert(message:error.localizedDescription)
                })
            }
            return
            
        }
        
        if accountsIDList.count > 0 {
            
            let RightObjectName:String = "company"
          
            
            let json: [String: Any] = ["ObjectName": "linker_recurring_activities_companies",
                                       "LeftId": rightID,
                                       "LeftObjectName": "recurring_activity",
                                       "RightId": accountsIDList[0],
                                       "RightObjectName": RightObjectName,
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)//fds
                    if self.accountsIDList.count > 0 {
                    self.accountsIDList.removeObject(at: 0)
                    }
                    self.linkAppointmentCompanies(rightID: rightID)
                }
            },  onFailure: { error in
                OperationQueue.main.addOperation {
                //self.navigationController?.popViewController(animated: true)
//                    NotificationCenter.default.removeObserver(self)

                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }else{
            OperationQueue.main.addOperation {
//                NotificationCenter.default.removeObserver(self)

              // self.navigationController?.popViewController(animated: true)
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }

    func updateAPI(jsonInput:NSDictionary,ServiceDeliverableTemplateId:String){
        
        let validaData:NSMutableDictionary = [:]
        validaData.setValue(ClientClassId, forKey:"ClientClassId")
        validaData.setValue(jsonInput.value(forKey: "ContactDateFieldName") as! String, forKey:"ContactDateFieldName")
        validaData.setValue(jsonInput.value(forKey: "RecurrencePatternId") as! String, forKey:"RecurrencePatternId")
        validaData.setValue(jsonInput.value(forKey: "ActivityType") as! String, forKey:"ActivityType")
        validaData.setValue(jsonInput.value(forKey: "AppointmentTypeId") as! String, forKey:"AppointmentTypeId")
        validaData.setValue(jsonInput.value(forKey: "Subject") as! String, forKey:"Subject")
        validaData.setValue(jsonInput.value(forKey: "Description") as! String, forKey:"Description")
        validaData.setValue(jsonInput.value(forKey: "Location") as! String, forKey:"Location")
        validaData.setValue(jsonInput.value(forKey: "StartTime") as! String, forKey:"StartTime")
        validaData.setValue(jsonInput.value(forKey: "EndTime") as! String, forKey:"EndTime")
        validaData.setValue(jsonInput.value(forKey: "DayOffset") as! NSNumber, forKey:"DayOffset")
        validaData.setValue(true, forKey:"Enabled")
        validaData.setValue(jsonInput.value(forKey: "AllDay") as! Bool, forKey:"AllDay")
        validaData.setValue(jsonInput.value(forKey: "RollOver") as! Bool, forKey:"RollOver")
        validaData.setValue(jsonInput.value(forKey: "AssigneeType") as! String, forKey:"AssigneeType")
        validaData.setValue(jsonInput.value(forKey: "AssigneeId") as! String, forKey:"AssigneeId")
        validaData.setValue(ServiceDeliverableTemplateId, forKey:"ServiceDeliverableTemplateId")
        
        
        let json:[String:Any] = ["DataObject":validaData,
                                 "ObjectName":"service_matrix_template",
                                 "PassKey":passKey,
                                 "OrganizationId":currentOrgID]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                if let getValid = jsonResponse["Valid"] as? Bool {
                    OperationQueue.main.addOperation {
                       self.navigationController?.popViewController(animated: true)
//                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
//                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                    //                    if getValid == true {
                    //                        OperationQueue.main.addOperation {
                    //                            self.navigationController?.popViewController(animated: true)
                    //                        }
                    //                    }else{
                    //                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                    //                        print(responseMessage)
                    //                        NavigationHelper.showSimpleAlert(message:responseMessage)
                    //                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    //Days
    @IBAction func tappedAddDay(_ sender: Any) {
        var getCount:Int = Int(fieldDayCount.text!)!
        getCount = getCount + 1
        fieldDayCount.text = "\(getCount)"
        
        lblEceryDays.text = "Every \(getCount) day(s)"
    }
    @IBAction func tappedRemoveDay(_ sender: Any) {
        var getCount:Int = Int(fieldDayCount.text!)!
        if getCount == 1 {
            return
        }
        getCount = getCount - 1
        fieldDayCount.text = "\(getCount)"
        lblEceryDays.text = "Every \(getCount) day(s)"
    }
    
    //Weeks
    @IBAction func tappedAddWeek(_ sender: Any) {
        var getCount:Int = Int(fieldWeekCount.text!)!
        getCount = getCount + 1
        fieldWeekCount.text = "\(getCount)"
        lblRecurEveryWeekend.text = "Recur Every \(getCount) week(s)"
    }
    
    @IBAction func tappedRemoveWeek(_ sender: Any) {
        var getCount:Int = Int(fieldWeekCount.text!)!
        if getCount == 1 {
            return
        }
        getCount = getCount - 1
        fieldWeekCount.text = "\(getCount)"
        lblRecurEveryWeekend.text = "Recur Every \(getCount) week(s)"
    }
    
    //Months
    @IBAction func tappedRecurAddMonth(_ sender: Any) {
        var getCount:Int = Int(fieldMonthCount.text!)!
        getCount = getCount + 1
        fieldMonthCount.text = "\(getCount)"
        lblRecurEveryMonths.text = "Recur Every \(getCount) month(s)"
    }
    
    @IBAction func tappedRecurRemoveMonth(_ sender: Any) {
        var getCount:Int = Int(fieldMonthCount.text!)!
        if getCount == 1 {
            return
        }
        getCount = getCount - 1
        fieldMonthCount.text = "\(getCount)"
        lblRecurEveryMonths.text = "Recur Every \(getCount) month(s)"
    }
    
    @IBAction func tappedTheAddMonth(_ sender: Any) {
        var getCount:Int = Int(fieldTheMonthCount.text!)!
        getCount = getCount + 1
        fieldTheMonthCount.text = "\(getCount)"
        lblTheEveryMonths.text = "Every \(getCount) month(s)"
    }
    @IBAction func tappedTheRemoveMonth(_ sender: Any) {
        var getCount:Int = Int(fieldTheMonthCount.text!)!
        if getCount == 1 {
            return
        }
        getCount = getCount - 1
        fieldTheMonthCount.text = "\(getCount)"
        lblRecurEveryMonths.text = "Every \(getCount) month(s)"
    }
    
    @IBAction func tappedEveryMonth(_ sender: Any) {
        btnRecurMonth.setImage(UIImage.init(named:"ic_check"), for: .normal)
        btnTheMonth.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
    }
    
    @IBAction func tappedEveryTheMonth(_ sender: Any) {
        btnTheMonth.setImage(UIImage.init(named:"ic_check"), for: .normal)
        btnRecurMonth.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
    }
    
    @IBAction func tappedEveryYear(_ sender: Any) {
        btnRecureEveryYear.setImage(UIImage.init(named:"ic_check"), for: .normal)
        btnTheYear.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
    }
    
    @IBAction func tappedEveryTheYear(_ sender: Any) {
        btnTheYear.setImage(UIImage.init(named:"ic_check"), for: .normal)
        btnRecureEveryYear.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
    }
    
    @IBAction func tappedRecurYearRemove(_ sender: Any) {
        var getCount:Int = Int(fieldRecureYearCount.text!)!
        if getCount == 1 {
            return
        }
        getCount = getCount - 1
        fieldRecureYearCount.text = "\(getCount)"
        lblRecureEceryYear.text = "Every \(getCount) year(s)"
    }
    @IBAction func tappedRecurYearAdd(_ sender: Any) {
        var getCount:Int = Int(fieldRecureYearCount.text!)!
        getCount = getCount + 1
        fieldRecureYearCount.text = "\(getCount)"
        lblRecureEceryYear.text = "Recur Every \(getCount) year(s)"
    }
    
    @IBAction func tappedRecureTheYearRemove(_ sender: Any) {
        var getCount:Int = Int(fieldTheEveryYearCount.text!)!
        if getCount == 1 {
            return
        }
        getCount = getCount - 1
        fieldTheEveryYearCount.text = "\(getCount)"
        lblTheEveryYear.text = "Every \(getCount) year(s)"
    }
    @IBAction func tappedRecurTheYearAdd(_ sender: Any) {
        var getCount:Int = Int(fieldTheEveryYearCount.text!)!
        getCount = getCount + 1
        fieldTheEveryYearCount.text = "\(getCount)"
        lblTheEveryYear.text = "Every \(getCount) year(s)"
    }
    @IBAction func tappedAllDayEvent(_ sender: Any) {
        let button:UIButton = sender as! UIButton
        if button.currentImage == UIImage.init(named:"ic_check_box"){
            isAllDay = true
            button.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            isAllDay = false
            button.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
        }
    }
    @IBAction func tappedRollOver(_ sender: Any) {
        let button:UIButton = sender as! UIButton
        if button.currentImage == UIImage.init(named:"ic_check_box"){
            isRollOver = true
            button.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            isRollOver = false
            button.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 22
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 7 {
            if indexPath.row == 2 {
                return 114
            }
            if indexPath.row == 4 {
                if (fieldSchedulingType.text?.count)! > 0 {
                    if fieldSchedulingType.text == "Task" {
                        return 0
                    }
                }
            }
            return 60
        }else if indexPath.row == 7{
            return 0
        }else if indexPath.row == 8 {
            if btnExisting.currentImage == UIImage.init(named:"ic_check") {
                return 60
            }
            return 0
        }else if indexPath.row == 9{
            if serviceList != nil {
                return 60
            }
            if btnCustom.currentImage == UIImage.init(named:"ic_check") {
                return 60
            }
            return 60
        }else if indexPath.row == 10 {
            if fieldCustomPattern.text == "Daily"  {
                return 197
            }
            return 197
        }else if indexPath.row == 11 {
            if fieldCustomPattern.text == "Weekly"  {
                return UIScreen.main.bounds.width-182
            }
            return 0
        }else if indexPath.row == 12 {
            if fieldCustomPattern.text == "Monthly"  {
                return 400
            }
            return 0
        }else if indexPath.row == 13 {
            if fieldCustomPattern.text == "Yearly" {
                return 406
            }
            return 0
        }else if indexPath.row == 14 {
            if serviceList != nil {
                if self.fieldCustomPattern.text == "Appointment" {
                    return 60
                }else{
                    return 0
                }
            }
            return 60
        }else if indexPath.row == 18 {
            return 0
        }
        return 60
    }
    
    //MARK:- API Call
    func getPatternUsers(){
        let json:[String: Any] = ["SearchTerm": "",
                                  "ObjectName":"recurrence_pattern",
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID,
                                  "PageOffset": 1,
                                  "ResultsPerPage": 5000]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let getModel = GetPatternUsers.init(fromDictionary: jsonResponse)
                self.patternNameList = []
                self.patternIdList = []
                
                if getModel.valid {
                    for index in 0..<getModel.results.count {
                        let patternUser = getModel.results[index]
                        self.patternNameList.add(patternUser.name!)
                        self.patternIdList.add(patternUser.id!)
                        
                    }
                    self.showPatternDropDownList()
                }
                
                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    func getAppointmentTypes(){
        let json:[String: Any] = ["SearchTerm": "",
                                  "ObjectName":"appointment_type",
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID,
                                  "PageOffset": 1,
                                  "ResultsPerPage": 5000]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let getModel = GetPatternAppointmentUsers.init(fromDictionary: jsonResponse)
                print(getModel.responseMessage)
                self.appointmentNameList = []
                self.appointmentIdList = []
                
                
                if getModel.valid {
                    
                    let result = getModel.results.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending }

                    
                    for index in 0..<result.count {
                        let patternUser = result[index]
                        self.appointmentNameList.add(patternUser.name!)
                        self.appointmentIdList.add((patternUser.id!))
                        self.appointmentColor.add((patternUser.calendarColor!))
                    }
                    let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.appointmentColor)
                    UserDefaults.standard.set(encodedData, forKey: "ColorAppID")
                    
                    let encodedData1 = NSKeyedArchiver.archivedData(withRootObject: self.appointmentIdList)
                    UserDefaults.standard.set(encodedData1, forKey: "AppointAppID")
                    
                    self.showAppointmentNameList()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    func getAssigneeList(){
        let json:[String: Any] = ["SearchTerm": "",
                                  "ObjectName":"organization_user",
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let getModel = GetPatternAssigneeUsers.init(fromDictionary: jsonResponse)
                self.assigneeNameList = []
                self.assigneeIDSList = []
                
                if getModel.valid {
                    for index in 0..<getModel.results.count {
                        let patternUser = getModel.results[index]
                        self.assigneeNameList.add(patternUser.fullName!)
                        self.assigneeIDSList.add(patternUser.id!)
                    }
                    self.showAssigneeNameList()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension CreateRecurrencePattern:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    removeBottomView()
        
        if textField == fieldSchedulingType {
            showSchedulingTypePicker()
            return false
        }
            
//        else if textField == fieldDate {
//            if textField.placeholder == "Date Field" {
//                dateFieldDropDown()
//            }else{
//                dateFieldDateDropDown()
//            }
//            return false
//        }
        else if textField == fieldPattern {
            getPatternUsers()
            return false
        }else if textField == fieldCustomPattern {
            if serviceList != nil {
                DPPickerManager.shared.showPicker(title: "Activity Type", selected: self.fieldCustomPattern.text!, strings: activityTypeList as! [String]) { (value, index, cancel) in
                    self.setupBottomView()
                    
                    if !cancel {
                        // TODO: you code here
                        debugPrint(value as Any)
                        OperationQueue.main.addOperation {
                            self.fieldCustomPattern.text = value
                            self.tableView.reloadData()
                        }
                    }
                }
                return false
            }
            showCustomPatternDropDownList()
            return false
        }else if textField == fieldMonthPattern {
            showMonthPatternTypesList(textField: fieldMonthPattern)
            return false
        }else if textField == fieldTheMonth {
            showMonthTypeList(textField: fieldTheMonth)
            return false
        }else if textField == fieldDayPattern {
            showMonthPatternTypesList(textField: fieldDayPattern)
            return false
        }else if textField == fieldRecurYearPattern {
            showMonthPatternTypesList(textField: fieldRecurYearPattern)
            return false
        }else if textField == fieldMonthYear {
            showMonthTypeList(textField: fieldMonthYear)
            return false
        }else if textField == fieldTheMonthYear {
            showMonthNamesList(textField: fieldTheMonthYear)
            return false
        }else if textField == fieldAppointmentType {
            getAppointmentTypes()
            return false
        }else if textField == fieldStartTime || textField == fieldEndTime {
            showStartEndTimePicker(textField: textField)
            return false
        }else if textField == filedRecurrenceStart || textField == filedRecurrenceEnd {
            showStartEndDatePicker(textField: textField)
            return false
        }else if textField == fieldRemovaRule {
            //removalRules
            
            DPPickerManager.shared.showPicker(title: "Removal Rule", selected: self.fieldCustomPattern.text!, strings: removalRules as! [String]) { (value, index, cancel) in
                self.setupBottomView()
                if !cancel {
                    // TODO: you code here
                    debugPrint(value as Any)
                    OperationQueue.main.addOperation {
                        self.fieldRemovaRule.text = value
                    }
                }
            }
            return false
        }else if textField == fieldChooseContacts {
            showContactsPicker()
            return false
        }else if textField == fieldChooseTeammemberes {
            showTeamMembers()
            return false
        }else if textField == fieldChooseAccounts {
            showAccountsPicker()
            return false
        }
        
        setupBottomView()
        
        return true
    }
}
 extension CreateRecurrencePattern: CZPickerViewDelegate, CZPickerViewDataSource {
        func numberOfRows(in pickerView: CZPickerView!) -> Int {
            if pickerView.tag == 0 {
                return contactList.count
            }else if pickerView.tag == 1 {
                return teamMembers.count
            }else if pickerView.tag == 2 {
                return accountsList.count
            }
            return 0
        }
        
        func czpickerView(_ pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
            return nil
        }
        
        func numberOfRowsInPickerView(pickerView: CZPickerView!) -> Int {
            if pickerView.tag == 0 {
                return contactList.count
            }else if pickerView.tag == 1 {
                return teamMembers.count
            }else if pickerView.tag == 2 {
                return accountsList.count
            }
            return 0
        }
        
        func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
            if pickerView.tag == 0 {
                let getContact = contactList[row]
                return getContact.fullName
            }else if pickerView.tag == 1 {
                let getContact = teamMembers[row]
                return getContact.fullName
            }else if pickerView.tag == 2 {
                let getContact = accountsList[row]
                return getContact.name
            }
            return ""
        }
    
    func czpickerView(_ pickerView: CZPickerView!) -> NSMutableArray!{
        if pickerView.tag == 0 {
            let Arrayname : NSMutableArray = []
            for i in 0 ..< contactList.count {
                let getContact = contactList[i]
                Arrayname.add(getContact.fullName)
            }
            return Arrayname
        }
        else if pickerView.tag == 1 {
            let Arrayname : NSMutableArray = []
            for i in 0 ..< teamMembers.count {
                let getContact = teamMembers[i]
                if getContact.fullName.count == 0 {
                    Arrayname.add(getContact.firstName + " " + getContact.lastName)
                }
                else {
                    Arrayname.add(getContact.fullName)
                }
            }
            return Arrayname
        }
        else if pickerView.tag == 2 {
            let Arrayname : NSMutableArray = []
            for i in 0 ..< accountsList.count {
                let getContact = accountsList[i]
                Arrayname.add(getContact.name)
            }
            return Arrayname
        }
        return []
    }
        
        func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
            if pickerView.tag == 0 {
                let getContact = contactList[row]
                fieldChooseContacts.text = getContact.fullName
            }else if pickerView.tag == 1 {
                let getContact = teamMembers[row]
                fieldChooseTeammemberes.text = getContact.fullName
            }else if pickerView.tag == 2 {
                let getContact = accountsList[row]
                fieldChooseAccounts.text = getContact.name
            }
        }
        
        func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
            self.setupBottomView()
        }
    
//    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
//        setupBottomView()
//        if pickerView.tag == 0 {
//            self.contactsIDList = []
//            var selectedContacts:[String] = []
//            self.selectedContacts = []
//            for row in rows {
//                if let row = row as? Int {
//                    let getContact = contactList[row]
//                    self.contactsIDList.add(getContact.id!)
//                    selectedContacts.append(getContact.fullName)
//                    self.selectedContacts.add(row)
//                }
//            }
//            if selectedContacts.count > 0 {
//                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
//                self.fieldChooseContacts.text = stringRepresentation
//            }else{
//                self.fieldChooseContacts.text = ""
//            }
////            if openedActivties != nil {
////                setupLinkedContacts()
////            }
//        }else if pickerView.tag == 1 {
//
//            self.teamMembersIDList = []
//            self.selectedTeamMembers = []
//
//
//            var selectedContacts:[String] = []
//            for row in rows {
//                if let row = row as? Int {
//                    let getContact = teamMembers[row]
//                    print(getContact.fullName)
//                    self.teamMembersIDList.add(getContact.id!)
//                    selectedContacts.append(getContact.fullName)
//                    self.selectedTeamMembers.add(row)
//
//                }
//            }
//            if selectedContacts.count > 0 {
//                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
//                self.fieldChooseTeammemberes.text = stringRepresentation
//            }else{
//                self.fieldChooseTeammemberes.text = ""
//            }
////            if openedActivties != nil {
////                setupLinkedTeamMembers()
////            }
//        }else if pickerView.tag == 2 {
//            self.selectedCompanies = []
//
//            self.accountsIDList = []
//            var selectedContacts:[String] = []
//            for row in rows {
//                if let row = row as? Int {
//                    let getContact = accountsList[row]
//                    print(getContact.name)
//                    self.accountsIDList.add(getContact.id!)
//                    selectedContacts.append(getContact.name)
//                    self.selectedCompanies.add(row)
//
//                }
//            }
//            if selectedContacts.count > 0 {
//                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
//                self.fieldChooseAccounts.text = stringRepresentation
//            }else{
//                self.fieldChooseAccounts.text = ""
//            }
////            if openedActivties != nil {
////                setupLinkedAccounts()
////            }
//        }
//    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, withoutBool value: Bool) {
        setupBottomView()
        if(!value) {
        if pickerView.tag == 0 {
            self.contactsIDList = []
            var selectedContacts:[String] = []
            self.selectedContacts = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = contactList[row]
                    self.contactsIDList.add(getContact.id!)
                    selectedContacts.append(getContact.fullName)
                    self.selectedContacts.add(row)
                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseContacts.text = stringRepresentation
            }else{
                self.fieldChooseContacts.text = ""
            }
          
        }else if pickerView.tag == 1 {
            
            self.teamMembersIDList = []
            self.selectedTeamMembers = []
            
            
            var selectedContacts:[String] = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = teamMembers[row]
                    print(getContact.fullName)
                    self.teamMembersIDList.add(getContact.id!)
                    selectedContacts.append(getContact.fullName)
                    self.selectedTeamMembers.add(row)
                    
                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseTeammemberes.text = stringRepresentation
            }else{
                self.fieldChooseTeammemberes.text = ""
            }
            //            if openedActivties != nil {
            //                setupLinkedTeamMembers()
            //            }
        }else if pickerView.tag == 2 {
            self.selectedCompanies = []
            
            self.accountsIDList = []
            var selectedContacts:[String] = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = accountsList[row]
                    print(getContact.name)
                    self.accountsIDList.add(getContact.id!)
                    selectedContacts.append(getContact.name)
                    self.selectedCompanies.add(row)
                    
                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseAccounts.text = stringRepresentation
            }else{
                self.fieldChooseAccounts.text = ""
            }
            //            if openedActivties != nil {
            //                setupLinkedAccounts()
            //            }
        }
        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, with value: Bool, arrayvalue array: NSMutableArray!) {
        setupBottomView()
        if(!value) {
        if pickerView.tag == 0 {
            self.contactsIDList = []
            var selectedContacts:[String] = []
            self.selectedContacts = []
//            for row in rows {
//                if let row = row as? Int {
//                    let getContact = array[row]
//                    self.contactsIDList.add(getContact)
//                    selectedContacts.append(getContact as! String)
//                    self.selectedContacts.add(row)
//                }
//            }
            for row in rows {
                if let row = row as? Int {
                    let getContact = array[row] as? String ?? ""
                    for index in 0..<contactList.count {
                        let getContacts = contactList[index]
                        if getContacts.fullName == getContact {
                            contactsIDList.add(getContacts.id)
                            selectedContacts.append(getContacts.fullName ?? "")
                            self.selectedContacts.add(row)
                        }
                    }
                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseContacts.text = stringRepresentation
            }else{
                self.fieldChooseContacts.text = ""
            }
            //            if openedActivties != nil {
            //                setupLinkedContacts()
            //            }
        }else if pickerView.tag == 1 {
            
            self.teamMembersIDList = []
            self.selectedTeamMembers = []
            
            
            var selectedContacts:[String] = []
//            for row in rows {
//                if let row = row as? Int {
//                    let getContact = array[row]
//                    self.teamMembersIDList.add(getContact)
//                    selectedContacts.append(getContact as! String)
//                    self.selectedTeamMembers.add(row)
//
//                }
//            }
            for row in rows {
                if let row = row as? Int {
                    let getContact = array[row] as? String ?? ""
                    for index in 0..<teamMembers.count {
                        let getContacts = teamMembers[index]
                        if getContacts.fullName == getContact {
                            teamMembersIDList.add(getContacts.id)
                            selectedContacts.append(getContacts.fullName ?? "")
                            self.selectedTeamMembers.add(row)
                        }
                    }
                    
                }
            }

            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseTeammemberes.text = stringRepresentation
            }else{
                self.fieldChooseTeammemberes.text = ""
            }
            //            if openedActivties != nil {
            //                setupLinkedTeamMembers()
            //            }
        }else if pickerView.tag == 2 {
            self.selectedCompanies = []
            
            self.accountsIDList = []
            var selectedContacts:[String] = []
//            for row in rows {
//                if let row = row as? Int {
//                    let getContact = array[row]
//                    self.accountsIDList.add(getContact)
//                    selectedContacts.append(getContact as! String)
//                    self.selectedCompanies.add(row)
//                    
//                }
//            }
            for row in rows {
                if let row = row as? Int {
                    let getContact = array[row] as? String ?? ""
                    for index in 0..<accountsList.count {
                        let getContacts = accountsList[index]
                        if getContacts.name == getContact {
                            accountsIDList.add(getContacts.id)
                            selectedContacts.append(getContacts.name ?? "")
                            self.selectedCompanies.add(row)
                        }
                    }
                }
            }

            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseAccounts.text = stringRepresentation
            }else{
                self.fieldChooseAccounts.text = ""
            }
            //            if openedActivties != nil {
            //                setupLinkedAccounts()
            //            }
        }
        }
    }
    
}
extension CreateRecurrencePattern {
    
    func showContactsPicker(){
        let picker = CZPickerView(headerTitle: "Contacts", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        
        picker?.delegate = self
        
        if selectedContacts.count > 0 {
            picker?.setSelectedRows(selectedContacts as! [Any])
        }else if selectedContacts.count == 0 && self.fieldChooseContacts.text!.count > 0 {
            let combineString = self.fieldChooseContacts.text!.components(separatedBy: ",")
            self.selectedContacts = []
            contactsIDList = []
            for row in 0..<contactList.count {
                let getContact = contactList[row]
                if combineString.contains(getContact.fullName) {
                    self.selectedContacts.add(row)
                }
            }
            picker?.setSelectedRows(selectedContacts as! [Any])
        }
        //self.selectedContacts
        //        picker?.setSelectedRows(selectedContacts as! [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 0
        picker?.show()
    }
    func showTeamMembers(){
        let picker = CZPickerView(headerTitle: "Team Members", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        if selectedTeamMembers.count > 0 {
            picker?.setSelectedRows(selectedTeamMembers as! [Any])
        }else if selectedTeamMembers.count == 0 && self.fieldChooseTeammemberes.text!.count > 0 {
                let combineString = self.fieldChooseTeammemberes.text!.components(separatedBy: ",")
                self.selectedTeamMembers = []
                for row in 0..<teamMembers.count {
                    let getContact = teamMembers[row]
                    if combineString.contains(getContact.fullName) {
                        self.selectedTeamMembers.add(row)
                }
            }
            picker?.setSelectedRows(selectedTeamMembers as! [Any])
        }
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1
        picker?.show()
    }
    func showAccountsPicker(){
        let picker = CZPickerView(headerTitle: "Accounts", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        if (self.fieldChooseAccounts.text?.count)! > 0 {
            self.selectedCompanies = []
            for index in 0..<self.accountsList.count {
                let getID = self.accountsList[index].id
                if self.accountsIDList.contains(getID!) {
                    self.selectedCompanies.add(index)
                }
            }
            if self.selectedCompanies.count == 0 {
                if fieldChooseAccounts.text == accountname {
                    //linkParentID
                    for index in 0..<self.accountsList.count {
                        let getID = self.accountsList[index].id
                        if linkParentID == getID {
                            self.selectedCompanies.add(index)
                        }
                    }
                }
            }
        }
        if selectedCompanies.count > 0 {
            picker?.setSelectedRows(selectedCompanies as! [Any])
        }
        //        picker?.setSelectedRows(selectedContacts as! [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 2
        picker?.show()
    }
    func showAssigneeTypeListPicker(){
        //assigneeTypeList
//        DPPickerManager.shared.showPicker(title: "Assignee Type", selected: fieldAssigneeType.text!, strings: assigneeTypeList as! [String]) { (value, index, cancel) in
//            self.setupBottomView()
//
//            if !cancel {
//                OperationQueue.main.addOperation {
//                    self.fieldAssigneeType.text = value
//                    self.assigneeID = ""
//                    if index == 2 {
//                        self.tableView.reloadData()
//                    }
//                }
//                // TODO: you code here
//                debugPrint(value as Any)
//            }
//        }
    }
    func showSchedulingTypePicker(){
        // Strings Picker
        DPPickerManager.shared.showPicker(title: "Activity Type", selected: fieldSchedulingType.text!, strings: scheduleTpes as! [String]) { (value, index, cancel) in
            self.setupBottomView()
            
            if !cancel {
                OperationQueue.main.addOperation {
                    self.fieldSchedulingType.text = value
                    
                    if index == 1 {
                        self.tableView.reloadData()
                    }
//                    self.fieldDate.text = ""
//                    if index == 0 {
//                        self.fieldDate.placeholder = "Date Field"
//                    }else{
//                        self.fieldDate.placeholder = "Date"
//                    }
                }
                // TODO: you code here
                debugPrint(value as Any)
            }
        }
    }
    
    func dateFieldDropDown(){
        // Strings Picker
//        DPPickerManager.shared.showPicker(title: "Date Field", selected: self.fieldDate.text!, strings: dateFieldTypes as! [String]) { (value, index, cancel) in
//            self.setupBottomView()
//
//            if !cancel {
//                // TODO: you code here
//                debugPrint(value as Any)
//                OperationQueue.main.addOperation {
//                    self.fieldDate.text = value
//                }
//            }
//        }
    }
    
    func dateFieldDateDropDown(){
        // Date Picker
        let min = Date()
        DPPickerManager.shared.showPicker(title: "Date", selected: Date(), min: min, max: nil) { (date, cancel) in
            self.setupBottomView()
            
            if !cancel {
                // TODO: you code here
                debugPrint(date as Any)
                OperationQueue.main.addOperation {
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "YYYY-MM-dd"
//                    self.fieldDate.text = formatter.string(from: date!)
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.deliverableDate = formatter.string(from: date!)
                    
                }
            }
        }
    }
    
    func showAppointmentNameList(){
        ///patternNameList
        DPPickerManager.shared.showPicker(title: "Appointment Type", selected: self.fieldAppointmentType.text!, strings: appointmentNameList as! [String]) { (value, index, cancel) in
            self.setupBottomView()
            
            if !cancel {
                // TODO: you code here
                debugPrint(value as Any)
                OperationQueue.main.addOperation {
                    self.fieldAppointmentType.text = value
                    self.appointmentID = self.appointmentIdList[index] as! String
                    //self.fieldPattern.becomeFirstResponder()
                }
            }
        }
    }
    func showAssigneeNameList(){
        ///patternNameList
//        DPPickerManager.shared.showPicker(title: "Assignee", selected: self.fieldAssignee.text!, strings: assigneeNameList as! [String]) { (value, index, cancel) in
//            self.setupBottomView()
//
//            if !cancel {
//                // TODO: you code here
//                debugPrint(value as Any)
//                OperationQueue.main.addOperation {
//                    self.assigneeID = self.assigneeIDSList[index] as! String
//                    self.fieldAssignee.text = value
//                }
//            }
//        }
    }
    
    func showPatternDropDownList(){
        ///patternNameList
//        DPPickerManager.shared.showPicker(title: "Pattern", selected: self.fieldPattern.text!, strings: patternNameList as! [String]) { (value, index, cancel) in
//            self.setupBottomView()
//
//            if !cancel {
//                // TODO: you code here
//                debugPrint(value as Any)
//                OperationQueue.main.addOperation {
//                    self.patternID = self.patternIdList[index] as! String
//                    self.fieldPattern.text = value
//                }
//            }
//        }
    }
    
    func showCustomPatternDropDownList() {
        ///patternNameList
        DPPickerManager.shared.showPicker(title: "Pattern", selected: self.fieldCustomPattern.text!, strings: patternTypes as! [String]) { (value, index, cancel) in
            self.setupBottomView()
            
            if !cancel {
                // TODO: you code here
                debugPrint(value as Any)
                OperationQueue.main.addOperation {
                    self.fieldCustomPattern.text = value
                    self.weekDays = []
                    self.tableView.reloadData()
                }
            }
        }
    }
    func showMonthPatternTypesList(textField:UITextField){
        DPPickerManager.shared.showPicker(title: "Pattern", selected: textField.text!, strings: patternMonthsTypes as! [String]) { (value, index, cancel) in
            self.setupBottomView()
            
            if !cancel {
                // TODO: you code here
                debugPrint(value as Any)
                OperationQueue.main.addOperation {
                    textField.text = value
                    self.tableView.reloadData()
                }
            }
        }
    }
    func showMonthTypeList(textField:UITextField){
        //        fieldTheMonth.text = monthTypesList[0] as? String
        DPPickerManager.shared.showPicker(title: "", selected: textField.text!, strings: monthTypesList as! [String]) { (value, index, cancel) in
            self.setupBottomView()
            
            if !cancel {
                // TODO: you code here
                debugPrint(value as Any)
                OperationQueue.main.addOperation {
                    textField.text = value
                    self.tableView.reloadData()
                }
            }
        }
    }
    func showMonthNamesList(textField:UITextField){
        //        fieldTheMonth.text = monthTypesList[0] as? String
        DPPickerManager.shared.showPicker(title: "", selected: textField.text!, strings: yearMonthsList as! [String]) { (value, index, cancel) in
            self.setupBottomView()
            
            if !cancel {
                // TODO: you code here
                debugPrint(value as Any)
                OperationQueue.main.addOperation {
                    textField.text = value
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    func showStartEndTimePicker(textField:UITextField){
        var minimumDate = Date()
        var pickTitle:String = "Start Time"
        
        if textField == fieldEndTime {
            pickTitle = "End Time"
            if fieldStartTime.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message:"Please Choose Start Time")
                return
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            let getDate = formatter.date(from: fieldStartTime.text!)
            
            let calendar = Calendar.current
            minimumDate = calendar.date(byAdding: .minute, value: 15, to: getDate!)!
        }
        
        DPPickerManager.shared.showPicker(title: pickTitle, picker: { (picker) in
            picker.date = Date()
            self.custompicker = picker
            picker.datePickerMode = .time
            picker.minuteInterval = 15
            picker.timeZone = TimeZone.current
            if textField == self.fieldEndTime {
               // picker.minimumDate = minimumDate
            }
        }) { (date, cancel) in
            self.setupBottomView()
            if !cancel {
                // TODO: you code here
                debugPrint(date as Any)
                OperationQueue.main.addOperation {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    textField.text = formatter.string(from: (self.custompicker?.date)!)
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    if textField == self.fieldEndTime {
                        formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        self.lblEndTime = formatter.string(from: date!)
                    }
                    else{
                        let vals = UserDefaults.standard.bool(forKey: "Goday")
                        if(vals)
                        {
                            let cdate = UserDefaults.standard.string(forKey: "Godate")!
                            self.lblStartTime = formatter.string(from: (self.custompicker?.date)!)
                            let strcoll = self.lblStartTime.components(separatedBy: "T")
                            let fdate = cdate+"T"+strcoll.last!
                            let newstartdate = formatter.date(from: fdate)
                            let calendar = Calendar.current
                            let date = calendar.date(byAdding: .hour, value: 1, to: newstartdate!)
                            formatter.dateFormat = "hh:mm a"
                            self.fieldEndTime.text = formatter.string(from: date!)
                            formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                            self.lblEndTime = formatter.string(from: date!)
                            self.lblStartTime = fdate
                        }
                       else
                        {
                            self.lblStartTime = formatter.string(from: (self.custompicker?.date)!)
                            let newstartdate = formatter.date(from:self.lblStartTime)
                            let calendar = Calendar.current
                            let date = calendar.date(byAdding: .hour, value: 1, to: newstartdate!)
                            formatter.dateFormat = "hh:mm a"
                            self.fieldEndTime.text = formatter.string(from: date!)
                            formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                            self.lblEndTime = formatter.string(from: date!)
                        }
                        
                    }
                }
            }
        }
    }
    func showStartEndDatePicker(textField:UITextField){
        var minimumDate = Date()
        var pickTitle:String = "Recurrence Start"
        
        if textField == filedRecurrenceEnd {
            pickTitle = "Recurrence End"
            
            if filedRecurrenceStart.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message:"Please Choose Recurrence Start")
                return
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            let getDate = formatter.date(from: filedRecurrenceStart.text!)
            
            let calendar = Calendar.current
            minimumDate = calendar.date(byAdding: .day, value: 1, to: getDate!)!
        }
        
        DPPickerManager.shared.showPicker(title: pickTitle, picker: { (picker) in
//            picker.date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            if textField != self.filedRecurrenceEnd {
            picker.date = formatter.date(from: self.filedRecurrenceStart.text!)!
            }
            else
            {
                let getDate = formatter.date(from: self.filedRecurrenceStart.text!)
                
                let calendar = Calendar.current
                let ennddate = calendar.date(byAdding: .day, value: 1, to: getDate!)!
                picker.date = ennddate

            }
            
            picker.datePickerMode = .date
            if textField == self.filedRecurrenceEnd {
              //  picker.minimumDate = minimumDate
            }
        }) { (date, cancel) in
            self.setupBottomView()
            
            if !cancel {
                // TODO: you code here
                debugPrint(date as Any)
                OperationQueue.main.addOperation {
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "YYYY-MM-dd"
                    textField.text = formatter.string(from: date!)
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    if textField == self.filedRecurrenceEnd {
                        self.lblRecurrenceEndTime = formatter.string(from: date!)
                        
                    }else{
                        
                        self.lblRecurrenceStartTime = formatter.string(from: date!)
                        let calendar = Calendar.current
                        let date = calendar.date(byAdding: .day, value: 1, to: date!)
                        formatter.dateFormat = "YYYY-MM-dd"
                        self.filedRecurrenceEnd.text = formatter.string(from: date!)
                        
                        formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        self.lblRecurrenceEndTime = formatter.string(from: date!)
                        
                    }
                }
            }
        }
    }
}
extension CreateRecurrencePattern: WeekdaysSegmentedControlDelegate {
    
    func weekDaysSegmentedControl(_ control: WeekdaysSegmentedControl, didSelectDay day: Int) {
        let firstWeekday = 1 // -> Sunday
        
        let fmt = DateFormatter()
        var symbols = fmt.shortWeekdaySymbols
        symbols = Array(symbols![firstWeekday-1..<symbols!.count]) + symbols![0..<firstWeekday-1]
        
        if  fieldCustomPattern.text == "Weekly" {
            let dayName:String = symbols![day]
            print(dayName)
            
            if !weekDays.contains(dayName) {
                weekDays.add(dayName)
            }
        }else if  fieldCustomPattern.text == "Monthly" {
            let dayName:String = symbols![day]
            print(dayName)
            
            if !weekDays.contains(dayName) {
                weekDays.add(dayName)
            }
        }else if  fieldCustomPattern.text == "Yearly" {
            let dayName:String = symbols![day]
            print(dayName)
            if !weekDays.contains(dayName) {
                weekDays.add(dayName)
            }
        }
        
        print(weekDays)
    }
    
    func weekDaysSegmentedControl(_ control: WeekdaysSegmentedControl, didDeselectDay day: Int) {
        
        let firstWeekday = 1 // -> Sunday
        
        let fmt = DateFormatter()
        var symbols = fmt.shortWeekdaySymbols
        symbols = Array(symbols![firstWeekday-1..<symbols!.count]) + symbols![0..<firstWeekday-1]
        
        if  fieldCustomPattern.text == "Weekly" {
            let dayName:String = symbols![day]
            print(dayName)
            if weekDays.contains(dayName) {
                weekDays.remove(dayName)
            }
        }else if  fieldCustomPattern.text == "Monthly" {
            let dayName:String = symbols![day]
            print(dayName)
            
            if weekDays.contains(dayName) {
                weekDays.remove(dayName)
            }
        }else if fieldCustomPattern.text == "Yearly" {
            let dayName:String = symbols![day]
            print(dayName)
            
            if weekDays.contains(dayName) {
                weekDays.remove(dayName)
            }
        }
        print(weekDays)
    }
}
extension CreateRecurrencePattern:URLSessionDelegate {
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

