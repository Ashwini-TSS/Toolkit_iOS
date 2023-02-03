//
//  CreatingNewService.swift
//  Processes
//
//  Created by Test Technologies PVT LTD on 07/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class CreatingNewService: UITableViewController {

    var createMethod:String = ""
    
    var scheduleTpes:NSArray = ["Contact Date Field","Set Date"]
    var dateFieldTypes:NSArray = ["Review Date", "Anniversary", "BirthDate", "Client Since", "Driver's License Expiry"]
    var patternNameList:NSMutableArray = []
    var patternIdList:NSMutableArray = []
    
    
    @IBOutlet var Deletebtn: UIBarButtonItem!

    var patternTypes:NSArray = ["Daily","Weekly","Monthly","Yearly"]
    var activityTypeList:NSArray = ["Appointment","Task"]

    var patternMonthsTypes:NSArray = ["Scheduling","Skipping","Moving To Nearest Weekday"]
    var monthTypesList:NSArray = ["First","Second","Third","Fourth","Last"]
    var yearMonthsList:NSArray = []
    var appointmentNameList:NSMutableArray = []
    var appointmentIdList:NSMutableArray = []

    var assigneeNameList:NSMutableArray = []
    var assigneeIDSList:NSMutableArray = []

    var assigneeTypeList:NSMutableArray = ["Contacts Owner","Owner's Assistant","Specific Person"]
    
    var serviceList:GetServicesListResult!
    
    @IBOutlet var fieldActivityType: ACFloatingTextfield!
    @IBOutlet weak var btnPatternAdd: UIButton!
    @IBOutlet weak var btnRollOver: UIButton!
    @IBOutlet weak var btnAllDayEvent: UIButton!
    @IBOutlet weak var fieldAssignee: ACFloatingTextfield!
    @IBOutlet weak var fieldAssigneeType: ACFloatingTextfield!
    @IBOutlet weak var fieldDayOffset: ACFloatingTextfield!
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
    @IBOutlet weak var fieldDate: ACFloatingTextfield!
    @IBOutlet weak var fieldSchedulingType: ACFloatingTextfield!
    
    var patternID:String = ""
    var appointmentID:String = ""
    var lblStartTime:String = ""
    var lblEndTime:String = ""
    var isAllDay:Bool = false
    var isRollOver:Bool = false
    var assigneeID:String = ""
    var deliverableDate:String = ""
    var weekDays:NSMutableArray = []
    var monthDays:NSMutableArray = []
    var YearDays:NSMutableArray = []
    var ClientClassId:String!
    var bottomView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Service"
        
        setupBottomView()
        
        fieldActivityType.text = "Appointment"
        Deletebtn.isEnabled = false
        
        
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
            
            Deletebtn.isEnabled = true
            Deletebtn.setBackgroundImage(UIImage.init(named:"TaskDelete"), for: .normal, barMetrics: .default)

            lblStartTime = serviceList.startTime
            lblEndTime = serviceList.endTime
            
            fieldActivityType.text = serviceList.activityType
            fieldSchedulingType.text = serviceList.deliverableType
            fieldDate.text = serviceList.contactDateFieldName
            fieldAppointmentType.text = serviceList.appointmentTypeId
            fieldSubject.text = serviceList.subject
            fieldDescription.text = serviceList.descriptionField
            fieldLocation.text = serviceList.location
            fieldStartTime.text = converDateToString(dateString: serviceList.startTime)
            fieldEndTime.text = converDateToString(dateString: serviceList.endTime)
            fieldDayOffset.text = "\(serviceList.dayOffset!)"
            fieldAssigneeType.text = serviceList.assigneeType
            fieldCustomPattern.text = serviceList.activityType
            self.fieldCustomPattern.placeholder = "Activity Type"
            isAllDay = serviceList.allDay
            isRollOver = serviceList.rollOver
            
            if self.serviceList.appointmentTypeId != nil {
                self.getAppointmentName(appointmentID: self.serviceList.appointmentTypeId!)
            }

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
                                       "OrganizationId":currentOrgID]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL:globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    let controller = GetServiceInfoModel.init(fromDictionary: jsonResponse)
                    if controller.valid {
                        self.fieldPattern.text = controller.dataObject.name!
                    }
                    self.tableView.reloadData()
                }
            },  onFailure: { error in
                print(error.localizedDescription)
            })
            
        }
        
        setupWeekDay()
        setupMonthlyWeekDay()
        setupYearlyWeekDay()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func appointmenttype() {
        
    }
    
    
    func setupBottomView() {
        bottomView.removeFromSuperview()
        bottomView = UIView()
        bottomView.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height - 67.0, width: UIScreen.main.bounds.width, height: 67.0)
        bottomView.backgroundColor = UIColor.PSNavigaitonController()
        
        let cancelBtn = UIButton()
        cancelBtn.setTitle("Close", for: .normal)
        cancelBtn.frame = CGRect(x: 15.0, y: 9.0, width: 168.0, height: 38)
        cancelBtn.backgroundColor = UIColor.white
        cancelBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        cancelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        cancelBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchUpInside)
        
        bottomView.addSubview(cancelBtn)
        
        let donelBtn = UIButton()
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
    override func viewWillDisappear(_ animated: Bool) {
        removeBottomView()
    }
    func removeBottomView(){
        bottomView.removeFromSuperview()
    }
    
    func getAppointmentName(appointmentID:String){
        
        self.appointmentID = appointmentID
        let json:[String: Any] = ["ObjectId": appointmentID,
                                  "ObjectName":"appointment_type",
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID
                                  ]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL:globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            if self.serviceList != nil {
                if self.serviceList.AssigneeId != nil {
                    self.assigneeName(assignID: self.serviceList.AssigneeId!)
                }
            }
            DispatchQueue.main.async {
                print(json)
                self.fieldAppointmentType.text = json["DataObject"]["Name"].string
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
                            self.fieldAssignee.text = patternUser.fullName!
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
    
    //MARK:- Save API
    
    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tappedSave(_ sender: Any) {
        if fieldActivityType.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please enter the Activity Type")
            return
        }
        if fieldSubject.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please enter the Subject")
            return
        }else if fieldStartTime.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the Start Time")
            return
        }else if fieldEndTime.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the End Time")
            return
        }else if fieldAssigneeType.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the AssigneeType")
            return
        }else if fieldDate.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the fieldDate")
            return
        }else if btnExisting.currentImage == UIImage.init(named:"ic_check") && fieldPattern.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the fieldPattern")
            return
        }else if fieldDayOffset.text?.count == 0 {
            fieldDayOffset.text = "0"
        }

        if serviceList != nil {
            
            //update API
            print(ClientClassId)
            let dataObject:NSMutableDictionary = [:]
            dataObject.setValue(Int(fieldDayOffset.text!), forKey: "DayOffset")
            dataObject.setValue(fieldDescription.text!, forKey: "Description")
            dataObject.setValue(lblEndTime, forKey: "EndTime")
            dataObject.setValue(removeWhiteSpaceFromAString(string: fieldDate.text!), forKey: "ContactDateFieldName")
            dataObject.setValue(isRollOver, forKey: "RollOver")
            dataObject.setValue(fieldCustomPattern.text!, forKey: "ActivityType")
            dataObject.setValue(ClientClassId, forKey:"ClientClassId")
            dataObject.setValue(serviceList.createdBy, forKey:"CreatedBy")
            dataObject.setValue(serviceList.createdOn, forKey:"CreatedOn")
            dataObject.setValue(serviceList.createdBy, forKey:"ModifiedBy")
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dataObject.setValue(dateFormatter.string(from: NSDate() as Date), forKey:"ModifiedOn")
            if(fieldActivityType.text! == "Appointment"){
                dataObject.setValue(appointmentID, forKey: "AppointmentTypeId")
            }
            dataObject.setValue(lblStartTime, forKey: "StartTime")
            dataObject.setValue(serviceList.sequence, forKey: "Sequence")
            dataObject.setValue(fieldSubject.text!, forKey: "Subject")
            dataObject.setValue(isAllDay, forKey: "AllDay")
            var formattedString = removeWhiteSpaceFromAString(string: fieldAssigneeType.text!)
            if formattedString == "Owner'sAssistant" {
                formattedString = "ContactsOwnersAssistant"
            }
            if formattedString == "Current User" {
                formattedString = "CurrentUser"
            }
            if formattedString == "ContactsOwner" {
                formattedString = "ContactsOwner"
            }
            if formattedString == "SpecificPerson" {
                formattedString = "SpecificPerson"
            }
            dataObject.setValue(formattedString, forKey: "AssigneeType")
            if fieldSchedulingType.text == "Set Date" {
              //  dataObject.setValue("StaticDate", forKey: "DeliverableType")
               // dataObject.setValue(deliverableDate, forKey: "DeliverableDate")

            }else{
               // dataObject.setValue(removeWhiteSpaceFromAString(string: fieldSchedulingType.text!), forKey: "DeliverableType")
//dataObject.setValue("", forKey: "DeliverableDate")

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
        
        if btnCustom.currentImage == UIImage.init(named:"ic_check") && fieldCustomPattern.text == "Daily" {
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
        else if btnCustom.currentImage == UIImage.init(named:"ic_check") && fieldCustomPattern.text == "Weekly" {
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
            //weekDays
            dataObject.setValue(statusName, forKey: "Name")
            dataObject.setValue("First", forKey: "WeekOfMonth")
            dataObject.setValue(0, forKey: "MonthOfYear")
            createRecurrencePattern(jsonInput: dataObject)

        }
        else if btnCustom.currentImage == UIImage.init(named:"ic_check") && fieldCustomPattern.text == "Monthly" {
            if btnRecurMonth.currentImage == UIImage.init(named:"ic_check") {
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

            }else{
                dataObject.setValue("MonthlyV", forKey: "PatternType")
                dataObject.setValue("MaintainDay", forKey: "RescheduleAlgorithm")
                dataObject.setValue(false, forKey: "EnableMonthOverlap")
                dataObject.setValue(Int(fieldTheMonthCount.text!), forKey: "Interval")
                dataObject.setValue("Schedule", forKey: "WeekendAvoidanceMode")
                dataObject.setValue(fieldTheMonth.text!, forKey: "WeekOfMonth")
                dataObject.setValue(0, forKey: "MonthOfYear")

                var statusName:String = "The \(fieldTheMonth.text!)"

                
                if weekDays.count > 0 {
                    let weekNames:String = weekDays.componentsJoined(by: ",")
                    statusName = statusName + " \(weekNames) of every \((Int(fieldMonthCount.text!)?.ordinal)!) month"
                }
                dataObject.setValue(statusName, forKey: "Name")
                createRecurrencePattern(jsonInput: dataObject)

            }
            
            
        } else if btnCustom.currentImage == UIImage.init(named:"ic_check") && fieldCustomPattern.text == "Yearly" {

            if btnRecureEveryYear.currentImage == UIImage.init(named:"ic_check") {
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
                //fieldTheMonthYear
                
                for index in 0..<yearMonthsList.count {
                    let month:String = yearMonthsList[index] as! String
                    if month == fieldTheMonthYear.text! {
                        dataObject.setValue(index, forKey: "MonthOfYear")
                    }
                }
                dataObject.setValue("AnnuallyV", forKey: "PatternType")
                dataObject.setValue("MaintainDay", forKey: "RescheduleAlgorithm")
                dataObject.setValue(false, forKey: "EnableMonthOverlap")
                dataObject.setValue(Int(fieldTheEveryYearCount.text!), forKey: "Interval")
                dataObject.setValue("Schedule", forKey: "WeekendAvoidanceMode")
                dataObject.setValue(fieldMonthYear.text!, forKey: "WeekOfMonth")
                
              
                
                var statusName:String = "The \(fieldMonthYear.text!)"
                var getMonth:String = fieldTheMonthYear.text!
                getMonth = String(getMonth.prefix(3))

                if weekDays.count > 0 {
                    let weekNames:String = weekDays.componentsJoined(by: ",")
                    statusName = statusName + " \(weekNames) of \(getMonth) every \((Int(fieldTheEveryYearCount.text!)?.ordinal)!) year"
                }
                dataObject.setValue(statusName, forKey: "Name")
                createRecurrencePattern(jsonInput: dataObject)

            }

        }else{
            if fieldSchedulingType.text == "Set Date" {
                dataObject.setValue("StaticDate", forKey: "DeliverableType")
                dataObject.setValue(deliverableDate, forKey: "DeliverableDate")
            }else{
                dataObject.setValue(removeWhiteSpaceFromAString(string: fieldSchedulingType.text!), forKey: "DeliverableType")
                dataObject.setValue("", forKey: "DeliverableDate")
            }
            dataObject.setValue(removeWhiteSpaceFromAString(string: fieldDate.text!), forKey: "ContactDateFieldName")
            dataObject.setValue(patternID, forKey: "RecurrencePatternId")
            
            if btnExisting.currentImage == UIImage.init(named:"ic_check") {
                dataObject.setValue(fieldActivityType.text!, forKey: "ActivityType")
            }
            if(fieldActivityType.text! == "Appointment"){
                dataObject.setValue(appointmentID, forKey: "AppointmentTypeId")
            }
            
            dataObject.setValue(fieldSubject.text!, forKey: "Subject")
            dataObject.setValue(fieldDescription.text!, forKey: "Description")
            dataObject.setValue(fieldLocation.text!, forKey: "Location")
            dataObject.setValue(lblStartTime, forKey: "StartTime")
            dataObject.setValue(lblEndTime, forKey: "EndTime")
            dataObject.setValue(Int(fieldDayOffset.text!), forKey: "DayOffset")
            dataObject.setValue(isAllDay, forKey: "AllDay")
            dataObject.setValue(isRollOver, forKey: "RollOver")
            
            var formattedString = removeWhiteSpaceFromAString(string: fieldAssigneeType.text!)
            
            if formattedString == "Owner'sAssistant" {
                formattedString = "ContactsOwnersAssistant"
            }
            if formattedString == "Current User" {
                formattedString = "CurrentUser"
            }
            if formattedString == "ContactsOwner" {
                formattedString = "ContactsOwner"
            }
            if formattedString == "SpecificPerson" {
                formattedString = "SpecificPerson"
            }
            dataObject.setValue(formattedString, forKey: "AssigneeType")
            dataObject.setValue(assigneeID, forKey: "AssigneeId")
            dataObject.setValue(0, forKey: "Sequence")
          
            createService(jsonInput: dataObject)
        }
        print(dataObject)
    }
    
    func createRecurrencePattern(jsonInput:NSDictionary){
        
        let json:[String:Any] = ["DataObject":jsonInput,
                                 "ObjectName":"recurrence_pattern",
                                 "PassKey":passKey,
                                 "OrganizationId":currentOrgID]
        
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

        if fieldSchedulingType.text == "Set Date" {
            dataObject.setValue("StaticDate", forKey: "DeliverableType")
            dataObject.setValue(deliverableDate, forKey: "DeliverableDate")
        }else{
            dataObject.setValue(removeWhiteSpaceFromAString(string: fieldSchedulingType.text!), forKey: "DeliverableType")
            dataObject.setValue("", forKey: "DeliverableDate")
        }
        dataObject.setValue(removeWhiteSpaceFromAString(string: fieldDate.text!), forKey: "ContactDateFieldName")
        dataObject.setValue(recID, forKey: "RecurrencePatternId")
        dataObject.setValue(fieldActivityType.text!, forKey: "ActivityType")
        if(fieldActivityType.text! == "Appointment"){
            dataObject.setValue(appointmentID, forKey: "AppointmentTypeId")
        }
        dataObject.setValue(fieldSubject.text!, forKey: "Subject")
        dataObject.setValue(fieldDescription.text!, forKey: "Description")
        dataObject.setValue(fieldLocation.text!, forKey: "Location")
        dataObject.setValue(lblStartTime, forKey: "StartTime")
        dataObject.setValue(lblEndTime, forKey: "EndTime")
        dataObject.setValue(Int(fieldDayOffset.text!), forKey: "DayOffset")
        dataObject.setValue(isAllDay, forKey: "AllDay")
        dataObject.setValue(isRollOver, forKey: "RollOver")
        
        var formattedString = removeWhiteSpaceFromAString(string: fieldAssigneeType.text!)
        
        if formattedString == "Owner'sAssistant" {
            formattedString = "ContactsOwnersAssistant"
        }
        if formattedString == "Current User" {
            formattedString = "CurrentUser"
        }
        if formattedString == "ContactsOwner" {
            formattedString = "ContactsOwner"
        }
        if formattedString == "SpecificPerson" {
            formattedString = "SpecificPerson"
        }
        dataObject.setValue(formattedString, forKey: "AssigneeType")
        dataObject.setValue(assigneeID, forKey: "AssigneeId")
       // dataObject.setValue(0, forKey: "Sequence")
        
        let json:[String:Any] = ["DataObject":dataObject,
                                 "ObjectName":createMethod,
                                 "PassKey":passKey,
                                 "OrganizationId":currentOrgID]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                OperationQueue.main.addOperation {
                    var dicmuta = json["DataObject"]
                    let id = dicmuta["Id"].string
                    let dataObject1:NSMutableDictionary = [:]
                    var objectname :  String!
                    if self.fieldSchedulingType.text == "Set Date" {
                        dataObject1.setValue(self.deliverableDate, forKey: "DeliverableDate")
                        objectname = "static_deliverable_template"
                    }else{
                         objectname = "service_matrix_template"
                         dataObject1.setValue(self.removeWhiteSpaceFromAString(string: self.fieldDate.text!), forKey: "ContactDateFieldName")
                    }
                   
                    dataObject1.setValue(recID, forKey: "RecurrencePatternId")
                    dataObject1.setValue(self.fieldActivityType.text!, forKey: "ActivityType")
                    if(self.fieldActivityType.text! == "Appointment"){
                    dataObject1.setValue(self.appointmentID, forKey: "AppointmentTypeId")
                    }
                    dataObject1.setValue(self.fieldSubject.text!, forKey: "Subject")
                    dataObject1.setValue(self.fieldDescription.text!, forKey: "Description")
                    dataObject1.setValue(self.fieldLocation.text!, forKey: "Location")
                    dataObject1.setValue(self.lblStartTime, forKey: "StartTime")
                    dataObject1.setValue(self.lblEndTime, forKey: "EndTime")
                    dataObject1.setValue(Int(self.fieldDayOffset.text!), forKey: "DayOffset")
                    dataObject1.setValue(self.isAllDay, forKey: "AllDay")
                    dataObject1.setValue(self.isRollOver, forKey: "RollOver")
                    
                    var formattedString = self.removeWhiteSpaceFromAString(string: self.fieldAssigneeType.text!)
                    
                    if formattedString == "Owner'sAssistant" {
                        formattedString = "ContactsOwnersAssistant"
                    }
                    if formattedString == "Current User" {
                        formattedString = "CurrentUser"
                    }
                    if formattedString == "ContactsOwner" {
                        formattedString = "ContactsOwner"
                    }
                    if formattedString == "SpecificPerson" {
                        formattedString = "SpecificPerson"
                    }
                    dataObject1.setValue(formattedString, forKey: "AssigneeType")
                    dataObject1.setValue(self.assigneeID, forKey: "AssigneeId")
                    dataObject1.setValue(self.ClientClassId, forKey:"ClientClassId")
                    dataObject1.setValue(true, forKey:"Enabled")
                    dataObject1.setValue(id, forKey:"ServiceDeliverableTemplateId")
                    let json:[String:Any] = ["DataObject":dataObject1,
                                             "ObjectName":objectname!,
                                             "PassKey":passKey,
                                             "OrganizationId":currentOrgID]
                    print(json)
                    APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                        DispatchQueue.main.async {
                            print(json)
                             var response = json["ResponseMessage"]
                            if(response == "success"){
                            OperationQueue.main.addOperation {
                                 self.navigationController?.popViewController(animated: true)
                                 NavigationHelper.showSimpleAlert(message:"Created Successfully")
                            }
                            }
                            else{
                                NavigationHelper.showSimpleAlert(message:"unable to create Servicematrix Template")
                            }
                        }
                    },  onFailure: { error in
                        print(error.localizedDescription)
                    })
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func DeleteAction(_ sender: Any) {
        
        let alert = UIAlertController(title:"Delete", message: "Are you sure want to delete this step?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let json: [String: Any] = ["ObjectName": "service_matrix_template",
                                       "ObjectId":self.serviceList.id!,
                                       "OrganizationId": currentOrgID,
                                       "PassKey":passKey]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/delete.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    self.navigationController?.popViewController(animated:true)
                    NavigationHelper.showSimpleAlert(message: "Successfully Deleted")
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            
        }))
        self.present(alert, animated: true)
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
                        
