//
//  LinkedAccountsController.swift
//  Pareto Systems
//
//  Created by Thabresh on 22/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class LinkedAccountsController: UITableViewController {

    var linkParentID:String = ""
    var searchResult:[LinkedAccountsResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        getLinkedAccountList()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getLinkedAccountList(){
        let json: [String: Any] = ["ListObjectName": "company",
                                   "ObjectName": "linker_contacts_companies",
                                   "LinkParentId": linkParentID,
                                   "PassKey": passKey,
                                   "OrganizationId": currentOrgID]
        print(json)
        
        
        APIManager.sharedInstance.postRequestCall(postURL: linkedURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let result = LinkedAccountsModel.init(fromDictionary: jsonResponse)
                print(result.responseMessage)
                
                if result.valid == true {
                    self.searchResult = result.results
                    self.tableView.reloadData()
                }else{
                    self.searchResult = []
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    @IBAction func tappedSave(_ sender: Any) {
        let controller:AddLinkedAccountController = self.storyboard?.instantiateViewController(withIdentifier: "AddLinkedAccountController") as! AddLinkedAccountController
        controller.leftID = linkParentID
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResult.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LinkedAccountsCell = tableView.dequeueReusableCell(withIdentifier: "LinkedAccountsCell", for: indexPath) as! LinkedAccountsCell

        let result:LinkedAccountsResult = searchResult[indexPath.row]
        cell.lblName.text = result.name
        cell.lblEmail.text = result.eMailAddress1
        cell.lblPhone.text = result.telephone1

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result:LinkedAccountsResult = searchResult[indexPath.row]
        let controller:AddLinkedAccountController = self.storyboard?.instantiateViewController(withIdentifier: "AddLinkedAccountController") as! AddLinkedAccountController
        controller.additionalAddressDetail = result
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let result:LinkedAccountsResult = self.searchResult[indexPath.row]

            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    print(index,title)
                    if title == "Yes" {
                        self.deleteInviteUser(contactID: result.id)
                    }
                })
            })
        })
        // 5
        return [shareAction]
    }
    func deleteInviteUser(contactID:String){
        
        let parameters = [
            "ObjectName": "company",
            "OrganizationId": currentOrgID,
            "ObjectId": contactID,
            "PassKey": passKey
            ] as [String : Any]
        
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Deleted") { (index, title) in
                        OperationQueue.main.addOperation {
                            self.getLinkedAccountList()
                        }
                    }
                })
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
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
extension LinkedAccountsController:URLSessionDelegate {
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
