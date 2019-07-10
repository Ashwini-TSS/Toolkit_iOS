//
//  AddRecurrencePattern.swift
//  NewRecurrencePattern
//
//  Created by Test Technologies PVT LTD on 07/09/18.
//  Copyright © 2018 Thabresh. All rights reserved.
//

import UIKit

class AddRecurrencePattern: UITableViewController {

    @IBOutlet weak var fieldMonth: UITextField!
    @IBOutlet weak var fieldWeek: UITextField!
    @IBOutlet weak var btnMonthOverlap: UIButton!
    @IBOutlet weak var fieldDaysOfWeek: UITextField!
    @IBOutlet weak var fieldRescheduleMode: UITextField!
    @IBOutlet weak var fieldWeekends: UITextField!
    @IBOutlet weak var fieldInterval: UITextField!
    @IBOutlet weak var fieldPattern: UITextField!
    @IBOutlet weak var weekDaysSegment: WeekdaysSegmentedControl!
    
    var currentStatus:Int = 0
    var PatternType:String = ""
    var weekEndModeStr:String = ""
    var recurrenceName:String = ""
    var rescheduleAlg:String = ""
    var monthOverLap:Bool = false
    var weekOfMonth:String = ""
    var allWeekStr:String = ""
    var monthOfYear:Int = 0
    var bottomView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fieldInterval.text = "1"
        tableView.tableFooterView = UIView()
        setupWeekDay()
        
        fieldPattern.text = "Daily"
        self.PatternType = "Daily"

