//
//  AccountDeatilController.swift
//  Pareto Systems
//
//  Created by Thabresh on 14/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class AccountDeatilController: UITableViewController {
    
    var contactList:AccountsListResult!
    var orgID:String = ""

    @IBOutlet weak var firstnameField: ACFloatingTextfield!
    @IBOutlet weak var websiteField: ACFloatingTextfield!
    @IBOutlet weak var stateField: ACFloatingTextfield!
    @IBOutlet weak var cityField: ACFloatingTextfield!
    @IBOutlet weak var mobileField: ACFloatingTextfield!
    @IBOutlet weak var addresslineField: ACFloatingTextfield!
    @IBOutlet weak var emailAddressField: ACFloatingTextfield!
    @IBOutlet weak var postalFiekd: ACFloatingTextfield!
    @IBOutlet weak var lastnameField: ACFloatingTextfield!
    @IBOutlet weak var fullnameField: ACFloatingTextfield!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if contactList != nil {
            firstnameField.text = contactList.name
            lastnameField.text = contactList.descriptionField
            fullnameField.text = contactList.legalName
            postalFiekd.text = contactList.postal
            emailAddressField.text = contactList.eMailAddress1
            addresslineField.text = contactList.addressLine1
//            mobileField.text = contactList.telephone1
            cityField.text = contactList.city
            stateField.text = contactList.state
            websiteField.text = contactList.webSiteUrl
            mobileField.text = NavigationHelper.USPhoneFormat(number: contactList.telephone1)
        }else{
            btnDelete.setTitle("Close", for: .normal)
        }
        
        mobileField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @objc func textFieldDidChange(textField : UITextField){
        mobileField.text = NavigationHelper.USPhoneFormat(number: textField.text!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tappedDelete(_ sender: Any) {
        if contactList != nil {
            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    print(index,title)
                    if title == "Yes" {
                        self.deleteInviteUser()
                    }
                    
                })
            })
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 11
    }
    
    
    func deleteInviteUser(){
        let contactID:String = contactList.id
        
        let headers = [
            "Content-Type": "application/json"
        ]
        let parameters = [
            "ObjectName": "company",
            "OrganizationId": orgID,
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
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                })
            }
        })
        
        dataTask.resume()
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
extension AccountDeatilController:URLSessionDelegate {
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
