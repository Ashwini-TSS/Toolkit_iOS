//
//  NewAppointmentsController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 27/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit


class NewAppointmentsController: UITableViewController {
    
    @IBOutlet weak var Starttimeappointment: ACFloatingTextfield!
    @IBOutlet weak var EndtimeAppointment: ACFloatingTextfield!
    
    var ModifiedOninput : String!
    var ModifiedByinput : String!
    var CreatedOninput : String!
    var StartTimeinput : String!
    var EndTimeinput : String!
    var Subjectinput : String!
    var CreatedByinput : String!
    var RecurringActivityIdinput : String!
    var RecurrenceIndexinput : String!
    var Descriptioninput : String!
    var Locationinput : String!
    var AppointmentTypeIdinput : String!
    var AppliedAdvocateProcessIdinput : String!
    
    var AlertCondition : String!
    
    var getObjectNames:[String] = []
    var getObjectAccount:[String] = []
    var getObjectContact:[String] = []
    
    
    var getAppointmentModel:[GetPatternAppointmentResult] = []
    
    var EditCondition : String!
    
 
    var fromAccounts:Bool = false
    @IBOutlet weak var fieldEndtime: ACFloatingTextfield!
    @IBOutlet weak var btnComplete: UIButton!
    @IBOutlet weak var btlRollover: UIButton!
    @IBOutlet weak var btnAlldayevent: UIButton!
    
    @IBOutlet weak var fieldChooseAccounts: ACFloatingTextfield!
    @IBOutlet weak var fieldStartTime: ACFloatingTextfield!
    
    @IBOutlet weak var fieldChooseTeamMember: ACFloatingTextfield!
    
    @IBOutlet weak var fieldContacts: ACFloatingTextfield!
    
    
    @IBOutlet weak var fieldComments: KMPlaceholderTextView!
    
    @IBOutlet weak var fieldLocation: ACFloatingTextfield!
    @IBOutlet weak var fieldAppointmentType: ACFloatingTextfield!
    @IBOutlet weak var fieldSubject: ACFloatingTextfield!
    
    var linkParentID:String = ""
    var contactList:[ContactListResult] = []
    var teamMembers:[NewAppointmentResult] = []
    var accountsList:[TeamMembersResult] = []
    var appointmentType:[AppointmentTypeResult] = []
    var appointmentById:String = ""
    var startTime:String = ""
    var endTime:String = ""
    
    var Id : String = ""
    
    var Editvalue : String = ""
    
    var isallday : String = ""
    
    var accountname : String = ""
    
     var RecurrenceID : String!
     var AdvacateIndexID : Int!
     var RecurrenceIndex : Int!
     var AppliedAdvocateProcessId : String!
     var AppliedProcessId : String!
    
    var isAlldayEvent:Bool = false
    var isRollOver:Bool = false
    var isComplete:Bool = false
    var openedActivties:OpenActivityActivity!
    
    var cancelBtn = UIButton()
    var donelBtn = UIButton()
    
    //API
    var contactsIDList:NSMutableArray = []
    var teamMembersIDList:NSMutableArray = []
    var accountsIDList:NSMutableArray = []
    
    var selectedContacts:NSMutableArray = []
    var selectedTeamMembers:NSMutableArray = []
    var selectedCompanies:NSMutableArray = []
    var selectedappointmentType:NSMutableArray = []
    
    var linkedContactIDList:NSMutableArray = []
    var linkedTeamMemberIDList:NSMutableArray = []
    var linkedAccountsIDList:NSMutableArray = []
    var bottomView = UIView()
    var linkedContactsArray : [String] = []
    var linkedTeammembersArray : [String] = []

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationController.bartin
        fieldAppointmentType.setupRightView()
        
        AlertCondition = "normal"
        
        fieldComments.layer.cornerRadius = 5.0
        fieldComments.layer.borderColor = UIColor.lightGray.cgColor
        fieldComments.layer.borderWidth = 1.0
        fieldComments.clipsToBounds = true
        
        cancelBtn.isUserInteractionEnabled = true
        donelBtn.isUserInteractionEnabled = true
        
        
        fieldChooseAccounts.text = accountname
        
        if(Editvalue == "edit"){
            navigationItem.title = "Edit Appointment"
        }
        
