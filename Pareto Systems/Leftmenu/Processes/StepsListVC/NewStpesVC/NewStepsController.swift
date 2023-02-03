//
//  NewStepsController.swift
//  Processes
//
//  Created by Test Technologies PVT LTD on 02/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class NewStepsController: UITableViewController {

    @IBOutlet weak var btnRollOver: UIButton!
    @IBOutlet weak var fieldDayOffset: ACFloatingTextfield!
    @IBOutlet weak var fieldEndTime: ACFloatingTextfield!
    @IBOutlet weak var fieldStartTime: ACFloatingTextfield!
    @IBOutlet weak var fieldLocation: ACFloatingTextfield!
    @IBOutlet weak var fieldActivity: ACFloatingTextfield!
    
    @IBOutlet var Deletebtn: UIBarButtonItem!
    @IBOutlet weak var fieldAppointmentType: ACFloatingTextfield!
    @IBOutlet weak var fieldAssignee: ACFloatingTextfield!
    @IBOutlet weak var fieldSequence: ACFloatingTextfield!
    @IBOutlet weak var fieldAssigneeType: ACFloatingTextfield!
    @IBOutlet weak var btnAllDay: UIButton!
    @IBOutlet weak var fieldDescription: KMPlaceholderTextView!
    @IBOutlet weak var fieldSubject: ACFloatingTextfield!
    var stepsList:[GetStepsResult] = []
    var isAssignee:Bool = false
    var getAppointments:[GetStepsUsersResult] = []
    var getAssingeeList:[GetAssigneeResult] = []
    var selectedSequence:Int = 0
    var lblStartTime:String = ""
    var lblEndTime:String = ""
    var isRollOver:Bool = false
    var isAllDay:Bool = false
    var assigneeID:String = ""
    var appointmentTypeID:String = ""
    var advProcessID:String = ""
    var previousProcessesValue:GetStepsResult!
    var bottomView = UIView()
    
    func convertToTime(strDate:String) -> String{
        if strDate.count == 0 {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let getDate:Date = formatter.date(from: strDate) {
            formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            formatter.dateFormat = "hh:mm a"
            return formatter.string(from: getDate)
        }
        return ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBottomView()
        
        Deletebtn.isEnabled = false
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        self.fieldStartTime.text = formatter.string(from: Date())
        
        fieldActivity.text = "Appointment"
        fieldAssigneeType.text = "Contacts Owner"
        
        formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.lblStartTime = formatter.string(from: Date())
        
        
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: 15, to: Date())
        formatter.dateFormat = "hh:mm a"
        self.fieldEndTime.text = formatter.string(from: date!)
        
        
        formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.lblEndTime = formatter.string(from: date!)

        fieldDescription.layer.cornerRadius = 5.0
        fieldDescription.layer.borderColor = UIColor.lightGray.cgColor
        fieldDescription.layer.borderWidth = 1.0
        fieldDescription.clipsToBounds = true
        
        if previousProcessesValue != nil {
            self.title = "Edit Step"
            isRollOver = previousProcessesValue.rollOver
            isAllDay = previousProcessesValue.allDay
            Deletebtn.isEnabled = true
            Deletebtn.setBackgroundImage(UIImage.init(named:"TaskDelete"), for: .normal, barMetrics: .default)
            
    
            if isAllDay == false {
                btnAllDay.setImage(UIImage.init(named:"ic_check_box"), for: .normal)

            }else{
                btnAllDay.setImage(UIImage.init(named:"ic_check"), for: .normal)

            }
            if isRollOver == false {
                btnRollOver.setImage(UIImage.init(named:"ic_check_box"), for: .normal)

            }else{
                btnRollOver.setImage(UIImage.init(named:"ic_check"), for: .normal)

            }
            
            fieldActivity.text = previousProcessesValue.activityType
            fieldSubject.text = previousProcessesValue.subject
            fieldDescription.text = previousProcessesValue.descriptionField
            fieldLocation.text = previousProcessesValue.location
            lblStartTime = previousProcessesValue.startTime
            lblEndTime = previousProcessesValue.endTime
            fieldStartTime.text = convertToTime(strDate: previousProcessesValue.startTime)
            fieldEndTime.text = convertToTime(strDate: previousProcessesValue.endTime)
            fieldDayOffset.text = "\(previousProcessesValue.dayOffset!)"
            fieldAssigneeType.text = previousProcessesValue.assigneeType
            fieldAppointmentType.text = previousProcessesValue.appointmentTypeId
            fieldSequence.text = "\(previousProcessesValue.sequence!) - Current Position"
            selectedSequence = previousProcessesValue.sequence


            if previousProcessesValue.advocateProcessId != nil {
                advProcessID = previousProcessesValue.advocateProcessId
            }
            if previousProcessesValue.AssigneeId != nil {
                assigneeID = previousProcessesValue.AssigneeId

               

                tableView.reloadData()
                
                let json:[String: Any] = ["SearchTerm": "",
                                          "ObjectName":"organization_user",
                                          "PassKey":passKey,
                                          "OrganizationId":currentOrgID,
                                          "PageOffset":1,
                                          "ResultsPerPage":100]
                print(json)
                APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                    self.checkAppointment()
                    DispatchQueue.main.async {
                        print(json)
                        
                        let getModel = GetAssigneeModel.init(fromDictionary: jsonResponse)
                        if getModel.valid {
                            
                            let gettAssingeeList:[GetAssigneeResult] = getModel.results
                            
                            for index in 0..<gettAssingeeList.count {
                                let eachAssignee = gettAssingeeList[index]
                                if eachAssignee.id == self.previousProcessesValue.AssigneeId {
                                    self.isAssignee = true
                                    self.fieldAssignee.text = eachAssignee.fullName
                                }
                            }
                          
                        }
                    }
                },  onFailure: { error in
                    print(error.localizedDescription)
                })
            }else{
                checkAppointment()
            }
            
