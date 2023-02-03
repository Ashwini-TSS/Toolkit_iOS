//
//  NewTaskController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 28/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
class NewTaskController: UITableViewController {
    
    var fromAccounts:Bool = false
    
    @IBOutlet weak var DuetimeTask: ACFloatingTextfield!
    @IBOutlet weak var StartTimetask: ACFloatingTextfield!
    
    var RecurringActivityId : String!
    var CreatedOn : String!
    var ModifiedBy : String!
    var ModifiedOn : String!
    var AdvocateProcessIndex : String!
    var AppliedAdvocateProcessId : String!
    var PriorityValue : String!
    var PercentComplete : String!
    var DescriptionValue : String!
    var StartTime : String!
    var Id : String!
    var DueTime : String!
    var StatusValue : String!
    var RollOver : String!
    var LocationValue : String!
    var CreatedBy : String!
    var RecurrenceIndex : String!
    var SubjectValue : String!
    var IsEdit : Bool! = false
    
    var getTeammem : [String] = []
    var getTeamContac : [String] = []
    var getTeamAccoun : [String] = []
    
    var cancelBtn = UIButton()
    var donelBtn = UIButton()
    
    var mainURL:String!
    
    var StrAccount : String!
    
    var accountname : String = ""
    
    var EditUrl : Int!
    
    var AlertString : String!
    

    @IBOutlet weak var fieldChooseAccounts: ACFloatingTextfield!
    @IBOutlet weak var fieldChooseTeam: ACFloatingTextfield!
    @IBOutlet weak var fieldContacts: ACFloatingTextfield!
    @IBOutlet weak var btnRollOver: UIButton!
    @IBOutlet weak var fieldDueTime: ACFloatingTextfield!
    
    @IBOutlet weak var fieldStartTime: ACFloatingTextfield!
    
    
    @IBOutlet weak var fieldStatus: ACFloatingTextfield!
    @IBOutlet weak var fieldPriority: ACFloatingTextfield!
    
    @IBOutlet weak var fieldComplete: ACFloatingTextfield!
    
    @IBOutlet weak var fieldLocation: ACFloatingTextfield!
    
    @IBOutlet weak var fieldDescription: KMPlaceholderTextView!
    
    @IBOutlet weak var fieldSubject: ACFloatingTextfield!
    
    var linkParentID:String = ""
    
    var Editvalue : String = ""
    
    
    
    var contactList:[ContactListResult] = []
    var teamMembers:[NewAppointmentResult] = []
    var accountsList:[TeamMembersResult] = []
    var appointmentType:[AppointmentTypeResult] = []
    var startTime:String = ""
    var endTime:String = ""
    var isRollOver:Bool = false
    var openedActivties:OpenActivityActivity!

    //API
    
    var SelectedIndexArrayContact : [String] = []
    
    var contactsIDList:NSMutableArray = []
    var teamMembersIDList:NSMutableArray = []
    var accountsIDList:NSMutableArray = []
    
    var selectedContacts:NSMutableArray = []
    var selectedTeamMembers:NSMutableArray = []
    var selectedCompanies:NSMutableArray = []
    
    var linkedContactIDList:NSMutableArray = []
    var linkedTeamMemberIDList:NSMutableArray = []
    var linkedAccountsIDList:NSMutableArray = []
    var bottomView = UIView()

    @IBOutlet weak var completeSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        fieldDescription.layer.cornerRadius = 5.0
        fieldDescription.layer.borderColor = UIColor.lightGray.cgColor
        fieldDescription.layer.borderWidth = 1.0
        fieldDescription.clipsToBounds = true
        
        AlertString = "normal"
        
        cancelBtn.isUserInteractionEnabled = true
        donelBtn.isUserInteractionEnabled = true
        
        fieldChooseAccounts.text = accountname
        
        if(Editvalue == "edit"){
            navigationItem.title = "Edit Task"
        }
        
