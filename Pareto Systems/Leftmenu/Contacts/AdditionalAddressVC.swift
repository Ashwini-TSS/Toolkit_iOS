//
//  AdditionalAddressVC.swift
//  Pareto Systems
//
//  Created by Thabresh on 21/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class AdditionalAddressVC: UITableViewController {

    var linkParentID:String = ""
    var searchResult:[AdditionalAddsResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
     
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
       getAddressList()
    }
    func getAddressList(){
        let json: [String: Any] = ["ListObjectName": "address",
                                   "ObjectName": "linker_contacts_addresses",
                                   "LinkParentId": linkParentID,
                                   "PassKey": passKey,
                                   "OrganizationId": currentOrgID]
        print(json)
        
        
        APIManager.sharedInstance.postRequestCall(postURL: linkedURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let result = AdditionalAddsModel.init(fromDictionary: jsonResponse)
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
        let controller:AdditionalNewAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "AdditionalNewAddressVC") as! AdditionalNewAddressVC
        controller.leftID = linkParentID
        self.navigationController?.pushViewController(controller, animated: true)
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
        return searchResult.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AdditionalAddressCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalAddressCell", for: indexPath) as! AdditionalAddressCell
//        let getAddress:AdditionalAddsResult = searchResult[indexPath.row]
//        cell.addressFiel.text = getAddress.line1
//        cell.cityField.text = getAddress.city
//        cell.countryField.text = getAddress.country
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let getAddress:AdditionalAddsResult = searchResult[indexPath.row]
        let controller:AdditionalNewAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "AdditionalNewAddressVC") as! AdditionalNewAddressVC
        controller.additionalAddressDetail = getAddress
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let getAddress:AdditionalAddsResult = self.searchResult[indexPath.row]

            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    print(index,title)
                    if title == "Yes" {
                        self.deleteInviteUser(contactID: getAddress.id)
                    }
                })
            })
        })
        // 5
        return [shareAction]
    }
    func deleteInviteUser(contactID:String){
        
        let parameters = [
            "ObjectName": "address",
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
                            self.getAddressList()
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
extension AdditionalAddressVC:URLSessionDelegate {
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