//                        if self.serviceList != nil {
//                            self.navigationController?.popViewController(animated: true)
//                            return
//                        }
                        self.updateAPI(jsonInput: jsonInput, ServiceDeliverableTemplateId: getModel.dataObject.id!)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:getModel.responseMessage!)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    func updateAPI(jsonInput:NSDictionary,ServiceDeliverableTemplateId:String){
        
        let validaData:NSMutableDictionary = [:]
       
        validaData.setValue(jsonInput.value(forKey: "ContactDateFieldName") as! String, forKey:"ContactDateFieldName")
        validaData.setValue(jsonInput.value(forKey: "RecurrencePatternId") as! String, forKey:"RecurrencePatternId")
        validaData.setValue(ClientClassId, forKey:"ClientClassId")
        validaData.setValue(jsonInput.value(forKey: "ActivityType") as! String, forKey:"ActivityType")
        validaData.setValue(jsonInput.value(forKey: "AppointmentTypeId") as! String, forKey:"AppointmentTypeId")
        validaData.setValue(jsonInput.value(forKey: "Subject") as! String, forKey:"Subject")
        validaData.setValue(jsonInput.value(forKey: "Description") as! String, forKey:"Description")
        validaData.setValue(jsonInput.value(forKey: "Location") as! String, forKey:"Location")
        validaData.setValue(jsonInput.value(forKey: "StartTime") as! String, forKey:"StartTime")
        validaData.setValue(jsonInput.value(forKey: "EndTime") as! String, forKey:"EndTime")
        validaData.setValue(jsonInput.value(forKey: "DayOffset") as! NSNumber, forKey:"DayOffset")
       
        validaData.setValue(jsonInput.value(forKey: "AllDay") as! Bool, forKey:"AllDay")
        validaData.setValue(jsonInput.value(forKey: "RollOver") as! Bool, forKey:"RollOver")
        validaData.setValue(jsonInput.value(forKey: "AssigneeType") as! String, forKey:"AssigneeType")
        validaData.setValue(jsonInput.value(forKey: "AssigneeId") as! String, forKey:"AssigneeId")
        validaData.setValue(true, forKey:"Enabled")
        validaData.setValue(ServiceDeliverableTemplateId, forKey:"ServiceDeliverableTemplateId")

        
        let json:[String:Any] = ["DataObject":validaData,
                                 "ObjectName":"service_matrix_template",
                                 "PassKey":passKey,
                                 "OrganizationId":currentOrgID]
        
        
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                if let getValid = jsonResponse["Valid"] as? Bool {
                    OperationQueue.main.addOperation {
                        self.navigationController?.popViewController(animated: true)
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
        return 21
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 11   {
            return 60
        }else if indexPath.row == 3 {
            if serviceList != nil {
                return 0
            }
            return 78
        }else if indexPath.row == 4 {
            if btnExisting.currentImage == UIImage.init(named:"ic_check") {
                return 60
            }
            return 0
        }else if indexPath.row == 5 {
            if serviceList != nil {
                return 60
            }
            if btnCustom.currentImage == UIImage.init(named:"ic_check") {
                return 60
            }
            return 0
        }else if indexPath.row == 6 {
            if fieldCustomPattern.text == "Daily" && btnCustom.currentImage == UIImage.init(named:"ic_check") {
                return 197
            }
            return 0
        }else if indexPath.row == 7 {
            if fieldCustomPattern.text == "Weekly" && btnCustom.currentImage == UIImage.init(named:"ic_check") {
                return UIScreen.main.bounds.width-182
            }
            return 0
        }else if indexPath.row == 8 {
            if fieldCustomPattern.text == "Monthly" && btnCustom.currentImage == UIImage.init(named:"ic_check") {
                return 400
            }
            return 0
        }else if indexPath.row == 9 {
            if fieldCustomPattern.text == "Yearly" && btnCustom.currentImage == UIImage.init(named:"ic_check") {
                return 406
            }
            return 0
        }else if indexPath.row == 10 {
            if serviceList != nil {
                if self.fieldCustomPattern.text == "Appointment" {
                    return 60
                }else{
                    return 0
                }
            }
            if(self.fieldActivityType.text! == "Appointment"){
              return 60
            }
            return 0
        }else if indexPath.row == 12 {
            return 116
        }else if indexPath.row == 20 {
            if serviceList != nil {
                if serviceList.AssigneeId != nil {
                    return 60
                }
            }
            if fieldAssigneeType.text == assigneeTypeList.object(at: 2) as? String {
                return 60
            }
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
                                  "PageOffset":1,
                                  "ResultsPerPage":100]
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
                                  "PageOffset":1,
                                  "ResultsPerPage":100]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let getModel = GetPatternAppointmentUsers.init(fromDictionary: jsonResponse)
                print(getModel.responseMessage)
                self.appointmentNameList = []
                self.appointmentIdList = []
                
                if getModel.valid {
                    for index in 0..<getModel.results.count {
                        let patternUser = getModel.results[index]
                        self.appointmentNameList.add(patternUser.name!)
                        self.appointmentIdList.add((patternUser.id!))
                    }
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
                                  "OrganizationId":currentOrgID,
                                  "PageOffset":1,
                                  "ResultsPerPage":100]
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
extension CreatingNewService:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        removeBottomView()
        if textField == fieldActivityType {
            removeBottomView()
            let values = ["Appointment", "Task"]
            DPPickerManager.shared.showPicker(title: "Activity Type", selected: "", strings: values) { (value, index, cancel) in
                self.setupBottomView()
                if !cancel {
                    self.fieldActivityType.text = value
                    debugPrint(value as Any)
                    self.tableView.reloadData()
                }
            }
            return false
        }
       else if textField == fieldSchedulingType {
            showSchedulingTypePicker()
            return false
        }else if textField == fieldDate {
            if textField.placeholder == "Date Field" {
                dateFieldDropDown()
            }else{
                dateFieldDateDropDown()
            }
            return false
        }else if textField == fieldPattern {
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
        }else if textField == fieldAssigneeType {
            showAssigneeTypeListPicker()
            return false
        }else if textField == fieldAssignee {
            getAssigneeList()
            return false
        }
        setupBottomView()

        return true
    }
}
extension CreatingNewService {
    func showAssigneeTypeListPicker(){
        //assigneeTypeList
        DPPickerManager.shared.showPicker(title: "Assignee Type", selected: fieldAssigneeType.text!, strings: assigneeTypeList as! [String]) { (value, index, cancel) in
            self.setupBottomView()

            if !cancel {
                OperationQueue.main.addOperation {
                    self.fieldAssigneeType.text = value
                    self.assigneeID = ""
                    if index == 2 {
                        self.tableView.reloadData()
                    }
                }
                // TODO: you code here
                debugPrint(value as Any)
            }
        }
    }
    func showSchedulingTypePicker(){
        // Strings Picker
        DPPickerManager.shared.showPicker(title: "Scheduling Types", selected: fieldSchedulingType.text!, strings: scheduleTpes as! [String]) { (value, index, cancel) in
            self.setupBottomView()

            if !cancel {
                OperationQueue.main.addOperation {
                    self.fieldSchedulingType.text = value
                    self.fieldDate.text = ""
                    if index == 0 {
                        self.fieldDate.placeholder = "Date Field"
                    }else{
                        self.fieldDate.placeholder = "Date"
                    }
                }
                // TODO: you code here
                debugPrint(value as Any)
            }
        }
    }
    