        self.title = "Add Recurrence Pattern"
    }
    override func viewDidAppear(_ animated: Bool) {
        setupBottomView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeBottomView()
    }
    func setupBottomView() {
        bottomView.removeFromSuperview()
        bottomView = UIView()
        bottomView.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height - 50.0, width: UIScreen.main.bounds.width, height: 50.0)
        bottomView.backgroundColor = UIColor.PSNavigaitonController()
        
        let cancelBtn = UIButton()
        cancelBtn.setTitle("Close", for: .normal)
        cancelBtn.frame = CGRect(x: 25.0, y: 5.0, width: 120.0, height: 30)
        cancelBtn.backgroundColor = UIColor.white
        cancelBtn.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 17.0)!
        cancelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        cancelBtn.addTarget(self, action: #selector(tapClose(_:)), for: .touchUpInside)
        
        bottomView.addSubview(cancelBtn)
        
        let donelBtn = UIButton()
        donelBtn.setTitle("Save", for: .normal)
        donelBtn.frame = CGRect(x: UIScreen.main.bounds.width - 150, y: 5.0, width: 120.0, height: 30)
        donelBtn.backgroundColor = UIColor.white
        donelBtn.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 17.0)!
        donelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        donelBtn.addTarget(self, action: #selector(tapSave(_:)), for: .touchUpInside)
        
        bottomView.addSubview(donelBtn)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.addSubview(bottomView)
    }
    func removeBottomView(){
        bottomView.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 { //Pattern  Interval
            return 120
        }else if indexPath.row == 1 { //Weekends
            if currentStatus == 0 {
                if fieldPattern.text == "Daily" || fieldPattern.text == "Monthly" || fieldPattern.text == "Annually" {
                    return 60
                }
                return 0
            }
            return 0
        }else if indexPath.row == 2 { //Reschedule Mode
            if currentStatus == 0 {
                if fieldWeekends.text == "Reschedule" {
                    return 60
                }
                return 0
            }
        }else if indexPath.row == 3 { //Days Of Week
            if currentStatus == 0 {
                return 0
            }
        }else if indexPath.row == 4 { //Month Overlap
            if currentStatus == 0 {
                if  fieldPattern.text == "Monthly" || fieldPattern.text == "Annually" {
                    return 60
                }
                return 0
            }
        }else if indexPath.row == 5 { //Week
            if currentStatus == 0 {
                if fieldPattern.text == "Monthly Variable" || fieldPattern.text == "Annually Variable"{
                    return 60
                }
                return 0
            }
        }else if indexPath.row == 6 { //Days of week
            if fieldPattern.text == "Weekly" || fieldPattern.text == "Monthly Variable" || fieldPattern.text == "Annually Variable"{
                return 90
            }else{
                return 0
            }
        } else if indexPath.row == 7 { //Month
            if currentStatus == 0 {
                if fieldPattern.text == "Annually Variable"{
                    return 60
                }
                return 0
            }
        }
        return 60
    }
    
    func setupWeekDay(){
        weekDaysSegment.selectedColor = .blue
        weekDaysSegment.deselectedColor = .white
        weekDaysSegment.cornerRadius = 5
        weekDaysSegment.borderWidth = 2
        weekDaysSegment.borderColor = .lightGray
        weekDaysSegment.font = UIFont.systemFont(ofSize: 17.0)
        weekDaysSegment.setButtonsTitleColor(.black, for: .normal)
        weekDaysSegment.setButtonsTitleColor(.white, for: .selected)
        weekDaysSegment.setButtonsTitleColor(.blue, for: .highlighted)
        weekDaysSegment.tag = 0
        weekDaysSegment.selectedDays = []
        weekDaysSegment.delegate = self
    }
    
    @IBAction func tapMonthOverlap(_ sender:UIButton) {
        if btnMonthOverlap.currentBackgroundImage == UIImage.init(named:"ic_check_box") {
            sender.setBackgroundImage(UIImage.init(named:"ic_check"), for: .normal)
            monthOverLap = true
        }else{
            sender.setBackgroundImage(UIImage.init(named:"ic_check_box"), for: .normal)
            monthOverLap = false
        }
    }
    @IBAction func tapSave(_ sender:UIButton) {
        
        if fieldPattern.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the \(String(describing: fieldPattern.placeholder!))")
            return
        }else if fieldInterval.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please enter the \(String(describing: fieldInterval.placeholder!))")
            return
        }
        if fieldPattern.text == "Monthly Variable" || fieldPattern.text == "Annually Variable" {
            if fieldWeek.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message:"Please choose the \(String(describing: fieldWeek.placeholder!))")
                return
            }
        }
        
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(self.PatternType, forKey: "PatternType")
        dataObject.setValue(0, forKey: "DaysOfWeekMask")
        dataObject.setValue(monthOfYear, forKey: "MonthOfYear")
        dataObject.setValue(weekEndModeStr, forKey: "WeekendAvoidanceMode")
        dataObject.setValue(weekOfMonth, forKey: "WeekOfMonth")
        dataObject.setValue(getStatusName(), forKey: "Name")
        dataObject.setValue(monthOverLap, forKey: "EnableMonthOverlap")
        dataObject.setValue(rescheduleAlg, forKey: "RescheduleAlgorithm")
        dataObject.setValue(Int(fieldInterval.text!), forKey: "Interval")
       
        let json:[String:Any] = ["DataObject":dataObject,
                                 "ObjectName":"recurrence_pattern",
                                 "PassKey":passKey,
                                 "OrganizationId":currentOrgID]
        print(json)
        print(createContact)
        
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                        if let dataObj:NSDictionary = jsonResponse["DataObject"] as? NSDictionary {
                            print(dataObj)
                            let getID:String = dataObj.value(forKey: "Id") as! String
                            print(getID)
                            self.navigationController?.popViewController(animated: true)
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
        
//createContact
        
    }
    func getStatusName() -> String {
        var statusName:String = ""
        if fieldPattern.text == "Daily" || fieldPattern.text == "Monthly" || fieldPattern.text == "Annually" {
            if fieldPattern.text == "Monthly" {
                statusName = "Every Month"
            }else if fieldPattern.text == "Annually"{
                statusName = "Every Year"
            }else{
                statusName = "Every Day"
            }
            if fieldWeekends.text == "Do not schedule" {
                statusName = statusName + " skipping weekends"
            }
            if fieldWeekends.text == "Reschedule" {
                statusName = statusName + " Reschedule weekends"
            }
        }else if fieldPattern.text == "Weekly" {
            
            let firstWeekday = 1 // -> Sunday
            
            let fmt = DateFormatter()
            var symbols = fmt.shortWeekdaySymbols
            symbols = Array(symbols![firstWeekday-1..<symbols!.count]) + symbols![0..<firstWeekday-1]
            
            var dayNames:String = ""
            
            for index in 0..<weekDaysSegment.selectedDays.count {
                let getTag = weekDaysSegment.selectedDays[index]
                print(symbols![getTag])
                let name:String = " \(symbols![getTag]),"
                dayNames.append(name)
            }
            dayNames.removeLast()
            statusName = "Every week on" + dayNames
        }else if fieldPattern.text == "Monthly Variable" || fieldPattern.text == "Annually Variable" {
            allWeekStr.removeLast()
            if fieldPattern.text == "Annually Variable" {
                
                let getStr = fieldMonth.text!.prefix(3)
                statusName = "\(recurrenceName)\(allWeekStr) of \(getStr) every year"
            }else{
                statusName = "\(recurrenceName)\(allWeekStr) of every month"
            }
        }
        
        return statusName
    }
    @IBAction func tapClose(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK:- Showing Picker
extension AddRecurrencePattern {
    func showPickerView(textfield:UITextField){
        if textfield == fieldPattern {
            let values = ["Daily", "Weekly", "Monthly", "Monthly Variable","Annually","Annually Variable"]
            self.showPicker(values: values as NSArray, textfield: textfield)
        }else if textfield == fieldWeekends {
            let values = ["Schedule", "Do not schedule", "Reschedule"]
            self.showPicker(values: values as NSArray, textfield: textfield)
        }else if textfield == fieldRescheduleMode {
            let values = ["Maintain Day of Month", "Maintain Spacing"]
            self.showPicker(values: values as NSArray, textfield: textfield)
        }else if textfield == fieldWeek {
            let values = ["First", "Second", "Third", "Fourth", "Last"]
            self.showPicker(values: values as NSArray, textfield: textfield)
        }else if textfield == fieldMonth {
            let values = ["January", "February", "March", "April", "May","June", "July", "August", "September", "October", "November", "December"]
            self.showPicker(values: values as NSArray, textfield: textfield)
        }
    }
    func showPicker(values:NSArray,textfield:UITextField){
        DPPickerManager.shared.showPicker(title: "", selected: textfield.text!, strings: values as! [String]) { (value, index, cancel) in
            self.setupBottomView()
            self.view.endEditing(true)
            if !cancel {
                textfield.text = value
                // TODO: you code here
                debugPrint(value as Any)
                self.tableView.reloadData()
                if textfield == self.fieldWeekends {
                }
                if textfield == self.fieldPattern {
                    if self.fieldPattern.text == "Daily" {
                        self.PatternType = "Daily"
                        self.recurrenceName = "Every day "
                    }else if self.fieldPattern.text == "Weekly" {
                        self.PatternType = "Weekly"
                        self.recurrenceName = "Every week "
                    }else if self.fieldPattern.text == "Monthly" {
                        self.PatternType = "MonthlyN"
                        self.recurrenceName = "Every month "
                    }else if self.fieldPattern.text == "Monthly Variable" {
                        self.PatternType = "MonthlyV"
                    }else if self.fieldPattern.text == "Annually" {
                        self.PatternType = "AnnuallyN"
                    }else if self.fieldPattern.text == "Annually Variable" {
                        self.PatternType = "AnnuallyV"
                    }
                    self.fieldWeekends.text = ""
                }else if textfield == self.fieldWeekends {
                    if self.fieldWeekends.text == "Do not schedule" {
                        self.weekEndModeStr = "Skip"
                        if self.fieldPattern.text == "Annually" {
                             self.recurrenceName = "Every year skipping weekends"
                        }else if self.fieldPattern.text == "Weekly"{
                             self.recurrenceName = "Every day skipping weekends"
                        }
                    }else if self.fieldWeekends.text == "Schedule" {
                        self.weekEndModeStr = "Schedule"
                    }else if self.fieldWeekends.text == "Reschedule" {
                        if self.fieldPattern.text == "Annually" {
                            self.recurrenceName = "Every year rescheduling weekends"
                        }else if self.fieldPattern.text == "Weekly"{
                            self.recurrenceName = "Every day rescheduling weekends"
                        }
                        self.weekEndModeStr = "ReSchedule"
                    }
                }else if textfield == self.fieldRescheduleMode {
                    if self.fieldRescheduleMode.text == "Maintain Day of Month" {
                        self.rescheduleAlg = "MaintainDay"
                    }else if self.fieldRescheduleMode.text == "Maintain Spacing" {
                        self.rescheduleAlg = "MaintainSpan"
                    }
                }else if textfield == self.fieldWeek {
                    self.weekOfMonth = self.fieldWeek.text!
                    self.recurrenceName = "The \(self.fieldWeek.text!)"
                }else if textfield == self.fieldMonth {
                    if textfield.text == "January" { self.monthOfYear = 0 }else
                    if textfield.text == "February" { self.monthOfYear = 1 }else
                    if textfield.text == "March" { self.monthOfYear = 2 }else
                    if textfield.text == "April" { self.monthOfYear = 3 }else
                    if textfield.text == "May" { self.monthOfYear = 4  }else
                    if textfield.text == "June" { self.monthOfYear = 5 }else
                    if textfield.text == "July" { self.monthOfYear = 6 }else
                    if textfield.text == "August" { self.monthOfYear = 7 }else
                    if textfield.text == "September" { self.monthOfYear = 8 }else
                    if textfield.text == "October" { self.monthOfYear = 9 }else
                    if textfield.text == "November" { self.monthOfYear = 10 }else
                    if textfield.text == "December" { self.monthOfYear = 11 }
                }
                
            }
        }
    }
}
extension AddRecurrencePattern:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        removeBottomView()
        if textField == fieldPattern {
            showPickerView(textfield: textField)
            return false
        }else if textField == fieldWeekends {
            showPickerView(textfield: textField)
            return false
        }else if textField == fieldRescheduleMode {
            showPickerView(textfield: textField)
            return false
        }else if textField == fieldWeek {
            showPickerView(textfield: textField)
            return false
        }else if textField == fieldMonth {
            showPickerView(textfield: textField)
            return false
        }
        return true
    }
}
extension AddRecurrencePattern: WeekdaysSegmentedControlDelegate {
    
    func weekDaysSegmentedControl(_ control: WeekdaysSegmentedControl, didSelectDay day: Int) {
        let firstWeekday = 1 // -> Sunday
        
        let fmt = DateFormatter()
        var symbols = fmt.shortWeekdaySymbols
        symbols = Array(symbols![firstWeekday-1..<symbols!.count]) + symbols![0..<firstWeekday-1]
        let dayName:String = symbols![day]
        print(dayName)
        allWeekStr += " \(dayName),"
    }
    
    func weekDaysSegmentedControl(_ control: WeekdaysSegmentedControl, didDeselectDay day: Int) {
        
        let firstWeekday = 1 // -> Sunday
        
        let fmt = DateFormatter()
        var symbols = fmt.shortWeekdaySymbols
        symbols = Array(symbols![firstWeekday-1..<symbols!.count]) + symbols![0..<firstWeekday-1]
        
        print("deselect \(day)")
    }
}
extension AddRecurrencePattern:URLSessionDelegate {
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
