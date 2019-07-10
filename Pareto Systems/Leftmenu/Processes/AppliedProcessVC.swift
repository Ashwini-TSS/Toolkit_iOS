//
//  AppliedProcessVC.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 04/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class AppliedProcessVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
     var processList:[AppliedProcessResult] = []
     var contactsList:[familyContactResult] = []
     var getSearchList:[searchAccountResult] = []
     var ArrayContact : NSMutableArray = []
     var ArrayCompany : NSMutableArray = []
     var Contact : String = ""
     var Company : String = ""
    var indexs :Int = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Applied Processes"
        tableView.tableFooterView = UIView()
        indexs = 0
        getAppliedProcessList()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func tappedAdd(_ sender: Any) {
        let controller:NewAppliedProcess = self.storyboard?.instantiateViewController(withIdentifier: "NewAppliedProcess") as! NewAppliedProcess
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func getAppliedProcessList(){
        let parameters = [
            "OrderBy": "Name",
            "ResultsPerPage": 500,
            "OrganizationId": currentOrgID,
            "PassKey": passKey,
            "PageOffset": 1,
            "ObjectName": "applied_advocate_process",
            "AscendingOrder":true
            ] as [String : Any]
        
        APIManager.sharedInstance.postRequestCall(postURL: getOrgListURL, parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let model = AppliedProcessModel.init(fromDictionary: jsonResponse)
                if model.valid {
                    self.processList = []
                    if model.results.count > 0 {
                        self.processList = model.results
                        self.callservice()
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:model.responseMessage)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    
    func callservice(){
        print(indexs)
        let getResult:AppliedProcessResult = self.processList[indexs]
        if (getResult.contactId != ""){
            self.callContacts(contactID:getResult.contactId)
        }
        else {
            self.Contact = ""
            self.ArrayContact.add(self.Contact)
        }
        if (getResult.CompanyId != ""){
           self.getCompany(companyID:getResult.CompanyId)
        }
        else {
            self.Company = ""
            self.ArrayCompany.add(self.Company)
        }
        
    }
    
    
    
   // func callContacts(contactID:String , finish: @escaping (_ str:String?) -> Void)
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
                          self.Contact = getResult.fullName
                          self.ArrayContact.add(self.Contact)
                        }
                    }
                }else{
                    self.contactsList = []
                }
                self.indexs = self.indexs+1
                if(self.indexs == self.processList.count){
                print("Finish")
                self.tableView.reloadData()
                }
                else {
                    self.callservice()
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
                            self.Company = getResult.name
                            self.ArrayCompany.add(self.Company)
                        }
                    }
                }else{
                    self.getSearchList = []
                }
                self.indexs = self.indexs+1
                if(self.indexs == self.processList.count){
                    print("Finish")
                    self.tableView.reloadData()
                }
                else {
                    self.callservice()
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

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.processList.count
    }

  
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AppliedProcessCell = tableView.dequeueReusableCell(withIdentifier: "AppliedProcessCell", for: indexPath) as! AppliedProcessCell
        let getResult:AppliedProcessResult = processList[indexPath.row]
        if getResult.name != nil {
            cell.lblProcess.text = getResult.name!
        }else{
            cell.lblProcess.text = ""
        }
        let contactname = ArrayContact[indexPath.row] as! String
        if(contactname != ""){
            cell.lblCreatedBy.text = contactname
        }
        let Companyname = ArrayCompany[indexPath.row] as! String
        if(Companyname != ""){
            cell.lblCreatedBy.text = Companyname
        }
        cell.lblDate.text = converDateToString(dateString: getResult.initializationDate!)
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let getResult:AppliedProcessResult = processList[indexPath.row]
        let controller:NewAppliedProcess = self.storyboard?.instantiateViewController(withIdentifier: "NewAppliedProcess") as! NewAppliedProcess
        controller.appliedProcess = getResult
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //{"ObjectName":"applied_advocate_process","ObjectId":"566130c7-5c7e-4907-8ad0-f18b916d8206","PassKey":"2YMl6UdVco2LlxfA_Te1Ro38q4XCFRZTgto0o_zwxyFxLB32Hse8Vly3uE4zyCTOoQBtA3WF_VgnXmAP2LxeH0w","OrganizationId":"c27304fa-3ce6-40f7-90d4-f51e1723a882"}
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let getResult:AppliedProcessResult = self.processList[indexPath.row]
            
            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    print(index,title)
                    if title == "Yes" {
                        self.deleteInviteUser(contactID: getResult.id)
                    }
                })
            })
        })
        // 5
        return [shareAction]
    }
  
 
    
    func deleteInviteUser(contactID:String){
        let parameters = [
            "ObjectName": "applied_advocate_process",
            "ObjectId": contactID,
            "OrganizationId": currentOrgID,
            "PassKey": passKey
            ] as [String : Any]
        
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Deleted") { (index, title) in
                        OperationQueue.main.addOperation {
                            self.getAppliedProcessList()
                        }
                    }
                })
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
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
            dateFormatter.dateFormat = "MMMM dd, yyyy" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
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
extension AppliedProcessVC:URLSessionDelegate {
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