        if openedActivties != nil {
            AppliedAdvocateProcessId = openedActivties.activity.AppliedAdvocateProcessId
            fieldSubject.text = openedActivties.activity.subject
            fieldDescription.text = openedActivties.activity.descriptionField
            fieldLocation.text = openedActivties.activity.location
            print(openedActivties.activity.PercentComplete)
            
            if openedActivties.activity != nil {
                if openedActivties.activity.PercentComplete != nil {
                    if let percentCom = openedActivties.activity.PercentComplete {
                        if percentCom > 0 {
                            self.completeSlider.value = Float(percentCom)
                        }else{
                            self.completeSlider.value = 0.0
                        }
                        fieldComplete.text = "\(percentCom)"
                        if(percentCom == 0){
                            fieldStatus.text = "Not Started"
                        }
                        else if(percentCom == 100){
                            fieldStatus.text = "Completed"
                        }
                        else{
                            fieldStatus.text = "In Progress"
                        }
                    }
                }
            }
           
            fieldPriority.text = openedActivties.activity.Priority
            
            fieldStartTime.text = openedActivties.activity.startTime.convertYearMonthDatehourMin12()
            fieldDueTime.text = openedActivties.activity.DueTime.convertYearMonthDatehourMin12()
            
            StartTimetask.text =  openedActivties.activity.startTime.convertminss()
            DuetimeTask.text = openedActivties.activity.DueTime.convertminss()
            
            
            isRollOver = openedActivties.activity.rollOver
            self.startTime = openedActivties.activity.startTime.convertYearMonthDatehourMinn()
            self.endTime = openedActivties.activity.DueTime.convertYearMonthDatehourMinn()
            
            if openedActivties.activity.rollOver {
                btnRollOver.setImage(UIImage.init(named:"ic_check"), for: .normal)
            }
        }else{
             self.fieldPriority.text = "Low"
            self.fieldStatus.text = "Not Started"
            
//            if((UserDefaults.standard.object(forKey: "showingDayView")) != nil) {
//                if let eventStartDAte = UserDefaults.standard.object(forKey: "eventStartDate") as? Date {
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "yyyy-MM-dd"
//                    let getStartTime:String = formatter.string(from: Date())
//                    fieldStartTime.text = getStartTime
//
//                    let formatter1 = DateFormatter()
//                    formatter1.dateFormat = "hh:00 a"
//                    let gtStartTime:String = formatter1.string(from: Date())
//                    StartTimetask.text = gtStartTime
//
//                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//                    formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
//                    self.startTime = formatter.string(from: Date())
//
//
//                    let calendar = Calendar.current
//                    let date = calendar.date(byAdding: .hour, value: 1, to: Date())
//                    formatter.dateFormat = "yyyy-MM-dd"
//                    formatter1.dateFormat = "hh:00 a"
//                    let getEndTime:String = formatter.string(from: date!)
//                    let gtEndTime:String = formatter1.string(from: date!)
//                    print(getEndTime)
//
//                    fieldDueTime.text = getEndTime
//                    DuetimeTask.text = gtEndTime
//
//
//                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//                    formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
//                    self.endTime = formatter.string(from: date!)
//                }
//
//                UserDefaults.standard.removeObject(forKey: "showingDayView")
//                UserDefaults.standard.removeObject(forKey: "eventStartDate")
//            }else{
                if(StartTime == nil){
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "hh:00 a"
                let getStarttTime1:String = formatter1.string(from: Date())
                StartTimetask.text = getStarttTime1
                //
                let calendar1 = Calendar.current
                let date1 = calendar1.date(byAdding: .hour, value: 1, to: Date())
                formatter1.dateFormat = "hh:00 a"
                let getEndTime1:String = formatter1.string(from: date1!)
                
                DuetimeTask.text = getEndTime1
                
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let getStartTime:String = formatter.string(from: Date())
                fieldStartTime.text = getStartTime
                
                formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
                self.startTime = formatter.string(from: Date())
                
                
                let calendar = Calendar.current
                let date = calendar.date(byAdding: .hour, value: 1, to: Date())
                formatter.dateFormat = "yyyy-MM-dd"
                let getEndTime:String = formatter.string(from: date!)
                print(getEndTime)
                
                fieldDueTime.text = getEndTime
                
                formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                formatter.dateFormat = "yyyy-MM-dd'T'HH:00:ss.SSSZ"
                self.endTime = formatter.string(from: date!)
                }
                else{
                    let convertformat = DateFormatter()
                    convertformat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    guard let cdate = convertformat.date(from: self.StartTime) else
                    {
                        return
                    }
                    
                    let formatter1 = DateFormatter()
                    formatter1.dateFormat = "hh:mm a"
                    let getStarttTime1:String = formatter1.string(from: cdate)
                    StartTimetask.text = getStarttTime1
                    
                    let calendar1 = Calendar.current
                    let date1 = calendar1.date(byAdding: .hour, value: 1, to: cdate)
                    formatter1.dateFormat = "hh:mm a"
                    let getEndTime1:String = formatter1.string(from: date1!)
                    DuetimeTask.text = getEndTime1
                    
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let getStartTime:String = formatter.string(from: cdate)
                    fieldStartTime.text = getStartTime
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.startTime = formatter.string(from: cdate)
                    
                    
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .hour, value: 1, to: cdate)
                    formatter.dateFormat = "yyyy-MM-dd"
                    let getEndTime:String = formatter.string(from: date!)
                    print(getEndTime)
                    
                    fieldDueTime.text = getEndTime
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.endTime = formatter.string(from: date!)
                }
           // }
        }
        
        if(IsEdit){
            EditDetails()
        }
        
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        let myIntValue:Int = Int(completeSlider.value)
        if(myIntValue == 0){
            fieldStatus.text = "Not Started"
        }
        else if(myIntValue == 100){
            fieldStatus.text = "Completed"
        }
        else{
            fieldStatus.text = "In Progress"
        }
        fieldComplete.text = "\(myIntValue)"
    }
    func getLinkedContactsdetail(){
        
        let json: [String: Any] = ["ObjectName":"linker_tasks_contacts",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "ListObjectName":"contact",
                                   "AscendingOrder":true,
                                   "LinkParentId": Id]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listLinked.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                var resultsArray : [JSON] = []
                var linkaccountArray : [String] = []
                resultsArray = json["Results"].arrayValue
                for dic in resultsArray{
                    let value = dic["FullName"].string
                    linkaccountArray.append(value!)
                }
                self.fieldContacts.text = linkaccountArray.joined(separator:",")
                self.SelectedIndexArrayContact = linkaccountArray as! [String]
                print("XXXXXXX")
                print(self.SelectedIndexArrayContact)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    func getLinkedAccountsdetail(){
        
        let json: [String: Any] = ["ObjectName":"linker_tasks_companies",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "ListObjectName":"company",
                                   "AscendingOrder":true,
                                   "LinkParentId":Id]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listLinked.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                var resultsArray : [JSON] = []
                var linkaccountArray : [String] = []
                resultsArray = json["Results"].arrayValue
                for dic in resultsArray{
                    let value = dic["Name"].string
                    linkaccountArray.append(value!)
                }
                self.fieldChooseAccounts.text = linkaccountArray.joined(separator:",")
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func getTeammemberdetail(){
        
        let json: [String: Any] = ["ObjectName":"linker_tasks_users",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "ListObjectName":"organization_user",
                                   "AscendingOrder":true,
                                   "LinkParentId": Id]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listLinked.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                var resultsArray : [JSON] = []
                var linkaccountArray : [String] = []
                resultsArray = json["Results"].arrayValue
                for dic in resultsArray{
                    let value = dic["FullName"].string
                    linkaccountArray.append(value!)
                }
                self.fieldChooseTeam.text = linkaccountArray.joined(separator:",")
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    func EditDetails(){
        if openedActivties != nil {
            
            Id = openedActivties.activity.id!
            startTime = openedActivties.activity.startTime!
            endTime = openedActivties.activity.DueTime!
            fieldSubject.text = openedActivties.activity.subject!
            fieldDescription.text = openedActivties.activity.descriptionField!
            fieldLocation.text = openedActivties.activity.location!
            fieldPriority.text = openedActivties.activity.Priority!
            
            StartTimetask.text =  openedActivties.activity.startTime.convertminss()
            DuetimeTask.text = openedActivties.activity.DueTime.convertminss()
            print(openedActivties.activity.PercentComplete)
            print(openedActivties.activity.Priority!)
            
            if openedActivties.activity != nil {
                if openedActivties.activity.PercentComplete != nil {
                    if let percentCom = openedActivties.activity.PercentComplete {
                        if percentCom > 0 {
                            self.completeSlider.value = Float(percentCom)
                        }else{
                            self.completeSlider.value = 0.0
                        }
                        fieldComplete.text = "\(percentCom)"
                        if(percentCom == 0){
                            fieldStatus.text = "Not Started"
                        }
                        else if(percentCom == 100){
                            fieldStatus.text = "Completed"
                        }
                        else{
                            fieldStatus.text = "In Progress"
                        }
                    }
                }
            }
            
            fieldPriority.text = openedActivties.activity.Priority
            fieldStartTime.text = openedActivties.activity.startTime.convertYearMonthDatehourMin12()
            fieldDueTime.text = openedActivties.activity.DueTime.convertYearMonthDatehourMin12()
            isRollOver = openedActivties.activity.rollOver
            self.startTime = openedActivties.activity.startTime.convertYearMonthDatehourMinn()
            self.endTime = openedActivties.activity.DueTime.convertYearMonthDatehourMinn()
            
            if openedActivties.activity.rollOver {
                btnRollOver.setImage(UIImage.init(named:"ic_check"), for: .normal)
            }
        }
        else{
//            print(converDateToString(dateString: StartTime))
//            print(converDateToString(dateString: DueTime))

//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//            let date1 = dateFormatter.date(from: DueTime)
//            let start1 = dateFormatter.date(from: StartTime)
//
//
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd hh:00 a"
//            let getDueTime:String = formatter.string(from:date1!)
//            let getStartTime:String = formatter.string(from:start1!)
//
//
//            let date = formatter.date(from: getDueTime)
//            let start = formatter.date(from: getStartTime)
//
//
//            let utcDate = date!.toGlobalTime()
//            let localDate1 = utcDate.toLocalTime()
            
            fieldDueTime.text = converDateToString(dateString: DueTime)
            fieldStartTime.text = converDateToString(dateString: StartTime)
            
            StartTimetask.text = convertTimeString(dateString: StartTime)
            DuetimeTask.text = convertTimeString(dateString: DueTime)
            
        fieldPriority.text = PriorityValue
        fieldLocation.text = LocationValue
        fieldDescription.text = DescriptionValue
        fieldSubject.text = SubjectValue
        fieldStatus.text = StatusValue
        fieldComplete.text = PercentComplete
        completeSlider.value = Float(PercentComplete ?? "0") ?? 0
        getLinkedAccountsdetail()
        getLinkedContactsdetail()
        getTeammemberdetail()
        
        if(PercentComplete == "0"){
            fieldStatus.text = "NotStarted"
        }
            
        }
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
        donelBtn.frame = CGRect(x:UIScreen.main.bounds.width-182, y: 9.0, width: 168.0, height: 38)
        donelBtn.backgroundColor = UIColor.white
        donelBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        donelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        donelBtn.addTarget(self, action: #selector(tappedNewTask(_:)), for: .touchUpInside)
        
        bottomView.addSubview(donelBtn)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.addSubview(bottomView)
    }
    @IBAction func tappedAction(_ sender: Any) {
        bottomView.removeFromSuperview()
        let alertController = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        let sendButton = UIAlertAction(title: "Delete", style: .default, handler: { (action) -> Void in
            self.setupBottomViewEdit()
            self.AlertString = "delete"
            self.tappedDeleteedit()
        })
        
        let closeButton = UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
          self.setupBottomViewEdit()
          self.tappedSaveEdit()
        })
        
        let deleteButton = UIAlertAction(title: "Complete", style: .default, handler: { (action) -> Void in
           self.setupBottomViewEdit()
           self.AlertString = "complete"
          self.tappedCompleteedit()
            
        })
      
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
            self.setupBottomViewEdit()
        })
        let NoteButton = UIAlertAction(title: "Add Note", style: .default, handler: { (action) -> Void in
            print("Note button tapped")
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailsVC") as! NoteDetailsVC
            if(self.openedActivties != nil)
            {
                controller.taskActivitiesCreated = self.openedActivties.activity.createdBy
                controller.taskActivitiesModified = self.openedActivties.activity.modifiedBy
                controller.taskAcitivitiesID = self.openedActivties.activity.id
            }else
            {
                controller.taskActivitiesCreated = self.CreatedBy
                controller.taskActivitiesModified = self.ModifiedBy
                controller.taskAcitivitiesID = self.Id
            }
            controller.passDefaultTaskSubject = self.fieldSubject.text!
            controller.fromviewcontroller = "task"
            controller.editModeON = false
            self.navigationController?.pushViewController(controller, animated: true)
        })
        alertController.addAction(NoteButton)
        alertController.addAction(sendButton)
        alertController.addAction(closeButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        self.navigationController?.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func setupBottomViewEdit() {
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
        cancelBtn.addTarget(self, action: #selector(tappedCancelEdit(_:)), for: .touchUpInside)
        
        bottomView.addSubview(cancelBtn)
        
        let donelBtn = UIButton()
        donelBtn.setTitle("Actions", for: .normal)
        donelBtn.frame = CGRect(x:UIScreen.main.bounds.width-182, y: 9.0, width: 168.0, height: 38)
        donelBtn.backgroundColor = UIColor.white
        donelBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        donelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        donelBtn.addTarget(self, action: #selector(tappedAction(_:)), for: .touchUpInside)
        bottomView.addSubview(donelBtn)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.addSubview(bottomView)
    }
    
    func tappedDeleteedit() {
        let parameters = [
            "ObjectId":Id,
            "OrganizationId": currentOrgID,
            "ObjectName": "task",
            "PassKey": passKey
            ] as [String : Any]
        profileUpdateAlertEdit(param: parameters)
    }
    
    func profileUpdateAlertEdit(param:[String : Any]){
        let alert = UIAlertController(title: "Are you sure want to delete this task?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.EditUrl = 1
            self.UpdatedNewTask(jsonParameter: param)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
            self.cancelBtn.isUserInteractionEnabled = true
            self.donelBtn.isUserInteractionEnabled = true
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
   func tappedCompleteedit() {
        EditUrl = 2
        if(RecurringActivityId != ""){
        let parameters = [
            "DataObject": [
                "AdvocateProcessIndex":0,
                "Description": fieldDescription.text!,
                "AppliedAdvocateProcessId":AppliedAdvocateProcessId,
                "DueTime": endTime,
                "Location": fieldLocation.text!,
                "PercentComplete": 100,
                "Priority": fieldPriority.text!,
                "StartTime": startTime,
                "Status": "Completed",
                "Subject": fieldSubject.text!,
                "Id":Id,
                "CreatedBy": CreatedBy,
                "CreatedOn": CreatedOn,
                "ModifiedBy": ModifiedBy,
                "ModifiedOn": ModifiedOn,
                "RecurrenceIndex": 0,
                "RollOver": isRollOver,
                "RecurringActivityId":RecurringActivityId
            ],
            "OrganizationId": currentOrgID,
            "ObjectName": "task",
            "PassKey": passKey
            ] as [String : Any]
        profileCompleteAlert(param: parameters)
        }
        else {
        let parameters = [
            "DataObject": [
                "AdvocateProcessIndex":0,
                "AppliedAdvocateProcessId":AppliedAdvocateProcessId,
                "Description": fieldDescription.text!,
                "DueTime": endTime,
                "Location": fieldLocation.text!,
                "PercentComplete": 100,
                "Priority": fieldPriority.text!,
                "StartTime": startTime,
                "Status": "Completed",
                "Subject": fieldSubject.text!,
                "Id":Id,
                "CreatedBy": CreatedBy,
                "CreatedOn": CreatedOn,
                "ModifiedBy": ModifiedBy,
                "ModifiedOn": ModifiedOn,
                "RecurrenceIndex": 0,
                "RollOver": isRollOver
            ],
            "OrganizationId": currentOrgID,
            "ObjectName": "task",
            "PassKey": passKey
            ] as [String : Any]
        profileCompleteAlert(param: parameters)
        }
    }
    func profileCompleteAlert(param:[String : Any]){
        let alert = UIAlertController(title: "Are you sure want to Complete this task?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.UpdatedNewTask(jsonParameter: param)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
            self.cancelBtn.isUserInteractionEnabled = true
            self.donelBtn.isUserInteractionEnabled = true
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func tappedCancelEdit(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    func tappedSaveEdit() {
        if(startTime == ""){
            NavigationHelper.showSimpleAlert(message: "Please enter the Starttime")
            return
        }
        else if(endTime == ""){
            NavigationHelper.showSimpleAlert(message: "Please enter the Duetime")
            return
        }
        if(StrAccount == "Accounts"){
            EditUrl = 3
            var getPercentage:Int = 0
            let completeStr:String = fieldComplete.text!
            if completeStr.count > 0 {
                getPercentage = Int(fieldComplete.text!)!
            }
            let getStatus:String = fieldStatus.text!
            let formattedString = getStatus.replacingOccurrences(of: " ", with: "")
            print(openedActivties.activity.recurrenceID)
            if( openedActivties.activity.recurrenceID != ""){
                let parameters = [
                    "DataObject": [
                        "AdvocateProcessIndex":0,
                        "AppliedAdvocateProcessId":AppliedAdvocateProcessId,
                        "Description": fieldDescription.text!,
                        "DueTime": endTime,
                        "Location": "",
                        "PercentComplete": getPercentage,
                        "Priority": fieldPriority.text!,
                        "StartTime": startTime,
                        "Status": formattedString,
                        "Subject": fieldSubject.text!,
                        "Id":Id!,
                        "CreatedBy": openedActivties.activity.createdBy!,
                        "CreatedOn": openedActivties.activity.createdOn!,
                        "ModifiedBy": openedActivties.activity.modifiedBy!,
                        "ModifiedOn": openedActivties.activity.modifiedOn!,
                        "RecurrenceIndex": 0,
                        "RollOver": isRollOver,
                        "RecurringActivityId":openedActivties.activity.recurrenceID!
                    ],
                    "OrganizationId": currentOrgID,
                    "ObjectName": "task",
                    "PassKey": passKey
                    ] as [String : Any]
                profileSaveEditAlert(param: parameters)
            }
            else {
                let parameters = [
                    "DataObject": [
                        "AdvocateProcessIndex":0,
                        "AppliedAdvocateProcessId":AppliedAdvocateProcessId,
                        "Description":fieldDescription.text!,
                        "DueTime": endTime,
                        "Location": "dsaghfdghsa",
                        "PercentComplete": getPercentage,
                        "Priority": fieldPriority.text!,
                        "StartTime": startTime,
                        "Status": formattedString,
                        "Subject": fieldSubject.text!,
                        "Id":Id!,
                        "CreatedBy": openedActivties.activity.createdBy!,
                        "CreatedOn": openedActivties.activity.createdOn!,
                        "ModifiedBy": openedActivties.activity.modifiedBy!,
                        "ModifiedOn": openedActivties.activity.modifiedOn!,
                        "RecurrenceIndex": 0,
                        "RollOver": isRollOver
                    ],
                    "OrganizationId": currentOrgID,
                    "ObjectName": "task",
                    "PassKey": passKey
                    ] as [String : Any]
                profileSaveEditAlert(param: parameters)
            }
        }
        else{
        EditUrl = 3
        var getPercentage:Int = 0
        let completeStr:String = fieldComplete.text!
        if completeStr.count > 0 {
            getPercentage = Int(fieldComplete.text!)!
        }
        let getStatus:String = fieldStatus.text!
        let formattedString = getStatus.replacingOccurrences(of: " ", with: "")
        if(RecurringActivityId != nil ){
        let parameters = [
            "DataObject": [
                "AdvocateProcessIndex":0,
                "Description": fieldDescription.text!,
                "DueTime": endTime,
                "Location": fieldLocation.text!,
                "PercentComplete": getPercentage,
                "Priority": fieldPriority.text!,
                "StartTime": startTime,
                "Status": formattedString,
                "Subject": fieldSubject.text!,
                "Id":Id,
                "CreatedBy": CreatedBy,
                "CreatedOn": CreatedOn,
                "ModifiedBy": ModifiedBy,
                "ModifiedOn": ModifiedOn,
                "RecurrenceIndex": 0,
                "RollOver": isRollOver,
                "RecurringActivityId":RecurringActivityId
            ],
            "OrganizationId": currentOrgID,
            "ObjectName": "task",
            "PassKey": passKey
            ] as [String : Any]
        profileSaveEditAlert(param: parameters)
        }
        else {
        let parameters = [
                "DataObject": [
                    "AdvocateProcessIndex":0,
                    "AppliedAdvocateProcessId":AppliedAdvocateProcessId,
                    "Description": fieldDescription.text!,
                    "DueTime": endTime,
                    "Location": fieldLocation.text!,
                    "PercentComplete": getPercentage,
                    "Priority": fieldPriority.text!,
                    "StartTime": startTime,
                    "Status": formattedString,
                    "Subject": fieldSubject.text!,
                    "Id":Id,
                    "CreatedBy": CreatedBy,
                    "CreatedOn": CreatedOn,
                    "ModifiedBy": ModifiedBy,
                    "ModifiedOn": ModifiedOn,
                    "RecurrenceIndex": 0,
                    "RollOver": isRollOver
                ],
                "OrganizationId": currentOrgID,
                "ObjectName": "task",
                "PassKey": passKey
                ] as [String : Any]
        profileSaveEditAlert(param: parameters)
        }
        }
    }
    
    func profileSaveEditAlert(param:[String : Any]){
        let alert = UIAlertController(title: "Are you sure want to Update this task?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.UpdatedNewTask(jsonParameter: param)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
            self.cancelBtn.isUserInteractionEnabled = true
            self.donelBtn.isUserInteractionEnabled = true
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func UpdatedNewTask(jsonParameter:[String : Any]){
        print(jsonParameter)
        let headers = [
            "Content-Type": "application/json",
            ]
        if(EditUrl == 2 || EditUrl == 3){
            mainURL = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/modify.json"
        }
        else{
            mainURL = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/delete.json"
        }
        let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        //        request.httpBody = postData as Data
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonParameter, options: []) {
            request.httpBody = jsonData
        }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            OperationQueue.main.addOperation {
//                SVProgressHUD.dismiss()
//                MBProgressHUD.hide(for: self.view, animated: true)

            }
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
                
                let jsonResponse:NSDictionary = (jsonObj as? NSDictionary)!
                print(jsonResponse)
                
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                        if(self.AlertString == "delete"){
                            let alert = UIAlertController(title: "Task Deleted Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                        if let getDataObject:NSDictionary = jsonResponse["DataObject"] as? NSDictionary {
                            if let getID:String = getDataObject["Id"] as? String {
                                self.linkAddress(rightID: getID)
                                self.linkAppointmentCompanies(rightID:getID)
                            }
                        }
                        
                    }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        print(responseMessage)
                        NavigationHelper.showSimpleAlert(message:responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
                
//                if let getValid = jsonResponse["Valid"] as? Bool {
//                    if getValid == true {
//                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
//                        print(responseMessage)
//                        let alert = UIAlertController(title: "Task Updated successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
//                            self.navigationController?.popViewController(animated: true)
//                        }))
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                }else{
//                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
//                }

                
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
    }
    
    
    func removeBottomView(){
        bottomView.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        if(IsEdit){
            setupBottomViewEdit()
        }
        else {
            setupBottomView()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeBottomView()
    }
    override func viewWillAppear(_ animated: Bool) {
        getContacts()
        if(IsEdit){
            setupBottomViewEdit()
        }
        else {
            setupBottomView()
        }
    }
    
    @IBAction func ActionBack(_ sender: Any) {
 self.navigationController?.popViewController(animated: true)
    }
    
    func getContacts(){
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
//            MBProgressHUD.showAdded(to: self.view, animated: true)

        }
        let headers = [
            "Content-Type": "application/json"
        ]
        let parameters = [
            "OrderBy": "",
            "ParentId": "",
            "ResultsPerPage": 5000,
            "OrganizationId": currentOrgID,
            "PassKey": passKey,
            "ParentObjectName": "",
            "PageOffset": 1,
            "ObjectName": "contact",
            "AscendingOrder":true
            ] as [String : Any]
        
        let request = NSMutableURLRequest(url: NSURL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            OperationQueue.main.addOperation {
                self.getLinkedAccounts()
                SVProgressHUD.dismiss()
//                MBProgressHUD.hide(for: self.view, animated: true)
//
            }
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
                
                let contactModel = ContactListModel.init(fromDictionary: jsonObj as! NSDictionary)
                print(contactModel.responseMessage)
                
                self.contactList = contactModel.results
                
                self.contactList = self.contactList.sorted { $0.fullName.localizedCaseInsensitiveCompare($1.fullName) == ComparisonResult.orderedAscending }
             
                if self.openedActivties == nil {
                    for index in 0..<self.contactList.count {
                        let getID = self.contactList[index].id
                        if getID == self.linkParentID {
                            let getContact = self.contactList[index]
                            self.fieldContacts.text = getContact.fullName
                            if self.fieldContacts.text!.count > 0 {
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
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
    }
    
    func getLinkedAccounts(){
        
        let json: [String: Any] = ["ObjectName":"company",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "OrderBy":"Name",
                                   "AscendingOrder":true,
                                   "PageOffset": 1,
                                   "ResultsPerPage": 5000]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                self.getTeamMembers()
                print(json)
                let contactModel = TeamMembersModel.init(fromDictionary: jsonResponse)
                self.accountsList = contactModel.results
                self.accountsList = self.accountsList.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func getTeamMembers(){
        let json: [String: Any] = ["ObjectName": "organization_user",
                                   "SearchTerm": "",
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey,
                                   "PageOffset":1,
                                   "ResultsPerPage":100]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            if self.IsEdit {
                DispatchQueue.main.async {
                    self.getAppointmentType()
                }
            }
            DispatchQueue.main.async {
                print(json)
                let respon = json["ResponseMessage"].string
                if(respon == "success"){
                let contactModel = NewAppointmentModel.init(fromDictionary: jsonResponse)
                print(contactModel.results)
                self.teamMembers = contactModel.results
                if(!self.IsEdit){
                        self.getJson()
//                    self,getLinkerUsers()
//                    self.fieldChooseTeam.text = getContact.fullName
                }
                    var indexs : Int!
                    for index in 0..<self.teamMembers.count {
                        let getContact = self.teamMembers[index]
                        print(getContact.id)
                        if(getContact.fullName == "SYSTEM ADMINISTRATOR"){
                            indexs = index
                        }
                    }
                    if(indexs != nil){
                        self.teamMembers.remove(at:indexs)
                    }
                    
                    
                    
                   
//              self.teamMembers = self.teamMembers.sorted { $0.fullName.localizedCaseInsensitiveCompare($1.fullName) == ComparisonResult.orderedAscending }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    func getAppointmentType(){
        
        let json: [String: Any] = ["ObjectName": "appointment_type",
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey,
                                   "PageOffset":1,
                                   "ResultsPerPage":1000,
                                   "AscendingOrder":true,
                                   "OrderBy":"Name"]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let contactModel = AppointmentTypeModel.init(fromDictionary: jsonResponse)
                print(contactModel.results)
                self.appointmentType = contactModel.results
                self.appointmentType = self.appointmentType.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending }
               
                if self.IsEdit {
                    self.getListlinkedAccounts()
                }else{
                    OperationQueue.main.addOperation {
                        self.getJson()
                    }
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
                    if self.openedActivties == nil {
                        self.fieldChooseTeam.text = contactModel.dataObject.fullName
                        if self.fieldChooseTeam.text!.count > 0 {
                            self.teamMembersIDList = []
                            self.selectedTeamMembers = []
                            var selectedContacts:[String] = []
                            self.teamMembersIDList.add(contactModel.dataObject.id!)
                            selectedContacts.append(contactModel.dataObject.fullName)
                            //                            self.selectedTeamMembers.add(row)
                        }
                    }
                }
                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 14
    }
    
    
    func registerNewTask(jsonParameter:[String : Any]){
        print(jsonParameter)
        let headers = [
            "Content-Type": "application/json",
            ]
        
        var mainURL:String!
        if(IsEdit){
           mainURL = modifyURL
        }
        else{
            mainURL = createContact
        }
        if openedActivties != nil {
            mainURL = modifyURL
        }
        print(mainURL)
        print(globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/create.json")
        
        let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        //        request.httpBody = postData as Data
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonParameter, options: []) {
            request.httpBody = jsonData
        }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            OperationQueue.main.addOperation {
//                SVProgressHUD.dismiss()
//                MBProgressHUD.hide(for: self.view, animated: true)

            }
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
                
                let jsonResponse:NSDictionary = (jsonObj as? NSDictionary)!
                print(jsonResponse)
                
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                        
                      
                        if let getDataObject:NSDictionary = jsonResponse["DataObject"] as? NSDictionary {
                            if let getID:String = getDataObject["Id"] as? String {
                                    print(getID)
                                   if(self.fieldContacts.text != ""){
                                        self.linkAddress(rightID: getID)
                                      }
                                        self.linkAppointmentUseres(rightID: getID)
                                        self.linkAppointmentCompanies(rightID:getID)
                                
                                    }
                            }
                      
                }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        print(responseMessage)
                        NavigationHelper.showSimpleAlert(message:responseMessage)
                    }
                }else{
                        NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
                
             
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
    }
    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tappedNewTask(_ sender: Any) {
        
        cancelBtn.isUserInteractionEnabled = false
        donelBtn.isUserInteractionEnabled = false
        
        var getPercentage:Int = 0
        let completeStr:String = fieldComplete.text!
        if completeStr.count > 0 {
            getPercentage = Int(fieldComplete.text!)!
        }
        let getStatus:String = fieldStatus.text!
        let formattedString = getStatus.replacingOccurrences(of: " ", with: "")
      
        if openedActivties != nil {
            let parameters = [
                "DataObject": [
                    "Description": fieldDescription.text!,
                    "DueTime": endTime,
                    "Location": fieldLocation.text!,
                    "PercentComplete": getPercentage,
                    "Priority": fieldPriority.text!,
                    "StartTime": startTime,
                    "Status": formattedString,
                    "Subject": fieldSubject.text!,
                    "Id":Id,
                    "RollOver":isRollOver
                ],
                "OrganizationId": currentOrgID,
                "ObjectName": "task",
                "PassKey": passKey
                ] as [String : Any]
            profileUpdateAlert(param: parameters)
            return
        }
       
        let parameters = [
            "DataObject": [
                "Description": fieldDescription.text!,
                "DueTime": endTime,
                "Location": fieldLocation.text!,
                "PercentComplete": getPercentage,
                "Priority": fieldPriority.text!,
                "StartTime": startTime,
                "Status": formattedString,
                "Subject": fieldSubject.text!,
                "RollOver":isRollOver
            ],
            "OrganizationId": currentOrgID,
            "ObjectName": "task",
            "PassKey": passKey
            ] as [String : Any]
        profileUpdateAlert(param: parameters)
       
    }
    func profileUpdateAlert(param:[String : Any]){
        let alert = UIAlertController(title: "Are you sure want to save the information?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.registerNewTask(jsonParameter: param)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
            self.cancelBtn.isUserInteractionEnabled = true
            self.donelBtn.isUserInteractionEnabled = true
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func linkAddress(rightID:String){
        
        if IsEdit {
            OperationQueue.main.addOperation {
                var Titles : String!
                if(self.AlertString == "delete"){
                    Titles = "Task Deleted Successfully"
                }
                else if(self.AlertString == "complete"){
                    Titles = "Task Completed Successfully"
                }
                else{
                   Titles = "Task Saved Successfully"
                }
                let alert = UIAlertController(title: Titles, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        if contactsIDList.count == 0 {
            if contactList.count > 0 {
                let getEachContact = contactList[0]
                let contactID:String = getEachContact.id
                let json: [String: Any] = ["ObjectName": "linker_tasks_contacts",
                                           "LeftId": rightID,
                                           "LeftObjectName": "task",
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
                                self.linkAddress(rightID: rightID)
                            }
                        }
                    }
                },  onFailure: { error in
                    OperationQueue.main.addOperation {
                        var Titles : String!
                        if(self.AlertString == "delete"){
                            Titles = "Task Deleted Successfully"
                        }
                        else if(self.AlertString == "complete"){
                            Titles = "Task Completed Successfully"
                        }
                        else{
                            Titles = "Task Saved Successfully"
                        }
                        let alert = UIAlertController(title: Titles, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    print(error.localizedDescription)
                    NavigationHelper.showSimpleAlert(message:error.localizedDescription)
                })
            }
            return
        }
        
        if contactsIDList.count > 0 {
            let json: [String: Any] = ["ObjectName": "linker_tasks_contacts",
                                       "LeftId": rightID,
                                       "LeftObjectName": "task",
                                       "RightId": contactsIDList[0],
                                       "RightObjectName": "contact",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    if(self.contactsIDList.count > 0){
                    self.contactsIDList.removeObject(at: 0)
                    }
                    if self.contactsIDList.count == 0 {
                        self.linkAppointmentUseres(rightID: rightID)
                    }else{
                        self.linkAddress(rightID: rightID)
                    }
                }
            },  onFailure: { error in
                OperationQueue.main.addOperation {
                    var Titles : String!
                    if(self.AlertString == "delete"){
                        Titles = "Task Deleted Successfully"
                    }
                    else if(self.AlertString == "complete"){
                        Titles = "Task Completed Successfully"
                    }
                    else{
                        Titles = "Task Saved Successfully"
                    }
                    let alert = UIAlertController(title: Titles, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
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
                
//                var RightObjectName:String = "contact"
                if fromAccounts {
                    contactID = linkParentID
//                    RightObjectName = "organization_user"
                }
                
                let json: [String: Any] = ["ObjectName": "linker_tasks_users",
                                           "LeftId": rightID,
                                           "LeftObjectName": "task",
                                           "RightId": contactID,
                                           "RightObjectName": "organization_user",
                                           "PassKey": passKey,
                                           "OrganizationId": currentOrgID]
                print(json)
                
//                let json: [String: Any] = ["ObjectName": "linker_appointments_users",
//                                           "LeftId": rightID,
//                                           "LeftObjectName": "appointment",
//                                           "RightId": contactID,
//                                           "RightObjectName": RightObjectName,
//                                           "PassKey": passKey,
//                                           "OrganizationId": currentOrgID]
//                print(json)
                
                APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                    DispatchQueue.main.async {
                        print(json)
                        if self.accountsIDList.count > 0 {
                            self.accountsIDList.removeObject(at: 0)
                        }
                        self.linkAppointmentCompanies(rightID: rightID)
                    }
                },  onFailure: { error in
                    OperationQueue.main.addOperation {
                        var Titles : String!
                        if(self.AlertString == "delete"){
                            Titles = "Task Deleted Successfully"
                        }
                        else if(self.AlertString == "complete"){
                            Titles = "Task Completed Successfully"
                        }
                        else{
                            Titles = "Task Saved Successfully"
                        }
                        let alert = UIAlertController(title: Titles, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    print(error.localizedDescription)
                    NavigationHelper.showSimpleAlert(message:error.localizedDescription)
                })
            }
            return
            
        }
        if teamMembersIDList.count > 0 {
            let json: [String: Any] = ["ObjectName": "linker_tasks_users",
                                       "LeftId": rightID,
                                       "LeftObjectName": "task",
                                       "RightId": teamMembersIDList[0],
                                       "RightObjectName": "organization_user",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    if(self.teamMembersIDList.count > 0){
                    self.teamMembersIDList.removeObject(at: 0)
                    }
                    self.linkAppointmentUseres(rightID: rightID)
                }
            },  onFailure: { error in
                OperationQueue.main.addOperation {
                    var Titles : String!
                    if(self.AlertString == "delete"){
                        Titles = "Task Deleted Successfully"
                    }
                    else if(self.AlertString == "complete"){
                        Titles = "Task Completed Successfully"
                    }
                    else{
                        Titles = "Task Saved Successfully"
                    }
                    let alert = UIAlertController(title: Titles, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
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
                
                let json: [String: Any] = ["ObjectName": "linker_tasks_companies",
                                           "LeftId": rightID,
                                           "LeftObjectName": "task",
                                           "RightId": contactID,
                                           "RightObjectName": "company",
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
                            var Titles : String!
                            if(self.AlertString == "delete"){
                                Titles = "Task Deleted Successfully"
                            }
                            else if(self.AlertString == "complete"){
                                Titles = "Task Completed Successfully"
                            }
                            else{
                                Titles = "Task Saved Successfully"
                            }
                            let alert = UIAlertController(title: Titles, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                },  onFailure: { error in
                    OperationQueue.main.addOperation {
                        var Titles : String!
                        if(self.AlertString == "delete"){
                            Titles = "Task Deleted Successfully"
                        }
                        else if(self.AlertString == "complete"){
                            Titles = "Task Completed Successfully"
                        }
                        else{
                            Titles = "Task Saved Successfully"
                        }
                        let alert = UIAlertController(title: Titles, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    print(error.localizedDescription)
                    NavigationHelper.showSimpleAlert(message:error.localizedDescription)
                })
            }
            return
            
        }
        
        if accountsIDList.count > 0 {
            let json: [String: Any] = ["ObjectName": "linker_tasks_companies",
                                       "LeftId": rightID,
                                       "LeftObjectName": "task",
                                       "RightId": accountsIDList[0],
                                       "RightObjectName": "company",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    if(self.accountsIDList.count > 0){
                    self.accountsIDList.removeObject(at: 0)
                    }
                    self.linkAppointmentCompanies(rightID: rightID)
                }
            },  onFailure: { error in
                OperationQueue.main.addOperation {
                    var Titles : String!
                    if(self.AlertString == "delete"){
                        Titles = "Task Deleted Successfully"
                    }
                    else if(self.AlertString == "complete"){
                        Titles = "Task Completed Successfully"
                    }
                    else{
                        Titles = "Task Saved Successfully"
                    }
                    let alert = UIAlertController(title: Titles, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }else{
            OperationQueue.main.addOperation {
                var Titles : String!
                if(self.AlertString == "delete"){
                    Titles = "Task Deleted Successfully"
                }
                else if(self.AlertString == "complete"){
                    Titles = "Task Completed Successfully"
                }
                else{
                    Titles = "Task Saved Successfully"
                }
                let alert = UIAlertController(title: Titles, message: nil, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: InitailGetAccounts,Teammbers and cnontacts list
    func getLinkerAccounts(){
        
        let parameters = [
            "ObjectName": "linker_tasks_companies",
            "LinkParentId": Id,
            "ListObjectName": "company",
            "OrganizationId": currentOrgID,
            "PassKey": passKey,
            "PageOffset":1,
            "ResultsPerPage":1000
            ] as [String : Any]
        print(parameters)
        let request = NSMutableURLRequest(url: NSURL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listLinked.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 30.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
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
                
                
                let getModel = getAccountsModel.init(fromDictionary: jsonObj as! NSDictionary)
                print(getModel.responseMessage)
                
                self.selectedCompanies = []
                self.linkedAccountsIDList = []
                
                let tempResultID:NSMutableArray = []
                self.getTeamAccoun = []
                for index in 0..<getModel.results.count {
                    let getResult = getModel.results[index]
                    print(getResult.name)
                    tempResultID.add(getResult.id)
                    self.linkedAccountsIDList.add(getResult.id)

                    self.getTeamAccoun.append(getResult.name)
                }
                let tempContactID:NSMutableArray = []
                for index in 0..<self.accountsList.count {
                    let list = self.accountsList[index]
                    tempContactID.add(list.id)
                }
                for index in 0..<tempResultID.count {
                    let contID:String = tempResultID[index] as! String
                    if tempContactID.contains(contID) {
                        let getPath:Int = tempContactID.index(of: contID)
                        self.selectedCompanies.add(getPath)
                    }
                }
                if self.getTeamAccoun.count > 0 {
                    let stringRepresentation = self.getTeamAccoun.joined(separator: ", ")// "1-2-3"
                    self.fieldChooseAccounts.text = stringRepresentation
                }else{
                    //self.fieldChooseAccounts.text = ""
                }
                
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
    }
    func getLinkerUsers(){
        let parameters = [
            "ObjectName": "linker_tasks_users",
            "LinkParentId": Id,//openedActivties.activity.id,
            "ListObjectName": "organization_user",
            "OrganizationId": currentOrgID,
            "PassKey": passKey,
            "PageOffset":1,
            "ResultsPerPage":1000
            ] as [String : Any]
        print(parameters)
        let request = NSMutableURLRequest(url: NSURL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listLinked.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 30.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            self.getLinkerAccounts()
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
                
                
                let getModel = getLinkedMembersModel.init(fromDictionary: jsonObj as! NSDictionary)
                print(getModel.responseMessage)
                
                self.selectedTeamMembers = []
                self.linkedTeamMemberIDList = []

                
                let tempResultID:NSMutableArray = []
                self.getTeammem = []
                for index in 0..<getModel.results.count {
                    let getResult = getModel.results[index]
                    print(getResult.fullName)
                    tempResultID.add(getResult.id)
                    self.linkedTeamMemberIDList.add(getResult.id)

                    self.getTeammem.append(getResult.fullName)
                }
                
                let tempContactID:NSMutableArray = []
                for index in 0..<self.teamMembers.count {
                    let list = self.teamMembers[index]
                    tempContactID.add(list.id)
                }
                for index in 0..<tempResultID.count {
                    let contID:String = tempResultID[index] as! String
                    if tempContactID.contains(contID) {
                        let getPath:Int = tempContactID.index(of: contID)
                        self.selectedTeamMembers.add(getPath)
                    }
                }
                
                if self.getTeammem.count > 0 {
                    let stringRepresentation = self.getTeammem.joined(separator: ", ")// "1-2-3"
                    self.fieldChooseTeam.text = stringRepresentation
                }else{
                }
                
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
    }
    func getListlinkedAccounts(){
        
        let parameters = [
            "ObjectName": "linker_tasks_contacts",
            "LinkParentId": Id,
            "ListObjectName": "contact",
            "OrganizationId": currentOrgID,
            "PassKey": passKey,
            "PageOffset":1,
            "ResultsPerPage":1000
            ] as [String : Any]
        print(parameters)
        let request = NSMutableURLRequest(url: NSURL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listLinked.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 30.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            self.getLinkerUsers()
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
                
                self.selectedContacts = []
                self.linkedContactIDList = []

                let getModel = getLinkedAccountsModel.init(fromDictionary: jsonObj as! NSDictionary)
                print(getModel.responseMessage)
                let tempResultID:NSMutableArray = []

                
                self.getTeamContac = []
                for index in 0..<getModel.results.count {
                    let getResult = getModel.results[index]
                    print(getResult.fullName)
                    tempResultID.add(getResult.id)
                    self.linkedContactIDList.add(getResult.id)
                    self.getTeamContac.append(getResult.fullName)
                }
                
                let tempContactID:NSMutableArray = []
                for index in 0..<self.contactList.count {
                    let list = self.contactList[index]
                    tempContactID.add(list.id)
                }
                for index in 0..<tempResultID.count {
                    let contID:String = tempResultID[index] as! String
                    if tempContactID.contains(contID) {
                        let getPath:Int = tempContactID.index(of: contID)
                        self.selectedContacts.add(getPath)
                    }
                }
                
                if self.getTeamContac.count > 0 {
                    let stringRepresentation = self.getTeamContac.joined(separator: ", ")// "1-2-3"
                    self.fieldContacts.text = stringRepresentation
                }else{
                   // self.fieldContacts.text = ""
                }
                
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
        
    }
    
    @IBAction func tappedRollOver(_ sender: Any) {
        if isRollOver == false {
            isRollOver = true
            btnRollOver.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            isRollOver = false
            btnRollOver.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
        }
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
extension NewTaskController: CZPickerViewDelegate, CZPickerViewDataSource {
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
            if getContact.fullName.count == 0 {
                 return getContact.firstName + " " + getContact.lastName
            }
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
            fieldContacts.text = getContact.fullName
        }else if pickerView.tag == 1 {
            let getContact = teamMembers[row]
            if getContact.fullName.count == 0 {
                fieldChooseTeam.text = getContact.firstName + " " + getContact.lastName
            }else{
                fieldChooseTeam.text = getContact.fullName
            }
        }else if pickerView.tag == 2 {
            let getContact = accountsList[row]
            fieldChooseAccounts.text = getContact.name
        }
    }
    
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)        setupBottomView()
        if(IsEdit){
        setupBottomViewEdit()
        }
        else {
        setupBottomView()
        }

        
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
        if(IsEdit){
            setupBottomViewEdit()
        }
        else {
            setupBottomView()
        }
       
        if pickerView.tag == 0 {
            self.selectedContacts = []

            var selectedContacts:[String] = []
            contactsIDList = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = contactList[row]
                    print(getContact.fullName)
                    contactsIDList.add(getContact.id)
                    selectedContacts.append(getContact.fullName)
                    self.selectedContacts.add(row)

                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldContacts.text = stringRepresentation
            }else{
                self.fieldContacts.text = ""
            }
//            if openedActivties != nil {
//                setupLinkedContacts()
//            }
            if IsEdit {
                setupLinkedContacts()
            }

        }else if pickerView.tag == 1 {
            self.selectedTeamMembers = []

            teamMembersIDList = []
            var selectedContacts:[String] = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = teamMembers[row]
                    print(getContact.fullName)
                    teamMembersIDList.add(getContact.id)
                    selectedContacts.append(getContact.fullName)
                    self.selectedTeamMembers.add(row)

                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseTeam.text = stringRepresentation
            }else{
                self.fieldChooseTeam.text = ""
            }
//            if openedActivties != nil {
//                setupLinkedTeamMembers()
//            }
            if IsEdit{
                setupLinkedTeamMembers()
            }

        }else if pickerView.tag == 2 {
            self.selectedCompanies = []

            accountsIDList = []
            var selectedContacts:[String] = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = accountsList[row]
                    print(getContact.name)
                    accountsIDList.add(getContact.id)
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
            if IsEdit {
                setupLinkedAccounts()
            }
//            if openedActivties != nil {
//                setupLinkedAccounts()
//            }
        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, withoutBool value: Bool) {
        if(IsEdit){
            setupBottomViewEdit()
        }
        else {
            setupBottomView()
        }
        if(!value) {
        if pickerView.tag == 0 {
            if rows.count == 0 {
                print("o rows")
                self.fieldContacts.text = ""
                if IsEdit {
                    setupLinkedTeamMembers()
                }
                self.selectedContacts = []
                contactsIDList = []
                return
            }
            self.selectedContacts = []
            
            var selectedContacts:[String] = []
            contactsIDList = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = contactList[row]
                    print(getContact.fullName)
                    contactsIDList.add(getContact.id)
                    selectedContacts.append(getContact.fullName)
                    self.selectedContacts.add(row)
                    
                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldContacts.text = stringRepresentation
            }else{
                self.fieldContacts.text = ""
            }
            if IsEdit {
                setupLinkedContacts()
            }
        }else if pickerView.tag == 1 {
            if rows.count == 0 {
                print("o rows")
                self.fieldChooseTeam.text = ""
                if IsEdit {
                    setupLinkedTeamMembers()
                }
                self.selectedTeamMembers = []
                teamMembersIDList = []
                return
            }
            self.selectedTeamMembers = []
            
            teamMembersIDList = []
            var selectedContacts:[String] = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = teamMembers[row]
                    print(getContact.fullName)
                    teamMembersIDList.add(getContact.id)
                    selectedContacts.append(getContact.fullName)
                    self.selectedTeamMembers.add(row)
                    
                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseTeam.text = stringRepresentation
            }else{
                self.fieldChooseTeam.text = ""
            }
            if IsEdit {
                setupLinkedTeamMembers()
            }
        }else if pickerView.tag == 2 {
            if rows.count == 0 {
                print("o rows")
                self.fieldChooseAccounts.text = ""
                if IsEdit {
                    setupLinkedAccounts()
                }
                self.selectedCompanies = []
                accountsIDList = []
                return
            }
            self.selectedCompanies = []
            
            accountsIDList = []
            var selectedContacts:[String] = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = accountsList[row]
                    print(getContact.name)
                    accountsIDList.add(getContact.id)
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
            if IsEdit {
                setupLinkedAccounts()
            }
        }
    }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, with value: Bool, arrayvalue array: NSMutableArray!) {
        if(IsEdit){
            setupBottomViewEdit()
        }
        else {
            setupBottomView()
        }
        if(value) {
        if pickerView.tag == 0 {
            self.selectedContacts = []
            
            var selectedContacts:[String] = []
            contactsIDList = []
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
                self.fieldContacts.text = stringRepresentation
            }else{
                //self.fieldContacts.text = ""
            }
            if IsEdit {
                setupLinkedContacts()
            }
        }else if pickerView.tag == 1 {
            self.selectedTeamMembers = []
            
            teamMembersIDList = []
            var selectedContacts:[String] = []
//            for row in rows {
//                if let row = row as? Int {
//                    let getContact = array[row]
//                    print(getContact)
//                    teamMembersIDList.add(getContact)
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
                self.fieldChooseTeam.text = stringRepresentation
            }else{
            }
            if IsEdit {
                setupLinkedTeamMembers()
            }
        }else if pickerView.tag == 2 {
            self.selectedCompanies = []
            
            accountsIDList = []
            var selectedContacts:[String] = []
//            for row in rows {
//                if let row = row as? Int {
//                    let getContact = array[row]
//                    print(getContact)
//                    accountsIDList.add(getContact)
//                    selectedContacts.append(getContact as! String)
//                    self.selectedCompanies.add(row)
//                    //accountsIDList
//                    //selectedCompanies
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
               // self.fieldChooseAccounts.text = ""
            }
            if IsEdit {
                setupLinkedAccounts()
            }
        }
        }
    }
  
    
    //MARK:- Update Contacts
    
    func setupLinkedContacts(){
        let allContactID:NSMutableArray = []
        
        for index in 0..<contactList.count {
            let getContact = contactList[index]
            allContactID.add(getContact.id)
        }
        
        let addUsersList:NSMutableArray = []
        
        for index in 0..<contactsIDList.count {
            if allContactID.contains(contactsIDList[index]) {
                addUsersList.add(contactsIDList[index])
            }
        }
        
        let removeIDList:NSMutableArray = []
        
        for index in 0..<linkedContactIDList.count {
            let user = linkedContactIDList[index]
            if addUsersList.contains(user) {
                
            }else{
                removeIDList.add(user)
            }
        }
        
        let addUserToContact:NSMutableArray = []
        for index in 0..<addUsersList.count {
            let selectedUser = addUsersList[index]
            if !linkedContactIDList.contains(selectedUser) {
                addUserToContact.add(selectedUser)
            }
        }
        removeUpdatedLink(contactListID: removeIDList, addContactListID: addUserToContact)
    }
    
    func removeUpdatedLink(contactListID:NSMutableArray,addContactListID:NSMutableArray){
        if contactListID.count > 0 {
            let leftIDD:String = Id //openedActivties.activity.id!
            let json: [String: Any] = ["ObjectName": "linker_tasks_contacts",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "task",
                                       "RightId": contactListID[0],
                                       "RightObjectName": "contact",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: removeLinkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    if(contactListID.count > 0){
                    contactListID.removeObject(at: 0)
                    }
                    self.removeUpdatedLink(contactListID: contactListID, addContactListID: addContactListID)
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }else if addContactListID.count > 0{
            let leftIDD:String = Id//openedActivties.activity.id!
            
            let json: [String: Any] = ["ObjectName": "linker_tasks_contacts",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "task",
                                       "RightId": addContactListID[0],
                                       "RightObjectName": "contact",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                     if(addContactListID.count > 0){
                    addContactListID.removeObject(at: 0)
                    }
                    self.removeUpdatedLink(contactListID: contactListID, addContactListID: addContactListID)
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }
    }
    
    
    //MARK:- Update Team Members
    
    
    func setupLinkedTeamMembers(){
        let allContactID:NSMutableArray = []
        
        for index in 0..<teamMembers.count {
            let getContact = teamMembers[index]
            allContactID.add(getContact.id)
        }
        
        let addUsersList:NSMutableArray = []
        
        for index in 0..<teamMembersIDList.count {
            if allContactID.contains(teamMembersIDList[index]) {
                addUsersList.add(teamMembersIDList[index])
            }
        }
        
        let removeIDList:NSMutableArray = []
        
        for index in 0..<linkedTeamMemberIDList.count {
            let user = linkedTeamMemberIDList[index]
            if addUsersList.contains(user) {
                
            }else{
                removeIDList.add(user)
            }
        }
        
        let addUserToContact:NSMutableArray = []
        for index in 0..<addUsersList.count {
            let selectedUser = addUsersList[index]
            if !linkedTeamMemberIDList.contains(selectedUser) {
                addUserToContact.add(selectedUser)
            }
        }
        removeUpdatedteamLink(contactListID: removeIDList, addContactListID: addUserToContact)
    }
    
    func removeUpdatedteamLink(contactListID:NSMutableArray,addContactListID:NSMutableArray){
        if contactListID.count > 0 {
            let leftIDD:String = Id//openedActivties.activity.id!
            let json: [String: Any] = ["ObjectName": "linker_tasks_users",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "task",
                                       "RightId": contactListID[0],
                                       "RightObjectName": "organization_user",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: removeLinkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    if(contactListID.count > 0){
                    contactListID.removeObject(at: 0)
                    }
                    self.removeUpdatedteamLink(contactListID: contactListID, addContactListID: addContactListID)
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }else if addContactListID.count > 0{
            let leftIDD:String = Id//openedActivties.activity.id!
            
            let json: [String: Any] = ["ObjectName": "linker_tasks_users",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "task",
                                       "RightId": addContactListID[0],
                                       "RightObjectName": "organization_user",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                     if(addContactListID.count > 0){
                    addContactListID.removeObject(at: 0)
                    }
                    self.removeUpdatedteamLink(contactListID: contactListID, addContactListID: addContactListID)
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }
    }
    
    //MARK:- Update Accounts
    
    func setupLinkedAccounts(){
        let allContactID:NSMutableArray = []
        
        for index in 0..<accountsList.count {
            let getContact = accountsList[index]
            allContactID.add(getContact.id)
        }
        
        let addUsersList:NSMutableArray = []
        
        for index in 0..<accountsIDList.count {
            if allContactID.contains(accountsIDList[index]) {
                addUsersList.add(accountsIDList[index])
            }
        }
        
        let removeIDList:NSMutableArray = []
        
        for index in 0..<linkedAccountsIDList.count {
            let user = linkedAccountsIDList[index]
            if addUsersList.contains(user) {
                
            }else{
                removeIDList.add(user)
            }
        }
        
        let addUserToContact:NSMutableArray = []
        for index in 0..<addUsersList.count {
            let selectedUser = addUsersList[index]
            if !linkedAccountsIDList.contains(selectedUser) {
                addUserToContact.add(selectedUser)
            }
        }
        removeUpdatedAccountsLink(contactListID: removeIDList, addContactListID: addUserToContact)
    }
    
    func removeUpdatedAccountsLink(contactListID:NSMutableArray,addContactListID:NSMutableArray){
        if contactListID.count > 0 {
            let leftIDD:String = Id//openedActivties.activity.id!
            let json: [String: Any] = ["ObjectName": "linker_tasks_companies",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "task",
                                       "RightId": contactListID[0],
                                       "RightObjectName": "company",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: removeLinkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                     if(contactListID.count > 0){
                    contactListID.removeObject(at: 0)
                    }
                    self.removeUpdatedAccountsLink(contactListID: contactListID, addContactListID: addContactListID)
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }else if addContactListID.count > 0{
            let leftIDD:String = Id//openedActivties.activity.id!
            
            let json: [String: Any] = ["ObjectName": "linker_tasks_companies",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "task",
                                       "RightId": addContactListID[0],
                                       "RightObjectName": "company",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                     if(addContactListID.count > 0){
                    addContactListID.removeObject(at: 0)
                    }
                    self.removeUpdatedAccountsLink(contactListID: contactListID, addContactListID: addContactListID)
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }
    }
    
}
extension NewTaskController:UITextFieldDelegate {
    
    
    
    func showContactsPicker(){
        let picker = CZPickerView(headerTitle: "Contacts", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        if selectedContacts.count > 0 {
            picker?.setSelectedRows(selectedContacts as! [Any])
        }else {
            if IsEdit && self.fieldContacts.text!.count > 0 {
                let combineString = self.fieldContacts.text!.components(separatedBy: ",")
                self.selectedContacts = []
                                contactsIDList = []
                for row in 0..<contactList.count {
                    let getContact = contactList[row]
                    if self.getTeamContac.contains(getContact.fullName) {
                        self.selectedContacts.add(row)
                    }
                }
            }else if (self.fieldContacts.text?.count)! > 0 {
                self.selectedContacts = []
                for index in 0..<self.contactList.count {
                    let getID = self.contactList[index].id
                    if self.contactsIDList.contains(getID!) {
                        self.selectedContacts.add(index)
                    }
                }
            }
            picker?.setSelectedRows(selectedContacts as! [Any])
        }
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
        }else {
            if IsEdit && self.fieldChooseTeam.text!.count > 0 {
                let combineString = self.fieldChooseTeam.text!.components(separatedBy: ",")
                self.selectedTeamMembers = []
                contactsIDList = []
                for row in 0..<teamMembers.count {
                    let getContact = teamMembers[row]
                    if self.getTeammem.contains(getContact.fullName) {
                        self.selectedTeamMembers.add(row)
                    }
                }
            }else if (self.fieldChooseTeam.text?.count)! > 0 {
                self.selectedTeamMembers = []
                for index in 0..<self.teamMembers.count {
                    let getID = self.teamMembers[index].id
                    if self.teamMembersIDList.contains(getID!) {
                        //                    let getContact = self.teamMembers[index]
                        self.selectedTeamMembers.add(index)
                    }
                }
            }
            picker?.setSelectedRows(selectedTeamMembers as! [Any])
        }
        //        picker?.setSelectedRows(selectedContacts as! [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1
        picker?.show()
    }
    //accountsIDList
    //selectedCompanies
    
    func showAccountsPicker(){
        let picker = CZPickerView(headerTitle: "Accounts", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        if selectedCompanies.count > 0 {
            picker?.setSelectedRows(selectedCompanies as! [Any])
        }else {
            if IsEdit && self.fieldChooseAccounts.text!.count > 0 {
                let combineString = self.fieldChooseAccounts.text!.components(separatedBy: ",")
                self.selectedCompanies = []
                for row in 0..<accountsList.count {
                    let getContact = accountsList[row]
                    if self.getTeamAccoun.contains(getContact.name) {
                        self.selectedCompanies.add(row)
                    }
                }
            }else if (self.fieldChooseAccounts.text?.count)! > 0 {
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
            picker?.setSelectedRows(selectedCompanies as! [Any])
        }
        //        picker?.setSelectedRows(selectedContacts as! [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 2
        picker?.show()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.removeBottomView()
        if textField == fieldContacts {
            textField.resignFirstResponder()
            showContactsPicker()
            return false
        }else if textField == fieldChooseTeam {
            textField.resignFirstResponder()
            showTeamMembers()
            return false
        }else if textField == fieldChooseAccounts {
            textField.resignFirstResponder()
            showAccountsPicker()
            return false
        }else if textField == fieldDueTime {
            textField.resignFirstResponder()
            // Time Picker (custom picker)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let getDate = formatter.date(from: fieldStartTime.text!)
            
            let calendar = Calendar.current
            
            DPPickerManager.shared.showPicker(title: "End Time", picker: { (picker) in
                picker.date = Date()
              //  picker.minimumDate = date
                picker.datePickerMode = .date
                
            }) { (date, cancel) in
                if(self.IsEdit){
                    self.setupBottomViewEdit()
                }
                else {
                    self.setupBottomView()
                }

                if !cancel {
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.fieldDueTime.text = formatter.string(from: date!)
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.endTime = formatter.string(from: date!)
                    
                    // TODO: you code here
                    //                    debugPrint(date as Any)
                }
            }
            return false
        }
        else if textField == DuetimeTask {
            textField.resignFirstResponder()
            if StartTimetask.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message:"Please Choose Start Time")
                return true
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            let getDate = formatter.date(from: StartTimetask.text!)
            
            let calendar = Calendar.current
            // Time Picker (custom picker)
            DPPickerManager.shared.showPicker(title: "End Time", picker: { (picker) in
                
                picker.datePickerMode = .time
                picker.minuteInterval = 15
                if((self.DuetimeTask.text?.count)! > 0) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    picker.date = formatter.date(from: self.DuetimeTask.text!)!
                }
                //                picker.date = Date()
                
                
            }) { (date, cancel) in
                if(self.IsEdit){
                    self.setupBottomViewEdit()
                }
                else{
                self.setupBottomView()
                }
                if !cancel {
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    self.DuetimeTask.text = formatter.string(from: date!)
                    
                }
            }
            return true
        }else if textField == fieldStartTime {
            textField.resignFirstResponder()
            // Time Picker (custom picker)
            DPPickerManager.shared.showPicker(title: "Start Time", picker: { (picker) in
                picker.date = Date()
                picker.datePickerMode = .date
               // picker.minuteInterval = 30
            }) { (date, cancel) in
                if(self.IsEdit){
                    self.setupBottomViewEdit()
                }
                else {
                    self.setupBottomView()
                }
                if !cancel {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.fieldStartTime.text = formatter.string(from: date!)
                    
                    let startdate = formatter.string(from: date!)
                    let startdatetime = startdate + " " + self.StartTimetask.text!
                    print(startdatetime)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                    let dates = dateFormatter.date(from:startdatetime)!
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.startTime = formatter.string(from: dates)
                    
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.fieldDueTime.text = formatter.string(from: dates)
                    
                    let enddate = formatter.string(from: date!)
                    let enddatetime = enddate + " " + self.DuetimeTask.text!
                    print(enddatetime)
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "yyyy-MM-dd hh:mm a"
                    let enddates = dateFormatter1.date(from:enddatetime)!
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.endTime = formatter.string(from:enddates)

                }
            }
            return false
        }
        else if textField == StartTimetask {
            textField.resignFirstResponder()
            // Time Picker (custom picker)
            DPPickerManager.shared.showPicker(title: "Start Time", picker: { (picker) in
                picker.datePickerMode = .time
                picker.minuteInterval = 15
                if((self.StartTimetask.text?.count)! > 0) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    picker.date = formatter.date(from: self.StartTimetask.text!)!
                }
                //                picker.date = Date()
               
            }) { (date, cancel) in
                if(self.IsEdit){
                    self.setupBottomViewEdit()
                }
                else{
                    self.setupBottomView()
                }
                
                if !cancel {
                    self.DuetimeTask.text = ""
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    self.StartTimetask.text = formatter.string(from: date!)
                    
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .hour, value: 1, to: date!)
                    formatter.dateFormat = "hh:mm a"
                    self.DuetimeTask.text = formatter.string(from: date!)
                    
                    if(self.fieldStartTime.text != ""){
                        let start = self.fieldStartTime.text!
                        let startdatetime = start + " " + self.StartTimetask.text!
                        print(startdatetime)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                        let dates = dateFormatter.date(from:startdatetime)!
                        
                        formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        self.startTime = formatter.string(from: dates)
                    }
                    
                    let start = self.fieldDueTime.text!
                    let startdatetime = start + " " + self.DuetimeTask.text!
                    print(startdatetime)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                    let dates = dateFormatter.date(from:startdatetime)!
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.endTime = formatter.string(from: dates)
                }
            }
            return true
        }else if textField == fieldPriority {
            textField.resignFirstResponder()
            // Strings Picker
            let values = ["Low", "Normal", "High"]
            DPPickerManager.shared.showPicker(title: "Priority", selected: "", strings: values) { (value, index, cancel) in
                if(self.IsEdit){
                    self.setupBottomViewEdit()
                }
                else {
                    self.setupBottomView()
                }
                if !cancel {
                    self.fieldPriority.text = value
                    // TODO: you code here
                    debugPrint(value as Any)
                }
            }
            return false
        }else if textField == fieldStatus {
            textField.resignFirstResponder()
            // Strings Picker
            let values = ["Not Started", "In Progress", "Completed", "Waiting On Someone Else", "Deferred"]
            DPPickerManager.shared.showPicker(title: "Status", selected: "", strings: values) { (value, index, cancel) in
                if(self.IsEdit){
                    self.setupBottomViewEdit()
                }
                else {
                    self.setupBottomView()
                }

                if !cancel {
                    self.fieldStatus.text = value
                    // TODO: you code here
                    debugPrint(value as Any)
                }
            }
            return false
        }
        if(IsEdit){
            setupBottomViewEdit()
        }
        else {
            setupBottomView()
        }

        return true
    }
}
extension NewTaskController:URLSessionDelegate {
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