//            fieldAssignee.text = previousProcessesValue.ass
        }
        getSteps()
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
        donelBtn.addTarget(self, action: #selector(tappedAddSteps(_:)), for: .touchUpInside)

        bottomView.addSubview(donelBtn)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.window?.addSubview(bottomView)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
      
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeBottomView()
    }
    
    func removeBottomView(){
        bottomView.removeFromSuperview()
    }
    
    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedSave(_ sender: Any) {

        
    }
    @IBAction func DeleteAction(_ sender: Any) {
        
        let alert = UIAlertController(title:"Delete", message: "Are you sure want to delete this step?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            let json: [String: Any] = ["ObjectName": "advocate_process_template",
                                       "ObjectId":self.previousProcessesValue.id!,
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
    
    func checkAppointment(){
        if previousProcessesValue.appointmentTypeId == nil {
            return
        }
        appointmentTypeID = previousProcessesValue.appointmentTypeId

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
                
                let getModel = GetStepsUsersModel.init(fromDictionary: jsonResponse)
                print(getModel.responseMessage)
                self.getAppointments = []
                if getModel.valid {
                    self.getAppointments = getModel.results
                }
                
                if self.previousProcessesValue != nil {
                    for index in 0..<self.getAppointments.count {
                        let getEachAppointment = self.getAppointments[index]
                        if getEachAppointment.id == self.previousProcessesValue.appointmentTypeId {
                            self.fieldAppointmentType.text = getEachAppointment.name
                        }
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    func getSteps(){
        let json:[String: Any] = ["PageOffset": 0,
                                   "ResultsPerPage": 1000,
                                   "ObjectName":"advocate_process_template",
                                   "ParentObjectName":"advocate_process",
                                   "ParentId":advProcessID,
                                   "AscendingOrder":true,
                                   "OrderBy":"Sequence",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let steps:GetStepsModel = GetStepsModel.init(fromDictionary: jsonResponse)
                if steps.valid {
                    self.stepsList = steps.results
                }else{
                    
                }
                self.tableView.reloadData()
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
                
                let getModel = GetStepsUsersModel.init(fromDictionary: jsonResponse)
                print(getModel.responseMessage)
                self.getAppointments = []
                if getModel.valid {
                    self.getAppointments = getModel.results
                    self.getAppointments = self.getAppointments.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending }

                }
                
                if self.previousProcessesValue != nil {
                    for index in 0..<self.getAppointments.count {
                        let getEachAppointment = self.getAppointments[index]
                        if getEachAppointment.id == self.previousProcessesValue.appointmentTypeId {
                            self.fieldAppointmentType.text = getEachAppointment.name
                        }
                    }
                }
                self.showAppointmentPicker()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        
    }
    func getAssignee(){
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
                
                let getModel = GetAssigneeModel.init(fromDictionary: jsonResponse)
                print(getModel.responseMessage)
                self.getAssingeeList = []
                if getModel.valid {
                    self.getAssingeeList = getModel.results
                    self.getAssingeeList = self.getAssingeeList.sorted { $0.fullName.localizedCaseInsensitiveCompare($1.fullName) == ComparisonResult.orderedAscending }

                }
                self.showAssigneeList()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        
    }
    func showAssigneeList(){
        var appointments:[String] = []
        for index in 0..<getAssingeeList.count {
            let getAppoint = getAssingeeList[index]
            appointments.append(getAppoint.fullName)
        }
        DPPickerManager.shared.showPicker(title: "Assignee", selected: "", strings: appointments) { (value, index, cancel) in
            self.setupBottomView()

            if !cancel {
                self.fieldAssignee.text = value
                
                let getAppoint = self.getAssingeeList[index]
                self.assigneeID = getAppoint.id
                //assigneeID
                debugPrint(value as Any)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tappedAllDayEvent(_ sender: Any) {
        if isAllDay == false {
            isAllDay = true
            btnAllDay.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            isAllDay = false
            btnAllDay.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
        }
    }
    
    @IBAction func tappedRollOver(_ sender: Any) {
        if isRollOver == false {
            isRollOver = true
            btnRollOver.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            isRollOver = false
            btnRollOver.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
        }
    }
    func checkValidation() -> Bool {
        if fieldActivity.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please enter the ActivityType")
            return false
        }
        if fieldSubject.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please enter the Subject")
            return false
        }
        if fieldStartTime.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the StartTime")
            return false
        }
        if fieldEndTime.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the EndTime")
            return false
        }
        if fieldSequence.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the Sequence")
            return false
        }
        return true
    }
    @IBAction func tappedAddSteps(_ sender: Any) {
       
        if !checkValidation(){
            return
        }
        var mainURL:String = createContact

       
        let trimmedString = fieldAssigneeType.text!.trimmingCharacters(in: .whitespaces)
        var formattedString = trimmedString.replacingOccurrences(of: " ", with: "")

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
        let myString2 = fieldDayOffset.text!
        let dayOffSet = (myString2 as NSString).integerValue
        
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(fieldActivity.text!, forKey: "ActivityType")
        dataObject.setValue(advProcessID, forKey: "AdvocateProcessId")
        dataObject.setValue(appointmentTypeID, forKey: "AppointmentTypeId")
        dataObject.setValue(assigneeID, forKey: "AssigneeId")
        dataObject.setValue(formattedString, forKey: "AssigneeType")
        dataObject.setValue(dayOffSet, forKey: "DayOffset")
        dataObject.setValue(fieldDescription.text!, forKey: "Description")
        dataObject.setValue(lblEndTime, forKey: "EndTime")
        dataObject.setValue(fieldLocation.text!, forKey: "Location")
        dataObject.setValue(selectedSequence, forKey: "Sequence")
        dataObject.setValue(lblStartTime, forKey: "StartTime")
        dataObject.setValue(fieldSubject.text!, forKey: "Subject")
        dataObject.setValue(isAllDay, forKey: "AllDay")
        dataObject.setValue(isRollOver, forKey: "RollOver")
        if previousProcessesValue != nil {
            mainURL = modifyURL
            dataObject.setValue(previousProcessesValue.id, forKey: "Id")
        }
        let json:[String:Any] = ["DataObject":dataObject,
                                 "ObjectName":"advocate_process_template",
                                 "PassKey":passKey,
                                 "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: mainURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                        OperationQueue.main.addOperation {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        print(responseMessage)
                        NavigationHelper.showSimpleAlert(message:responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
                
                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })

//        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
//            DispatchQueue.main.async {
//                print(json)
//            }
//        },  onFailure: { error in
//            print(error.localizedDescription)
//        })
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 13
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 116
        }
        if indexPath.row == 12 {
            if !isAssignee {
                return 0
            }
        }
        if indexPath.row == 3 {
            if fieldActivity.text == "Task" {
                return 0
            }
        }
        return 57
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

extension NewStepsController:UITextFieldDelegate {
    func showAppointmentPicker(){
        var appointments:[String] = []
        for index in 0..<getAppointments.count {
            let getAppoint = getAppointments[index]
            appointments.append(getAppoint.name)
        }
        DPPickerManager.shared.showPicker(title: "Appointment Type", selected: "", strings: appointments) { (value, index, cancel) in
            self.setupBottomView()

            if !cancel {
                self.fieldAppointmentType.text = value
                
                let getAppoint = self.getAppointments[index]
                self.appointmentTypeID = getAppoint.id
                
                debugPrint(value as Any)
            }
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        if textField == fieldActivity {
            removeBottomView()
            let values = ["Appointment", "Task"]
            DPPickerManager.shared.showPicker(title: "Activity Type", selected: "", strings: values) { (value, index, cancel) in
                self.setupBottomView()

                if !cancel {
                    self.fieldActivity.text = value
                    debugPrint(value as Any)
                    self.tableView.reloadData()
                }
            }
         
            return false
        }
        if textField == fieldAssigneeType {
            removeBottomView()

            let values = [ "Contacts Owner","Current User", "Owner's Assistant", "Specific Person"]
            DPPickerManager.shared.showPicker(title: "Assignee Type", selected: "", strings: values) { (value, index, cancel) in
                self.setupBottomView()

                if !cancel {
                    self.fieldAssigneeType.text = value
                    debugPrint(value as Any)
                    self.isAssignee = false
                    self.assigneeID = ""
                    
                    if index == 3 {
                        self.isAssignee = true
                    }
                    self.tableView.reloadData()
                }
            }
            return false
        }
        if textField == fieldSequence {
            removeBottomView()
            if stepsList.count == 0 {
                let values = ["Last Step"]
                DPPickerManager.shared.showPicker(title: "Sequence", selected: "", strings: values) { (value, index, cancel) in
                    self.setupBottomView()

                    if !cancel {
                        self.selectedSequence = index
                        self.fieldSequence.text = value
                        debugPrint(value as Any)
                    }
                }
                return false
            }
            
            if stepsList.count > 0 {
                
                var totalList:[String] = []
                totalList.append("Last Step")
                
                for index in 0..<stepsList.count {
                    let step:GetStepsResult = stepsList[index]
                    totalList.append("\(index+1) - Before : \(step.subject!)")
                }
                DPPickerManager.shared.showPicker(title: "Sequence", selected: "", strings: totalList) { (value, index, cancel) in
                    self.setupBottomView()

                    if !cancel {
                        self.selectedSequence = index
                        self.fieldSequence.text = value
                        debugPrint(value as Any)
                    }
                }
                return false
            }
        }
        if textField == fieldAppointmentType {
            removeBottomView()

            getAppointmentTypes()
            return false
        }
        if textField == fieldAssignee {
            removeBottomView()

            getAssignee()
            return false
        }
        if textField == fieldStartTime {
            removeBottomView()

            DPPickerManager.shared.showPicker(title: "Start Time", picker: { (picker) in
                picker.date = Date()
                picker.datePickerMode = .time
                picker.minuteInterval = 15
            }) { (date, cancel) in
                self.setupBottomView()
                if !cancel {
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    textField.text = formatter.string(from: date!)
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    //                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.lblStartTime = formatter.string(from: date!)
                    
                    let arr =  self.lblStartTime.components(separatedBy: " ")
                    let arstr = arr.first
                    let stra = arstr?.components(separatedBy: ":")
                    guard let checkmin = stra?[1] else
                    {
                        return
                    }
                    if(checkmin == "00" || checkmin == "15" || checkmin == "30" || checkmin == "45")
                    {
                        let strval = String(format: "%@:%@ %@", (stra?.first)!,checkmin,arr.last!)
                        self.lblStartTime = strval        }
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
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.lblStartTime = formatter.string(from: newstartdate!)
                    self.lblEndTime = formatter.string(from: date!)
                    
                    // TODO: you code here
                    //                    debugPrint(date as Any)
                }
            }
            return false
        }
        if textField == fieldEndTime {
            removeBottomView()

            
            if fieldStartTime.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message:"Please Choose Start Time")
                return false
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            
            print(fieldStartTime.text!)
            let getDate = formatter.date(from: fieldStartTime.text!)
            
            let calendar = Calendar.current
            let convertDate = calendar.date(byAdding: .minute, value: 15, to: getDate!)
            
            DPPickerManager.shared.showPicker(title: "End Time", picker: { (picker) in
                picker.date = Date()
                picker.datePickerMode = .time
                picker.minuteInterval = 15
              //  picker.minimumDate = convertDate
            }) { (date, cancel) in
                self.setupBottomView()

                if !cancel {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    textField.text = formatter.string(from: date!)
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.lblEndTime = formatter.string(from: date!)
                    
                    // TODO: you code here
                    //                    debugPrint(date as Any)
                }
            }
            return false
        }
        
        return true
    }

}
extension NewStepsController:URLSessionDelegate {
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