        if openedActivties != nil {
            
            AdvacateIndexID = openedActivties.activity.advocateProcessIndex
            RecurrenceID = openedActivties.activity.recurrenceID
            RecurrenceIndex = openedActivties.activity.recurrenceIndex
            
            if(openedActivties.activity.AppliedAdvocateProcessId != ""){
            AppliedProcessId = openedActivties.activity.AppliedAdvocateProcessId
            }else{
               AppliedProcessId = ""
            }
            
            CreatedByinput = openedActivties.activity.createdBy
            CreatedOninput = openedActivties.activity.createdOn
            ModifiedByinput = openedActivties.activity.modifiedBy
            ModifiedOninput = openedActivties.activity.modifiedOn
            
            getAddedAppointmentType()
            fieldLocation.text = openedActivties.activity.location
            fieldSubject.text = openedActivties.activity.subject
            fieldComments.text = openedActivties.activity.descriptionField
            fieldAppointmentType.text = ""
            print(openedActivties.activity.id!)
            
            Id = openedActivties.activity.id!
            
            getLinkedContactsdetail()
            getLinkedAccountsdetail()
            
            fieldStartTime.text = convertDateMonthString(dateString: openedActivties.activity.startTime)
            fieldEndtime.text = convertDateMonthString(dateString: openedActivties.activity.endTime)
            
            Starttimeappointment.text = convertTimeString(dateString: openedActivties.activity.startTime)
            EndtimeAppointment.text = convertTimeString(dateString: openedActivties.activity.endTime)
            
            isAlldayEvent = openedActivties.activity.allDay
            isRollOver = openedActivties.activity.rollOver
            isComplete = openedActivties.activity.complete
            startTime = openedActivties.activity.startTime!
            endTime = openedActivties.activity.endTime!

            if isallday == "true" {
                btnAlldayevent.setImage(UIImage.init(named:"ic_check"), for: .normal)
            }
            if openedActivties.activity.allDay {
                btnAlldayevent.setImage(UIImage.init(named:"ic_check"), for: .normal)
            }
            if openedActivties.activity.rollOver {
                btlRollover.setImage(UIImage.init(named:"ic_check"), for: .normal)
            }
            if openedActivties.activity.complete {
                btnComplete.setImage(UIImage.init(named:"ic_check"), for: .normal)
            }
        }else{
            
            if((UserDefaults.standard.object(forKey: "showingDayView")) != nil) {
                if let eventStartDAte = UserDefaults.standard.object(forKey: "eventStartDate") as? Date {
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let getStartTime:String = formatter.string(from:Date())
                    fieldStartTime.text = getStartTime
                    
                    let formatter1 = DateFormatter()
                    formatter1.dateFormat = "hh:00 a"
                    let gtStartTime:String = formatter1.string(from: Date())
                    Starttimeappointment.text = gtStartTime
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat =  "yyyy-MM-dd'T'HH:00:ss.SSSZ"
                    self.startTime = formatter.string(from: Date())
                    
                    
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .hour, value: 1, to: Date())
                    formatter.dateFormat = "yyyy-MM-dd"
                    formatter1.dateFormat = "hh:00 a"
                    let getEndTime:String = formatter.string(from: date!)
                    let gtEndTime:String = formatter1.string(from: date!)
                    print(getEndTime)
                    
                    fieldEndtime.text = getEndTime
                    EndtimeAppointment.text = gtEndTime
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat =  "yyyy-MM-dd'T'HH:00:ss.SSSZ"
                    self.endTime = formatter.string(from: date!)
                }
                
                UserDefaults.standard.removeObject(forKey: "showingDayView")
                UserDefaults.standard.removeObject(forKey: "eventStartDate")
            }else{
                
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "hh:00 a"
                let getStarttTime1:String = formatter1.string(from: Date())
                Starttimeappointment.text = getStarttTime1
                //
                let calendar1 = Calendar.current
                let date1 = calendar1.date(byAdding: .hour, value: 1, to: Date())
                formatter1.dateFormat = "hh:00 a"
                let getEndTime1:String = formatter1.string(from: date1!)
                
                EndtimeAppointment.text = getEndTime1
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let getStartTime:String = formatter.string(from: Date())
                fieldStartTime.text = getStartTime
                
                formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                formatter.dateFormat =  "yyyy-MM-dd'T'HH:00:ss.SSSZ"
                self.startTime = formatter.string(from: Date())
                
                
                let calendar = Calendar.current
                let date = calendar.date(byAdding: .hour, value: 1, to: Date())
                formatter.dateFormat = "yyyy-MM-dd"
                let getEndTime:String = formatter.string(from: date!)
                print(getEndTime)
                
                fieldEndtime.text = getEndTime
                
                formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                formatter.dateFormat =  "yyyy-MM-dd'T'HH:00:ss.SSSZ"
                self.endTime = formatter.string(from: date!)
            }
           
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func tappedBack(_ sender: Any) {
        if(self.EditCondition == "calendar"){
//           let controller = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
//           self.navigationController?.pushViewController(controller, animated: true)
             NavigationHelper().createMenuView()
        }
        else{
           NavigationHelper().createMenuView()
        }
        
    }
    func getLinkedContactsdetail(){
        
        let json: [String: Any] = ["ObjectName":"linker_appointments_contacts",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "ListObjectName":"contact",
                                   "AscendingOrder":true,
                                   "LinkParentId": openedActivties.activity.id!]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listLinked.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                var resultsArray : [JSON] = []
                self.linkedContactsArray = []
                resultsArray = json["Results"].arrayValue
                for dic in resultsArray{
                    let value = dic["FullName"].string
                    self.linkedContactsArray.append(value!)
                }
                if(self.linkedContactsArray.count > 0 ){
                self.fieldContacts.text = self.linkedContactsArray.joined(separator:",")
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    func getLinkedAccountsdetail(){
       
        let json: [String: Any] = ["ObjectName":"linker_appointments_companies",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "ListObjectName":"company",
                                   "AscendingOrder":true,
                                   "LinkParentId": openedActivties.activity.id!]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listLinked.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                var resultsArray : [JSON] = []
                var linkaccountArray : [String] = []
                resultsArray = json["Results"].arrayValue
                for dic in resultsArray{
                    let value = dic["Name"].string
                    linkaccountArray.append(value!)
                    self.getObjectContact.append(value!)
                }
                self.fieldChooseAccounts.text = linkaccountArray.joined(separator:",")
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        setupBottomView()
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
        
        if(Editvalue == "edit"){
            donelBtn.setTitle("Actions", for: .normal)
        }else{
            donelBtn.setTitle("Save", for: .normal)
        }
        donelBtn.frame = CGRect(x: UIScreen.main.bounds.width-182, y: 9.0, width: 168.0, height: 38)
        donelBtn.backgroundColor = UIColor.white
        donelBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        donelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        donelBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchUpInside)
        
        bottomView.addSubview(donelBtn)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.addSubview(bottomView)
    }
    func removeBottomView(){
        bottomView.removeFromSuperview()
    }
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.removeObject(forKey: "appointmentTypeID")
        removeBottomView()
    }
    func getAddedAppointmentType(){
        if openedActivties.activity.AppointmentTypeId == nil {
            return
        }
        appointmentById = openedActivties.activity.AppointmentTypeId
        if appointmentById.count == 0 {
            if let data:String = UserDefaults.standard.object(forKey: "appointmentTypeID") as? String {
                getAppointmentTypesList(appointmentTypeID: data)
                appointmentById = data
            }
        }else{
            getAppointmentTypesList(appointmentTypeID: appointmentById)
        }
        
    }
    func getAppointmentTypesList(appointmentTypeID:String){
        let json: [String: Any] = ["ObjectName": "appointment_type",
                                   "ObjectId": appointmentTypeID,
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                        if let getDataObject:NSDictionary = jsonResponse["DataObject"] as? NSDictionary {
                            if let getID:String = getDataObject["Name"] as? String {
                                print(getID)
                                self.fieldAppointmentType.text = getID
                                self.AppliedAdvocateProcessId = getDataObject["Id"] as? String
                            }
                        }
                    }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        print(responseMessage)
//                        NavigationHelper.showSimpleAlert(message:responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getContacts()
        getAppointmentType()
        UINavigationBar.appearance().barTintColor = UIColor.PSNavigaitonBlack()
    }
    
    @IBAction func tappedAlldayEvent(_ sender: Any) {
        let btnImag = (sender as AnyObject).image(for: .normal)
        if btnImag == UIImage.init(named:"ic_uncheck") {
            isAlldayEvent = true
            btnAlldayevent.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            isAlldayEvent = false
            btnAlldayevent.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
        }
    }
    
    @IBAction func tappedRollOVer(_ sender: Any) {
        let btnImag = (sender as AnyObject).image(for: .normal)
        if btnImag == UIImage.init(named:"ic_uncheck") {
            isRollOver = true

            btlRollover.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            isRollOver = false

            btlRollover.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
        }
    }
    
