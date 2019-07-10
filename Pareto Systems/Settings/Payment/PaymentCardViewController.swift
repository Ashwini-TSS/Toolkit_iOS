//
//  PaymentCardViewController.swift
//  Pareto Systems
//
//  Created by Thabresh on 30/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class PaymentCardViewController: UITableViewController {
    
    @IBOutlet weak var lblFirstName: ACFloatingTextfield!
    @IBOutlet weak var lblLastName: ACFloatingTextfield!
    @IBOutlet weak var lblEmail: ACFloatingTextfield!
    @IBOutlet weak var lblPhone: ACFloatingTextfield!
    @IBOutlet weak var lblZipCode: ACFloatingTextfield!
    @IBOutlet weak var lblCreditCard: ACFloatingTextfield!
    @IBOutlet weak var lblCreditNumber: ACFloatingTextfield!
    @IBOutlet weak var lblExpiry: ACFloatingTextfield!
    @IBOutlet weak var lblCSV: ACFloatingTextfield!
    var cardDetails:PaymentCard!
    
    @IBAction func tappedSave(_ sender: Any) {
        
    }
    
    @IBAction func tappedDelete(_ sender: Any) {
        //deletePaymentCardURL
        
        let cardID:String = cardDetails.id
        let OrganizationId:String = cardDetails.organizationId

        let json: [String: Any] = ["PaymentCardId": cardID,
                                   "PassKey": passKey,
                                   "OrganizationId": OrganizationId]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: deletePaymentCardURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let invite:deleteInviteuser = deleteInviteuser.init(fromDictionary: jsonResponse)
                if invite.valid {
                    if invite.responseMessage == "success" {
                        DispatchQueue.main.async(execute: {
                            AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Deleted") { (index, title) in
                                OperationQueue.main.addOperation {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                        })
                    }else{
                        NavigationHelper.showSimpleAlert(message:invite.responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:invite.responseMessage)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblFirstName.text = cardDetails.name
        lblLastName.text = ""
        lblEmail.text = ""
        lblPhone.text = ""
        lblZipCode.text = cardDetails.addressZip
        lblCreditCard.text = cardDetails.brand
        lblCreditNumber.text = cardDetails.fullCCNum
        
        var expiryYear:String = String(cardDetails.expYear)
        if expiryYear.count > 2 {
            expiryYear = String(expiryYear.prefix(2))
        }
        let expiryMonth:String = String(cardDetails.expMonth)
        let conString:String = expiryMonth + "/" + expiryYear
        lblExpiry.text = conString
        
        lblCSV.text = cardDetails.cvcCheck
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
extension PaymentCardViewController:URLSessionDelegate {
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
