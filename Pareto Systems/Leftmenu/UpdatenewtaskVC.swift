//
//  UpdatenewtaskVC.swift
//  Blue Square
//
//  Created by Tecnovators on 21/07/21.
//  Copyright © 2021 VividInfotech. All rights reserved.
//

import UIKit
import MobileCoreServices

class UpdatenewtaskVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var fromAccounts:Bool = false
    var selectedContactIndx:NSMutableArray = []

    @IBOutlet weak var DuetimeTask: ACFloatingTextfield!
    @IBOutlet weak var StartTimetask: ACFloatingTextfield!
    var noteheightArray : NSMutableArray = []
    var sum = 0
    var  deleteTaskobbj : DeleteModal!
    // note values
    @IBOutlet weak var Viewheightconstant: NSLayoutConstraint!
    var contactTypes:NSArray = ["Appointment","Contact","Company","Task"]
    static let regardingnotify = "regardingnotify"
    static let attachdownnotify = "attachdownnotify"
    static let accountregardingnotify = "accountregardingnotify"
    static let taskregardingnotify = "taskregardingnotify"
    static let appointementregardingnotify = "appointementregardingnotify"
    static let commentTasknotify = "commentTasknotify"

    @IBOutlet weak var notestblview: UITableView!
    var selectedNoteID : String = ""
    var isExpand:Bool = false
    var isNoteCellPresent : Bool = false
    var noteheight : CGFloat = 0
    var globalRegType : String = ""
    var  notedata : [NoteList] = []
    var  noteobj : NoteModel!
    var  noteregardingData : [Any] = []
    var  noteattachmentData : [Any] = []
    var  notecommentData : [Any] = []
    var allcommentExpandArray : [Int] = []
    var iscommentapimethod : Bool = false
    var selectedIndexPath_condition:Int = 0
    var selectedIndexPath:Int = 1992001
    var selectedNoteIndx : Int = -1
    var globalCommentCount : Int = 0
    var iscommentExpand:Bool = false
    var taskmodelobj : Taskmodel!
    var appointmentList : GetAppointmentModelModel!
    var importaccountList:[GetAccountsListResult] = []
    var searchCurrNoteid : String!
    var allregardingname : [ContactListResult] = []
    var allaccountregardingname : [GetAccountsListResult] = []
    var allTaskregardingSubject : [TaskResult] = []
    var allAppointmentregardingSubject : [GetAppointmentModelData] = []
    var usersList:[UserlistUser] = []
    var selectedContactsList:[String] = []
    var selectedAppointmentList:[String] = []
    var selectedTaskList:[String] = []
    var allcreatedRegardingID  : [String] = []
    var allregardingObjectID : [String] = []
    var tappedContact:Bool = true
    var selectedContactWholeValue:[String] = []
    
    
    
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
    var isSeries: Bool = false
    var patternobbj : PatterID!
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
        notestblview.register(UINib(nibName: "NoteHeaderCell", bundle: nil), forCellReuseIdentifier: "NoteHeaderCell")
        notestblview.register(UINib(nibName: "NotesListCell", bundle: nil), forCellReuseIdentifier: "NotesListCell")
        self.notestblview.delegate = self
        self.notestblview.dataSource = self
        fieldChooseAccounts.text = accountname
        self.getTask()
        self.getAppointments()
        self.listOfUsersBasedOnOrganization()
        if(Editvalue == "edit"){
            navigationItem.title = "Edit Task"
            self.notestblview.isHidden = false
        }else{
            self.notestblview.isHidden = true
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
        if(RecurringActivityId != nil){
        self.getRecurrencePatternID()
        }
        // Do any additional setup after loading the view.
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
    //MARK: - Comment Action
    @objc func CommentApiMethod(notfication: NSNotification)
    {
        let cmtMsg = notfication.userInfo?["msg"] as? String
        let json: [String: Any] = ["ObjectName":"note_comment",
                                   "DataObject": [
                                    "NoteId": self.selectedNoteID,
                                    "Comment": cmtMsg],
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey] as [String : Any]
        
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                self.iscommentapimethod = true
                self.PullDownAllCommentsFromServer()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    //MARK: - Get All Note Related Api
    func pullNotesListFromServerApi()
    {
        self.notedata.removeAll()
        self.allcommentExpandArray.removeAll()

            let json: [String: Any] = ["OrderBy":"CreatedOn",
                                       "AscendingOrder":false,
                                       "ResultsPerPage":100,
                                       "PageOffset":1,
                                       "ParentId":Id,
                                       "ObjectName":"task",
                                       "PassKey":passKey,
                                       "OrganizationId":currentOrgID]
            OperationQueue.main.addOperation {
                SVProgressHUD.show()
            }
            let url = URL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listNotes.json")!
            var request = URLRequest(url: url)
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.addValue("en", forHTTPHeaderField: "Accept-Language")
            request.httpMethod = "POST"
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
                request.httpBody = jsonData
            }
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            let task = session.dataTask(with: request){ data, response, error in
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                    self.noteobj = try? JSONDecoder().decode(NoteModel.self, from: data)
                    if(self.noteobj.totalResults != 0){
                    self.notedata =  self.noteobj.notedata!
                    for(_,_) in self.notedata.enumerated()
                    {
                        self.allcommentExpandArray.append(0)
                    }
                    self.PullDownAllNoteRegardingsFromServer()
                    self.PullDownAllCommentsFromServer()
                    }
                }
            }
            task.resume()
        
    }
    //MARK: - PullDownAllNoteRegardingsFromServer
    func PullDownAllNoteRegardingsFromServer()
    {
        self.noteregardingData.removeAll()
        for(index,element) in self.notedata.enumerated()
        {
            let json: [String: Any] = [
                "ParentId":element.note?.id,
                "ParentObjectName":"note",
                "ObjectName": "notes_regarding",
                "PassKey":passKey,
                "OrganizationId":currentOrgID,
                "AscendingOrder":true]
            
            OperationQueue.main.addOperation {
                SVProgressHUD.show()
            }
            let url = URL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json")!
            var request = URLRequest(url: url)
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.addValue("en", forHTTPHeaderField: "Accept-Language")
            request.httpMethod = "POST"
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
                request.httpBody = jsonData
            }
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            let task = session.dataTask(with: request){ data, response, error in
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                    let reobj = try? JSONDecoder().decode(NoteRegardingModel.self, from: data)
                    self.noteregardingData.append(reobj?.regardingobj)
                    DispatchQueue.main.async {
                        self.notestblview.reloadData()
                    }
                    if(index == self.notedata.count - 1)
                    {
                        self.PullDownAllNoteAttachmentFromServer()
                    }
                }
            }
            task.resume()
            
        }
    }
    //MARK: - PullDownAllNoteAttachmentFromServer
    func PullDownAllNoteAttachmentFromServer()
    {
        self.noteattachmentData.removeAll()
        for(index,element) in self.notedata.enumerated()
        {
            let json: [String: Any] = [
                "ParentId":element.note?.id as? String,
                "ParentObjectName":"note",
                "ObjectName": "note_attachment",
                "PassKey":passKey,
                "OrganizationId":currentOrgID,
                "AscendingOrder":true]
            let url = URL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json")!
            var request = URLRequest(url: url)
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.addValue("en", forHTTPHeaderField: "Accept-Language")
            request.httpMethod = "POST"
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
                request.httpBody = jsonData
            }
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            let task = session.dataTask(with: request){ data, response, error in
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                    let reobj = try? JSONDecoder().decode(NoteRegardingModel.self, from: data)
                    if((reobj?.regardingobj!.count)! > 0){
                        self.noteattachmentData.append(reobj?.regardingobj!)
                    }
                }
            }
            task.resume()
            
        }
    }
    //MARK: - PullDownAllCommentsFromServer
    func PullDownAllCommentsFromServer()
    {
        self.notecommentData.removeAll()
        for(index,element) in self.notedata.enumerated()
        {
            let json: [String: Any] = [
                "ParentId":element.note?.id as? String,
                "ParentObjectName":"note",
                "ObjectName": "note_comment",
                "PageOffset":1,
                "ResultsPerPage":100,
                "OrderBy":"CreatedOn",
                "PassKey":passKey,
                "OrganizationId":currentOrgID,
                "AscendingOrder":false]
            let url = URL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json")!
            var request = URLRequest(url: url)
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.addValue("en", forHTTPHeaderField: "Accept-Language")
            request.httpMethod = "POST"
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
                request.httpBody = jsonData
            }
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            let task = session.dataTask(with: request){ data, response, error in
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                    if(index == self.notedata.count - 1){
                    if(self.iscommentapimethod)
                    {
                        self.iscommentapimethod = false
                        DispatchQueue.main.async {
                            self.notestblview.reloadData()
                        }
                       
                    }}
                    let reobj = try? JSONDecoder().decode(NoteCommentModel.self, from: data)
                    if((reobj?.commentdata!.count)! > 0){
                        self.notecommentData.append(reobj?.commentdata!)
                        DispatchQueue.main.async {
                            self.notestblview.reloadData()
                        }
                    }
                }
            }
            task.resume()
        }
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
    @objc func openContactAttachmentFile(notfication : NSNotification)
    {

        guard let noteid = notfication.userInfo?["noteid"] as? String else
        {
            return
        }
        guard let attachid = notfication.userInfo?["attachid"] as? String else
        {
            return
        }
        guard let filename = notfication.userInfo?["filename"] as? String else
        {
            return
        }
        let currentTime = String(Date().toMillis())
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
        }
         let urlString = globalURL+"/note_attachment/\(currentOrgID)/\(noteid)/\(attachid)"
         let separr = filename.components(separatedBy: ".")
        let firststr = separr.first! + currentTime
        let secstr = firststr + "." + (separr.last?.lowercased())!
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(secstr)")
        //Create URL to the source file you want to download
        let fileURL = URL(string: urlString)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        var request = URLRequest(url:fileURL!)
        request.setValue(passKey, forHTTPHeaderField: "X-VCPassKey")
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                do {
                    OperationQueue.main.addOperation {
                        SVProgressHUD.dismiss()
                    }
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    do {
                        //Show UIActivityViewController to save the downloaded file
                        let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                        for indexx in 0..<contents.count {
                            if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                                OperationQueue.main.addOperation {
                                let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                self.present(activityViewController, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                    catch (let err) {
                        print("error: \(err)")
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
    }
    @objc func movetheRegardingAppointments(notfication : NSNotification)
    {
        guard let selecteditem = notfication.userInfo?["item"] as? GetAppointmentModelData else
        {
            return
        }
        if(Id == selecteditem.id){
            return
        }else{
            
            var gDict = [String : Any]()
            gDict["RecurringActivityId"] = selecteditem.recurringActivityID
            gDict["DueTime"] = ""
            gDict["Priority"] = 0
            gDict["AdvocateProcessIndex"] = selecteditem.advocateProcessIndex
            gDict["PercentComplete"] = 0
            gDict["AppointmentTypeId"] = selecteditem.appointmentTypeID
            gDict["AllDay"] = selecteditem.allDay
            gDict["AppliedAdvocateProcessId"] = selecteditem.appliedAdvocateProcessID
            gDict["Complete"] = selecteditem.complete
            gDict["CreatedBy"] = selecteditem.createdBy
            gDict["CreatedOn"] = selecteditem.createdOn
            gDict["Description"] = selecteditem.resultDescription
            gDict["EndTime"] = selecteditem.endTime
            gDict["Id"] = selecteditem.id
            gDict["Location"] = selecteditem.location
            gDict["ModifiedBy"] = selecteditem.modifiedBy
            gDict["ModifiedOn"] = selecteditem.modifiedOn
            gDict["RecurrenceIndex"] = selecteditem.recurrenceIndex
            gDict["RollOver"] = selecteditem.rollOver
            gDict["StartTime"] = selecteditem.startTime
            gDict["Subject"] = selecteditem.subject
            gDict["Activity"] = nil
            gDict["Type"] = ""

            
            
            
            var cDict = [String : Any]()
            cDict["RecurringActivityId"] = selecteditem.recurringActivityID
            cDict["DueTime"] = ""
            cDict["Priority"] = 0
            cDict["AdvocateProcessIndex"] = selecteditem.advocateProcessIndex
            cDict["PercentComplete"] = 0
            cDict["AppointmentTypeId"] = selecteditem.appointmentTypeID
            cDict["AllDay"] = selecteditem.allDay
            cDict["AppliedAdvocateProcessId"] = selecteditem.appliedAdvocateProcessID
            cDict["Complete"] = selecteditem.complete
            cDict["CreatedBy"] = selecteditem.createdBy
            cDict["CreatedOn"] = selecteditem.createdOn
            cDict["Description"] = selecteditem.resultDescription
            cDict["EndTime"] = selecteditem.endTime
            cDict["Id"] = selecteditem.id
            cDict["Location"] = selecteditem.location
            cDict["ModifiedBy"] = selecteditem.modifiedBy
            cDict["ModifiedOn"] = selecteditem.modifiedOn
            cDict["RecurrenceIndex"] = selecteditem.recurrenceIndex
            cDict["RollOver"] = selecteditem.rollOver
            cDict["StartTime"] = selecteditem.startTime
            cDict["Subject"] = selecteditem.subject
            cDict["Activity"] = gDict
            cDict["Type"] = ""
            
        let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: cDict )
        let controller:UpdatenewappointmentVC = self.storyboard?.instantiateViewController(withIdentifier:"UpdatenewappointmentVC") as! UpdatenewappointmentVC
            controller.openedActivties = getAddress
            controller.contactList = self.contactList
            controller.accountsList = self.accountsList
            controller.appointmentList = self.appointmentList
            controller.taskmodelobj = self.taskmodelobj
        self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    @objc func movetheRegardingTasks(notfication : NSNotification)
    {
    }
    @objc func movetheRegardingConatcts(notfication : NSNotification)
    {
        guard let selecteditem = notfication.userInfo?["item"] as? ContactListResult else
        {
            return
        }
        let controller:ContactssController = self.storyboard?.instantiateViewController(withIdentifier:"ContactssController") as! ContactssController
            controller.contactInfoDetail = selecteditem
            controller.allContactList = contactList
            controller.passTaskList = self.taskmodelobj
            controller.passAppointmentList = self.appointmentList
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @objc func movetheRegardingAccounts(notfication : NSNotification)
    {
        guard let selecteditem = notfication.userInfo?["item"] as? GetAccountsListResult else
        {
            return
        }
            let controller:NewAccountsController = self.storyboard?.instantiateViewController(withIdentifier:"NewAccountsController") as! NewAccountsController
             controller.contactInfoDetail = selecteditem
            controller.allmainaccountList = importaccountList
            controller.allContactList = contactList
            controller.passTaskList = self.taskmodelobj
            controller.passAppointmentList = self.appointmentList
            self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK:- GET Appiontment
    func getAppointments()
    {
        let param: [String: Any] = ["ObjectName":"appointment",
                                   "OrganizationId":currentOrgID,
                                   "IncludeExtendedProperties" :  true,
                                   "OrderBy" : "Subject",
                                   "PassKey": passKey,
                                   "SearchTerm":"",
                                   "PageOffset": 1,
                                   "AscendingOrder":true,
                                   "ResultsPerPage": 5000]
        
        do{
            OperationQueue.main.addOperation {
                SVProgressHUD.show()
            }
        let postData = try JSONSerialization.data(withJSONObject: param, options: [])
        let request = NSMutableURLRequest(url: URL(string: searchURL)!)
        let session = URLSession.shared
        request.httpBody = postData as Data
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if (data != nil && error == nil) {
                do {
                    OperationQueue.main.addOperation {
                        SVProgressHUD.dismiss()
                    }
                    let decoder = JSONDecoder()
                    self.appointmentList = try? decoder.decode(GetAppointmentModelModel.self, from: data!)
                }
                catch
                {
                    
                }
     
                
            } else {
                print("Web Service have Error")
            }
        })
        
        task.resume()
        }catch
        {
            
        }
    }
    func listOfUsersBasedOnOrganization() {
        
        let json: [String: Any] = ["OrganizationId": currentOrgID,
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: userListByOrgURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:UserlistMapping = UserlistMapping.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    self.usersList = logModel.users
                    OperationQueue.main.addOperation {
                        print(self.usersList.count)
                     
                    }
                }else{
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    //MARK:- GET Task
    func getTask()
    {
        
            let param: [String: Any] = ["ObjectName":"task",
                                       "OrganizationId":currentOrgID,
                                       "IncludeExtendedProperties" :  true,
                                       "OrderBy" : "Subject",
                                       "PassKey": passKey,
                                       "SearchTerm":"",
                                       "PageOffset": 1,
                                       "AscendingOrder":true,
                                       "ResultsPerPage": 5000]
        UserDefaults.standard.set(true, forKey: "tasklist")
        do{
            OperationQueue.main.addOperation {
                SVProgressHUD.show()
            }
        let postData = try JSONSerialization.data(withJSONObject: param, options: [])
        let request = NSMutableURLRequest(url: URL(string: searchURL)!)
        let session = URLSession.shared
        request.httpBody = postData as Data
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if (data != nil && error == nil) {
                do {
                    OperationQueue.main.addOperation {
                        SVProgressHUD.dismiss()
                    }
                    let decoder = JSONDecoder()
                    self.taskmodelobj = try? decoder.decode(Taskmodel.self, from: data!)
                }
                catch
                {
                    
                }
     
                
            } else {
                print("Web Service have Error")
            }
        })
        
        task.resume()
        }catch
        {
            
        }
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
    @objc func commentTableviewExpandAction(_ sender: UIButton)
    {
        iscommentExpand = true
        if(self.allcommentExpandArray[sender.tag] == 0)
        {
            self.allcommentExpandArray.insert(1, at: sender.tag)
            self.allcommentExpandArray.remove(at: sender.tag + 1)
        }else
        {
            self.allcommentExpandArray.insert(0, at: sender.tag)
            self.allcommentExpandArray.remove(at: sender.tag + 1)
        }
        let currNoteid = self.notedata[sender.tag].note?.id
        for(indx,_) in self.notecommentData.enumerated()
        {
            let valu = self.notecommentData[indx] as? [CommnetResults]
            if (currNoteid == valu?.first?.noteID)
            {
                self.globalCommentCount = valu!.count
            }
        }

        self.noteheight = 0
        self.notestblview.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            let set = NSSet(array: self.noteheightArray as! [Int])
            let fval = set.allObjects
            for (_,elem) in fval.enumerated()
            {
                self.sum += elem as! Int
                
            }
            print(self.sum)
            if(self.sum < 1000) {
                self.Viewheightconstant.constant = CGFloat(Float(self.sum)) + 970.0
            }
            else if(self.sum < 1200) {
                self.Viewheightconstant.constant = CGFloat(Float(self.sum)) + 570.0
            }
            else if(self.sum < 1400) {
                self.Viewheightconstant.constant = CGFloat(Float(self.sum)) + 470.0
            }
            else if(self.sum < 1700) {
                self.Viewheightconstant.constant = CGFloat(Float(self.sum)) + 570.0
            }
            else {
                self.Viewheightconstant.constant = CGFloat(Float(self.sum))
            }
            
            self.sum = 0
            self.noteheightArray = []
        }
//        self.notestblview.reloadSections(IndexSet(integer: 9), with: .none)
//        let indexPath = IndexPath(row: sender.tag + 1, section: 9)
//        self.notestblview.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    @objc func commentNoteButtonTapped(_ sender: UIButton)
    {
        self.selectedNoteID =  self.notedata[sender.tag].note!.id
        let modalViewController:AddCommentVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCommentVC") as! AddCommentVC
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.istype = "comment"
        modalViewController.fromviewController = "task"
        self.present(modalViewController, animated: true, completion: nil)

    }
    @objc func searchNoteButtonTapped(_ sender: UIButton)
    {
        self.selectedNoteIndx = sender.tag
        self.selectedNoteID =  self.notedata[sender.tag].note!.id
        searchCurrNoteid = self.notedata[sender.tag].note?.id
        self.showContactsTypePicker()
    }
    @objc func AddNoteButtonTapped(_ button: UIButton) {
        let controller:NoteDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailsVC") as! NoteDetailsVC
        controller.appoinmentActivities = self.openedActivties
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
    }
    @objc func attachNoteButtonTapped(_ sender: UIButton)
    {
        self.selectedNoteIndx = sender.tag
        self.selectedNoteID =  self.notedata[sender.tag].note!.id
        var types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet,kUTTypeGIF,kUTTypePNG,kUTTypeHTML,kUTTypeJPEG,kUTTypeMPEG,kUTTypeAudio,kUTTypeMP3,kUTTypeMovie,kUTTypeMPEG4,kUTTypeBMP,kUTTypeXML,kUTTypeICO,kUTTypeText,kUTTypeTIFF]
        types.append("com.microsoft.word.doc" as CFString)
        types.append("com.apple.iwork.pages.pages" as CFString)
        types.append("com.apple.iwork.keynote.key" as CFString)
        types.append("com.apple.application" as CFString)
        types.append("public.item" as CFString)
        types.append("public.data" as CFString)
        types.append("public.content" as CFString)
        types.append("public.audiovisual-content" as CFString)
        types.append("public.movie" as CFString)
        types.append("public.audio" as CFString)
        types.append("public.text" as CFString)
        types.append("public.data" as CFString)
        types.append("public.zip-archive" as CFString)
        types.append("public.composite-content" as CFString)
        types.append("public.text" as CFString)
        let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
        importMenu.delegate = self
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.blue], for: .normal)
        self.present(importMenu, animated: true, completion: nil)
    }
    @objc func editNoteButtonTapped(_ sender: UIButton)
    {
        self.selectedNoteID =  self.notedata[sender.tag].note!.id
        let controller:NoteDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailsVC") as! NoteDetailsVC
        controller.fromviewcontroller = "task"
        controller.editModeON = true
        controller.editContactList = self.contactList
        controller.mainaccountList = self.importaccountList
        controller.editpassTaskmodel = self.taskmodelobj
        controller.editpassAppoinementmodel = self.appointmentList
        controller.appoinmentActivities = self.openedActivties
        controller.editNoteID = self.notedata[sender.tag].note!.id
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
        controller.editnotetext = self.notedata[sender.tag].note!.note ?? ""
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK: - Show Appointment Picker
    func showChooseAppointmentPicker(){
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Appointment", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        for (index,elemnt) in self.appointmentList.results.enumerated() {
            
            if (self.selectedContactsList.contains(elemnt.id!))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1114
        picker?.show()
    }
    //MARK: - Show Task Picker
    func showChooseTaskPicker(){
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Task", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        for (index,elemnt) in self.taskmodelobj.results.enumerated() {
            
            if (self.selectedContactsList.contains(elemnt.id!))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1116
        picker?.show()
    }
    func deleteRegardingContactAction(ObjectId : String)
    {
        let json: [String: Any] = ["ObjectName":"notes_regarding",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "ObjectId":ObjectId
        ]
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print("jsonSecond:",json)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func secondCreateAPi(noteID : String, RegardingId : String){
        var regtype : String = ""
        if(self.globalRegType == "contact")
        {
            regtype = "contact"
        }else if(self.globalRegType == "appointment")
        {
            regtype = "appointment"
        }
        else if(self.globalRegType == "task")
        {
            regtype = "task"
        }
        else
        {
             regtype = "company"
        }
        let json: [String: Any] = ["ObjectName":"notes_regarding",
                                   "DataObject": [
                                    "NoteId" : noteID,
                                    "RegardingId": RegardingId,
                                    "RegardingType":regtype],
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey] as [String : Any]
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print("jsonSecond:",json)
//                self.allcreatedRegardingID.append(RegardingId)
//                self.allregardingObjectID.append( json["DataObject"]["Id"].stringValue)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    //MARK: - Show Conatcts Picker
    func showChooseContactsPicker(){
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Contact", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        for (index,elemnt) in self.contactList.enumerated() {
            
            if (self.selectedContactsList.contains(elemnt.id))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1112
        picker?.show()
    }
    //MARK: - Show Company Picker
    func showChooseCompanysPicker(){
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Company", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        
        for (index,elemnt) in self.importaccountList.enumerated() {
            
            if (self.selectedContactsList.contains(elemnt.id))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1002
        picker?.show()
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
        
            if (RecurringActivityId != nil)
            {
                let controller:PopActivityController = self.storyboard?.instantiateViewController(withIdentifier: "PopActivityController") as! PopActivityController
                controller.modalPresentationStyle = .overCurrentContext
                self.present(controller, animated: true, completion: nil)
            }else{
                let parameters = [
                    "ObjectId":Id,
                    "OrganizationId": currentOrgID,
                    "ObjectName": "task",
                    "PassKey": passKey
                    ] as [String : Any]
                profileUpdateAlertEdit(param: parameters)
            }
        
          
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
        isExpand = false
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "deletefuture") , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "deleteunmodify") , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "deleteseries") , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "deletesingle") , object: nil)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: UpdatenewtaskVC.commentTasknotify) , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  UpdatenewtaskVC.regardingnotify) , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  UpdatenewtaskVC.attachdownnotify) , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  UpdatenewtaskVC.accountregardingnotify) , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  UpdatenewtaskVC.appointementregardingnotify) , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  UpdatenewtaskVC.taskregardingnotify) , object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        getContacts()
        isExpand = false
        self.Viewheightconstant.constant = 1100
        self.isNoteCellPresent = false
        self.pullNotesListFromServerApi()
        if(IsEdit){
            setupBottomViewEdit()
        }
        else {
            setupBottomView()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteAllFutureSeriesAPI), name: NSNotification.Name(rawValue: "deletefuture"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteAllUnmodifiedSeriesAPI), name: NSNotification.Name(rawValue: "deleteunmodify"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteIncompleteSeries), name: NSNotification.Name(rawValue: "deleteseries"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteSingleApi), name: NSNotification.Name(rawValue: "deletesingle"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.CommentApiMethod(notfication:)), name: NSNotification.Name(rawValue: UpdatenewtaskVC.commentTasknotify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.movetheRegardingAccounts(notfication:)), name: NSNotification.Name(UpdatenewtaskVC.accountregardingnotify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.movetheRegardingConatcts(notfication:)), name: NSNotification.Name(UpdatenewtaskVC.regardingnotify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openContactAttachmentFile(notfication:)), name: NSNotification.Name(UpdatenewtaskVC.attachdownnotify), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.movetheRegardingTasks(notfication:)), name: NSNotification.Name(UpdatenewtaskVC.taskregardingnotify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.movetheRegardingAppointments(notfication:)), name: NSNotification.Name(UpdatenewtaskVC.appointementregardingnotify), object: nil)
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
                let contactMode1l = GetAccountsListModel.init(fromDictionary: jsonResponse)
                self.importaccountList = contactMode1l.results
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
    func getRecurrencePatternID()
    {
        let json: [String: Any] = ["ObjectName": "recurring_activity",
                                   "ObjectId": RecurringActivityId,
                                   "IncludeExtendedProperties":true,
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey]
        do{
            OperationQueue.main.addOperation {
                SVProgressHUD.show()
            }
            let postData = try JSONSerialization.data(withJSONObject: json, options: [])
            let request = NSMutableURLRequest(url: URL(string: "https://toolkit.bluesquareapps.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json")!)
            let session = URLSession.shared
            request.httpBody = postData as Data
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                if (data != nil && error == nil) {
                    do {
                        OperationQueue.main.addOperation {
                            SVProgressHUD.dismiss()
                        }
                        do {
                            // make sure this JSON is in the format we expect
                            let json = try JSONSerialization.jsonObject(with: data!, options: [])
                            print(json)
                                // try to read out a string array
                                
                        } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                        }
                        let decoder = JSONDecoder()
                        self.patternobbj = try? decoder.decode(PatterID.self, from: data!)
                        print(self.patternobbj)
                    }
         
                    
                } else {
                    print("Web Service have Error")
                }
            })
            
            task.resume()
            }catch
            {
                
            }
    }
    func modifyJsonApi(type : String)
    {
        let sobbjb : [String: Any] =
        [
            "Description" : "",
            "RecurrenceDeleteMode" : type,
            "CreatedBy":self.patternobbj.dataObject.createdBy ?? "",
            "EndTime":self.patternobbj.dataObject.endTime ?? "",
            "ModifiedOn":ModifiedOn,
            "RollOver":self.patternobbj.dataObject.rollOver ?? "",
            "ActivityType":"Task",
            "AppointmentTypeId":self.patternobbj.dataObject.appointmentTypeID ?? "",
            "StartTime":self.patternobbj.dataObject.startTime ?? "",
            "RecurrenceStart":self.patternobbj.dataObject.recurrenceStart ?? "",
            "LastCreatedIndex":self.patternobbj.dataObject.lastCreatedIndex ?? "",
            "ModifiedBy":ModifiedBy,
            "Subject":self.patternobbj.dataObject.subject ?? "",
            "AllDay":self.patternobbj.dataObject.allDay ?? "",
            "RecurrenceEnd":self.patternobbj.dataObject.recurrenceEnd ?? "",
            "StaticDeliverableTemplateId":"",
            "Id":RecurringActivityId,
            "CreatedOn":CreatedOn,
            "RecurrencePatternId":self.patternobbj.dataObject.recurrencePatternID ?? "",
            "ServiceMatrixTemplateId":self.patternobbj.dataObject.serviceMatrixTemplateID ?? "",
            "Location":""
        ]
        let json: [String: Any] = [
            "ObjectName":"recurring_activity",
            "DataObject":sobbjb,
            "IncludeExtendedProperties":true,
"PassKey":passKey,
"OrganizationId":currentOrgID]
        do{
            OperationQueue.main.addOperation {
                SVProgressHUD.show()
            }
            let postData = try JSONSerialization.data(withJSONObject: json, options: [])
            let request = NSMutableURLRequest(url: URL(string: modifyURL)!)
            let session = URLSession.shared
            request.httpBody = postData as Data
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
                if (data != nil && error == nil) {
                    do {
                        // make sure this JSON is in the format we expect
                        let json = try JSONSerialization.jsonObject(with: data!, options: [])
                        print(json)
                        DispatchQueue.main.async {
                            self.deleteSingleApi()

                        }
                            // try to read out a string array
                            
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }

         
                    
                } else {
                    print("Web Service have Error")
                }
            })
            
            task.resume()
            }catch
            {
                
            }
        
        
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isNoteCellPresent)
        {
            return self.notedata.count + 1
            
        }else
        {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isExpand {
            isNoteCellPresent = false
            selectedIndexPath = 2123123
            iscommentExpand = false
            isExpand = false
            self.noteheight = 0
            notestblview.reloadData()
            self.Viewheightconstant.constant = 1100
        }else{
            selectedIndexPath = indexPath.section + 1
            isExpand = true
            isNoteCellPresent = true
            let indexPath = IndexPath(item: 0, section: 0)
            self.notestblview.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            notestblview.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.Viewheightconstant.constant = self.notestblview.contentSize.height + 1100.0
            }
        }
        selectedIndexPath_condition = indexPath.row
        self.noteheight = 0
