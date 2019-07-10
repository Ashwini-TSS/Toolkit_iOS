//
//  AddNewCardController.swift
//  Pareto Systems
//  59, New mosque street,Kannamangalam.
//
//  Created by Thabresh on 05/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import ThinCreditCard

class AddNewCardController: UITableViewController {

    @IBOutlet weak var csvField: ACFloatingTextfield!
    @IBOutlet weak var expiryField: ACFloatingTextfield!
    @IBOutlet weak var creditNumberField: ACFloatingTextfield!
    @IBOutlet weak var zipPostalField: ACFloatingTextfield!
    @IBOutlet weak var creditTypeField: ACFloatingTextfield!
    @IBOutlet weak var phoneField: ACFloatingTextfield!
    @IBOutlet weak var lastnameField: ACFloatingTextfield!
    @IBOutlet weak var emailField: ACFloatingTextfield!
    @IBOutlet weak var firstnameField: ACFloatingTextfield!
    var orgID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tappedClose(_ sender: Any) {
   
    }
    
    @IBAction func tappedSave(_ sender: Any) {

        /*
 @IBOutlet weak var csvField: ACFloatingTextfield!
 @IBOutlet weak var expiryField: ACFloatingTextfield!
 @IBOutlet weak var creditNumberField: ACFloatingTextfield!
 @IBOutlet weak var zipPostalField: ACFloatingTextfield!
 @IBOutlet weak var creditTypeField: ACFloatingTextfield!
 @IBOutlet weak var phoneField: ACFloatingTextfield!
 @IBOutlet weak var lastnameField: ACFloatingTextfield!
 @IBOutlet weak var emailField: ACFloatingTextfield!
 @IBOutlet weak var firstnameField: ACFloatingTextfield!
 */
        let detailDict:NSMutableDictionary = [:]
        detailDict.setValue("", forKey: "Fingerprint")
        detailDict.setValue("1234", forKey: "Last4")
        detailDict.setValue("credit" , forKey: "Funding")
        detailDict.setValue("", forKey: "CvcCheck")
        detailDict.setValue("", forKey: "Recipient")
        detailDict.setValue("", forKey: "AddressCountry")
        detailDict.setValue("1234 1234 1234 1234", forKey: "FullCCNum")
        detailDict.setValue(orgID, forKey: "OrganizationId")
        detailDict.setValue(zipPostalField.text!, forKey: "AddressZip")
        detailDict.setValue("02", forKey: "ExpMonth")
        detailDict.setValue(firstnameField.text! + " " + lastnameField.text!, forKey: "Name")
        detailDict.setValue("", forKey: "AddressLine2")
        detailDict.setValue("Visa", forKey: "Brand")
        detailDict.setValue("", forKey: "AddressLine1")
        detailDict.setValue("Visa", forKey: "Type")
        detailDict.setValue("", forKey: "AddressCity")
        detailDict.setValue("", forKey: "Country")
        detailDict.setValue("", forKey: "Id")
        detailDict.setValue("2024", forKey: "ExpYear")
        detailDict.setValue("", forKey: "AddressState")

        let json: [String: Any] = ["OrganizationId": orgID,
                                   "PassKey": passKey,
                                   "PaymentCard":detailDict]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: createPaymentURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
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
// MARK: - CreditCardValidatorViewDelegate
extension AddNewCardController: CreditCardValidatorViewDelegate {
    func didEdit(number: String) {
//        cardNumberLabel.text = "Number: " + number
        
        print("Number: " + number)
        
        
    }
    
    func didEdit(expiryDate: String) {
//        cardExpirationLabel.text = "Expiry Date: " + expiryDate
        print("Expiry Date: " + expiryDate)

    }
    
    func didEdit(cvc: String) {
//        cardCvcLabel.text = "CVC: " + cvc
        print("CVC: " + cvc)

    }
}
extension AddNewCardController:URLSessionDelegate {
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
