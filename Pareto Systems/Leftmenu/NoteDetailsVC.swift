//
//  NoteDetailsVC.swift
//  Blue Square
//
//  Created by TECNVATORS SOFTWARE on 18/10/19.
//  Copyright © 2019 VividInfotech. All rights reserved.
//

import UIKit
import MobileCoreServices

class NoteDetailsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var actionBtnOutlet: UIButton!
    @IBOutlet weak var closebtnOutlet: UIButton!
    var contactTypes:NSArray = ["Appointment","Contact","Company","Task"]
    var conditionType:String!
    var Contactname:String = ""
    var passDefaultContactname : String = ""
    var passDefaultAppointemntSubject : String  = ""
    var passDefaultTaskSubject : String  = ""
    var Arrayfilename : [String] = []
    var ArrayUrlname : [String] = []
    var allcreatedRegardingID  : [String] = []
    var allregardingObjectID : [String] = []
    var taskmodelobj : Taskmodel!
    var allcreatedCompanyRegardingID  : [String] = []
    var allregardingCompanyObjectID : [String] = []
    var allcreatedAppointmentRegardingID  : [String] = []
    var allcreatedTaskRegardingID : [String] = []
    var allregardingAppointmentObjectID : [String] = []
    var allregardingTaskObjectID : [String] = []
    var isFirstCreateFinish : Bool = false
    var getCalendarActivityList:[GetCalendarListActivity] = []
    var  noteregardingData : [NoteRegardingList] = []
    var  noteattachmentData : [NoteRegardingList] = []
    var contactListResult:ContactListResult!
    var accountListResult:GetAccountsListResult!
    var appointmentListResult:NewAppointmentResult!
    var appoinmentActivities : OpenActivityActivity!
    var taskActivitiesCreated : String = ""
    var taskActivitiesModified : String = ""
    var taskAcitivitiesID : String = ""
    var contactsList:[familyContactResult] = []
    var appointmentList:GetAppointmentModelModel!
    var selectedContactWholeValue:[String] = []
    var selectedCompanyWholeValue:[String] = []
    var selectedAppointmentWholeValue:[String] = []
    var selectedTaskWholeValue:[String] = []
    var selectedAppoinmentIDs:[String] = []
    var getSearchList:[searchAccountResult] = []
    var selectedContactsList:[String] = []
    var selectedCompanyList:[String] = []
    var selectedTaskList:[String] = []
    var selectedTaskIDs : [String] = []
    var selectedAppointmentList:[String] = []
    var editContactList:[ContactListResult] = []
    var mainaccountList : [GetAccountsListResult] = []
    var editpassTaskmodel : Taskmodel!
    var editpassAppoinementmodel : GetAppointmentModelModel!
    static let completenotify = "completenotify"
    static let deletenotify = "deletenotify"
    var tappedRegType : String = ""
    var selectedContactIndx:NSMutableArray = []
    @IBOutlet var Uploadbtn: UIButton!
    @IBOutlet var Searchtxtfield: ACFloatingTextfield!
    @IBOutlet var Regardingtxtfield: ACFloatingTextfield!
    @IBOutlet var NotesTextview: KMPlaceholderTextView!
    @IBOutlet var AttachCollectionview: UICollectionView!
    var editModeON : Bool = true
    var editnotetext : String = ""
    var editNoteID : String = ""
    var fromviewcontroller : String = ""
    var CustomNoteId : String = ""
    var CustomCreatedOn : String = ""
    var CustomModifiedOn : String = ""
    var allAttachmentObjectID : [String] = []
    var scrollView = UIScrollView()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.closebtnOutlet.isEnabled = true
        self.closebtnOutlet.setTitleColor(UIColor.lightGray, for: .normal)
        self.actionBtnOutlet.isEnabled = true
        self.actionBtnOutlet.setTitleColor(UIColor.lightGray, for: .normal)
        self.NotesTextview.delegate  = self
        if(self.fromviewcontroller == "contact")
        {
            self.tappedRegType = "contact"
                if(editModeON){
                    self.NotesTextview.text = self.editnotetext
                    self.PullDownAllNoteRegardingsFromServer(noteID: self.editNoteID)
                }
            self.callContacts()
        }else if (self.fromviewcontroller == "company")
        {
            self.tappedRegType = "company"
             if(editModeON){
                self.NotesTextview.text = self.editnotetext
                self.PullDownAllNoteRegardingsFromServer(noteID: self.editNoteID)
            }
              self.getCompany()
        }else if(self.fromviewcontroller == "appointment")
        {
            self.tappedRegType = "appointment"
            if(editModeON){
                self.NotesTextview.text = self.editnotetext
                self.PullDownAllNoteRegardingsFromServer(noteID: self.editNoteID)
            }
            self.getAppointments()
        }else if(self.fromviewcontroller == "task")
        {
            self.tappedRegType = "task"
            if(editModeON){
                self.NotesTextview.text = self.editnotetext
                self.PullDownAllNoteRegardingsFromServer(noteID: self.editNoteID)
            }
            self.getTask()
        }
      
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if(self.fromviewcontroller == "contact"){
             self.Regardingtxtfield.text = "Contact"
                self.Searchtxtfield.placeholder = "Search Contact"
        }
        else if(self.fromviewcontroller == "appointment"){
             self.Regardingtxtfield.text = "Appointment"
                self.Searchtxtfield.placeholder = "Search Appointment"
        }
        else if(self.fromviewcontroller == "task"){
             self.Regardingtxtfield.text = "Task"
                self.Searchtxtfield.placeholder = "Search Task"
        }
        else
        {
            self.Regardingtxtfield.text = "Company"
            self.Searchtxtfield.placeholder = "Search Company"
        }
        Uploadbtn.layer.cornerRadius = 5.0
        Uploadbtn.layer.borderWidth = 1.0
        Uploadbtn.layer.borderColor = UIColor.lightGray.cgColor
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  NoteDetailsVC.completenotify) , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  NoteDetailsVC.deletenotify) , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.CompleteApiAction), name: NSNotification.Name(rawValue: NoteDetailsVC.completenotify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.deleteapiaction), name: NSNotification.Name(rawValue: NoteDetailsVC.deletenotify), object: nil)
      
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  NoteDetailsVC.completenotify) , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  NoteDetailsVC.deletenotify) , object: nil)
    }
    @IBAction func Actionupload(_ sender: UIButton) {
        var types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet,kUTTypeGIF,kUTTypePNG,kUTTypeHTML,kUTTypeJPEG,kUTTypeMPEG,kUTTypeAudio,kUTTypeMP3,kUTTypeMovie,kUTTypeMPEG4]
        types.append("com.microsoft.word.doc" as CFString)
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
                    if(!self.isFirstCreateFinish){
                        if(!self.editModeON){
                            DispatchQueue.main.async {
                                self.Searchtxtfield.text = ""
                            
                            if(self.appointmentList.results.count > 0)
                            {
                                for(_,element) in self.appointmentList.results.enumerated()
                                {
                                    if(element.id == self.passDefaultAppointemntSubject)
                                    {
                                        self.Searchtxtfield.text = element.subject
                                        self.selectedAppointmentList.append(element.subject!)
                                        self.selectedAppoinmentIDs.append(element.id!)
                                        break
                                    }
                                }
                                    }
                                else{
                                    self.Searchtxtfield.text = self.selectedAppointmentList.joined(separator: ",")
                                        }
                        }
                        }
                    }
                    if(!self.isFirstCreateFinish){
                    if(!self.editModeON){
                        self.firstCreateApi()}
                    else
                    {
                        DispatchQueue.main.async {
                            self.closebtnOutlet.isEnabled = true
                             self.closebtnOutlet.setTitleColor(UIColor(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
                            self.actionBtnOutlet.isEnabled = true
                            self.actionBtnOutlet.setTitleColor(UIColor(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
                        }
                       
                        }}
                    
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
    func callContacts(){
        let json: [String: Any] = ["ObjectName":"contact",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "SearchTerm":"",
                                   "PageOffset": 1,
                                   "AscendingOrder":true,
                                   "ResultsPerPage": 5000]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let result = familyContactClassModel.init(fromDictionary: jsonResponse)
                print(result.responseMessage)
                if result.valid == true {
                    self.contactsList = result.results
                    for index in 0..<result.results.count {
                     let getResult = result.results[index]
                    }
                }else{
                    self.contactsList = []
                }
                if(!self.isFirstCreateFinish){
                     if(!self.editModeON){
                self.Searchtxtfield.text = ""
                if(self.contactsList.count > 0)
                {
                    for(_,element) in self.contactsList.enumerated()
                    {
                        if(element.fullName == self.passDefaultContactname)
                        {
                            self.Searchtxtfield.text = element.fullName
                            self.selectedContactsList.append(element.fullName)
                            break
                        }
                    }
                        }
                else{
                    self.Searchtxtfield.text = self.selectedContactsList.joined(separator: ",")
                        }}}
                if(!self.isFirstCreateFinish){
                if(!self.editModeON){
                    self.firstCreateApi()}
                else
                {
                    DispatchQueue.main.async {
                        self.closebtnOutlet.isEnabled = true
                         self.closebtnOutlet.setTitleColor(UIColor(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
                        self.actionBtnOutlet.isEnabled = true
                        self.actionBtnOutlet.setTitleColor(UIColor(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
                    }
                    }}
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
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
                    if(!self.isFirstCreateFinish){
                        if(!self.editModeON){
                            DispatchQueue.main.async {
                            self.Searchtxtfield.text = ""
                                if(self.taskmodelobj != nil){
                            if(self.taskmodelobj.results.count > 0)
                            {
                                for(_,element) in self.taskmodelobj.results.enumerated()
                                {
                                    if(element.subject == self.passDefaultTaskSubject)
                                    {
                                        self.Searchtxtfield.text = element.subject
                                        self.selectedTaskList.append(element.subject!)
                                        self.selectedTaskIDs.append(element.id!)
                                        break
                                    }
                                }
                                    }
                                else{
                                    self.Searchtxtfield.text = self.selectedTaskList.joined(separator: ",")
                                        }
                            }
                        }
                        }

                    }
                    if(!self.isFirstCreateFinish){
                    if(!self.editModeON){
                        self.firstCreateApi()}
                    else
                    {
                        DispatchQueue.main.async {
                            self.closebtnOutlet.isEnabled = true
                             self.closebtnOutlet.setTitleColor(UIColor(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
                            self.actionBtnOutlet.isEnabled = true
                            self.actionBtnOutlet.setTitleColor(UIColor(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
                        }
                        }}
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
    func getCompany(){
        let json: [String: Any] = ["ObjectName":"company",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "SearchTerm":"",
                                   "PageOffset": 1,
                                   "AscendingOrder":true,
                                   "ResultsPerPage": 5000]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let model = searchAccountClassModel.init(fromDictionary: jsonResponse)
                if model.valid == true {
                    self.getSearchList = model.results
                    for index in 0..<model.results.count {
                        let getResult = model.results[index]
                    }
                }else{
                    self.getSearchList = []
                }
                    if(!self.isFirstCreateFinish){
                        if(!self.editModeON){
                self.Searchtxtfield.text = ""
                if(self.getSearchList.count > 0)
                {
                    for(_,element) in self.getSearchList.enumerated()
                    {
                        if(element.name == self.passDefaultContactname)
                        {
                            self.Searchtxtfield.text = element.name
                            self.selectedCompanyList.append(element.name)
                            break
                        }
                    }
                        }
                    else{
                        self.Searchtxtfield.text = self.selectedCompanyList.joined(separator: ",")
                            }}}
                if(!self.isFirstCreateFinish){
                if(!self.editModeON){
                    self.firstCreateApi()}
                else
                {
                    DispatchQueue.main.async {
                        self.closebtnOutlet.isEnabled = true
                         self.closebtnOutlet.setTitleColor(UIColor(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
                        self.actionBtnOutlet.isEnabled = true
                        self.actionBtnOutlet.setTitleColor(UIColor(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
                    }
                    }}
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    //MARK: - PullDownAllNoteAttachmentFromServer
    func PullDownAllNoteAttachmentFromServer(noteID : String)
    {
          if(self.editNoteID != ""){
            let json: [String: Any] = [
                "ParentId":noteID,
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
                print(response as Any)
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                    let reobj = try? JSONDecoder().decode(NoteRegardingModel.self, from: data)
                    if((reobj?.regardingobj!.count)! > 0){
                        self.noteattachmentData = (reobj?.regardingobj)!
                        
                        for(_,element) in self.noteattachmentData.enumerated()
                        {
                            self.allAttachmentObjectID.append(element.id!)
                            self.Arrayfilename.append(element.name!)
                        }
                       self.AttachCollectionview.reloadData()
                    }
                }
            }
            task.resume()
        }
    }
    //MARK: - PullDownAllNoteRegardingsFromServer
    func PullDownAllNoteRegardingsFromServer(noteID : String)
    {
        self.allcreatedRegardingID.removeAll()
        self.allcreatedCompanyRegardingID.removeAll()
        self.noteregardingData.removeAll()
        self.selectedContactsList.removeAll()
        self.allregardingObjectID.removeAll()
        self.allregardingCompanyObjectID.removeAll()
        self.allcreatedTaskRegardingID.removeAll()
        self.allregardingTaskObjectID.removeAll()
        self.allcreatedAppointmentRegardingID.removeAll()
        self.allregardingAppointmentObjectID.removeAll()
        if(self.editNoteID != ""){
            let json: [String: Any] = [
                "ParentId":noteID,
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
                print(response as Any)
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                    let reobj = try? JSONDecoder().decode(NoteRegardingModel.self, from: data)
                    self.noteregardingData = (reobj?.regardingobj)!
                    var allregardingID : [String] = []

                    for(index,elem) in self.noteregardingData.enumerated(){
                        
                        let valu = self.noteregardingData[index]
                       
                        if(self.editNoteID == valu.noteID)
                        {
                            allregardingID.append(valu.regardingID!)
                            if(elem.regardingType == "contact")
                            {
                                self.allcreatedRegardingID.append(elem.regardingID!)
                                self.allregardingObjectID.append(elem.id!)
                            }
                            else if(elem.regardingType == "task")
                            {
                                self.allcreatedTaskRegardingID.append(elem.regardingID!)
                                self.allregardingTaskObjectID.append(elem.id!)
                                self.selectedTaskIDs.append(elem.id!)
                            }else if(elem.regardingType == "appointment")
                            {
                                self.allcreatedAppointmentRegardingID.append(elem.regardingID!)
                                self.allregardingAppointmentObjectID.append(elem.id!)
                                
                            }
                            else
                            {
                                self.allcreatedCompanyRegardingID.append(elem.regardingID!)
                                self.allregardingCompanyObjectID.append(elem.id!)
                            }
                            // add all note - regarding id into array
                        }
                    }
                    // to fetch contact name
                    var allregardingname : [String] = []
                   
                    for(_, elem) in allregardingID.enumerated()
                    {
                        for(_,ele) in self.editContactList.enumerated(){
                            if(elem == ele.id)
                            {
                                allregardingname.append(ele.fullName)
                                self.selectedContactsList.append(ele.fullName)
                            }
                        }
                        }
                  
                        for(_, elem) in allregardingID.enumerated()
                        {
                             for(_,ele) in self.mainaccountList.enumerated(){
                                if(elem == ele.id){
                                allregardingname.append(ele.name)
                                self.selectedCompanyList.append(ele.name)
                                   
                            }
                            }
                        }
                    for(_, elem) in allregardingID.enumerated()
                    {
                        if(self.editpassTaskmodel != nil){
                        for(_,ele) in self.editpassTaskmodel.results.enumerated(){
                            if(elem == ele.id){
                                allregardingname.append(ele.subject!)
                                self.selectedTaskList.append(ele.subject!)
                               
                        }
                        }
                        }
                    }
                    for(_, elem) in allregardingID.enumerated()
                    {
                        if(self.editpassAppoinementmodel != nil){
                        for(_,ele) in self.editpassAppoinementmodel.results.enumerated(){
                            if(elem == ele.id){
                                allregardingname.append(ele.subject!)
                                self.selectedAppointmentList.append(ele.subject!)
                                self.selectedAppoinmentIDs.append(ele.id!)
                               
                        }
                        }
                        }
                    }
                    if(self.Regardingtxtfield.text?.lowercased() == "contact")
                    {
                        self.Searchtxtfield.text =  self.selectedContactsList.joined(separator: ",")

                    } else if(self.Regardingtxtfield.text?.lowercased() == "task")
                    {
                        self.Searchtxtfield.text =  self.selectedTaskList.joined(separator: ",")
                    }
                    else if(self.Regardingtxtfield.text?.lowercased() == "appointment")
                   {
                       self.Searchtxtfield.text =  self.selectedAppointmentList.joined(separator: ",")
                   }
                    else{
                        self.Searchtxtfield.text =  self.selectedCompanyList.joined(separator: ",")

                    }
                    self.PullDownAllNoteAttachmentFromServer(noteID: self.editNoteID)
                }// do
            }
            task.resume()
        }
    }
    
    func completeConfirmationAlert()
    {
        let modalViewController:AddCommentVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCommentVC") as! AddCommentVC
        modalViewController.providesPresentationContextTransitionStyle = true
        modalViewController.definesPresentationContext = true
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.istype = "edit"
        modalViewController.controllername = "notedetail"
        modalViewController.action = "editer"
        modalViewController.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
        self.present(modalViewController, animated: true, completion: nil)

    }
    func deleteConfirmationAlert()
    {
        let modalViewController:AddCommentVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCommentVC") as! AddCommentVC
        modalViewController.providesPresentationContextTransitionStyle = true
        modalViewController.definesPresentationContext = true
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.istype = "edit"
        modalViewController.controllername = "notedetail"
        modalViewController.action = "delete"
        modalViewController.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
        self.present(modalViewController, animated: true, completion: nil)
    }

  
    func showDeleteActionSheet() {
        let alertController = UIAlertController(title: nil, message:"Actions", preferredStyle: .actionSheet)
        
        let completeAction = UIAlertAction(title: "Complete", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.completeConfirmationAlert()
        })
        
        let saveAction = UIAlertAction(title: "Save Draft", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.draftApiAction()
        })
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
         self.deleteConfirmationAlert()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            
        })
        alertController.addAction(completeAction)
        alertController.addAction(saveAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func deleteapiaction()
    {
        if(editModeON)
        {
            self.CustomNoteId  = self.editNoteID
        }
        let json: [String: Any] = ["ObjectId":self.CustomNoteId,
                                   "ObjectName":"note",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey]
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print("delete:\(json)")
                self.navigationController?.popViewController(animated: true)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func newCreateNoteDeleteAction()
    {
        let json: [String: Any] = ["ObjectId":self.CustomNoteId,
                                   "ObjectName":"note",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey]
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print("delete:\(json)")
                self.navigationController?.popViewController(animated: true)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    @objc func draftApiAction()
    {
        var ModifiedBy = ""
        var CreatedBy = ""
        if(self.fromviewcontroller == "contact"){
            if(editModeON)
            {
                self.CustomNoteId = self.editNoteID
            }
            ModifiedBy = contactListResult.modifiedBy!
            CreatedBy = contactListResult.createdBy!
        }
        else if(self.fromviewcontroller == "company")
        {
            if(editModeON)
            {
                self.CustomNoteId = self.editNoteID
            }
                ModifiedBy = accountListResult.modifiedBy!
                CreatedBy = accountListResult.createdBy!
        }
        else if(self.fromviewcontroller == "appointment")
        {
            if(editModeON)
            {
                self.CustomNoteId = self.editNoteID
            }
                ModifiedBy = appoinmentActivities.modifiedBy!
                CreatedBy = appoinmentActivities.createdBy!
        }
        else if(self.fromviewcontroller == "task")
        {
            if(editModeON)
            {
                self.CustomNoteId = self.editNoteID
            }
            ModifiedBy = self.taskActivitiesModified
            CreatedBy = self.taskActivitiesCreated
        }
        let notetxt = NotesTextview.text
        let json: [String: Any] = ["ObjectName":"note",
                                   "DataObject": [
                                    "Draft" : true,
                                    "CreatedOn":CustomCreatedOn,
                                    "CreatedBy": CreatedBy,
                                    "ModifiedBy": ModifiedBy,
                                    "ModifiedOn" : CustomModifiedOn,
                                    "Note": notetxt,
                                    "Id": CustomNoteId
                                   ],
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey]
        APIManager.sharedInstance.postRequestCall(postURL: modifyURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print("draft:\(json)")
               self.navigationController?.popViewController(animated: true)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func firstCreateApi()
    {
        let json: [String: Any] = ["ObjectName":"note",
                                   "DataObject": [
                                    "Draft" : true],
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey] as [String : Any]
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                self.CustomNoteId =  json["DataObject"]["Id"].stringValue
                self.CustomCreatedOn = json["DataObject"]["CreatedOn"].stringValue
                self.CustomModifiedOn = json["DataObject"]["ModifiedOn"].stringValue
                if(self.fromviewcontroller == "contact")
                {
                    self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: self.contactListResult.id!)
                }else if(self.fromviewcontroller == "appointment")
                {
                    self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: self.appoinmentActivities.id!)
                }
                else if(self.fromviewcontroller == "task")
                {
                    self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: self.taskAcitivitiesID)
                }
                else
                {
                    self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: self.accountListResult.id!)
                }
                self.closebtnOutlet.isEnabled = true
                self.closebtnOutlet.setTitleColor(UIColor(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
                self.actionBtnOutlet.isEnabled = true
                self.actionBtnOutlet.setTitleColor(UIColor(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
                self.isFirstCreateFinish  = true
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func secondCreateAPi(noteID : String, RegardingId : String){
        let json: [String: Any] = ["ObjectName":"notes_regarding",
                                   "DataObject": [
                                    "NoteId" : noteID,
                                   "RegardingId": RegardingId,
                                   "RegardingType":Regardingtxtfield.text?.lowercased()],
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey] as [String : Any]
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print("Sucess",json)
                if(self.Regardingtxtfield.text?.lowercased() == "contact")
                {
                    self.allcreatedRegardingID.append(RegardingId)
                    self.allregardingObjectID.append(json["DataObject"]["Id"].stringValue)
                }else if(self.Regardingtxtfield.text?.lowercased() == "appointment")
                {
                    self.allcreatedAppointmentRegardingID.append(RegardingId)
                    self.allregardingAppointmentObjectID.append(json["DataObject"]["Id"].stringValue)
                    
                }
                else if(self.Regardingtxtfield.text?.lowercased() == "task")
                {
                    self.allcreatedTaskRegardingID.append(RegardingId)
                    self.allregardingTaskObjectID.append(json["DataObject"]["Id"].stringValue)

                }
                else
                {
                    self.allcreatedCompanyRegardingID.append(RegardingId)
                    self.allregardingCompanyObjectID.append(json["DataObject"]["Id"].stringValue)
                }
                   }
            
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
   
    @objc func CompleteApiAction()
    {
        var cjson: [String: Any]  = [:]
        let notetxt = NotesTextview.text
        if(self.fromviewcontroller == "contact"){
            if(editModeON)
            {
                self.CustomNoteId = self.editNoteID
            }
         cjson = ["ObjectName":"note",
                                   "DataObject": [
                                    "Draft" : false,
                                    "CreatedOn":  CustomCreatedOn,
                                    "CreatedBy":  contactListResult.createdBy!,
                                    "ModifiedBy":  contactListResult.modifiedBy!,
                                    "ModifiedOn" : CustomModifiedOn,
                                    "Note": notetxt!,
                                    "Id": CustomNoteId],
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey] as [String : Any]}
        else if(self.fromviewcontroller == "appointment"){
            if(editModeON)
            {
                self.CustomNoteId = self.editNoteID
            }
            cjson = ["ObjectName":"note",
                                      "DataObject": [
                                       "Draft" : false,
                                       "CreatedOn":  CustomCreatedOn,
                                       "CreatedBy":  appoinmentActivities.createdBy!,
                                       "ModifiedBy":  appoinmentActivities.modifiedBy!,
                                       "ModifiedOn" : CustomModifiedOn,
                                       "Note": notetxt!,
                                       "Id": CustomNoteId],
                                      "OrganizationId":currentOrgID,
                                      "PassKey": passKey] as [String : Any]
        }
        else if(self.fromviewcontroller == "task"){
            if(editModeON)
            {
                self.CustomNoteId = self.editNoteID
            }
            cjson = ["ObjectName":"note",
                                      "DataObject": [
                                       "Draft" : false,
                                       "CreatedOn":  CustomCreatedOn,
                                        "CreatedBy":  self.taskActivitiesCreated,
                                        "ModifiedBy":  self.taskActivitiesModified,
                                       "ModifiedOn" : CustomModifiedOn,
                                       "Note": notetxt!,
                                       "Id": CustomNoteId],
                                      "OrganizationId":currentOrgID,
                                      "PassKey": passKey] as [String : Any]
        }
        else
        {
            if(editModeON)
            {
                self.CustomNoteId = self.editNoteID
            }
            
            cjson = ["ObjectName":"note",
                    "DataObject": [
                        "Draft" : false,
                        "CreatedOn":  CustomCreatedOn,
                        "CreatedBy":  accountListResult.createdBy!,
                        "ModifiedBy":  accountListResult.modifiedBy!,
                        "ModifiedOn" : CustomModifiedOn,
                        "Note": notetxt!,
                        "Id": CustomNoteId],
                    "OrganizationId":currentOrgID,
                    "PassKey": passKey] as [String : Any]
        }
        APIManager.sharedInstance.postRequestCall(postURL: modifyURL, parameters: cjson, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func deleteParticularAttachment(deleteID : String)
    {
        let json: [String: Any] = ["ObjectName":"note_attachment",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "ObjectId":deleteID
        ]
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print("delete attachment success")
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func deleteRegardingContactAction(ObjectId : String)
    {
        let json: [String: Any] = ["ObjectName":"notes_regarding",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "ObjectId":ObjectId
                                   ]
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
        }
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
             print("delete success")
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    @IBAction func closeNoteAction(_ sender: UIButton) {
        if(editModeON){
            self.navigationController?.popViewController(animated: true)}
        else
        {
            self.newCreateNoteDeleteAction()
        }
    }
    @IBAction func saveNoteAction(_ sender: UIButton) {
        self.showDeleteActionSheet()
    }
 
    @objc func deleteBtnAction(sender : UIButton)
    {
        // Create the alert controller
        let alertController = UIAlertController(title: "Confirmation Alert", message: "Remove this Attachment?", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.deleteParticularAttachment(deleteID: self.allAttachmentObjectID[sender.tag])
            self.allAttachmentObjectID.remove(at: sender.tag)
            self.Arrayfilename.remove(at: sender.tag)
         //   self.ArrayUrlname.remove(at: sender.tag)    uncomment if you want (By Ashwini)
            self.AttachCollectionview.reloadData()
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Uicollection view delegate and datasource method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(Arrayfilename.count > 0){
            return Arrayfilename.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = AttachCollectionview.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath as IndexPath) as! Uploadfilecell
        cell.Attachmentlbl.text = Arrayfilename[indexPath.item]
        cell.contentView.backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        cell.contentView.layer.cornerRadius = 5.0
        cell.contentView.layer.masksToBounds = true
        cell.closeBtn.tag = indexPath.item
        cell.closeBtn.addTarget(self, action: #selector(self.deleteBtnAction(sender:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 45)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
extension NoteDetailsVC : UITextViewDelegate
{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        return textView.text.count + (text.count - range.length) <= 65535
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
        
}
extension NoteDetailsVC: CZPickerViewDelegate, CZPickerViewDataSource {
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 0 {
            return contactTypes.count
        }
        else if pickerView.tag == 1 {
            return contactsList.count
        }
        else if pickerView.tag == 2 {
            return getSearchList.count
        }
        else if pickerView.tag == 3
        {
            if(self.appointmentList != nil){
            return appointmentList.results.count
            }else
            {
                return 0
            }
        }
        else if pickerView.tag == 4
        {
            
            if(self.taskmodelobj != nil){
            return taskmodelobj.results.count
            }else
            {
                return 0
            }
        }
        return 0
    }
    
    func czpickerView(_ pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
        return nil
    }
    
    func numberOfRowsInPickerView(pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 0 {
            return contactTypes.count
        }
        else if pickerView.tag == 1 {
            return contactsList.count
        }
        else if pickerView.tag == 2 {
            return getSearchList.count
        }else if pickerView.tag == 3
        {
            if(self.appointmentList != nil){
            return appointmentList.results.count
            }
            else{
                return 0
            }
        }else if pickerView.tag == 4
        {
            if(self.taskmodelobj != nil){
            return taskmodelobj.results.count
            }
            else{
                return 0
            }
        }
        return 0
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        if pickerView.tag == 0 {
            return contactTypes[row] as? String
        }
        else if pickerView.tag == 1 {
            let getcontact:familyContactResult = contactsList[row]
            return getcontact.fullName
        }
        else if pickerView.tag == 2 {
            let getcontact:searchAccountResult = getSearchList[row]
            return getcontact.name
        }
        else if pickerView.tag == 3 {
            if(self.appointmentList != nil){
            return self.appointmentList.results[row].subject
            }
            else{
                return ""
            }
        }
        else if pickerView.tag == 4
        {
            if(self.taskmodelobj != nil){
            return taskmodelobj.results[row].subject
            }
            else{
                return ""
            }
        }
        return ""
    }
    
    func czpickerView(_ pickerView: CZPickerView!) -> NSMutableArray!{
        if pickerView.tag == 0 {
            let Arrayname : NSMutableArray = []
            for i in 0 ..< contactTypes.count {
                let getContact = contactTypes[i]
                Arrayname.add(getContact)
            }
            return Arrayname
        }
        else if pickerView.tag == 1 {
            let Arrayname : NSMutableArray = []
            for i in 0 ..< contactsList.count {
                let getContact = contactsList[i]
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
            for i in 0 ..< getSearchList.count {
                let getContact = getSearchList[i]
                Arrayname.add(getContact.name)
            }
            return Arrayname
        }
        else if pickerView.tag == 3 {
            var Arrayname : NSMutableArray = []
            if(self.appointmentList != nil){
            for (_,eleem) in appointmentList.results.enumerated()
            {
                Arrayname.add(eleem.subject!)
            }
            }
            else{
                Arrayname = []
            }
            return Arrayname
        }
        else if pickerView.tag == 4 {
            var Arrayname : NSMutableArray = []
            if(self.taskmodelobj != nil){
            for (_,eleem) in taskmodelobj.results.enumerated()
            {
                Arrayname.add(eleem.subject!)
            }
            }
            else{
                Arrayname = []
            }
            return Arrayname
        }
        return []
    }
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, with value: Bool, arrayvalue array: NSMutableArray!) {
        if(value) {
      if pickerView.tag == 1
        {
        
        self.selectedContactsList = []
        self.selectedContactWholeValue = []
        Searchtxtfield.text = ""
        for row in rows {
            if let row = row as? Int {
                let getContact = array[row] as? String ?? ""
                for index in 0..<contactsList.count {
                    let getContacts = contactsList[index]
                    if getContacts.fullName == getContact {
                        self.selectedContactsList.append(getContacts.fullName)
                        self.selectedContactWholeValue.append(getContacts.id)
                        Searchtxtfield.text = self.selectedContactsList.joined(separator: ",")
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
                    if(editModeON)
                    {
                        self.secondCreateAPi(noteID: self.editNoteID, RegardingId: element)
                    }else
                    {
                        self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: element)
                    }
                }
            }
        
          return
        }
      
        else if pickerView.tag == 2
        {
            self.selectedCompanyList = []
            self.selectedCompanyWholeValue = []
            Searchtxtfield.text = ""
            for row in rows {
                if let row = row as? Int {
                    let getContact = array[row] as? String ?? ""
                    for index in 0..<mainaccountList.count {
                        let getContacts = mainaccountList[index]
                        if getContacts.name == getContact {
                            self.selectedCompanyList.append(getContacts.name)
                            self.selectedCompanyWholeValue.append(getContacts.id)
                            Searchtxtfield.text = self.selectedCompanyList.joined(separator: ",")
                        }
                    }
                    let getcontact:searchAccountResult = getSearchList[row]
                   
                }
            }
           
                for(index, element) in self.allcreatedCompanyRegardingID.enumerated()
                {
                    if(!self.selectedCompanyWholeValue.contains(element))
                    {
                        self.deleteRegardingContactAction(ObjectId: self.allregardingCompanyObjectID[index])
                    }
                }
                for(_,element) in self.selectedCompanyWholeValue.enumerated(){
                    if(!self.allcreatedCompanyRegardingID.contains(element))
                    {
                        if(editModeON)
                        {
                            self.secondCreateAPi(noteID: self.editNoteID, RegardingId: element)
                        }else
                        {
                            self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: element)
                        }
                    }
                }
          return
        }
        else if pickerView.tag == 3 {
            
            self.selectedAppointmentList = []
            self.selectedAppoinmentIDs = []
            self.selectedAppointmentWholeValue = []
            Searchtxtfield.text = ""
            for row in rows {
                if let row = row as? Int {
                    let getContact = self.appointmentList.results[row].id ?? ""
                    for index in 0..<self.appointmentList.results.count {
                        let getContacts = self.appointmentList.results[index]
                        if getContacts.id == getContact {
                            self.selectedAppointmentList.append(getContacts.subject!)
                            self.selectedAppoinmentIDs.append(getContacts.id!)
                            self.selectedAppointmentWholeValue.append(getContacts.id!)
                            Searchtxtfield.text = self.selectedAppointmentList.joined(separator: ",")
                        }
                    }
            
                }
            }
            for(index, element) in self.allcreatedAppointmentRegardingID.enumerated()
            {
                if(!self.selectedAppointmentWholeValue.contains(element))
                {
                    self.deleteRegardingContactAction(ObjectId: self.allregardingAppointmentObjectID[index])
                }
            }
            for(_,element) in self.selectedAppointmentWholeValue.enumerated(){
                if(!self.allcreatedAppointmentRegardingID.contains(element))
                {
                    if(editModeON)
                    {
                        self.secondCreateAPi(noteID: self.editNoteID, RegardingId: element)
                    }else
                    {
                        self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: element)
                    }
                }
            }
            return
        }
        else if pickerView.tag == 4 {
            
            self.selectedTaskList = []
            self.selectedTaskWholeValue = []
            self.selectedTaskIDs = []
            Searchtxtfield.text = ""
            for row in rows {
                if let row = row as? Int {
                    let getContact = self.taskmodelobj.results[row].id ?? ""
                    for index in 0..<self.taskmodelobj.results.count {
                        let getContacts = self.taskmodelobj.results[index]
                        if getContacts.id == getContact {
                            self.selectedTaskList.append(getContacts.subject!)
                            self.selectedTaskWholeValue.append(getContacts.id!)
                            self.selectedTaskIDs.append(getContacts.id!)
                            Searchtxtfield.text = self.selectedTaskList.joined(separator: ",")
                        }
                    }
                }
            }
            for(index, element) in self.allcreatedTaskRegardingID.enumerated()
            {
                if(!self.selectedTaskWholeValue.contains(element))
                {
                    self.deleteRegardingContactAction(ObjectId: self.allregardingTaskObjectID[index])
                }
            }
            for(_,element) in self.selectedTaskWholeValue.enumerated(){
                if(!self.allcreatedTaskRegardingID.contains(element))
                {
                    if(editModeON)
                    {
                        self.secondCreateAPi(noteID: self.editNoteID, RegardingId: element)
                    }else
                    {
                        self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: element)
                    }
                }
            }
            return
        }
        }
    }
func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, withoutBool value: Bool) {
    if(!value){
            if pickerView.tag == 1 {
                self.selectedContactsList = []
                self.selectedContactWholeValue = []
                Searchtxtfield.text = ""
                for row in rows {
                    if let row = row as? Int {
                        let getcontact:familyContactResult = contactsList[row]
                        self.selectedContactsList.append(getcontact.fullName)
                        self.selectedContactWholeValue.append(getcontact.id)
                        Searchtxtfield.text = self.selectedContactsList.joined(separator: ",")
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
                            if(editModeON)
                            {
                                self.secondCreateAPi(noteID: self.editNoteID, RegardingId: element)
                            }else
                            {
                                self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: element)
                            }
                        }
                    }
                
              
            }
            else if pickerView.tag == 2 {
                self.selectedCompanyList = []
                self.selectedCompanyWholeValue = []
                Searchtxtfield.text = ""
                for row in rows {
                    if let row = row as? Int {
                        let getcontact:searchAccountResult = getSearchList[row]
                        self.selectedCompanyList.append(getcontact.name)
                        self.selectedCompanyWholeValue.append(getcontact.id)
                        Searchtxtfield.text = self.selectedCompanyList.joined(separator: ",")
                    }
                }
               
                    for(index, element) in self.allcreatedCompanyRegardingID.enumerated()
                    {
                        if(!self.selectedCompanyWholeValue.contains(element))
                        {
                            self.deleteRegardingContactAction(ObjectId: self.allregardingCompanyObjectID[index])
                        }
                    }
                    for(_,element) in self.selectedCompanyWholeValue.enumerated(){
                        if(!self.allcreatedCompanyRegardingID.contains(element))
                        {
                            if(editModeON)
                            {
                                self.secondCreateAPi(noteID: self.editNoteID, RegardingId: element)
                            }else
                            {
                                self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: element)
                            }
                        }
                    }
                
               
            }
            else if pickerView.tag == 3
            {
                self.selectedAppointmentList = []
                self.selectedAppoinmentIDs = []
                self.selectedAppointmentWholeValue = []
                Searchtxtfield.text = ""
                for row in rows {
                    if let row = row as? Int {
                        let ports = self.appointmentList.results[row]
                        self.selectedAppointmentList.append(ports.subject!)
                        self.selectedAppoinmentIDs.append(ports.id!)
                        self.selectedAppointmentWholeValue.append(ports.id!)
                        Searchtxtfield.text = self.selectedAppointmentList.joined(separator: ",")
                    }
                }
                for(index, element) in self.allcreatedAppointmentRegardingID.enumerated()
                {
                    if(!self.selectedAppointmentWholeValue.contains(element))
                    {
                        self.deleteRegardingContactAction(ObjectId: self.allregardingAppointmentObjectID[index])
                    }
                }
                for(_,element) in self.selectedAppointmentWholeValue.enumerated(){
                    if(!self.allcreatedAppointmentRegardingID.contains(element))
                    {
                        if(editModeON)
                        {
                            self.secondCreateAPi(noteID: self.editNoteID, RegardingId: element)
                        }else
                        {
                            self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: element)
                        }
                    }
                }
            }
            else if pickerView.tag == 4
            {
                self.selectedTaskList = []
                self.selectedTaskWholeValue = []
                self.selectedTaskIDs = []
                Searchtxtfield.text = ""
                for row in rows {
                    if let row = row as? Int {
                        let ports = self.taskmodelobj.results[row]
                        self.selectedTaskList.append(ports.subject!)
                        self.selectedTaskWholeValue.append(ports.id!)
                        self.selectedTaskIDs.append(ports.id!)
                        Searchtxtfield.text = self.selectedTaskList.joined(separator: ",")
                    }
                }
                for(index, element) in self.allcreatedTaskRegardingID.enumerated()
                {
                    if(!self.selectedTaskWholeValue.contains(element))
                    {
                        self.deleteRegardingContactAction(ObjectId: self.allregardingTaskObjectID[index])
                    }
                }
                for(_,element) in self.selectedTaskWholeValue.enumerated(){
                    if(!self.allcreatedTaskRegardingID.contains(element))
                    {
                        if(editModeON)
                        {
                            self.secondCreateAPi(noteID: self.editNoteID, RegardingId: element)
                        }else
                        {
                            self.secondCreateAPi(noteID: self.CustomNoteId, RegardingId: element)
                        }
                    }
                }
            }
           
            }
}
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        
        if pickerView.tag == 0 {
            
            self.Regardingtxtfield.text = ""
                                                if row == 0 {
                                                    self.tappedRegType = "appointment"
                                                    self.getAppointments()
                                                    self.Searchtxtfield.placeholder = "Search Appointment"
                                                    if(self.selectedAppointmentList.count > 0)
                                                    { self.Searchtxtfield.text =  self.selectedAppointmentList.joined(separator: ",")}
                                                    else
                                                    {
                                                     if(self.selectedAppointmentList.count == 0)
                                                     {
                                                        self.Searchtxtfield.text = ""
                                                     }
                                                    }
                                                }
                                        else if row == 1 {
                                            self.tappedRegType = "contact"
                                            self.callContacts()
                                            self.Searchtxtfield.placeholder = "Search Contact"
                                            if(self.selectedContactsList.count > 0)
                                            { self.Searchtxtfield.text =  self.selectedContactsList.joined(separator: ",")}
                                            else
                                            {
                                             if(self.selectedContactsList.count == 0)
                                             {
                                                self.Searchtxtfield.text = ""
                                             }
                                            }
                                        }else if row == 2 {
                                            self.tappedRegType = "company"
                                            self.getCompany()
                                            self.Searchtxtfield.placeholder = "Search Company"
                                            if(self.selectedCompanyList.count > 0)
                                            {
                                                 self.Searchtxtfield.text =  self.selectedCompanyList.joined(separator: ",")
                                            }
                                            else
                                            {
                                                if(self.selectedCompanyList.count == 0)
                                                {
                                                    self.Searchtxtfield.text = ""
                                                }
                                            }
                                        }else if row == 3
                                        {
                                            self.tappedRegType = "task"
                                            self.getTask()
                                            self.Searchtxtfield.placeholder = "Search Task"
                                            if(self.selectedTaskList.count > 0)
                                            {
                                                 self.Searchtxtfield.text =  self.selectedTaskList.joined(separator: ",")
                                            }
                                            else
                                            {
                                                if(self.selectedTaskList.count == 0)
                                                {
                                                    self.Searchtxtfield.text = ""
                                                }
                                            }
                                        }
                                        self.Regardingtxtfield.text = contactTypes[row] as? String
                                    }
        }
    func showChooseAppointmentPicker()
    {
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Appointment", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        if(self.appointmentList != nil){
        for (index,elemnt) in self.appointmentList.results.enumerated() {
            
            if (self.selectedAppoinmentIDs.contains(elemnt.id!))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        }
        picker?.dataSource = self
        picker?.delegate = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 3
        picker?.show()
    }
    func showChooseTaskPicker()
    {
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Task", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        if(self.taskmodelobj != nil){
        for (index,elemnt) in self.taskmodelobj.results.enumerated() {
            
            if (self.selectedTaskList.contains(elemnt.subject!))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        }
        picker?.dataSource = self
        picker?.delegate = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 4
        picker?.show()
    }
    func showChooseContactsPicker(){
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Contact", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        for (index,elemnt) in self.contactsList.enumerated() {
            
            if (self.selectedContactsList.contains(elemnt.fullName))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        picker?.dataSource = self
        picker?.delegate = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1
        picker?.show()
    }
    func showContactsPicker(){
        let selecttypeindx:NSMutableArray = []
        let picker = CZPickerView(headerTitle: "Apply To Type", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        if(self.Regardingtxtfield.text == "Contact")
        {
          selecttypeindx.add(1)
        }
       else if(self.Regardingtxtfield.text == "Task")
        {
        selecttypeindx.add(3)

        }
       else if(self.Regardingtxtfield.text == "Appointment")
        {
        selecttypeindx.add(0)

        }
        else
        {
          selecttypeindx.add(2)
        }
        picker?.setSelectedRows(selecttypeindx as? [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = false
        picker?.tag = 0
        picker?.show()
    }
    func showChooseCompanyPicker(){
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Company", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        for (index,elemnt) in self.getSearchList.enumerated() {
            
            if (self.selectedCompanyList.contains(elemnt.name))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        picker?.dataSource = self
        picker?.delegate = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 2
        picker?.show()
    }
    
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
extension NoteDetailsVC:UITextFieldDelegate  {
   
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == Regardingtxtfield {
            showContactsPicker()
            return false
        }
        if textField == Searchtxtfield {
            if self.tappedRegType == "contact" {
                showChooseContactsPicker()
            }
            else if self.tappedRegType == "appointment"
            {
                showChooseAppointmentPicker()
            }else if self.tappedRegType == "task"
            {
                showChooseTaskPicker()
            }
            else{
                showChooseCompanyPicker()
            }
            return false
        }
    
        return true
    }
  
    func request(withImages headers:[String:String]?, parameters: [String:Any]?,imageNames : [String], images:[Data], completion: @escaping(Any?, Error?, Bool)->Void) {
        
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
        }
        if(editModeON)
        {
            self.CustomNoteId = self.editNoteID
        }
        let stringUrl = globalURL+"/note_attachment/\(currentOrgID)/\(self.CustomNoteId)"
        
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
                self.navigationController?.navigationBar.isUserInteractionEnabled = true
//                self.navigationItem.setHidesBackButton(false, animated: true)
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.closebtnOutlet.isUserInteractionEnabled =  true
                self.actionBtnOutlet.isUserInteractionEnabled = true
            }
            
            if let checkResponse = response as? HTTPURLResponse{
                if checkResponse.statusCode == 200{
                    guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.allowFragments]) else {
                        completion(nil, error, false)
                        return
                    }
                    do{
                        
                    let result = try JSON(data: data)
                    self.allAttachmentObjectID.append(result["Results"][0]["Id"].stringValue)
                        DispatchQueue.main.async {
                            self.AttachCollectionview.reloadData()
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
                    print(json)
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
extension Data {
    
    /// Append string to Data
    ///
    /// Rather than littering my code with calls to `data(using: .utf8)` to convert `String` values to `Data`, this wraps it in a nice convenient little extension to Data. This defaults to converting using UTF-8.
    ///
    /// - parameter string:       The string to be added to the `Data`.
    
    mutating func append(_ string: String, using encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
extension NoteDetailsVC: UIDocumentPickerDelegate,UINavigationControllerDelegate
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
        Arrayfilename.append(originalfile!)
        ArrayUrlname.append(urlString)
        let path = myURL.path
        let imgdata = FileManager.default.contents(atPath: path)!
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
//        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.closebtnOutlet.isUserInteractionEnabled =  false
        self.actionBtnOutlet.isUserInteractionEnabled = false
        self.request(withImages: ["X-VCPassKey": passKey], parameters: nil, imageNames: [originalfile!], images: [imgdata]) { (data, error, status) in
            print(data!)
            print(status)
        }
    }
    
   
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
extension NoteDetailsVC:URLSessionDelegate {
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
class ScrollView: UIScrollView {
  override func touchesShouldCancel(in view: UIView) -> Bool {
    if type(of: view) == UITextField.self || type(of: view) == UITextView.self {
      return true
    }
    return super.touchesShouldCancel(in: view)
  }
}