    @IBAction func tappedComplete(_ sender: Any) {
        let btnImag = (sender as AnyObject).image(for: .normal)
        if btnImag == UIImage.init(named:"ic_uncheck") {
            isComplete = true

            btnComplete.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            isComplete = false

            btnComplete.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
        }
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
        APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            
            DispatchQueue.main.async {
                print(json)
                let contactModel = AppointmentTypeModel.init(fromDictionary: jsonResponse)
                print(contactModel.results)
                self.appointmentType = contactModel.results
                self.appointmentType = self.appointmentType.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending }
              // self.showAppointmentTypes()
                
                self.linkedTeammembersArray = []
//                self.linkedTeammembersArray.append(contactModel.dataObject.fullName)
            
                if self.openedActivties != nil {
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
    func setupLinkTeamMembers(){
        let json: [String: Any] = ["ObjectName": "organization_user",
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey,
                                   "ObjectId":linkParentID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: getURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            
            DispatchQueue.main.async {
                print(json)
                let contactModel = getLinkedAccountContact.init(fromDictionary: jsonResponse)
                print(contactModel.responseMessage)
               
                if contactModel.valid {
                    self.teamMembersIDList = []
                    self.selectedTeamMembers = []
                    
                    
                    var selectedContacts:[String] = []
//                    for row in rows {
//                        if let row = row as? Int {
//                            let getContact = teamMembers[row]
//                            print(getContact.fullName)
//                            self.teamMembersIDList.add(getContact.id!)
//                            selectedContacts.append(getContact.fullName)
//                            self.selectedTeamMembers.add(row)
//
//                        }
//                    }
                    if selectedContacts.count > 0 {
                        let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                        self.fieldChooseTeamMember.text = stringRepresentation
                    }else{
                      //  self.fieldChooseTeamMember.text = ""
                    }
                    if self.openedActivties != nil {
                        self.setupLinkedTeamMembers()
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
//    func getTeamMembers(){
//        let json: [String: Any] = ["ObjectName":"organization_user",
//                                   "OrganizationId":currentOrgID,
//                                   "PassKey": passKey,
//                                   "OrderBy":"FullName",
//                                   "AscendingOrder":true,
//                                   "PageOffset": 1,
//                                   "ResultsPerPage": 5000]
//        print(json)
//        APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
//            if self.openedActivties != nil {
//                DispatchQueue.main.async {
//                    self.getAppointmentType()
//                }
//            }
//            DispatchQueue.main.async {
//                print(json)
//                let respon = json["ResponseMessage"].string
//                if(respon == "success"){
//                let contactModel = NewAppointmentModel.init(fromDictionary: jsonResponse)
//                print(contactModel.results)
//                self.teamMembers = contactModel.results
//
//                for index in 0..<self.teamMembers.count {
//                    let getContact = self.teamMembers[index]
//                    print(getContact.id)
//                }
////                let getContact = self.teamMembers[0]
////                self.fieldChooseTeamMember.text = getContact.fullName
//                self.teamMembers = self.teamMembers.sorted { $0.fullName.localizedCaseInsensitiveCompare($1.fullName) == ComparisonResult.orderedAscending }
//                }
//            }
//        },  onFailure: { error in
//            print(error.localizedDescription)
//            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
//        })
//    }
    
    func getTeamMembers(){
        let json:[String: Any] = ["ObjectName":"organization_user",
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID,
                                  "AscendingOrder":true]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: getOrgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                    let respon = json["ResponseMessage"].string
                    if(respon == "success"){
                        let contactModel = NewAppointmentModel.init(fromDictionary: jsonResponse)
                        print(contactModel.results)
                        self.teamMembers = contactModel.results
                        
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
                              //  self.fieldChooseTeamMember.text = getContact.fullName
                            }
                        }
//                        self.teamMembers = self.teamMembers.sorted { $0.fullName.localizedCaseInsensitiveCompare($1.fullName) == ComparisonResult.orderedAscending }
                    }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func tappedAddAppointment(_ sender: Any) {
        let controller:NewAppointmentTypeContorller = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentTypeContorller") as? NewAppointmentTypeContorller)!
        self.navigationController?.pushViewController(controller, animated: true)
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
        
        APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                self.getTeamMembers()
                print(json)
                var accountarray : [String] = []
                let contactModel = TeamMembersModel.init(fromDictionary: jsonResponse)
                self.accountsList = contactModel.results
                self.accountsList = self.accountsList.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending }
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
        
        APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
              
                print(json)
                let contactModel = getTeammemberModel.init(fromDictionary: jsonResponse)
                print(contactModel.dataObject)
               
                if contactModel.valid{
                    if self.openedActivties == nil {
                        self.fieldChooseTeamMember.text = contactModel.dataObject.fullName
                        if self.fieldChooseTeamMember.text!.count > 0 {
                            self.teamMembersIDList = []
                            self.selectedTeamMembers = []
                            var selectedContacts:[String] = []

                            self.teamMembersIDList.add(contactModel.dataObject.id!)
                            selectedContacts.append(contactModel.dataObject.fullName)
                            self.fieldChooseTeamMember.text = contactModel.dataObject.fullName
                        }
                        
                    }
                }
                
               
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
        
    }
    func getContacts(){
            OperationQueue.main.addOperation {
                SVProgressHUD.show()
//                MBProgressHUD.showAdded(to: self.view, animated: true)

            }
            let headers = [
                "Content-Type": "application/json"
            ]
            let parameters = [
                "OrderBy": "",
                "ParentId": "",
                "ResultsPerPage": 500,
                "OrganizationId": currentOrgID,
                "PassKey": passKey,
                "ParentObjectName": "",
                "PageOffset": 1,
                "ObjectName": "contact",
                "AscendingOrder":true
                ] as [String : Any]
            
            let request = NSMutableURLRequest(url: NSURL(string: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json")! as URL,
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
//                    MBProgressHUD.hide(for: self.view, animated: true)
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
    @IBAction func tappedClose(_ sender: Any) {
        removeBottomView()
        NavigationHelper().createMenuView()

//        self.navigationController?.popViewController(animated: true)
    }
    func profileEditAlert(){
        let alert = UIAlertController(title: "Are you sure want to update the information?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.UpdateEditRequest()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func profileUpdateAlert(){
        let alert = UIAlertController(title: "Are you sure want to save the information?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.updateRequest()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func tappedSave(_ sender: Any) {
        if(Editvalue == "edit"){
            TappedAction()
        }
        else {
            if self.fieldSubject.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message: "Please enter the subject")
                return
            }else if self.fieldStartTime.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message: "Please choose the start time")
                return
            }else if self.fieldEndtime.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message: "Please choose the end time")
                return
            }
            self.profileUpdateAlert()
          
        }
    }
    
    func TappedAction(){
        bottomView.removeFromSuperview()
        let alertController = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        
        let sendButton = UIAlertAction(title: "Delete", style: .default, handler: { (action) -> Void in
            self.setupBottomView()
            self.AlertCondition = "delete"
            self.tappedDeleteEdit()
        })
        
        let closeButton = UIAlertAction(title: "Save", style: .default, handler: { (action) -> Void in
            if self.fieldSubject.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message: "Please enter the subject")
                return
            }else if self.fieldStartTime.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message: "Please choose the start time")
                return
            }else if self.fieldEndtime.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message: "Please choose the end time")
                return
            }
            self.profileEditAlert()
        })
        
        let deleteButton = UIAlertAction(title: "Complete", style: .default, handler: { (action) -> Void in
            self.setupBottomView()
            self.AlertCondition = "complete"
            self.tappedCompleteedit()
            
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
            self.setupBottomView()
        })
        
        alertController.addAction(deleteButton)
        alertController.addAction(sendButton)
        alertController.addAction(closeButton)
        alertController.addAction(cancelButton)
        
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func tappedDeleteEdit(){
        let alert = UIAlertController(title: "Are you sure want to Delete this Appointment?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.DeleteAppointment()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func DeleteAppointment(){
        
        let parameters = [
            "ObjectId": Id,
            "ObjectName": "appointment",
            "OrganizationId": currentOrgID,
            "PassKey": passKey
            ] as [String : Any]
        
        var mainURL:String!
        let headers = [
            "Content-Type": "application/json",
            ]
        
        mainURL = "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/delete.json"
        
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
                let alert = UIAlertController(title:"Appointment Deleted Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    if(self.EditCondition == "calendar"){
                    NavigationHelper().createMenuView()
                    }
                    else{
                        self.navigationController?.popViewController(animated:true)
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
                catch {
                    print(error.localizedDescription)
                }
            })
           dataTask.resume()
    }
    
    
    func tappedCompleteedit() {
            let parameters = [
                "ForUsers":[],
                "From": startTime,
                "IncludeAppointments": true,
                "IncludeAttendees": true,
                "IncludeTasks": false,
                "OrganizationId": currentOrgID,
                "To": endTime,
                "PassKey": passKey
                ] as [String : Any]
            profileCompleteAlert(param: parameters)
    }
    
    func profileCompleteAlert(param:[String : Any]){
        let alert = UIAlertController(title: "Are you sure want to Complete this Appointment?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.UpdatedNewAppointment(jsonParameter: param)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func UpdatedNewAppointment1(){
        let parameters = [
            "ForUsers":[],
            "From": startTime,
            "IncludeAppointments": true,
            "IncludeAttendees": true,
            "IncludeTasks": false,
            "OrganizationId": currentOrgID,
            "To": endTime,
            "PassKey": passKey
            ] as [String : Any]
        var mainURL:String!
        let headers = [
            "Content-Type": "application/json",
            ]
        
        mainURL = "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.calendar.VCCalendarEndpoint/getActivities.json"
        
        let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 7.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        //        request.httpBody = postData as Data
        
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
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
    }
    
    
    func UpdatedNewAppointment(jsonParameter:[String : Any]){
        print(jsonParameter)
        var mainURL:String!
        let headers = [
            "Content-Type": "application/json",
            ]
        
        
        mainURL = "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.calendar.VCCalendarEndpoint/getActivities.json"
        
        let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 7.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        //        request.httpBody = postData as Data
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: jsonParameter, options: []) {
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
                let activities = result["Activities"].arrayValue
                print(activities)
                for dic in activities{
                    let value = dic["Activity"]
                    print(value)
                    print(value["Id"])
                    if(value["Id"].stringValue == self.Id){
                        
                        print("OUTPUT SUCCESS")
                        
                        self.CreatedByinput = value["CreatedBy"].stringValue
                        self.CreatedOninput = value["CreatedOn"].stringValue
                        self.EndTimeinput = value["EndTime"].stringValue
                        self.ModifiedByinput = value["ModifiedBy"].stringValue
                        self.ModifiedOninput = value["ModifiedOn"].stringValue
                        self.RecurrenceIndexinput = value["RecurrenceIndex"].stringValue
                        self.RecurringActivityIdinput = value["RecurringActivityId"].stringValue
                        self.StartTimeinput = value["StartTime"].stringValue
                        self.Subjectinput = value["Subject"].stringValue
                        self.Descriptioninput = value["Description"].stringValue
                        self.Locationinput = value["Location"].stringValue
                        self.AppointmentTypeIdinput = value["AppointmentTypeId"].stringValue
                        self.AppliedAdvocateProcessIdinput = value["AppliedAdvocateProcessId"].stringValue
                        
                        let parameters1 = [
                            "DataObject": [
                                "Location" : self.Locationinput,
                                "AppointmentTypeId":self.AppointmentTypeIdinput,
                                "AppliedAdvocateProcessId":self.AppliedAdvocateProcessIdinput,
                                "AdvocateProcessIndex": 0,
                                "AllDay": self.isAlldayEvent,
                                "Complete": true,
                                "CreatedBy": self.CreatedByinput!,
                                "CreatedOn": self.CreatedOninput!,
                                "Description":self.Descriptioninput!,
                                "EndTime": self.EndTimeinput!,
                                "Id": self.Id,
                                "ModifiedBy": self.ModifiedByinput!,
                                "ModifiedOn": self.ModifiedOninput!,
                                "RecurrenceIndex": value["RecurrenceIndex"].intValue,
                                "RecurringActivityId": self.RecurringActivityIdinput!,
                                "RollOver": self.isRollOver,
                                "StartTime": self.StartTimeinput!,
                                "Subject": self.Subjectinput!
                            ],
                            "OrganizationId": currentOrgID,
                            "ObjectName": "appointment",
                            "PassKey": passKey
                            ] as [String : Any]
                        
                        var mainURL:String!
                        let headers = [
                            "Content-Type": "application/json",
                            ]
                        mainURL = "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/modify.json"
                        
                        let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                                          cachePolicy: .useProtocolCachePolicy,
                                                          timeoutInterval: 7.0)
                        
                        request.httpMethod = "POST"
                        request.allHTTPHeaderFields = headers
                        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters1, options: []) {
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
                                let alert = UIAlertController(title:"Appointment Completed Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                    if(self.EditCondition == "calendar"){
                                        NavigationHelper().createMenuView()
                                    }
                                    else{
                                        self.navigationController?.popViewController(animated:true)
                                    }
                                }))
                                 self.present(alert, animated: true, completion: nil)
                            }catch {
                                print(error.localizedDescription)
                            }
                        })
                       
                        dataTask11.resume()
                    }
                }
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
    }
    
    
    func UpdateEditRequest(){
        
        cancelBtn.isUserInteractionEnabled = false
        donelBtn.isUserInteractionEnabled = false
        
        let parameters = [
            "ForUsers":[],
            "From": startTime,
            "IncludeAppointments": true,
            "IncludeAttendees": true,
            "IncludeTasks": false,
            "OrganizationId": currentOrgID,
            "To": endTime,
            "PassKey": passKey
            ] as [String : Any]
        
        var mainURL:String!
        let headers = [
            "Content-Type": "application/json",
            ]
        
        
        mainURL = "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.calendar.VCCalendarEndpoint/getActivities.json"
        
        let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 7.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        //        request.httpBody = postData as Data
        
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
                let activities = result["Activities"].arrayValue
                print(activities)
                var parameters1 : [String : Any]
                if(self.RecurrenceID != ""){
                        parameters1 = [
                            "DataObject": [
                                "Location" : self.fieldLocation.text!,
                                "AdvocateProcessIndex": self.AdvacateIndexID,
                                "AppointmentTypeId" : self.appointmentById,
                                "AllDay": self.isAlldayEvent,
                                "Complete": self.isComplete,
                                "CreatedBy": self.CreatedByinput!,
                                "CreatedOn": self.CreatedOninput!,
                                "Description":self.fieldComments.text!,
                                "EndTime": self.endTime,
                                "Id": self.Id,
                                "ModifiedBy": self.ModifiedByinput!,
                                "ModifiedOn": self.ModifiedOninput!,
                                "RecurrenceIndex": self.RecurrenceIndex!,
                                "RecurringActivityId":self.RecurrenceID!,
                                "RollOver": self.isRollOver,
                                "StartTime": self.startTime,
                                "Subject": self.fieldSubject.text!
                            ],
                            "OrganizationId": currentOrgID,
                            "ObjectName": "appointment",
                            "PassKey": passKey
                            ] as [String : Any]
                }
                else{
                    if(self.AppliedAdvocateProcessId == nil){
                        self.AppliedAdvocateProcessId = ""
                    }
                    //appointmentById
                    parameters1 = [
                        "DataObject": [
                            "Location" : self.fieldLocation.text!,
                            "AdvocateProcessIndex": self.AdvacateIndexID!,
                            "AppointmentTypeId" : self.appointmentById,
                            "AppliedAdvocateProcessId":self.AppliedProcessId,
                            "AllDay": self.isAlldayEvent,
                            "Complete": self.isComplete,
                            "CreatedBy": self.CreatedByinput!,
                            "CreatedOn": self.CreatedOninput!,
                            "Description":self.fieldComments.text!,
                            "EndTime": self.endTime,
                            "Id": self.Id,
                            "ModifiedBy": self.ModifiedByinput!,
                            "ModifiedOn": self.ModifiedOninput!,
                            "RecurrenceIndex": self.RecurrenceIndex!,
                            "RollOver": self.isRollOver,
                            "StartTime": self.startTime,
                            "Subject": self.fieldSubject.text!
                        ],
                        "OrganizationId": currentOrgID,
                        "ObjectName": "appointment",
                        "PassKey": passKey
                        ] as [String : Any]
                    
                }
                        
                        var mainURL:String!
                        let headers = [
                            "Content-Type": "application/json",
                            ]
                        mainURL = "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/modify.json"
                        
                        let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                                          cachePolicy: .useProtocolCachePolicy,
                                                          timeoutInterval: 7.0)
                        
                        request.httpMethod = "POST"
                        request.allHTTPHeaderFields = headers
                        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters1, options: []) {
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
                                let alert = UIAlertController(title:"Appointment Saved Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                    if(self.EditCondition == "calendar"){
                                        NavigationHelper().createMenuView()
                                    }
                                    else{
                                        self.navigationController?.popViewController(animated:true)
                                    }
                                }))
                                 self.present(alert, animated: true, completion: nil)
                            }catch {
                                print(error.localizedDescription)
                            }
                        })
                        dataTask11.resume()
                    
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
    }
    
    
    func updateRequest(){
        var mainURL:String = createContact
        
        let insertData:NSMutableDictionary = [:]
        insertData.setValue(fieldSubject.text!, forKey: "Subject")
        insertData.setValue(fieldComments.text!, forKey: "Description")
        insertData.setValue(appointmentById, forKey: "AppointmentTypeId")
        insertData.setValue(fieldLocation.text!, forKey: "Location")
        insertData.setValue(startTime, forKey: "StartTime")
        insertData.setValue(endTime, forKey: "EndTime")
        
        insertData.setValue(isAlldayEvent, forKey: "AllDay")
        insertData.setValue(isRollOver, forKey: "RollOver")
        insertData.setValue(isComplete, forKey: "Complete")
       // insertData.setValue("", forKey: "AppliedAdvocateProcessId")
       
        if openedActivties != nil {
            if openedActivties.activity.recurrenceID != nil {
                insertData.setValue(openedActivties.activity.recurrenceID, forKey: "RecurringActivityId")
            }
            mainURL = modifyURL
            insertData.setValue(openedActivties.activity.id, forKey: "Id")
        }
        var objectName:String = "appointment"
        if fromAccounts {
            objectName = "appointment"
        }
        let json: [String: Any] = ["ObjectName": objectName,
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID,
                                   "DataObject":insertData]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: mainURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                        if let getDataObject:NSDictionary = jsonResponse["DataObject"] as? NSDictionary {
                            if let getID:String = getDataObject["Id"] as? String {
                                print(getID)
                                if(self.fieldContacts.text != ""){
                                self.linkAppointmentContacts(rightID: getID)
                                }
                                if(self.fieldChooseTeamMember.text != ""){
                                 self.linkAppointmentUseres(rightID: getID)
                                }
                                self.UpdatedNewAppointment1()
                            }
                        }
                    }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        print(responseMessage)
                        OperationQueue.main.addOperation {
                            let alert = UIAlertController(title: self.openedActivties != nil ? "Appointment Updated Successfully" : "Appointment Created Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                if(self.EditCondition == "calendar"){
                                   NavigationHelper().createMenuView()
                                }
                                else{
                                    self.navigationController?.popViewController(animated:true)
                                }
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func linkAppointmentContacts(rightID:String){
        if openedActivties != nil {
            OperationQueue.main.addOperation {
                let alert = UIAlertController(title: self.openedActivties != nil ? "Appointment Updated Successfully" : "Appointment Created Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    if(self.EditCondition == "calendar"){
                        NavigationHelper().createMenuView()
                    }
                    else{
                        self.navigationController?.popViewController(animated:true)
                    }
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
            return
        }
        if contactsIDList.count == 0 {
            if contactList.count > 0 {
                
                let getEachContact = contactList[0]
                
                var contactID:String = getEachContact.id
                
                var LeftObjectName:String = "appointment"
                if fromAccounts {
                    contactID = linkParentID
                    LeftObjectName = "appointment"
                }
                
                let json: [String: Any] = ["ObjectName": "linker_appointments_contacts",
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
                        let alert = UIAlertController(title: self.openedActivties != nil ? "Appointment Updated Successfully" : "Appointment Created Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            if(self.EditCondition == "calendar"){
                               NavigationHelper().createMenuView()
                            }
                            else{
                                self.navigationController?.popViewController(animated:true)
                            }
                            
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
            var LeftObjectName:String = "appointment"
            if fromAccounts {
                LeftObjectName = "appointment"
            }
            
            let json: [String: Any] = ["ObjectName": "linker_appointments_contacts",
                                       "LeftId": rightID,
                                       "LeftObjectName": LeftObjectName,
                                       "RightId": contactsIDList[0],
                                       "RightObjectName": "contact",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
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
                    let alert = UIAlertController(title: self.openedActivties != nil ? "Appointment Updated Successfully" : "Appointment Created Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        if(self.EditCondition == "calendar"){
                            NavigationHelper().createMenuView()
                        }
                        else{
                            self.navigationController?.popViewController(animated:true)
                        }
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
//                print(error.localizedDescription)
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
                
                var RightObjectName:String = "contact"
                if fromAccounts {
                    contactID = linkParentID
                    RightObjectName = "organization_user"
                }
                
                let json: [String: Any] = ["ObjectName": "linker_appointments_users",
                                           "LeftId": rightID,
                                           "LeftObjectName": "appointment",
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
                        let alert = UIAlertController(title: self.openedActivties != nil ? "Appointment Updated Successfully" : "Appointment Created Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            if(self.EditCondition == "calendar"){
                               NavigationHelper().createMenuView()
                            }
                            else{
                                self.navigationController?.popViewController(animated:true)
                            }
                            
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
            
            var RightObjectName:String = "contact"
            if fromAccounts {
                RightObjectName = "organization_user"
            }
            
            let json: [String: Any] = ["ObjectName": "linker_appointments_users",
                                       "LeftId": rightID,
                                       "LeftObjectName": "appointment",
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
                    let alert = UIAlertController(title: self.openedActivties != nil ? "Appointment Updated Successfully" : "Appointment Created Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        if(self.EditCondition == "calendar"){
                             NavigationHelper().createMenuView()
                        }
                        else{
                            self.navigationController?.popViewController(animated:true)
                        }

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
                
                var RightObjectName:String = "contact"
                if fromAccounts {
                    contactID = linkParentID
                    RightObjectName = "company"
                }
                
                let json: [String: Any] = ["ObjectName": "linker_appointments_companies",
                                           "LeftId": rightID,
                                           "LeftObjectName": "appointment",
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
                            let alert = UIAlertController(title: self.openedActivties != nil ? "Appointment Updated Successfully" : "Appointment Created Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                if(self.EditCondition == "calendar"){
                                    NavigationHelper().createMenuView()
                                }
                                else{
                                    self.navigationController?.popViewController(animated:true)
                                }

                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                },  onFailure: { error in
                    OperationQueue.main.addOperation {
                        let alert = UIAlertController(title: self.openedActivties != nil ? "Appointment Updated Successfully" : "Appointment Created successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                            if(self.EditCondition == "calendar"){
                               NavigationHelper().createMenuView()
                            }
                            else{
                                self.navigationController?.popViewController(animated:true)
                            }
                            
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
    
            var RightObjectName:String = "contact"
            if fromAccounts {
                RightObjectName = "company"
            }
            
            let json: [String: Any] = ["ObjectName": "linker_appointments_companies",
                                       "LeftId": rightID,
                                       "LeftObjectName": "appointment",
                                       "RightId": accountsIDList[0],
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
                    self.linkAppointmentCompanies(rightID: rightID)
                }
            },  onFailure: { error in
                OperationQueue.main.addOperation {
                    let alert = UIAlertController(title: self.openedActivties != nil ? "Appointment Updated Successfully" : "Appointment Created Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        if(self.EditCondition == "calendar"){
                          NavigationHelper().createMenuView()
                        }
                        else{
                            self.navigationController?.popViewController(animated:true)
                        }

                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }else{
            OperationQueue.main.addOperation {
                let alert = UIAlertController(title: self.openedActivties != nil ? "Appointment Created Successfully" : "Appointment Created Successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    if(self.EditCondition == "calendar"){
                        NavigationHelper().createMenuView()
                    }
                    else{
                        self.navigationController?.popViewController(animated:true)
                    }

                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    func getLinkerAccounts(){
        
        let parameters = [
            "ObjectName": "linker_appoinments_companies",
            "LinkParentId": openedActivties.activity.id!,
            "ListObjectName": "company",
            "OrganizationId": currentOrgID,
            "PassKey": passKey,
            "PageOffset":1,
            "ResultsPerPage":1000
            ] as [String : Any]
        
        
        print(parameters)
        let request = NSMutableURLRequest(url: NSURL(string: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listLinked.json")! as URL,
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
                
                let tempResultID:NSMutableArray = []
                
                self.accountsIDList = []
                
                self.linkedAccountsIDList = []

                self.selectedCompanies = []
                if(getModel.results.count > 0){
                self.getObjectContact = []
                }
                for index in 0..<getModel.results.count {
                    let getResult = getModel.results[index]
                    self.getObjectContact.append(getResult.name)
                    tempResultID.add(getResult.id)
                    self.linkedAccountsIDList.add(getResult.id)
                    self.accountsIDList.add(getResult.id)
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
                
                
                if self.getObjectContact.count > 0 {
                    let stringRepresentation = self.getObjectContact.joined(separator: ", ")// "1-2-3"
                    self.fieldChooseAccounts.text = stringRepresentation
                }else{
                   // self.fieldChooseAccounts.text = ""
                }
                
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
    }
    func getLinkerUsers(){
        let parameters = [
            "ObjectName": "linker_appointments_users",
            "LinkParentId": openedActivties.activity.id!,
            "ListObjectName": "organization_user",
            "OrganizationId": currentOrgID,
            "PassKey": passKey
            ] as [String : Any]
        print(parameters)
        let request = NSMutableURLRequest(url: NSURL(string: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listLinked.json")! as URL,
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
                
                let getModel = getLinkedMembersModel.init(fromDictionary: jsonObj as! NSDictionary)
                let tempResultID:NSMutableArray = []

                self.teamMembersIDList = []
                self.linkedTeamMemberIDList = []
                
                self.selectedTeamMembers = []
                self.getObjectNames = []
                for index in 0..<getModel.results.count {
                    let getResult = getModel.results[index]
                    print(getResult.fullName)
                    self.getObjectNames.append(getResult.fullName)
                    tempResultID.add(getResult.id)
                    self.linkedTeamMemberIDList.add(getResult.id)
                    self.teamMembersIDList.add(getResult.id)

                }
                
                let tempContactID:NSMutableArray = []
                for index in 0..<self.teamMembers.count{
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
                
                if self.getObjectNames.count > 0 {
                    let stringRepresentation = self.getObjectNames.joined(separator: ", ")// "1-2-3"
                    self.fieldChooseTeamMember.text = stringRepresentation
                }else{
                   // self.fieldChooseTeamMember.text = ""
                }
                
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
    }
    func getListlinkedAccounts(){
        let parameters = [
            "ObjectName": "linker_appointments_contacts",
            "LinkParentId": openedActivties.activity.id!,
            "ListObjectName": "contact",
            "OrganizationId": currentOrgID,
            "PassKey": passKey,
            "PageOffset":1,
            "ResultsPerPage":1000
            ] as [String : Any]
        print(parameters)
        let request = NSMutableURLRequest(url: NSURL(string: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listLinked.json")! as URL,
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
                
                
                self.getObjectAccount = []
                for index in 0..<getModel.results.count {
                    let getResult = getModel.results[index]
                    print(getResult.fullName)
                    tempResultID.add(getResult.id)
                    self.linkedContactIDList.add(getResult.id)
                    self.getObjectAccount.append(getResult.fullName)
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
                
                if self.getObjectAccount.count > 0 {
                    let stringRepresentation = self.getObjectAccount.joined(separator: ", ")// "1-2-3"
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
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 14
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
extension NewAppointmentsController: CZPickerViewDelegate, CZPickerViewDataSource {
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 0 {
            return contactList.count
        }else if pickerView.tag == 1 {
            return teamMembers.count
        }else if pickerView.tag == 2 {
            return accountsList.count
        }else if pickerView.tag == 3 {
            return appointmentType.count
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
        }else if pickerView.tag == 3 {
            return appointmentType.count
        }
        return 0
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
        else if pickerView.tag == 3 {
            let Arrayname : NSMutableArray = []
            for i in 0 ..< appointmentType.count {
                let getContact = appointmentType[i]
                Arrayname.add(getContact.name)
            }
            return Arrayname
        }
      
        return []
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
        }else if pickerView.tag == 3 {
            let getContact = appointmentType[row]
            return getContact.name
        }
        return ""
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        self.setupBottomView()
        if pickerView.tag == 0 {
            let getContact = contactList[row]
            fieldContacts.text = getContact.fullName
        }else if pickerView.tag == 1 {
            let getContact = teamMembers[row]
            if getContact.fullName.count == 0 {
                fieldChooseTeamMember.text = getContact.firstName + " " + getContact.lastName
            }else{
                fieldChooseTeamMember.text = getContact.fullName
            }
        }else if pickerView.tag == 2 {
            let getContact = accountsList[row]
            fieldChooseAccounts.text = getContact.name
        }else if pickerView.tag == 3 {
            let getContact = appointmentType[row]
            fieldAppointmentType.text = getContact.name
            self.appointmentById = getContact.id
        }
    }
    
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
        
        self.setupBottomView()

        
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
            let leftIDD:String = openedActivties.activity.id!
            let json: [String: Any] = ["ObjectName": "linker_appointments_contacts",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "appointment",
                                       "RightId": contactListID[0],
                                       "RightObjectName": "contact",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: removeLinkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    contactListID.removeObject(at: 0)
                    self.removeUpdatedLink(contactListID: contactListID, addContactListID: addContactListID)
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }else if addContactListID.count > 0{
            let leftIDD:String = openedActivties.activity.id!

            let json: [String: Any] = ["ObjectName": "linker_appointments_contacts",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "appointment",
                                       "RightId": addContactListID[0],
                                       "RightObjectName": "contact",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    addContactListID.removeObject(at: 0)
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
            let leftIDD:String = openedActivties.activity.id!
            let json: [String: Any] = ["ObjectName": "linker_appointments_users",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "appointment",
                                       "RightId": contactListID[0],
                                       "RightObjectName": "contact",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: removeLinkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    contactListID.removeObject(at: 0)
                    self.removeUpdatedteamLink(contactListID: contactListID, addContactListID: addContactListID)
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }else if addContactListID.count > 0{
            let leftIDD:String = openedActivties.activity.id!
            
            let json: [String: Any] = ["ObjectName": "linker_appointments_users",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "appointment",
                                       "RightId": addContactListID[0],
                                       "RightObjectName": "contact",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    addContactListID.removeObject(at: 0)
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
            let leftIDD:String = openedActivties.activity.id!
            let json: [String: Any] = ["ObjectName": "linker_appointments_companies",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "appointment",
                                       "RightId": contactListID[0],
                                       "RightObjectName": "contact",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: removeLinkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    contactListID.removeObject(at: 0)
                    self.removeUpdatedAccountsLink(contactListID: contactListID, addContactListID: addContactListID)
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }else if addContactListID.count > 0{
            let leftIDD:String = openedActivties.activity.id!
            
            let json: [String: Any] = ["ObjectName": "linker_appointments_companies",
                                       "LeftId": leftIDD,
                                       "LeftObjectName": "appointment",
                                       "RightId": addContactListID[0],
                                       "RightObjectName": "contact",
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            
            APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    addContactListID.removeObject(at: 0)
                    self.removeUpdatedAccountsLink(contactListID: contactListID, addContactListID: addContactListID)
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
        }
    }

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
                    self.getObjectAccount.append(getContact.fullName)
                    self.selectedContacts.add(row)
                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldContacts.text = stringRepresentation
                UserDefaults.standard.removeObject(forKey: "filterarray")
                UserDefaults.standard.setValue(self.selectedContacts, forKey: "filterarray")
                
            }else{
                //self.fieldContacts.text = ""
            }
            if openedActivties != nil {
                setupLinkedContacts()
            }
        }else if pickerView.tag == 1 {
            
            self.teamMembersIDList = []
            self.selectedTeamMembers = []

            if rows.count == 0 {
                self.fieldChooseTeamMember.text = ""
                return
            }
            var selectedContacts:[String] = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = teamMembers[row]
                    print(getContact.fullName)
                    self.teamMembersIDList.add(getContact.id!)
                    selectedContacts.append(getContact.fullName)
                    self.getObjectNames.append(getContact.fullName)
                    self.selectedTeamMembers.add(row)

                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseTeamMember.text = stringRepresentation
            }else{
              //  self.fieldChooseTeamMember.text = ""
            }
            if openedActivties != nil {
                setupLinkedTeamMembers()
            }
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
                    self.getObjectContact.append(getContact.name)

                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseAccounts.text = stringRepresentation
            }else{
               // self.fieldChooseAccounts.text = ""
            }
            if openedActivties != nil {
                setupLinkedAccounts()
            }
        }else if pickerView.tag == 3 {
            self.selectedappointmentType = []
            self.appointmentType = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = appointmentType[row]
                    print(getContact.name)
                    print(getContact.id)
                    selectedappointmentType.add(row)
                }
            }
           
        }
    }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, with value: Bool, arrayvalue array: NSMutableArray!) {
        if(value){
        if pickerView.tag == 0 {
            var selectedContacts:[String] = []
            self.selectedContacts = []
//            for row in rows {
//                if let row = row as? Int {
//                    let getContact = array[row] as! String
//                    selectedContacts.append(getContact)
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
                            self.getObjectAccount.append(getContacts.fullName)
                        }
                    }
                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldContacts.text = stringRepresentation
            }else{
               // self.fieldContacts.text = ""
            }
            if openedActivties != nil {
                setupLinkedContacts()
            }
        }else if pickerView.tag == 1 {
            self.selectedTeamMembers = []
            var selectedContacts:[String] = []
//            for row in rows {
//                if let row = row as? Int {
//                    let getContact = array[row] as! String
//                    selectedContacts.append(getContact)
//                    self.selectedTeamMembers.add(row)
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
                            self.getObjectNames.append(getContacts.fullName)
                        }
                    }
                    
                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseTeamMember.text = stringRepresentation
            }else{
                //self.fieldChooseTeamMember.text = ""
            }
            if openedActivties != nil {
                setupLinkedTeamMembers()
            }
        }else if pickerView.tag == 2 {
            self.selectedCompanies = []
            self.accountsIDList = []
            var selectedContacts:[String] = []
//            for row in rows {
//                if let row = row as? Int {
//                    let getContact = array[row]as! String
//                    selectedContacts.append(getContact)
//                    self.selectedCompanies.add(row)
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
                            self.getObjectContact.append(getContacts.name)
                        }
                    }
                }
            }
            if selectedContacts.count > 0 {
                let stringRepresentation = selectedContacts.joined(separator: ", ")// "1-2-3"
                self.fieldChooseAccounts.text = stringRepresentation
            }else{
                //self.fieldChooseAccounts.text = ""
            }
            if openedActivties != nil {
                setupLinkedAccounts()
            }
        }else if pickerView.tag == 3 {
            for row in rows {
                if let row = row as? Int {
                    let getContact = array[row] as! String
                    print(getContact)
                }
            }
            
        }
    }
    }
}
extension NewAppointmentsController:UITextFieldDelegate {
    func showContactsPicker(){
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
        }
        let picker = CZPickerView(headerTitle: "Contacts", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        
        picker?.delegate = self
        
        if (self.fieldContacts.text?.count)! > 0 && openedActivties != nil && self.selectedContacts.count == 0 {
            for index in 0..<self.contactList.count {
                let getID = self.contactList[index].fullName
                if self.getObjectAccount.contains(getID!) {
                    let getContact = self.contactList[index]
                    self.contactsIDList.add(getContact.id!)
//                    self.selectedContacts.append(getContact.fullName)
                    self.selectedContacts.add(index)
                }
            }
        }else if (self.fieldContacts.text?.count)! > 0 {
            self.selectedContacts = []
            for index in 0..<self.contactList.count {
                let getID = self.contactList[index].fullName
                if self.getObjectAccount.contains(getID!) {
                    self.selectedContacts.add(index)
                }
            }
        }
        if selectedContacts.count > 0 {
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
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
        }
        let picker = CZPickerView(headerTitle: "Team Members", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        //self.teamMembersIDList
        if (self.fieldChooseTeamMember.text?.count)! > 0 && openedActivties != nil && self.selectedTeamMembers.count == 0 {
            for index in 0..<self.teamMembers.count {
                let getID = self.teamMembers[index].fullName
                if self.getObjectNames.contains(getID!) {
                    let getContact = self.teamMembers[index]
                    self.teamMembersIDList.add(getContact.id!)
                    self.selectedTeamMembers.add(index)
                }
            }
        }else if (self.fieldChooseTeamMember.text?.count)! > 0 {
            self.selectedTeamMembers = []
            for index in 0..<self.teamMembers.count {
                let getID = self.teamMembers[index].id
                if self.teamMembersIDList.contains(getID!) {
//                    let getContact = self.teamMembers[index]
                    self.selectedTeamMembers.add(index)
                }
            }
        }
        
        if selectedTeamMembers.count > 0 {
            picker?.setSelectedRows(selectedTeamMembers as! [Any])
        }
        //        picker?.setSelectedRows(selectedContacts as! [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1
        picker?.show()
    }
    func showAccountsPicker(){
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
        }
        let picker = CZPickerView(headerTitle: "Accounts", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        if (self.fieldChooseAccounts.text?.count)! > 0 && openedActivties != nil && self.selectedCompanies.count == 0 {
            self.selectedCompanies = []
            for index in 0..<self.accountsList.count {
                let getID = self.accountsList[index].name
                if self.getObjectContact.contains(getID!) {
                    self.selectedCompanies.add(index)
                }
            }
        }else if (self.fieldChooseAccounts.text?.count)! > 0 {
            self.selectedCompanies = []
            for index in 0..<self.accountsList.count {
                let getID = self.accountsList[index].name
                if self.getObjectContact.contains(getID!) {
                    self.selectedCompanies.add(index)
                }
            }
            if self.selectedCompanies.count == 0 {
                if fieldChooseAccounts.text == accountname {
                    //linkParentID
                    for index in 0..<self.accountsList.count {
                        let getID = self.accountsList[index].name
                        if self.getObjectContact.contains(getID!) {
                            self.selectedContacts.add(index)
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
    func showAppointmentTypes(){
        var appointments:[String] = []
        for index in 0..<appointmentType.count {
            let getAppoint = appointmentType[index]
            appointments.append(getAppoint.name)
        }
        DPPickerManager.shared.showPicker(title: "Appointment Type", selected: "", strings: appointments) { (value, index, cancel) in
            self.setupBottomView()
            
            if !cancel {
                let getAppoint = self.appointmentType[index]
                self.appointmentById = getAppoint.id
                self.fieldAppointmentType.text = value
                debugPrint(value as Any)
            }
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        removeBottomView()
        if textField == fieldContacts {
            textField.resignFirstResponder()
            showContactsPicker()
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return true
        }else if textField == fieldChooseTeamMember {
            textField.resignFirstResponder()
            showTeamMembers()
            return true
        }else if textField == fieldChooseAccounts {
            textField.resignFirstResponder()
            showAccountsPicker()
            return true
        }else if textField == fieldAppointmentType {
            textField.resignFirstResponder()
            showAppointmentTypes()
            return true
        }else if textField == fieldEndtime {
            textField.resignFirstResponder()
            if fieldStartTime.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message:"Please Choose Start Time")
                return true
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let getDate = formatter.date(from: fieldStartTime.text!)
            
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .minute, value: 15, to: getDate!)
            // Time Picker (custom picker)
            fieldLocation.resignFirstResponder()
            DPPickerManager.shared.showPicker(title: "End Time", picker: { (picker) in
                if((self.fieldEndtime.text?.count)! > 0) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    picker.date = formatter.date(from: self.fieldEndtime.text!)!
                }
                //                picker.date = Date()
                picker.datePickerMode = .date
                picker.minuteInterval = 15
            }) { (date, cancel) in
                self.setupBottomView()
                if !cancel {
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.fieldEndtime.text = formatter.string(from: date!)
                    
                    let enddate = formatter.string(from: date!)
                    let enddatetime = enddate + " " + self.EndtimeAppointment.text!
                    print(enddatetime)
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "yyyy-MM-dd hh:mm a"
                    let enddates = dateFormatter1.date(from:enddatetime)!
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.endTime = formatter.string(from: enddates)
                    // TODO: you code here
                    //                    debugPrint(date as Any)
                }
            }
            
            return true
        }
        else if textField == EndtimeAppointment {
            textField.resignFirstResponder()
            if Starttimeappointment.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message:"Please Choose Start Time")
                return true
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            let getDate = formatter.date(from: Starttimeappointment.text!)
            
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .minute, value: 15, to: getDate!)
            // Time Picker (custom picker)
            DPPickerManager.shared.showPicker(title: "End Time", picker: { (picker) in
                
                picker.datePickerMode = .time
                picker.minuteInterval = 15
                if((self.EndtimeAppointment.text?.count)! > 0) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    picker.date = formatter.date(from: self.EndtimeAppointment.text!)!
                }
                //                picker.date = Date()
               
                
            }) { (date, cancel) in
                self.setupBottomView()
                if !cancel {
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    self.EndtimeAppointment.text = formatter.string(from: date!)
                }
            }
            return true
        }else if textField == fieldStartTime {
            textField.resignFirstResponder()
            // Time Picker (custom picker)
            DPPickerManager.shared.showPicker(title: "Start Time", picker: { (picker) in
                
                if((self.fieldStartTime.text?.count)! > 0) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    picker.date = formatter.date(from: self.fieldStartTime.text!)!
                }
//                picker.date = Date()
                picker.datePickerMode = .date
            }) { (date, cancel) in
                self.setupBottomView()

                if !cancel {
                    self.fieldEndtime.text = ""
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.fieldStartTime.text = formatter.string(from: date!)
                    
                    let startdate = formatter.string(from: date!)
                    let startdatetime = startdate + " " + self.Starttimeappointment.text!
                    print(startdatetime)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                    let dates = dateFormatter.date(from:startdatetime)!
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.startTime = formatter.string(from: dates)
                    
                    
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .hour, value: 1, to: date!)
                    formatter.dateFormat = "yyyy-MM-dd"
                    self.fieldEndtime.text = formatter.string(from: date!)
                    
                    
                    let enddate = formatter.string(from: date!)
                    let enddatetime = enddate + " " + self.EndtimeAppointment.text!
                    print(enddatetime)
                    let dateFormatter1 = DateFormatter()
                    dateFormatter1.dateFormat = "yyyy-MM-dd hh:mm a"
                    let enddates = dateFormatter1.date(from:enddatetime)!
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.endTime = formatter.string(from: enddates)
                    // TODO: you code here
                    //                    debugPrint(date as Any)
                }
            }
            return true
        }
        else if textField == Starttimeappointment {
            textField.resignFirstResponder()
            // Time Picker (custom picker)
            DPPickerManager.shared.showPicker(title: "Start Time", picker: { (picker) in
                picker.datePickerMode = .time
                picker.minuteInterval = 15
                if((self.Starttimeappointment.text?.count)! > 0) {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    picker.date = formatter.date(from: self.Starttimeappointment.text!)!
                }
                //                picker.date = Date()
               
            }) { (date, cancel) in
                self.setupBottomView()
                
                if !cancel {
                    self.EndtimeAppointment.text = ""
                    let formatter = DateFormatter()
                    formatter.dateFormat = "hh:mm a"
                    self.Starttimeappointment.text = formatter.string(from: date!)
                    
                    let calendar = Calendar.current
                    let date = calendar.date(byAdding: .hour, value: 1, to: date!)
                    formatter.dateFormat = "hh:mm a"
                    self.EndtimeAppointment.text = formatter.string(from: date!)
                    
                    if(self.fieldStartTime.text != ""){
                    let start = self.fieldStartTime.text!
                    let startdatetime = start + " " + self.Starttimeappointment.text!
                    print(startdatetime)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                    let dates = dateFormatter.date(from:startdatetime)!
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.startTime = formatter.string(from: dates)
                    }
                    
                   
                    
                    let start = self.fieldEndtime.text!
                    let startdatetime = start + " " + self.EndtimeAppointment.text!
                    print(startdatetime)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
                    let dates = dateFormatter.date(from:startdatetime)!
                        
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.endTime = formatter.string(from: dates)
                    
                }
            }
            return true
        }
        setupBottomView()
        
        self.view.endEditing(true)
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);

        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
        }
        return true
    }
    
}
extension NewAppointmentsController:UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
        }
    }
}
extension NewAppointmentsController:URLSessionDelegate {
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
