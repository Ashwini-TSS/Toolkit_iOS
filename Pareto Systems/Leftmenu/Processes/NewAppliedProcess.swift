//
//  NewAppliedProcess.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 04/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class NewAppliedProcess: UIViewController {
    
    var contactTypes:NSArray = ["Contact","Company"]
    var conditionType:String!
    var Contactname:String = ""
    
    @IBOutlet weak var fieldName: ACFloatingTextfield!
    @IBOutlet weak var fieldInitializationDate: ACFloatingTextfield!
    @IBOutlet weak var btnWeekend: UIButton!
    @IBOutlet weak var btnDynamicProcess: UIButton!
    @IBOutlet weak var fieldContact: ACFloatingTextfield!
    @IBOutlet weak var fieldAppointmentType: ACFloatingTextfield!
    var processList:GetProcessesResult!
    var processesList:[GetProcessesResult] = []
    var contactsList:[familyContactResult] = []
    var getSearchList:[searchAccountResult] = []
    var appliedProcess:AppliedProcessResult!
    var getprocessList:[GetProcessesResult] = []
    var getprocessesList:[GetProcessesResult] = []
    var isFromContact:Bool = false
    var isFromAccount:Bool = false
    var contactListResult:ContactListResult!
    var contactInfoDetail:GetAccountsListResult!

    var tappedContact:Bool = true
    var isDynamicProcess:Bool = false
    var isWeekend:Bool = false
    var initDate:String = ""
    var isFromApplyProcess:Bool = false
    
    //API
    var advocateProcessID:String = ""
    var contactID:String = ""
    var companyID:String = ""
    
    var tempContactName:String = ""
    var tempCompanyName:String = ""
    
    func converDateToString(dateString:String) -> String{
        if dateString.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "YYYY-MM-dd" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // change format as per needs
        let result = formatter.string(from: date)
        fieldInitializationDate.text = result
        formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.initDate = formatter.string(from: date)
        
        setupProcessList()
//        tableView.tableFooterView = UIView()

    }
    func setupProcessList(){
        if processList != nil {
            fieldName.text = processList.name
            advocateProcessID = processList.id
        }
        
        if appliedProcess != nil {
            fieldName.text = appliedProcess.name
            advocateProcessID = appliedProcess.advocateProcessId
            isDynamicProcess = appliedProcess.dynamicProcess
            isWeekend = appliedProcess.weekendAvoidance
           // fieldInitializationDate.text = converDateToString(dateString: appliedProcess.initializationDate)
            initDate = appliedProcess.initializationDate
            fieldAppointmentType.text = "Contact"
            
            if appliedProcess.contactId != nil {
                if appliedProcess.contactId.count > 0 {
                    contactID = appliedProcess.contactId
                    self.tappedContact = true
                    self.fieldContact.placeholder = "Search Contact"
                    callContacts(contactID: appliedProcess.contactId)
                }
            }
            
            if appliedProcess.CompanyId != nil {
                if appliedProcess.CompanyId.count > 0 {
                    companyID = appliedProcess.CompanyId
                    fieldAppointmentType.text = "Company"
                    self.tappedContact = false
                    self.fieldContact.placeholder = "Search Company"
                    getCompany(companyID: appliedProcess.CompanyId)
                }
            }
            
            if isWeekend == false {
                btnWeekend.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
                
            }else{
                btnWeekend.setImage(UIImage.init(named:"ic_check"), for: .normal)
                
            }
            if isDynamicProcess == false {
                btnDynamicProcess.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
                
            }else{
                btnDynamicProcess.setImage(UIImage.init(named:"ic_check"), for: .normal)
                
            }
        }
        if isFromContact {
            fieldAppointmentType.text = "Contact"
            contactID = contactListResult.id!
            self.tappedContact = true
            self.fieldContact.placeholder = "Search Contact"
            callContacts(contactID: contactListResult.id!)
           // fieldInitializationDate.text = converDateToString(dateString: contactListResult.createdOn)
        }else if isFromAccount {
            //contactInfoDetail
            
            companyID = contactInfoDetail.id!
            fieldAppointmentType.text = "Company"
            self.tappedContact = false
            self.fieldContact.placeholder = "Search Company"
            
            if appliedProcess != nil {
                
                if appliedProcess.CompanyId != nil {
                    getCompany(companyID: appliedProcess.CompanyId)
                }
                
            }else{
                getCompanyLists()
            }
            
            
        }
    }
    func getCompanyLists(){
        let json: [String: Any] = ["ObjectName":"company",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "AscendingOrder":true,
                                   "PageOffset": 1,
                                   "ResultsPerPage": 5000,
                                   "OrderBy":"Name"]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: getOrgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let model = companyAccountModel.init(fromDictionary: jsonResponse)
                if model.valid == true {
                    
                    for index in 0..<model.results.count {
                        let getResult = model.results[index]
                        if getResult.id == self.contactInfoDetail.id! {
                            self.companyID = getResult.id
                            self.tempCompanyName = getResult.name
                            self.fieldContact.text = getResult.name
                        }
                    }
                }else{
                    self.getSearchList = []
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callContacts(contactID:String){
        let json: [String: Any] = ["ObjectName":"contact",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "SearchTerm":"",
                                   "PageOffset": 1,
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
                        if getResult.id == contactID {
                            self.tempContactName = getResult.fullName
                            self.fieldContact.text = getResult.fullName
                        }
                    }
                }else{
                    self.contactsList = []
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    
    func getCompany(companyID:String){
        let json: [String: Any] = ["ObjectName":"company",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "SearchTerm":"",
                                   "PageOffset": 1,
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
                        if getResult.id == companyID {
                            self.tempCompanyName = getResult.name
                            self.fieldContact.text = getResult.name
                        }
                    }
                }else{
                    self.getSearchList = []
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    override func viewWillAppear(_ animated: Bool) {

        getProcesses()
        
    }
    func getProcesses(){
        let json: [String: Any] = ["ObjectName": "advocate_process",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID,
                                   "AscendingOrder":true]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                self.processesList = []
                
                let getModel:GetProcessesModel = GetProcessesModel.init(fromDictionary: jsonResponse)
                
                
                if getModel.valid {
                    self.processesList = getModel.results
                    
//                    self.processesList = self.processesList.sorted(by: {
//                        $0.name.compare($1.name) == .orderedAscending
//                    })

                    
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func tappedSave(_ sender: Any) {
        if fieldName.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the \(String(describing: fieldName.placeholder!))")
            return
        }
        if fieldInitializationDate.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please choose the \(String(describing: fieldInitializationDate.placeholder!))")
            return
        }
        if processList != nil || appliedProcess != nil {
            if isFromApplyProcess {
                applyProcess()
                return
            }
            editProcess()
            return
        }
        applyProcess()
    }
    func editProcess(){
 
        var editID:String = ""
        var createdBy:String = ""
        var createdOn:String = ""
        var modifiedOn:String = ""
        var modifiedBy:String = ""
        var name:String = ""
        
        if processList != nil {
            editID = processList.id
            createdBy = processList.createdBy
            createdOn = processList.createdOn
            modifiedOn = processList.modifiedOn
            modifiedBy = processList.modifiedBy
            name = processList.name

        }
        if appliedProcess != nil {
            editID = appliedProcess.id
            createdBy = appliedProcess.createdBy
            createdOn = appliedProcess.createdOn
            modifiedOn = appliedProcess.modifiedOn
            modifiedBy = appliedProcess.modifiedBy
            name = appliedProcess.name

        }
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(advocateProcessID, forKey: "AdvocateProcessId")
        dataObject.setValue(contactID, forKey: "ContactId")
        dataObject.setValue(companyID, forKey: "CompanyId")
        dataObject.setValue(isDynamicProcess, forKey: "DynamicProcess")
        dataObject.setValue(isWeekend, forKey: "WeekendAvoidance")
        dataObject.setValue(initDate, forKey: "InitializationDate")
        dataObject.setValue(createdBy, forKey: "CreatedBy")
        dataObject.setValue(modifiedOn, forKey: "ModifiedOn")
        dataObject.setValue(createdOn, forKey: "CreatedOn")
        dataObject.setValue(editID, forKey: "Id")
        dataObject.setValue(modifiedBy, forKey: "ModifiedBy")
        dataObject.setValue(name, forKey: "Name")


        let json: [String: Any] = ["ObjectName": "applied_advocate_process",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID,
                                   "DataObject":dataObject]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: modifyURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
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
                        
                        OperationQueue.main.addOperation {
                            self.navigationController?.popViewController(animated: true)
                        }
                        
//                        NavigationHelper.showSimpleAlert(message:responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    func applyProcess(){
        
//        AdvocateProcessId: "2aeba45f-d71f-4f99-8d63-c03bbf1d69a8"
//        CompanyId: null
//        ContactId: "b7fc5561-8b2c-4525-9ddf-337c1545ee79"
//        DynamicProcess: true
//        InitializationDate: "2019-01-17T13:30:00.000Z"
//        WeekendAvoidance: true
//        ObjectName: "applied_advocate_process"
//        OrganizationId: "2603c1c8-17ee-48d7-acc0-51d9cbeca42a"
//        PassKey: "2Cs6zGShUdTODMudG1Z_Awk9L_QX5Y-k4dP0m7Ji-JIBNrkR1_Qt4KOjRI3lkJ5hPNmGW_t66yebXmAP2LxeH0w"
        
//        AdvocateProcessId: "8a833ae5-f465-49d5-9aa7-bfb60fc52e2d"
//        CompanyId: null
//        ContactId: "b5255266-b317-4403-b862-694d515eeb82"
//        DynamicProcess: true
//        InitializationDate: "2019-01-17T13:30:00.000Z"
//        WeekendAvoidance: true
//        ObjectName: "applied_advocate_process"
//        OrganizationId: "2603c1c8-17ee-48d7-acc0-51d9cbeca42a"
//        PassKey: "2X6WA-bx1O_kPGlpl1lxGfrOlUW0z_WJLf1HwhjIPGSKOmZl3PSyD--jRI3lkJ5hPNmGW_t66yebXmAP2LxeH0w"


        
        
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(advocateProcessID, forKey: "AdvocateProcessId")
        dataObject.setValue(contactID, forKey: "ContactId")
        if(companyID != ""){
        dataObject.setValue(companyID, forKey: "CompanyId")
        }
        dataObject.setValue(isDynamicProcess, forKey: "DynamicProcess")
        dataObject.setValue(isWeekend, forKey: "WeekendAvoidance")
        dataObject.setValue(initDate, forKey: "InitializationDate")
        
        let json: [String: Any] = ["ObjectName": "applied_advocate_process",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID,
                                   "DataObject":dataObject]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/create.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
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
                        
                        OperationQueue.main.addOperation {
                            self.navigationController?.popViewController(animated: true)
                        }
//                        NavigationHelper.showSimpleAlert(message:responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func tappedWeekendProcess(_ sender: Any) {
        if isWeekend == false {
            isWeekend = true
            btnWeekend.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            isWeekend = false
            btnWeekend.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
        }
    }
    
    @IBAction func tappedDailyProcess(_ sender: Any) {
        if isDynamicProcess == false {
            isDynamicProcess = true
            btnDynamicProcess.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            isDynamicProcess = false
            btnDynamicProcess.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 6
//    }

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
    func getContacts(){
        
        let json: [String: Any] = ["ObjectName":"contact",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "OrderBy":"FullName",
                                   "AscendingOrder":true,
                                   "PageOffset": 1,
                                   "ResultsPerPage": 5000]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let result = familyContactClassModel.init(fromDictionary: jsonResponse)
                print(result.responseMessage)
                if result.valid == true {
                    self.contactsList = result.results
                }else{
                    self.contactsList = []
                }
                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    
    func getCompany(){
        let json: [String: Any] = ["ObjectName":"company",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "OrderBy":"Name",
                                   "AscendingOrder":true,
                                   "PageOffset": 1,
                                   "ResultsPerPage": 5000]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let model = searchAccountClassModel.init(fromDictionary: jsonResponse)
                if model.valid == true {
                    self.getSearchList = model.results
                }else{
                    self.getSearchList = []
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    func getProcessList(){
        let json: [String: Any] = ["ObjectName": "advocate_process",
                                   "OrderBy": "Name",
                                   "AscendingOrder":true,
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                self.getprocessList = []
                
                let getModel:GetProcessesModel = GetProcessesModel.init(fromDictionary: jsonResponse)
                
                if getModel.valid {
                    self.getprocessList = getModel.results
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
}
extension NewAppliedProcess: CZPickerViewDelegate, CZPickerViewDataSource {
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 0 {
            return contactTypes.count
        }else if pickerView.tag == 1 {
            return contactsList.count
        }else if pickerView.tag == 2 {
            return getSearchList.count
        }else if pickerView.tag == 3 {
            return processesList.count
        }else if pickerView.tag == 12342332 {
            return getprocessesList.count
        }
        return 0
    }
    
    func czpickerView(_ pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
        return nil
    }
    
    func numberOfRowsInPickerView(pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 0 {
            return contactTypes.count
        }else if pickerView.tag == 1 {
            return contactsList.count
        }else if pickerView.tag == 2 {
            return getSearchList.count
        }else if pickerView.tag == 3 {
            return processesList.count
        }else if pickerView.tag == 12342332 {
            return getprocessesList.count
        }
        return 0
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        if pickerView.tag == 0 {
            return contactTypes[row] as! String
        }else if pickerView.tag == 1 {
            let getcontact:familyContactResult = contactsList[row]
            return getcontact.fullName
        }else if pickerView.tag == 2 {
            let getcontact:searchAccountResult = getSearchList[row]
            return getcontact.name
        }else if pickerView.tag == 3 {
            let getcontact:GetProcessesResult = processesList[row]
            return getcontact.name
        }else if pickerView.tag == 12342332 {
            let getcontact:GetProcessesResult = getprocessesList[row]
            return getcontact.name
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
            let Arrayname : NSMutableArray = []
            for i in 0 ..< processesList.count {
                let getContact = processesList[i]
                Arrayname.add(getContact.name)
            }
            return Arrayname
        }
        else if pickerView.tag == 12342332 {
            let Arrayname : NSMutableArray = []
            for i in 0 ..< getprocessesList.count {
                let getContact = getprocessesList[i]
                Arrayname.add(getContact.name)
            }
            return Arrayname
        }
        
        return []
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        
        if pickerView.tag == 0 {
            
            self.fieldContact.text = ""
            
            if row == 0 {
                
                self.tappedContact = true
                
                self.getContacts()
                
                if(conditionType == "Contact"){
                    
                    if(Contactname != ""){
                        
                        self.fieldContact.text = Contactname
                        
                    }
                        
                    else {
                        
                        self.setupProcessList()
                        
                    }
                    
                }
                
                self.fieldContact.placeholder = "Search Contact"
                
                if appliedProcess != nil {
                    
                    if appliedProcess.contactId != nil {
                        
                        if appliedProcess.contactId.count > 0 {
                            
                            self.fieldContact.text = tempContactName
                            
                        }
                        
                    }
                    
                }
                
                
                
            }else if row == 1 {
                
                self.tappedContact = false
                
                self.getCompany()
                
                if(conditionType == "Account"){
                    
                    if(Contactname != ""){
                        
                        self.fieldContact.text = Contactname
                        
                    }
                        
                    else {
                        
                        self.setupProcessList()
                        
                    }
                    
                }
                
                self.fieldContact.placeholder = "Search Company"
                
                if appliedProcess != nil {
                    
                    if appliedProcess.CompanyId != nil {
                        
                        if appliedProcess.CompanyId.count > 0 {
                            
                            self.fieldContact.text = tempCompanyName
                            
                        }
                        
                    }
                    
                }
                
                
                
            }
            
            self.fieldAppointmentType.text = contactTypes[row] as? String
            
            
            
            
            
        }else if pickerView.tag == 1 {
            
            let getcontact:familyContactResult = contactsList[row]
            
            contactID = getcontact.id
            
            fieldContact.text = getcontact.fullName
            
            Contactname = getcontact.fullName
            
            
            
            
            
        }else if pickerView.tag == 2 {
            
            let getcontact:searchAccountResult = getSearchList[row]
            
            companyID = getcontact.id
            
            fieldContact.text = getcontact.name
            
            Contactname = getcontact.name
            
        }else if pickerView.tag == 3 {
            
            let getcontact:GetProcessesResult = processesList[row]
            
            advocateProcessID = getcontact.id
            
            fieldName.text = getcontact.name
            
        }else if pickerView.tag == 12342332 {
            
            let getcontact:GetProcessesResult = getprocessesList[row]
            
            advocateProcessID = getcontact.id
            
            fieldName.text = getcontact.name
            
        }
        
    }
    
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
//        if pickerView.tag == 0 {
//            for row in rows {
//                if let row = row as? Int {
//                    self.fieldContact.text = ""
//                    if row == 0 {
//                        self.tappedContact = true
//                        self.getContacts()
//                        self.fieldContact.placeholder = "Contact"
//                    }else if row == 1 {
//                        self.tappedContact = false
//                        self.getCompany()
//                        self.fieldContact.placeholder = "Company"
//                    }
//                    self.fieldContact.text = contactTypes[row] as? String
//                }
//            }
//        }
    }
    
}
extension NewAppliedProcess:UITextFieldDelegate {
    
    func showProcessesPicker(){
        let picker = CZPickerView(headerTitle: "Process", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        //        picker?.setSelectedRows(selectedContacts as! [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = false
        picker?.tag = 12342332
        picker?.show()
    }
    
    func showContactsPicker(){
        let picker = CZPickerView(headerTitle: "Apply To Type", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        //        picker?.setSelectedRows(selectedContacts as! [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = false
        picker?.tag = 0
        picker?.show()
    }
    func showChooseContactsPicker(){
        if appliedProcess != nil {
            if appliedProcess.CompanyId != nil {
                if appliedProcess.CompanyId.count > 0 {
                    return
                }
            }
        }
        if appliedProcess != nil {
            if appliedProcess.contactId != nil {
                if appliedProcess.contactId.count > 0 {
                    return
                }
            }
        }
        let picker = CZPickerView(headerTitle: "Choose Contact", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
       // picker?.setSelectedRows(selectedContactInfo as! [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = false
        picker?.tag = 1
        picker?.show()
    }
    func showChooseCompanyPicker(){
        if appliedProcess != nil {
            if appliedProcess.contactId != nil {
                if appliedProcess.contactId.count > 0 {
                    return
                }
            }
        }
        if appliedProcess != nil {
            if appliedProcess.CompanyId != nil {
                if appliedProcess.CompanyId.count > 0 {
                    return
                }
            }
        }
      
        let picker = CZPickerView(headerTitle: "Choose Company", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        //        picker?.setSelectedRows(selectedContacts as! [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = false
        picker?.tag = 2
        picker?.show()
    }
    func showProcessPicker(){
        let picker = CZPickerView(headerTitle: "Process", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
      //  picker?.setSelectedRows(selectedContacts as! [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = false
        picker?.tag = 3
        picker?.show()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if textField == fieldName {
//            getProcessList()
//            return false
//        }
        if textField == fieldAppointmentType {
            showContactsPicker()
            return false
        }
        if textField == fieldContact {
            if tappedContact {
                showChooseContactsPicker()
            }else{
                showChooseCompanyPicker()
            }
            return false
        }
        if textField == fieldInitializationDate {
            DPPickerManager.shared.showPicker(title: "Initialization Date", picker: { (picker) in
                picker.date = Date()
                picker.datePickerMode = .date
            }) { (date, cancel) in
                if !cancel {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "YYYY-MM-dd"
                    self.fieldInitializationDate.text = formatter.string(from: date!)
                    
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.initDate = formatter.string(from: date!)
                    
                    // TODO: you code here
                    //                    debugPrint(date as Any)
                }
            }
            return false
        }
        if textField == fieldName {
            if processList != nil || appliedProcess != nil {
                textField.resignFirstResponder()
                showProcessPicker()

                return false
            }
            showProcessPicker()
            return false
        }
        return true
    }
}
extension NewAppliedProcess:URLSessionDelegate {
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
