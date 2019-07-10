
//
//  ContactHeaderVC.swift
//  Pareto Systems
//
//  Created by Thabresh on 20/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ContactHeaderVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func tappedSaveClose(_ sender: Any) {
        
        var mainURL:String = createContact

        
        let insertData:NSMutableDictionary = [:]
        insertData.addEntries(from: getBasicInfo() as! [AnyHashable : Any])
        insertData.addEntries(from: getAddressInfo() as! [AnyHashable : Any])
        insertData.addEntries(from: getFamilyInfo() as! [AnyHashable : Any])
        insertData.addEntries(from: getOccupationInfo() as! [AnyHashable : Any])
        insertData.addEntries(from: getMoneyInfo() as! [AnyHashable : Any])
 
        if selectedContactInfo != nil {
            mainURL = modifyURL
            insertData.setValue(selectedContactInfo.id, forKey: "Id")
        }
        print(insertData)

        let json: [String: Any] = ["ObjectName": "contact",
                                    "PassKey": passKey,
                                    "OrganizationId":currentOrgID,
                                    "DataObject":insertData]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: mainURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                OperationQueue.main.addOperation {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func getMoneyInfo() -> NSDictionary{
        
        
        if let data = UserDefaults.standard.object(forKey: "MoneyInfo") {
            return data as! NSDictionary
        }else{
            let dataObject:NSMutableDictionary = [:]
            dataObject.setValue(0, forKey: "Income")
            dataObject.setValue(0, forKey: "CreditLimit")
            dataObject.setValue("", forKey: "ExecutorName")
            dataObject.setValue("", forKey: "ExecutorId")
            dataObject.setValue("", forKey: "GroupInsurance")
            dataObject.setValue("", forKey: "MoneyNotes")
            dataObject.setValue(0, forKey: "Revenue")
            dataObject.setValue(0, forKey: "CreditOnHold")
            dataObject.setValue("", forKey: "PowerofAttorneyName")
            dataObject.setValue("", forKey: "PowerofAttorneyId")
            dataObject.setValue("", forKey: "GroupPensionPlan")
            return dataObject
        }
    }
    func getOccupationInfo() -> NSDictionary{
        if let data = UserDefaults.standard.object(forKey: "OccupationInfo") {
            return data as! NSDictionary
        }else{
            let dataObject:NSMutableDictionary = [:]
            dataObject.setValue("", forKey: "CompanyName")
            dataObject.setValue("", forKey: "CompanyId")
            dataObject.setValue("", forKey: "AssistantName")
            dataObject.setValue("", forKey: "OccupationNotes")
            dataObject.setValue("", forKey: "JobTitle")
            dataObject.setValue("", forKey: "Department")
            dataObject.setValue("", forKey: "AssistantPhone")
            dataObject.setValue("", forKey: "RecreationNotes")
            return dataObject
        }
    }
    func getFamilyInfo() -> NSDictionary {
        if let data = UserDefaults.standard.object(forKey: "FamilyInfo") {
            return data as! NSDictionary
        }else{
            let dataObject:NSMutableDictionary = [:]
            dataObject.setValue("", forKey: "SpousePartnerName")
            //dataObject.setValue("", forKey: "ChildrensNames")
            dataObject.setValue("", forKey: "SpousePartnerId")
            dataObject.setValue("", forKey: "FamilyNotes")
            return dataObject
        }
    }
    func getAddressInfo() -> NSDictionary {
        if let data = UserDefaults.standard.object(forKey: "AddressInfo") {
            return data as! NSDictionary
        }else{
            let dataObject:NSMutableDictionary = [:]
            
            //Address
            dataObject.setValue("", forKey: "AddressLine1")
            dataObject.setValue("", forKey: "AddressLine2")
            dataObject.setValue("", forKey: "AddressLine3")
            dataObject.setValue("", forKey: "City")
            dataObject.setValue("", forKey: "State")
            dataObject.setValue("", forKey: "Postal")
            dataObject.setValue("", forKey: "Country")
            dataObject.setValue("", forKey: "PoBox")
            
            //Email Address
            dataObject.setValue("", forKey: "EMailAddress1")
            dataObject.setValue("", forKey: "EMailAddress2")
            dataObject.setValue("", forKey: "EMailAddress3")
            dataObject.setValue("", forKey: "WebSiteUrl")
            dataObject.setValue("", forKey: "FtpSiteUrl")
            return dataObject
        }
    }
    func getBasicInfo() -> NSDictionary{
        if let data = UserDefaults.standard.object(forKey: "BasicInfo") {

            return data as! NSDictionary
        }else{
            let dataObject:NSMutableDictionary = [:]
            dataObject.setValue("", forKey: "Salutation")
            dataObject.setValue("", forKey: "FirstName")
            dataObject.setValue("", forKey: "MiddleName")
            dataObject.setValue("", forKey: "LastName")
            dataObject.setValue("", forKey: "Gender")
            dataObject.setValue("", forKey: "Anniversary")
            dataObject.setValue("", forKey: "Title")
            dataObject.setValue("", forKey: "Suffix")
            dataObject.setValue("", forKey: "NickName")
            dataObject.setValue("", forKey: "Private")
            dataObject.setValue("", forKey: "GovernmentIdent")
            dataObject.setValue("", forKey: "DriversLicenseNumber")
            dataObject.setValue("", forKey: "BirthDate")
            dataObject.setValue("", forKey: "ClientSince")
            dataObject.setValue("", forKey: "ReviewDate")
            dataObject.setValue("", forKey: "DriversLicenseExpiry")
            dataObject.setValue("", forKey: "ClientClassId")
            dataObject.setValue("", forKey: "Description")
            dataObject.setValue("", forKey: "MobilePhone")
            dataObject.setValue("", forKey: "Pager")
            dataObject.setValue("", forKey: "Telephone1")
            dataObject.setValue("", forKey: "Telephone2")
            dataObject.setValue("", forKey: "Telephone3")
            dataObject.setValue("", forKey: "Fax")
            dataObject.setValue("", forKey: "OwningOrganizationUserId")
            return dataObject
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if selectedContactInfo != nil {
            return 9
        }
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
         
            let controller:AdditionalAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "AdditionalAddressVC") as! AdditionalAddressVC
            controller.linkParentID = selectedContactInfo.id
            self.navigationController?.pushViewController(controller, animated: true)
        }
        if indexPath.row == 6 {
            
            let controller:LinkedAccountsController = self.storyboard?.instantiateViewController(withIdentifier: "LinkedAccountsController") as! LinkedAccountsController
            controller.linkParentID = selectedContactInfo.id
            self.navigationController?.pushViewController(controller, animated: true)
        }
        if indexPath.row == 7 {
            
            let controller:OpenActivitiesController = self.storyboard?.instantiateViewController(withIdentifier: "OpenActivitiesController") as! OpenActivitiesController
            controller.linkParentID = selectedContactInfo.id
            self.navigationController?.pushViewController(controller, animated: true)
        }
        if indexPath.row == 8 {
            
            let controller:CompleteActivitiesControler = self.storyboard?.instantiateViewController(withIdentifier: "CompleteActivitiesControler") as! CompleteActivitiesControler
            controller.linkParentID = selectedContactInfo.id
            self.navigationController?.pushViewController(controller, animated: true)
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
extension ContactHeaderVC:URLSessionDelegate {
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