    func dateFieldDropDown(){
        // Strings Picker
        DPPickerManager.shared.showPicker(title: "Date Field", selected: self.fieldDate.text!, strings: dateFieldTypes as! [String]) { (value, index, cancel) in
            self.setupBottomView()

            if !cancel {
                // TODO: you code here
                debugPrint(value as Any)
                OperationQueue.main.addOperation {
                    self.fieldDate.text = value
                }
            }
        }
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
                    self.fieldDate.text = formatter.string(from: date!)
                    
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
                }
            }
        }
    }
    func showAssigneeNameList(){
        ///patternNameList
        DPPickerManager.shared.showPicker(title: "Assignee", selected: self.fieldAssignee.text!, strings: assigneeNameList as! [String]) { (value, index, cancel) in
            self.setupBottomView()

            if !cancel {
                // TODO: you code here
                debugPrint(value as Any)
                OperationQueue.main.addOperation {
                    self.assigneeID = self.assigneeIDSList[index] as! String
                    self.fieldAssignee.text = value
                }
            }
        }
    }
    
    func showPatternDropDownList(){
        ///patternNameList
        DPPickerManager.shared.showPicker(title: "Pattern", selected: self.fieldPattern.text!, strings: patternNameList as! [String]) { (value, index, cancel) in
            self.setupBottomView()

            if !cancel {
                // TODO: you code here
                debugPrint(value as Any)
                OperationQueue.main.addOperation {
                    self.patternID = self.patternIdList[index] as! String
                    self.fieldPattern.text = value
                }
            }
        }
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
                    textField.text = formatter.string(for: date!)
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    if textField == self.fieldEndTime {
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        self.lblEndTime = formatter.string(from: date!)
                        
                    }else{
                        self.lblStartTime = formatter.string(from: date!)
                        let arr = self.lblStartTime.components(separatedBy: " ")
                        let arstr = arr.first
                        let stra = arstr?.components(separatedBy: ":")
                        guard let checkmin = stra?[1] else
                        {
                            return
                        }
                        if(checkmin == "00" || checkmin == "15" || checkmin == "30" || checkmin == "45")
                        {
                            self.lblStartTime = formatter.string(from: date!)
                        }
                        else if(Int(checkmin)! <= 15)
                        {
                            let strval = String(format: "%@:%@ %@", (stra?.first)!,"00",arr.last!)
                            self.lblStartTime = strval
                        }
                        else if(Int(checkmin)! > 15 && Int(checkmin)! <= 30)
                        {
                            let strval = String(format: "%@:%@ %@", (stra?.first)!,"15",arr.last!)
                            self.lblStartTime = strval
                        }
                        else if(Int(checkmin)! > 30 && Int(checkmin)! <= 45)
                        {
                            let strval = String(format: "%@:%@ %@", (stra?.first)!,"30",arr.last!)
                            self.lblStartTime = strval                           }
                        else
                        {
                            let strval = String(format: "%@:%@ %@", (stra?.first)!,"45",arr.last!)
                            self.lblStartTime = strval
                        }
                        self.fieldStartTime.text = self.lblStartTime
                        let newstartdate = formatter.date(from: self.lblStartTime)
                        let calendar = Calendar.current
                        let date = calendar.date(byAdding: .minute, value: 15, to: newstartdate!)
                        formatter.dateFormat = "hh:mm a"
                        self.fieldEndTime.text = formatter.string(from: date!)
                        
                        formatter.locale = Locale(identifier: "en_US_POSIX")
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        self.lblStartTime = formatter.string(from: newstartdate!)// set locale to reliable US_POSIX
                        self.lblEndTime = formatter.string(from: date!)
                    }
                    
                }
            }
    }
    }
}
extension CreatingNewService: WeekdaysSegmentedControlDelegate {
    