//        tableView.reloadSections(IndexSet(integer: 0), with: .bottom)
//        tableView.scrollToRow(at: IndexPath(row: 1, section: 0), at: .bottom, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0)
        {
            let notecell:NoteHeaderCell = tableView.dequeueReusableCell(withIdentifier: "NoteHeaderCell", for: indexPath) as! NoteHeaderCell
            
            if(isExpand){
                notecell.addnotebtn.isHidden = false
            }
            else{
                notecell.addnotebtn.isHidden = true
            }
            if selectedIndexPath == 10 {
                notecell.imgarrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                notecell.imgarrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            notecell.addnotebtn.tag = indexPath.section
            notecell.isUserInteractionEnabled = true
            notecell.addnotebtn.addTarget(self, action: #selector(AddNoteButtonTapped(_:)), for: .touchUpInside)
            return notecell
        }else
        {
   let notedetailcell:NotesListCell = tableView.dequeueReusableCell(withIdentifier: "NotesListCell", for: indexPath) as! NotesListCell
            if !(self.notedata.count > 0){
                return notedetailcell
            }
            let isdraft = (self.notedata[indexPath.row - 1].note?.draft)!
            if(isdraft)
            {
                notedetailcell.draftLblOutlet.isHidden = false
                notedetailcell.editWidthConstraint.constant = 22 // displayed edit buttonediting
            }else{
                notedetailcell.draftLblOutlet.isHidden = true
                notedetailcell.editWidthConstraint.constant = 0 // hide edit button
            }
            
            // created on - date
            let sdate = (self.notedata[indexPath.row - 1].note?.createdOn)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let st_date : Date = dateFormatter.date(from: sdate)!
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let firdate = dateFormatter.string(from: st_date)
            dateFormatter.dateFormat = "hh:mm:ss a"
            let secdate = dateFormatter.string(from: st_date)
           
            
            //created by - organization name
            for(_,elem) in self.usersList.enumerated()
            {
                if(self.notedata[indexPath.row - 1].note?.createdBy == elem.id)
                {
                    let cname = elem.firstName + " " + elem.lastName
                    let finalstr =  firdate + ", " + secdate + " by " + cname as NSString
                    let aattributedString = NSMutableAttributedString(string: finalstr as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12.0)])
                    let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 12.0)]
                    aattributedString.addAttributes(boldFontAttribute, range: finalstr.range(of: "by"))
                    notedetailcell.createOnLbl.attributedText = aattributedString
                    break
                }
            }
            
            // note text
            let noteee = self.notedata[indexPath.row - 1].note!.note
            if(noteee != nil && noteee != ""){
             notedetailcell.noteTxtViewOutlet.isHidden = false
                }else
            {
                 notedetailcell.noteTxtViewOutlet.isHidden = false
            }
            notedetailcell.noteTxtViewOutlet.text = self.notedata[indexPath.row - 1].note!.note
            //regarding contact name
            var allregardingID : [String] = []
            let currNoteid = self.notedata[indexPath.row - 1].note?.id
            for(index,_) in self.noteregardingData.enumerated(){
                
            let valu = self.noteregardingData[index] as? [NoteRegardingList]
            
                if(currNoteid == valu?.first?.noteID)
                {
                    for(_,ele) in (valu?.enumerated())!
                    {
                        allregardingID.append(ele.regardingID!) // add all note - regarding id into array
                    }
                    break
                }
            }
            // to fetch contact name
            var collectallname : [String] = []
            allregardingname.removeAll()
            allaccountregardingname.removeAll()
            for(_, elem) in allregardingID.enumerated()
            {
                for(_,ele) in self.contactList.enumerated(){
                    if(elem == ele.id)
                    {
                        allregardingname.append(ele)
                        collectallname.append(ele.fullName)
                    }
                }
                for(_,ele) in self.importaccountList.enumerated(){
                    if(elem == ele.id)
                    {
                        allaccountregardingname.append(ele)
                        collectallname.append(ele.name)
                    }
                }
                if(self.appointmentList != nil){
                for(_,ele) in self.appointmentList.results.enumerated()
                {
                    if(elem == ele.id)
                    {
                        allAppointmentregardingSubject.append(ele)
                        collectallname.append(ele.subject!)
                    }
                }
                }
                if(self.taskmodelobj != nil){
                for(_,ele) in self.taskmodelobj.results.enumerated()
                {
                    if(elem == ele.id)
                    {
                        allTaskregardingSubject.append(ele)
                        collectallname.append(ele.subject!)

                    }
                }
                }
            }
            
           // assign regarding name to cell
            notedetailcell.regattachlist = allregardingname
            notedetailcell.regaccountlist = allaccountregardingname
            notedetailcell.regTasklist = allTaskregardingSubject
            notedetailcell.regAppointmentlist = allAppointmentregardingSubject
            notedetailcell.allnames = collectallname
            notedetailcell.noteplace = "task"
            if(collectallname.count > 0)
            {
                if(collectallname.count <= 2)
                {
                    notedetailcell.regardingheightConstraint.constant = 48
                }else
                {
                    if(collectallname.count % 2 == 0) // if even set height below
                    {
                    notedetailcell.regardingheightConstraint.constant = CGFloat((collectallname.count/2) * 48)
                    }
                    else // if odd set height below
                    {
                        let hght = CGFloat((collectallname.count/2) * 48)
                        notedetailcell.regardingheightConstraint.constant = hght + 48
                    }
                }
            }
            notedetailcell.regardingCollectionview.reloadData()
            var isvaluepresent : Bool = false
            
            // attachment collectionview passing values
            for(indx,_) in self.noteattachmentData.enumerated()
            {
                let valu = self.noteattachmentData[indx] as? [NoteRegardingList]
                if (currNoteid == valu?.first?.noteID)
                {
                    notedetailcell.attachlblHeight.constant = 18
                    isvaluepresent = true
                    notedetailcell.typeattachlist = valu!
                    if(valu!.count > 0)
                    {
                        if(valu!.count <= 2)
                        {
                            notedetailcell.attachCollectionViewHeightConstraint.constant = 48
                        }else
                        {
                            if(valu!.count % 2 == 0) // if even set height below
                            {
                                notedetailcell.attachCollectionViewHeightConstraint.constant = CGFloat((valu!.count/2) * 48)
                            }else // if odd set height below
                            {
                                let hght = CGFloat((valu!.count/2) * 48)
                                notedetailcell.attachCollectionViewHeightConstraint.constant = hght + 50
                            }
                        }
                    }
                    notedetailcell.attachCollectionView.reloadData()
                }
            }
            if(!isvaluepresent) // if no attachment is present for current note
            {
                notedetailcell.typeattachlist = []
                notedetailcell.attachlblHeight.constant = 0
                notedetailcell.attachCollectionViewHeightConstraint.constant = 0
            }
            
            // comment tableview passing values
            var iscommentpresent : Bool = false
            var height : CGFloat = 0.0
            if(iscommentExpand){
            if(self.allcommentExpandArray[indexPath.row - 1] == 1){
            for(indx,_) in self.notecommentData.enumerated()
            {
                let valu = self.notecommentData[indx] as? [CommnetResults]
                if (currNoteid == valu?.first?.noteID)
                {
                    iscommentpresent = true
                    notedetailcell.cellusersList = self.usersList
                    notedetailcell.comments = valu!
                    let font = UIFont(name: "Helvetica", size: 14.0)!
                    for(indx,_) in (valu?.enumerated())!
                    {
                        height += heightForView(text: notedetailcell.comments[indx].comment!, font: font, width: notedetailcell.commentTableview.frame.width) + 40
                    }
                    notedetailcell.commentTablHeightConstarint.constant = height
                    notedetailcell.commentsBtnHeightConstraint.constant =  40
                    notedetailcell.commentExpandOutlet.isHidden = false
                    notedetailcell.commentImage.isHidden = false
                    notedetailcell.commentImage.image = UIImage(named: "ic_down_arrow_black")
                    notedetailcell.commentTableview.reloadData()
                }
            }
            if(!iscommentpresent) // if no attachment is present for current note
            {
                notedetailcell.comments = []
                notedetailcell.commentExpandOutlet.isHidden = true
                notedetailcell.commentImage.isHidden = true
                notedetailcell.commentsBtnHeightConstraint.constant =  0
                notedetailcell.commentTablHeightConstarint.constant = 0
                notedetailcell.commentTableview.reloadData()
                    }}
                else
                {
                    if(self.notecommentData.count > 0){
                        for(indx,_) in self.notecommentData.enumerated()
                        {
                            let valu = self.notecommentData[indx] as? [CommnetResults]
                            if (currNoteid == valu?.first?.noteID)
                            {
                                iscommentpresent = true
                                notedetailcell.comments = []
                                notedetailcell.commentImage.image = UIImage(named: "ic_forward")
                                notedetailcell.commentExpandOutlet.isHidden = false
                                notedetailcell.commentImage.isHidden = false
                                notedetailcell.commentsBtnHeightConstraint.constant =  40
                                notedetailcell.commentTablHeightConstarint.constant = 0
                                notedetailcell.commentTableview.reloadData()
                            }
                        }
                        if(!iscommentpresent) // if no attachment is present for current note
                        {
                            notedetailcell.comments = []
                            notedetailcell.commentExpandOutlet.isHidden = true
                            notedetailcell.commentImage.isHidden = true
                            notedetailcell.commentsBtnHeightConstraint.constant =  0
                            notedetailcell.commentTablHeightConstarint.constant = 0
                            notedetailcell.commentTableview.reloadData()
                        }}else
                    {
                         notedetailcell.comments = []
                        notedetailcell.commentExpandOutlet.isHidden = true
                        notedetailcell.commentImage.isHidden = true
                        notedetailcell.commentsBtnHeightConstraint.constant =  0
                        notedetailcell.commentTablHeightConstarint.constant = 0
                        notedetailcell.commentTableview.reloadData()
                    }
                 
                }
            }else
            {
                if(self.notecommentData.count > 0){
                    for(indx,_) in self.notecommentData.enumerated()
                    {
                        let valu = self.notecommentData[indx] as? [CommnetResults]
                        if (currNoteid == valu?.first?.noteID)
                        {
                            iscommentpresent = true
                            notedetailcell.comments = []
                            notedetailcell.commentImage.image = UIImage(named: "ic_forward")
                            notedetailcell.commentExpandOutlet.isHidden = false
                            notedetailcell.commentImage.isHidden = false
                            notedetailcell.commentsBtnHeightConstraint.constant =  40
                            notedetailcell.commentTablHeightConstarint.constant = 0
                            notedetailcell.commentTableview.reloadData()
                        }
                    }
                    if(!iscommentpresent) // if no attachment is present for current note
                    {
                        notedetailcell.comments = []
                        notedetailcell.commentExpandOutlet.isHidden = true
                        notedetailcell.commentImage.isHidden = true
                        notedetailcell.commentsBtnHeightConstraint.constant =  0
                        notedetailcell.commentTablHeightConstarint.constant = 0
                         notedetailcell.commentTableview.reloadData()
                    }}else
                {
                    notedetailcell.comments = []
                    notedetailcell.commentExpandOutlet.isHidden = true
                    notedetailcell.commentImage.isHidden = true
                    notedetailcell.commentsBtnHeightConstraint.constant =  0
                    notedetailcell.commentTablHeightConstarint.constant = 0
                     notedetailcell.commentTableview.reloadData()
                }
                
            }
            let contentSizetxt = notedetailcell.noteTxtViewOutlet.sizeThatFits(notedetailcell.noteTxtViewOutlet.bounds.size)
            
            let txtheight =  contentSizetxt.height

            if(notedetailcell.commentsBtnHeightConstraint.constant ==  0){
              notedetailcell.noteviewHeightConstraint.constant = CGFloat(defaultNoteCellHeight + commentHeight) + notedetailcell.attachCollectionViewHeightConstraint.constant + txtheight +  notedetailcell.regardingheightConstraint.constant + notedetailcell.attachlblHeight.constant + notedetailcell.commentsBtnHeightConstraint.constant + notedetailcell.commentTablHeightConstarint.constant - 20
                self.noteheight += notedetailcell.noteviewHeightConstraint.constant
                let vcalu = Int(notedetailcell.noteviewHeightConstraint.constant)
                self.noteheightArray.add(vcalu)
            }
            else{
                 notedetailcell.noteviewHeightConstraint.constant = CGFloat(defaultNoteCellHeight + commentHeight) + notedetailcell.attachCollectionViewHeightConstraint.constant + txtheight +  notedetailcell.regardingheightConstraint.constant + notedetailcell.attachlblHeight.constant + notedetailcell.commentsBtnHeightConstraint.constant + notedetailcell.commentTablHeightConstarint.constant
                self.noteheight += notedetailcell.noteviewHeightConstraint.constant
                let vcalu = Int(notedetailcell.noteviewHeightConstraint.constant)
                self.noteheightArray.add(vcalu)

            }

            // other button action
            notedetailcell.commentExpandOutlet.tag = indexPath.row - 1
            notedetailcell.commentExpandOutlet.addTarget(self, action: #selector(self.commentTableviewExpandAction(_:)), for: .touchUpInside)
            notedetailcell.commentbtnOutlet.tag = indexPath.row - 1
            notedetailcell.commentbtnOutlet.addTarget(self, action: #selector(self.commentNoteButtonTapped(_:)), for: .touchUpInside)
            notedetailcell.attachBtnOutlet.tag = indexPath.row - 1
            notedetailcell.attachBtnOutlet.addTarget(self, action: #selector(self.attachNoteButtonTapped(_:)), for: .touchUpInside)
            notedetailcell.searchBtnOutlet.tag = indexPath.row - 1
            notedetailcell.searchBtnOutlet.addTarget(self, action: #selector(self.searchNoteButtonTapped(_:)), for: .touchUpInside)
            notedetailcell.editbtnOutlet.tag = indexPath.row - 1
            notedetailcell.editbtnOutlet.addTarget(self, action: #selector(self.editNoteButtonTapped(_:)), for: .touchUpInside)
            if(self.isExpand)
            {
                if(notedata.count == 1)
                {
                    self.Viewheightconstant.constant = 1100 + self.noteheight

                }else
                {
                    self.Viewheightconstant.constant = 1100 + self.noteheight

                }
            }else
            {
                self.noteheight = 0
                self.Viewheightconstant.constant = 1100

            }
            return notedetailcell
}
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            if(indexPath.row == 0)
                    {
                        return 109
                    }else
                    {
                        return UITableViewAutomaticDimension
                    }
               
        }
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    @objc func deleteIncompleteSeries()
    {
        self.isSeries = true
        self.modifyJsonApi(type: "AllIncomplete")
    }
    @objc func deleteAllFutureSeriesAPI()
    {
        self.isSeries = true
        self.modifyJsonApi(type: "AllFuture")

    }
    @objc func deleteAllUnmodifiedSeriesAPI()
    {
        self.isSeries = true
        self.modifyJsonApi(type: "AllUnmodified")
    }
    func deleteInCompleteSeriesAPI()
    {
        let json: [String: Any] = [
            "ObjectId":RecurringActivityId,
                    "ObjectName":"recurring_activity",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]

    do{
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
        }
        let postData = try JSONSerialization.data(withJSONObject: json, options: [])
        let request = NSMutableURLRequest(url: URL(string: deleteActivityURL)!)
        let session = URLSession.shared
        request.httpBody = postData as Data
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if (data != nil && error == nil) {
                do {
                    OperationQueue.main.addOperation {
                        SVProgressHUD.dismiss()
                    }
                    let decoder = JSONDecoder()
                    self.deleteTaskobbj = try? decoder.decode(DeleteModal.self, from: data!)
                    if(self.deleteTaskobbj.responseMessage == "success")
                    {
                        DispatchQueue.main.async {
                            NavigationHelper().createMenuView()
                        }
                    }
                }
     
                
            } else {
                print("Web Service have Error")
            }
        })
        
        task.resume()
        }catch
        {
            
        }
           
    }
   
    @objc func deleteSingleApi()
    {
        let json: [String: Any] = [
            "ObjectId":Id,
                                   "ObjectName":"task",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]

    do{
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
        }
    let postData = try JSONSerialization.data(withJSONObject: json, options: [])
    let request = NSMutableURLRequest(url: URL(string: deleteActivityURL)!)
    let session = URLSession.shared
    request.httpBody = postData as Data
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
        if (data != nil && error == nil) {
            do {
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                let decoder = JSONDecoder()
                self.deleteTaskobbj = try? decoder.decode(DeleteModal.self, from: data!)
                if(self.deleteTaskobbj.responseMessage == "success")
                {
                    if(self.isSeries)
                    {
                        DispatchQueue.main.async {
                            self.deleteInCompleteSeriesAPI()
                        }
                    }else{
                    print("delete sucess")
                        DispatchQueue.main.async {
                            NavigationHelper().createMenuView()
                        }
                   
                    }
                }
            }
            catch
            {
                
            }
 
            
        } else {
            print("Web Service have Error")
        }
    })
    
    task.resume()
    }catch
    {
        
    }
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UpdatenewtaskVC: CZPickerViewDelegate, CZPickerViewDataSource {
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 0 {
            return contactList.count
        }else if pickerView.tag == 1 {
            return teamMembers.count
        }else if pickerView.tag == 2 {
            return accountsList.count
        }
        if pickerView.tag == 1112 {
                return self.contactList.count
        }
        if pickerView.tag == 1002 {
                return self.importaccountList.count
        }
        if pickerView.tag == 1114 {
            if(self.appointmentList != nil)
            {
            return self.appointmentList.results.count
            }else
            {
                return 0
            }
        }
        if pickerView.tag == 1116 {
            if(self.taskmodelobj != nil){
            return self.taskmodelobj.results.count
            }else
            {
                return 0
            }
        }
        if pickerView.tag == 1001 {
            return self.contactTypes.count
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
        if pickerView.tag == 1112 {
            return self.contactList.count
        }
        if pickerView.tag == 1002 {
            return self.importaccountList.count
        }
        if pickerView.tag == 1114 {
            if(self.appointmentList != nil)
            {
            return self.appointmentList.results.count
            }else
            {
                return 0
            }
        }
        if pickerView.tag == 1116 {
            if(self.taskmodelobj != nil){
            return self.taskmodelobj.results.count
            }else
            {
                return 0
            }
        }
        if pickerView.tag == 1001 {
            return self.contactTypes.count
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
        if pickerView.tag == 1002 {
            return self.importaccountList[row].name
        }
        if pickerView.tag == 1112 {
            return self.contactList[row].fullName
        }
        if pickerView.tag == 1114 {
            return self.appointmentList.results[row].subject
        }
        if pickerView.tag == 1116 {
            return self.taskmodelobj.results[row].subject
        }
        if pickerView.tag == 1001 {
            return contactTypes[row] as? String
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
        else if pickerView.tag == 1002 {
            //linkaddressArray
            //getLinkedAccountsResult
            let arr:NSMutableArray = []
            for index in 0..<self.importaccountList.count {
                arr.add(importaccountList[index].name)
            }
            
            return arr
        }
        else if pickerView.tag == 1112 {
            //linkaddressArray
            //getLinkedAccountsResult
            let arr:NSMutableArray = []
            for index in 0..<self.contactList.count {
                arr.add(contactList[index].fullName)
            }
            return arr
        }
        else if pickerView.tag == 1114 {
            //linkaddressArray
            //getLinkedAccountsResult
            let arr:NSMutableArray = []
            for index in 0..<self.appointmentList.results.count {
                arr.add(self.appointmentList.results[index].subject!)
            }
            return arr
        }
        else if pickerView.tag == 1116 {
            //linkaddressArray
            //getLinkedAccountsResult
            let arr:NSMutableArray = []
            for index in 0..<self.taskmodelobj.results.count {
                arr.add(self.taskmodelobj.results[index].subject!)
            }
            return arr
        }
        if pickerView.tag == 1001 {
            let Arrayname : NSMutableArray = []
            for i in 0 ..< contactTypes.count {
                let getContact = contactTypes[i]
                Arrayname.add(getContact)
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
        else if pickerView.tag == 1001 {
            if row == 0 {
                self.tappedContact = true
                self.globalRegType = "appointment"
                self.selectedContactsList = []
                self.allcreatedRegardingID.removeAll()
                self.allregardingObjectID.removeAll()
                for(index,_) in self.noteregardingData.enumerated(){
                    let valu = self.noteregardingData[index] as? [NoteRegardingList]
                    
                    if(searchCurrNoteid == valu?.first?.noteID)
                    {
                        for(_,ele) in (valu?.enumerated())!
                        {
                            if(ele.regardingType == "appointment"){
                            self.selectedContactsList.append(ele.regardingID!)
                            self.allcreatedRegardingID.append(ele.regardingID!)
                            self.allregardingObjectID.append(ele.id!)
                            // add all note - regarding id into array
                            }
                        }
                        break
                    }
                }
                self.showChooseAppointmentPicker()
            }
            
            else if row == 1 {
                self.tappedContact = true
                self.globalRegType = "contact"
                self.selectedContactsList = []
                self.allcreatedRegardingID.removeAll()
                self.allregardingObjectID.removeAll()
                for(index,_) in self.noteregardingData.enumerated(){
                    let valu = self.noteregardingData[index] as? [NoteRegardingList]
                    
                    if(searchCurrNoteid == valu?.first?.noteID)
                    {
                        for(_,ele) in (valu?.enumerated())!
                        {
                            if(ele.regardingType == "contact"){
                                self.selectedContactsList.append(ele.regardingID!)
                                self.allcreatedRegardingID.append(ele.regardingID!)
                                self.allregardingObjectID.append(ele.id!)
                                // add all note - regarding id into array
                            }
                        }
                        break
                    }
                }
             self.showChooseContactsPicker()
            }else if row == 2 {
                self.tappedContact = false
                self.globalRegType = "company"
                self.selectedContactsList = []
                self.allcreatedRegardingID.removeAll()
                self.allregardingObjectID.removeAll()
                for(index,_) in self.noteregardingData.enumerated(){
                    let valu = self.noteregardingData[index] as? [NoteRegardingList]
                    
                    if(searchCurrNoteid == valu?.first?.noteID)
                    {
                        for(_,ele) in (valu?.enumerated())!
                        {
                            if(ele.regardingType == "company"){
                                self.selectedContactsList.append(ele.regardingID!)
                                self.allcreatedRegardingID.append(ele.regardingID!)
                                self.allregardingObjectID.append(ele.id!)
                                // add all note - regarding id into array
                            }
                        }
                        break
                    }
                }
                self.showChooseCompanysPicker()
            }
            if row == 3 {
                self.tappedContact = true
                self.globalRegType = "task"
                self.selectedContactsList = []
                self.allcreatedRegardingID.removeAll()
                self.allregardingObjectID.removeAll()
                for(index,_) in self.noteregardingData.enumerated(){
                    let valu = self.noteregardingData[index] as? [NoteRegardingList]
                    
                    if(searchCurrNoteid == valu?.first?.noteID)
                    {
                        for(_,ele) in (valu?.enumerated())!
                        {
                            if(ele.regardingType == "task"){
                            self.selectedContactsList.append(ele.regardingID!)
                            self.allcreatedRegardingID.append(ele.regardingID!)
                            self.allregardingObjectID.append(ele.id!)
                            // add all note - regarding id into array
                            }
                        }
                        break
                    }
                }
                self.showChooseTaskPicker()
            }
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
        else if pickerView.tag == 1112
        {
          self.selectedContactWholeValue.removeAll()
          self.selectedContactsList.removeAll()
          for row in rows {
              if let row = row as? Int {
                  self.selectedContactsList.append(self.contactList[row].fullName)
                  self.selectedContactWholeValue.append(self.contactList[row].id)
              }
          }
          for(index, element) in self.allcreatedRegardingID.enumerated()
          {
              if(!self.selectedContactWholeValue.contains(element))
              {
                  self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
              }
          }
          for(_,element) in self.selectedContactWholeValue.enumerated(){
              if(!self.allcreatedRegardingID.contains(element))
              {
                  self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
              }
          }
        
          self.isExpand = false
          self.isNoteCellPresent = false
          self.selectedIndexPath = 111111111
            self.noteheight = 0
            self.Viewheightconstant.constant = 1100
          self.notestblview.reloadData()
          self.pullNotesListFromServerApi()
          return
        }
        else if pickerView.tag == 1002
        {
          self.selectedContactWholeValue.removeAll()
          self.selectedContactsList.removeAll()
          for row in rows {
              if let row = row as? Int {
                  self.selectedContactsList.append(self.importaccountList[row].name)
                  self.selectedContactWholeValue.append(self.importaccountList[row].id)
              }
          }
          for(index, element) in self.allcreatedRegardingID.enumerated()
          {
              if(!self.selectedContactWholeValue.contains(element))
              {
                  self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
              }
          }
          for(_,element) in self.selectedContactWholeValue.enumerated(){
              if(!self.allcreatedRegardingID.contains(element))
              {
                  self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
              }
          }
          self.isExpand = false
          self.isNoteCellPresent = false
            self.noteheight = 0
            self.Viewheightconstant.constant = 1100
          self.selectedIndexPath = 111111111
          self.notestblview.reloadData()
          self.pullNotesListFromServerApi()
          return
        }
        else if pickerView.tag == 1114 {
            self.selectedContactWholeValue = []
            self.selectedContactsList = []
            for row in rows {
                if let row = row as? Int {
                    self.selectedContactsList.append(self.appointmentList.results[row].subject!)
                    self.selectedContactWholeValue.append(self.appointmentList.results[row].id!)
                }
            }
            for(index, element) in self.allcreatedRegardingID.enumerated()
            {
                if(!self.selectedContactWholeValue.contains(element))
                {
                    self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
                }
            }
            for(_,element) in self.selectedContactWholeValue.enumerated(){
                if(!self.allcreatedRegardingID.contains(element))
                {
                    self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
                }
            }
            self.isExpand = false
            self.isNoteCellPresent = false
            self.noteheight = 0
            self.Viewheightconstant.constant = 1100
            self.selectedIndexPath = 111111111
            self.notestblview.reloadData()
            self.pullNotesListFromServerApi()
            return
        }
        else if pickerView.tag == 1116 {
            self.selectedContactWholeValue = []
            self.selectedContactsList = []
            for row in rows {
                if let row = row as? Int {
                    self.selectedContactsList.append(self.taskmodelobj.results[row].subject!)
                    self.selectedContactWholeValue.append(self.taskmodelobj.results[row].id!)
                }
            }
            for(index, element) in self.allcreatedRegardingID.enumerated()
            {
                if(!self.selectedContactWholeValue.contains(element))
                {
                    self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
                }
            }
            for(_,element) in self.selectedContactWholeValue.enumerated(){
                if(!self.allcreatedRegardingID.contains(element))
                {
                    self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
                }
            }
            self.isExpand = false
            self.isNoteCellPresent = false
            self.noteheight = 0
            self.Viewheightconstant.constant = 1100
            self.selectedIndexPath = 111111111
            self.notestblview.reloadData()
            self.pullNotesListFromServerApi()
            return
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
        else if pickerView.tag == 1112
        {
          self.selectedContactWholeValue.removeAll()
          self.selectedContactsList.removeAll()
          for row in rows {
              if let row = row as? Int {
                let getContact = array[row] as? String ?? ""
                for index in 0..<contactList.count {
                    let getContacts = contactList[index]
                    if getContacts.fullName == getContact {
                        self.selectedContactsList.append(getContacts.fullName)
                        self.selectedContactWholeValue.append(getContacts.id)
                    }
                }
                 
              }
          }
          for(index, element) in self.allcreatedRegardingID.enumerated()
          {
              if(!self.selectedContactWholeValue.contains(element))
              {
                  self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
              }
          }
          for(_,element) in self.selectedContactWholeValue.enumerated(){
              if(!self.allcreatedRegardingID.contains(element))
              {
                  self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
              }
          }
        
          self.isExpand = false
          self.isNoteCellPresent = false
          self.selectedIndexPath = 111111111
        self.noteheight = 0
            self.Viewheightconstant.constant = 1100
          self.notestblview.reloadData()
          self.pullNotesListFromServerApi()
          return
        }
        else if pickerView.tag == 1002
        {
          self.selectedContactWholeValue.removeAll()
          self.selectedContactsList.removeAll()
          for row in rows {
              if let row = row as? Int {
                let getContact = array[row] as? String ?? ""
                for index in 0..<accountsList.count {
                    let getContacts = accountsList[index]
                    if getContacts.name == getContact {
                        self.selectedContactsList.append(getContacts.name)
                        self.selectedContactWholeValue.append(getContacts.id)
                    }
                
                }
                  
              }
          }
          for(index, element) in self.allcreatedRegardingID.enumerated()
          {
              if(!self.selectedContactWholeValue.contains(element))
              {
                  self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
              }
          }
          for(_,element) in self.selectedContactWholeValue.enumerated(){
              if(!self.allcreatedRegardingID.contains(element))
              {
                  self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
              }
          }
          self.isExpand = false
          self.isNoteCellPresent = false
            self.noteheight = 0
            self.Viewheightconstant.constant = 1100
          self.selectedIndexPath = 111111111
          self.notestblview.reloadData()

          self.pullNotesListFromServerApi()
          return
        }
        else if pickerView.tag == 1114 {
            self.selectedContactWholeValue = []
            self.selectedContactsList = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = self.appointmentList.results[row].id ?? ""
                    for index in 0..<appointmentList.results.count {
                        let getContacts = appointmentList.results[index]
                        if getContacts.id == getContact {
                            self.selectedContactsList.append(getContacts.subject!)
                            self.selectedContactWholeValue.append(getContacts.id!)
                        }
                    }
                    
                   
                }
            }
            for(index, element) in self.allcreatedRegardingID.enumerated()
            {
                if(!self.selectedContactWholeValue.contains(element))
                {
                    self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
                }
            }
            for(_,element) in self.selectedContactWholeValue.enumerated(){
                if(!self.allcreatedRegardingID.contains(element))
                {
                    self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
                }
            }
            self.isExpand = false
            self.isNoteCellPresent = false
            self.noteheight = 0
            self.Viewheightconstant.constant = 1100
            self.selectedIndexPath = 111111111
            self.notestblview.reloadData()

            self.pullNotesListFromServerApi()
            return
        }
        else if pickerView.tag == 1116 {
            self.selectedContactWholeValue = []
            self.selectedContactsList = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = self.taskmodelobj.results[row].id ?? ""
                    for index in 0..<self.taskmodelobj.results.count {
                        let getContacts = self.taskmodelobj.results[index]
                        if getContacts.id == getContact {
                            self.selectedContactsList.append(getContacts.subject!)
                            self.selectedContactWholeValue.append(getContacts.id!)
                        }
                    }
                 
                }
            }
            for(index, element) in self.allcreatedRegardingID.enumerated()
            {
                if(!self.selectedContactWholeValue.contains(element))
                {
                    self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
                }
            }
            for(_,element) in self.selectedContactWholeValue.enumerated(){
                if(!self.allcreatedRegardingID.contains(element))
                {
                    self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
                }
            }
            self.isExpand = false
            self.isNoteCellPresent = false
            self.noteheight = 0
            self.Viewheightconstant.constant = 1100
            self.selectedIndexPath = 111111111
            self.notestblview.reloadData()

            self.pullNotesListFromServerApi()
            return
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
extension UpdatenewtaskVC:UITextFieldDelegate {
    
    func showContactsTypePicker(){
        let selecttypeindx:NSMutableArray = []
        let picker = CZPickerView(headerTitle: "Apply To Type", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        selecttypeindx.add(3)
        picker?.setSelectedRows(selecttypeindx as? [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = false
        picker?.tag = 1001
        picker?.show()
    }
    
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
extension UpdatenewtaskVC:URLSessionDelegate {
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
extension Date {
    func adding(hour: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hour, to: self)!
    }
    func Addminute(minute: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minute, to: self)!
    }
}
extension Date {
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
}
extension UpdatenewtaskVC: UIDocumentPickerDelegate,UINavigationControllerDelegate
{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
        let urlString: String = myURL.absoluteString
        let fullNameArr = urlString.components(separatedBy: "/")
        let filename = fullNameArr.last
        var originalfile = filename?.replacingOccurrences(of: "%20", with: "")
        
        let filePath: NSString = myURL.path as NSString
        let fileSize : UInt64
        do{
            let attr:NSDictionary? = try FileManager.default.attributesOfItem(atPath: filePath as String) as NSDictionary
            if let _attr = attr {
                fileSize = _attr.fileSize();
                let formatter = ByteCountFormatter()
                formatter.allowedUnits = [.useMB]
                formatter.countStyle = .file
                let displaySize = formatter.string(fromByteCount: Int64(fileSize))
                print(displaySize)// prints: 2.6 MB
                if(displaySize > "50.0 MB")
                {
                    NavigationHelper.showSimpleAlert(message:"Your file is \(displaySize) long. we allow size only upto 50 MB.")
                    return
                }
            }
        }
        catch{
            print(error.localizedDescription)
        }
        let path = myURL.path
        let imgdata = FileManager.default.contents(atPath: path)!
        self.request(withImages: ["X-VCPassKey": passKey], parameters: nil, imageNames: [originalfile!], images: [imgdata]) { (data, error, status) in
            print(data!)
            print(status)
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func request(withImages headers:[String:String]?, parameters: [String:Any]?,imageNames : [String], images:[Data], completion: @escaping(Any?, Error?, Bool)->Void) {
        
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
        }
        let stringUrl = globalURL+"/note_attachment/\(currentOrgID)/\(self.selectedNoteID)"
        
        let boundary = UUID().uuidString
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        print("\n\ncomplete Url :-------------- ",stringUrl," \n\n-------------: complete Url")
        guard let url = URL(string: stringUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        if headers != nil{
            print("\n\nHeaders :-------------- ",headers as Any,"\n\n --------------: Headers")
            for (key, value) in headers! {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        if parameters != nil{
            for(key, value) in parameters!{
                // Add the reqtype field and its value to the raw http request data
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                data.append("\(value)".data(using: .utf8)!)
            }
        }
        for (index,imageData) in images.enumerated() {
            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(imageNames[index])\"; filename=\"\(imageNames[index])\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            data.append(imageData)
        }
        
        // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: request, from: data, completionHandler: { data, response, error in
            
            OperationQueue.main.addOperation {
                SVProgressHUD.dismiss()
            }
            
            if let checkResponse = response as? HTTPURLResponse{
                if checkResponse.statusCode == 200{
                    guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.allowFragments]) else {
                        completion(nil, error, false)
                        return
                    }
                    do{
                        DispatchQueue.main.async {
                            let reobj = try? JSONDecoder().decode(NoteRegardingModel.self, from: data)
                            var isadded : Bool = false
                            if((reobj?.regardingobj!.count)! > 0){
                                for(indx,_) in self.noteattachmentData.enumerated()
                                {
                                    var valu = self.noteattachmentData[indx] as? [NoteRegardingList]
                                    
                                    if (self.selectedNoteID == valu?.first?.noteID)
                                    {
                                        isadded = true
                                        valu?.append((reobj?.regardingobj!.first)!)
                                        self.noteattachmentData.append(valu!)
                                    }
                                }
                                if(!isadded)
                                {
                                    self.noteattachmentData.append(reobj?.regardingobj!)
                                }
                                self.notestblview.reloadData()
                            }
                        }
                        }
                    catch
                    {
                        print(error.localizedDescription)
                    }
                    completion(json, nil, true)
                }else{
                    guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                        completion(nil, error, false)
                        return
                    }
                    let jsonString = String(data: data, encoding: .utf8)!
                    print("\n\n---------------------------\n\n"+jsonString+"\n\n---------------------------\n\n")
                   
                    completion(json, nil, false)
                }
            }else{
                guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    completion(nil, error, false)
                    return
                }
                completion(json, nil, false)
            }
            
        }).resume()
    }
    }
