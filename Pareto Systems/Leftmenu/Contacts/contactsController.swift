//
//  contactsController.swift
//  Pareto Systems
//
//  Created by Thabresh on 14/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class contactsController: UIViewController {

    var carsDictionary = [String: [String]]()
    var carSectionTitles = [String]()
    
    var contactList:[ContactListResult] = []
    @IBOutlet weak var tableView: UITableView!
    var userOrgID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarItem()
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 102
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        UserDefaults.standard.removeObject(forKey: "MoneyInfo")
        UserDefaults.standard.removeObject(forKey: "OccupationInfo")
        UserDefaults.standard.removeObject(forKey: "FamilyInfo")
        UserDefaults.standard.removeObject(forKey: "AddressInfo")
        UserDefaults.standard.removeObject(forKey: "BasicInfo")

        selectedContactInfo = nil
        //listByOrganization()
        
        self.userOrgID = currentOrgID
        self.getContactListAPI(orgID: self.userOrgID)
        
    }
    func listByOrganization() {
        
        let json: [String: Any] = ["OrderBy": "Name",
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: listByOrgURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:OrganizationMapping = OrganizationMapping.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    if logModel.organizations.count > 0 {
                        let getOrgID = logModel.organizations[0]
                        print(getOrgID.id)
                        currentOrgID = getOrgID.id
                        self.userOrgID = getOrgID.id
                        self.getContactListAPI(orgID: self.userOrgID)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Invalid session.")
                    NavigationHelper().setRootViewController()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
//            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    
    
    
    
    func getContactListAPI(orgID:String){
        let parameters = [
            "OrderBy": "",
            "ParentId": "",
            "ResultsPerPage": 5000,
            "OrganizationId": orgID,
            "PassKey": passKey,
            "ParentObjectName": "",
            "PageOffset": 1,
            "ObjectName": "contact",
            "AscendingOrder":true
            ] as [String : Any]
      
        APIManager.sharedInstance.postRequestCall(postURL: getOrgListURL, parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let contactModel = ContactListModel.init(fromDictionary: jsonResponse)
                print(contactModel.responseMessage)
                
                self.contactList = contactModel.results
                
                
                let nameList:NSMutableArray = []
                for index in 0..<contactModel.results.count {
                    let result = contactModel.results[index]
                    nameList.add("\(result.firstName!) \(result.lastName!)")
                }
                self.carSectionTitles = []
                self.carsDictionary = [String: [String]]()
                
                for car in nameList {
                    let name:String = car as! String
                    
                    let carKey = String(name.prefix(1))
                    if var carValues = self.carsDictionary[carKey] {
                        carValues.append(name)
                        self.carsDictionary[carKey] = carValues
                    } else {
                        self.carsDictionary[carKey] = [name]
                    }
                }
                self.carSectionTitles = [String](self.carsDictionary.keys)
                print(self.carSectionTitles)
                
                self.carSectionTitles = self.carSectionTitles.sorted(by: { $0 < $1 })
                
                self.tableView.reloadData()

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension contactsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return carSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let carKey = carSectionTitles[section]
        if let carValues = carsDictionary[carKey] {
            return carValues.count
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        let carKey = carSectionTitles[indexPath.section]
        if let carValues = carsDictionary[carKey] {
            cell.textLabel?.text = carValues[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return carSectionTitles[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 40))
        headerView.backgroundColor = UIColor.init(red: 143.0/255.0, green: 143.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        
        let label = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: tableView.bounds.size.width - 20, height: 30.0))
        label.text = carSectionTitles[section]
        headerView.addSubview(label)
        
        return headerView
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return carSectionTitles
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        let carKey = carSectionTitles[indexPath.section]
        if let carValues = carsDictionary[carKey] {
            let carTitle:String = carValues[indexPath.row]
            for index in 0..<contactList.count {
                let result = contactList[index]
                let contactName:String = "\(result.firstName!) \(result.lastName!)"
                
                if contactName == carTitle {
                    let controller:ContactssController = self.storyboard?.instantiateViewController(withIdentifier:"ContactssController") as! ContactssController
                    controller.contactInfoDetail = contactList[index]
                    self.navigationController?.pushViewController(controller, animated: true)
                    return
                }
            }
        }
        
//        selectedContactInfo = contactList[indexPath.row]
//
//        setupMoney()
//        setupOccupation()
//        setupFamily()
//        setupAddressInfo()
//        setupBasicInfo()
    }
    
    func setupMoney(){
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(selectedContactInfo.income, forKey: "Income")
        dataObject.setValue(selectedContactInfo.creditLimit, forKey: "CreditLimit")
        dataObject.setValue(selectedContactInfo.executorName, forKey: "ExecutorName")
        dataObject.setValue(selectedContactInfo.executorID, forKey: "ExecutorId")
        dataObject.setValue(selectedContactInfo.groupInsurance, forKey: "GroupInsurance")
        dataObject.setValue(selectedContactInfo.moneyNotes, forKey: "MoneyNotes")
        dataObject.setValue(selectedContactInfo.revenue, forKey: "Revenue")
        dataObject.setValue(selectedContactInfo.creditOnHold, forKey: "CreditOnHold")
        dataObject.setValue(selectedContactInfo.powerofAttorneyName, forKey: "PowerofAttorneyName")
        dataObject.setValue(selectedContactInfo.powerOfAttronyID, forKey: "PowerofAttorneyId")
        dataObject.setValue(selectedContactInfo.groupPensionPlan, forKey: "GroupPensionPlan")
        UserDefaults.standard.set(dataObject, forKey: "MoneyInfo")
    }
    
    func setupOccupation(){
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(selectedContactInfo.companyName, forKey: "CompanyName")
        dataObject.setValue(selectedContactInfo.companyId, forKey: "CompanyId")
        dataObject.setValue(selectedContactInfo.assistantName, forKey: "AssistantName")
        dataObject.setValue(selectedContactInfo.occupationNotes, forKey: "OccupationNotes")
        dataObject.setValue(selectedContactInfo.jobTitle, forKey: "JobTitle")
        dataObject.setValue(selectedContactInfo.department, forKey: "Department")
        dataObject.setValue(selectedContactInfo.assistantPhone, forKey: "AssistantPhone")
        dataObject.setValue(selectedContactInfo.recreationNotes, forKey: "RecreationNotes")
        UserDefaults.standard.set(dataObject, forKey: "OccupationInfo")
    }
    func setupFamily(){
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(selectedContactInfo.spousePartnerName, forKey: "SpousePartnerName")
        dataObject.setValue(selectedContactInfo.ChildrensNames, forKey: "ChildrensNames")
        dataObject.setValue(selectedContactInfo.spousePartnerID, forKey: "SpousePartnerId")
        dataObject.setValue(selectedContactInfo.familyNotes, forKey: "FamilyNotes")
        UserDefaults.standard.set(dataObject, forKey: "FamilyInfo")
    }
    func setupAddressInfo(){
        let dataObject:NSMutableDictionary = [:]
        //Address
        dataObject.setValue(selectedContactInfo.addressLine1, forKey: "AddressLine1")
        dataObject.setValue(selectedContactInfo.addressLine2, forKey: "AddressLine2")
        dataObject.setValue(selectedContactInfo.addressLine3, forKey: "AddressLine3")
        dataObject.setValue(selectedContactInfo.city, forKey: "City")
        dataObject.setValue(selectedContactInfo.state, forKey: "State")
        dataObject.setValue(selectedContactInfo.postal, forKey: "Postal")
        dataObject.setValue("", forKey: "Country")
        //        dataObject.setValue(countryField.text!, forKey: "Country")
        dataObject.setValue(selectedContactInfo.poBox, forKey: "PoBox")
        dataObject.setValue(selectedContactInfo.eMailAddress1, forKey: "EMailAddress1")
        dataObject.setValue(selectedContactInfo.eMailAddress2, forKey: "EMailAddress2")
        dataObject.setValue(selectedContactInfo.eMailAddress3, forKey: "EMailAddress3")
        dataObject.setValue(selectedContactInfo.webSiteUrl, forKey: "WebSiteUrl")
        dataObject.setValue(selectedContactInfo.ftpSiteUrl, forKey: "FtpSiteUrl")
        
        UserDefaults.standard.set(dataObject, forKey: "AddressInfo")
    }
    func setupBasicInfo(){
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(selectedContactInfo.salutation, forKey: "Salutation")
        dataObject.setValue(selectedContactInfo.firstName, forKey: "FirstName")
        dataObject.setValue(selectedContactInfo.middleName, forKey: "MiddleName")
        dataObject.setValue(selectedContactInfo.lastName, forKey: "LastName")
        dataObject.setValue(selectedContactInfo.gender, forKey: "Gender")
        
        
        dataObject.setValue(selectedContactInfo.anniversay, forKey: "Anniversary")
        
        
        dataObject.setValue(selectedContactInfo.title, forKey: "Title")
        dataObject.setValue(selectedContactInfo.suffix, forKey: "Suffix")
        dataObject.setValue(selectedContactInfo.nickName, forKey: "NickName")
        dataObject.setValue(true, forKey: "Private")
        dataObject.setValue(selectedContactInfo.governmentIdent, forKey: "GovernmentIdent")
        dataObject.setValue(selectedContactInfo.driversLicenseNumber, forKey: "DriversLicenseNumber")
        
        dataObject.setValue(selectedContactInfo.BirthDate, forKey: "BirthDate")
        
        
        dataObject.setValue(selectedContactInfo.clientSince, forKey: "ClientSince")
        
        
        dataObject.setValue(selectedContactInfo.renewDate, forKey: "ReviewDate")
        
        
        dataObject.setValue(selectedContactInfo.licenseExpiry, forKey: "DriversLicenseExpiry")
        
        dataObject.setValue(selectedContactInfo.clientClassId, forKey: "ClientClassId")
        dataObject.setValue(selectedContactInfo.descriptionField, forKey: "Description")
        dataObject.setValue(selectedContactInfo.mobilePhone, forKey: "MobilePhone")
        dataObject.setValue(selectedContactInfo.pager, forKey: "Pager")
        dataObject.setValue(selectedContactInfo.telephone1, forKey: "Telephone1")
        dataObject.setValue(selectedContactInfo.telephone2, forKey: "Telephone2")
        dataObject.setValue(selectedContactInfo.telephone3, forKey: "Telephone3")
        dataObject.setValue(selectedContactInfo.fax, forKey: "Fax")
        dataObject.setValue(selectedContactInfo.owningOrganizationUserId, forKey: "OwningOrganizationUserId")
        
        print(dataObject)
        
        UserDefaults.standard.set(dataObject, forKey: "BasicInfo")
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let getContact = self.contactList[indexPath.row]

            
            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    print(index,title)
                    if title == "Yes" {
                        self.deleteInviteUser(contactID: getContact.id)
                    }
                })
            })
        })
        // 5
        return [shareAction]
    }
    func deleteInviteUser(contactID:String){
        
        let headers = [
            "Content-Type": "application/json"
        ]
        let parameters = [
            "ObjectName": "contact",
            "OrganizationId": userOrgID,
            "ObjectId": contactID,
            "PassKey": passKey
            ] as [String : Any]
        
        let request = NSMutableURLRequest(url: NSURL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/delete.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription as Any)
            } else {
                
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
                
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Deleted") { (index, title) in
                        OperationQueue.main.addOperation {
                            self.listByOrganization()
                        }
                    }
                })
            }
        })
        
        dataTask.resume()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension contactsController:URLSessionDelegate {
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