    func weekDaysSegmentedControl(_ control: WeekdaysSegmentedControl, didSelectDay day: Int) {
        let firstWeekday = 1 // -> Sunday
        
        let fmt = DateFormatter()
        var symbols = fmt.shortWeekdaySymbols
        symbols = Array(symbols![firstWeekday-1..<symbols!.count]) + symbols![0..<firstWeekday-1]
        
        if btnCustom.currentImage == UIImage.init(named:"ic_check") && fieldCustomPattern.text == "Weekly" {
            let dayName:String = symbols![day]
            print(dayName)
        
            if !weekDays.contains(dayName) {
                weekDays.add(dayName)
            }
        }else if btnCustom.currentImage == UIImage.init(named:"ic_check") && fieldCustomPattern.text == "Monthly" {
            let dayName:String = symbols![day]
            print(dayName)
            
            if !weekDays.contains(dayName) {
                weekDays.add(dayName)
            }
        }else if btnCustom.currentImage == UIImage.init(named:"ic_check") && fieldCustomPattern.text == "Yearly" {
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
        
        if btnCustom.currentImage == UIImage.init(named:"ic_check") && fieldCustomPattern.text == "Weekly" {

            let dayName:String = symbols![day]
            print(dayName)
            
            if weekDays.contains(dayName) {
                weekDays.remove(dayName)
            }
        }else if btnCustom.currentImage == UIImage.init(named:"ic_check") && fieldCustomPattern.text == "Monthly" {
            let dayName:String = symbols![day]
            print(dayName)
            
            if weekDays.contains(dayName) {
                weekDays.remove(dayName)
            }
        }else if btnCustom.currentImage == UIImage.init(named:"ic_check") && fieldCustomPattern.text == "Yearly" {
            let dayName:String = symbols![day]
            print(dayName)
            
            if weekDays.contains(dayName) {
                weekDays.remove(dayName)
            }
        }
        print(weekDays)
    }
}
extension CreatingNewService:URLSessionDelegate {
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
extension Int {
    var ordinal: String {
        get {
            var suffix = "th"
            switch self % 10 {
            case 1:
                suffix = "st"
            case 2:
                suffix = "nd"
            case 3:
                suffix = "rd"
            default: ()
            }
            if 10 < (self % 100) && (self % 100) < 20 {
                suffix = "th"
            }
            return String(self) + suffix
        }
    }
}
