//
//  AddLinkedAccountController.swift
//  Pareto Systems
//
//  Created by Thabresh on 22/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class AddLinkedAccountController: UITableViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var legelNameField: UITextField!
    @IBOutlet weak var primaryPhoneField: UITextField!
    @IBOutlet weak var secondaryPhoneFeild: UITextField!
    @IBOutlet weak var descriptionFeild: KMPlaceholderTextView!
     @IBOutlet weak var mobilePhoneField: UITextField!
    @IBOutlet weak var otherPhoneFeild: UITextField!
    @IBOutlet weak var faxFeild: UITextField!
    @IBOutlet weak var pagerFeild: UITextField!
    @IBOutlet weak var addressLine1Feild: UITextField!
    @IBOutlet weak var addressLine2Feild : UITextField!
    @IBOutlet weak var addressLine3Feild: UITextField!
     @IBOutlet weak var cityFeild: UITextField!
     @IBOutlet weak var stateFeild: UITextField!
    @IBOutlet weak var postelFeild: UITextField!
    @IBOutlet weak var countryFeild: UITextField!
    @IBOutlet weak var poBoxFeild: UITextField!
    @IBOutlet weak var  emailAddress1Feild: UITextField!
    @IBOutlet weak var emailAddress2Feild: UITextField!
    @IBOutlet weak var emailAddress3Feild: UITextField!
    @IBOutlet weak var websiteFeild: UITextField!
    @IBOutlet weak var ftpSiteFeild: UITextField!
    var leftID:String = ""
    var additionalAddressDetail:LinkedAccountsResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionFeild.layer.cornerRadius = 5.0
        descriptionFeild.layer.borderColor = UIColor.lightGray.cgColor
        descriptionFeild.layer.borderWidth = 1.0
        descriptionFeild.clipsToBounds = true
        
        if additionalAddressDetail != nil {
            self.title = "Account"
            ftpSiteFeild.text = additionalAddressDetail.ftpSiteUrl
            websiteFeild.text = additionalAddressDetail.webSiteUrl
            emailAddress3Feild.text = additionalAddressDetail.eMailAddress3
            emailAddress2Feild.text = additionalAddressDetail.eMailAddress2
            emailAddress1Feild.text = additionalAddressDetail.eMailAddress1
            poBoxFeild.text = additionalAddressDetail.poBox
            countryFeild.text = additionalAddressDetail.country
            postelFeild.text = additionalAddressDetail.postal
            stateFeild.text = additionalAddressDetail.state
            cityFeild.text = additionalAddressDetail.city
            addressLine3Feild.text = additionalAddressDetail.addressLine3
            addressLine2Feild.text = additionalAddressDetail.addressLine2
            addressLine1Feild.text = additionalAddressDetail.addressLine1
            pagerFeild.text = additionalAddressDetail.pager
            faxFeild.text = additionalAddressDetail.fax
            
            otherPhoneFeild.text = NavigationHelper.USPhoneFormat(number: additionalAddressDetail.mobilePhone)
            mobilePhoneField.text = NavigationHelper.USPhoneFormat(number: additionalAddressDetail.mobilePhone)
            secondaryPhoneFeild.text = NavigationHelper.USPhoneFormat(number: additionalAddressDetail.mobilePhone)
            primaryPhoneField.text = NavigationHelper.USPhoneFormat(number: additionalAddressDetail.mobilePhone)

            descriptionFeild.text = additionalAddressDetail.descriptionField
            legelNameField.text = additionalAddressDetail.legalName
            nameField.text = additionalAddressDetail.name
        }
        
        otherPhoneFeild.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        mobilePhoneField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        secondaryPhoneFeild.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        primaryPhoneField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @objc func textFieldDidChange(textField : UITextField){
        textField.text = NavigationHelper.USPhoneFormat(number: textField.text!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 3
        }else if section == 1 {
            return 6
        }else if section == 2 {
            return 8
        }
        return 5
    }


    //MARK: - button ACtion
    
    @IBAction func tappedSaveBtn(_ sender: UIBarButtonItem) {
        
        var mainURL:String = createContact
        
        let insertData:NSMutableDictionary = [:]
        insertData.setValue(nameField.text!, forKey: "Name")
        insertData.setValue(legelNameField.text!, forKey: "LegalName")
        insertData.setValue(descriptionFeild.text!, forKey: "Description")
        insertData.setValue(emailAddress1Feild.text!, forKey: "EMailAddress1")
        insertData.setValue(emailAddress2Feild.text!, forKey: "EMailAddress2")
        insertData.setValue(emailAddress3Feild.text!, forKey: "EMailAddress3")
        
        insertData.setValue(websiteFeild.text!, forKey: "WebSiteUrl")
        insertData.setValue(ftpSiteFeild.text!, forKey: "FtpSiteUrl")
        insertData.setValue(mobilePhoneField.text!, forKey: "MobilePhone")
        
        insertData.setValue(pagerFeild.text!, forKey: "Pager")
        insertData.setValue(faxFeild.text!, forKey: "Fax")
        insertData.setValue(primaryPhoneField.text!, forKey: "Telephone1")
        insertData.setValue(secondaryPhoneFeild.text!, forKey: "Telephone2")
        insertData.setValue(otherPhoneFeild.text!, forKey: "Telephone3")
        insertData.setValue("", forKey: "LetterheadLogoId")
        insertData.setValue(addressLine1Feild.text!, forKey: "AddressLine1")
        insertData.setValue(addressLine2Feild.text!, forKey: "AddressLine2")
        insertData.setValue(addressLine3Feild.text!, forKey: "AddressLine3")
        insertData.setValue(cityFeild.text!, forKey: "City")
        insertData.setValue(stateFeild.text!, forKey: "State")
        insertData.setValue(postelFeild.text!, forKey: "Postal")
        insertData.setValue("", forKey: "Country")

//        insertData.setValue(countryFeild.text!, forKey: "Country")
        insertData.setValue(poBoxFeild.text!, forKey: "PoBox")
        
        if additionalAddressDetail != nil {
            mainURL = modifyURL
            insertData.setValue(additionalAddressDetail.id, forKey: "Id")
        }
        
        let json: [String: Any] = ["ObjectName": "company",
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
                                if self.additionalAddressDetail == nil {
                                    self.linkAddress(rightID: getID)
                                    return
                               }
                            }
                        }
                        OperationQueue.main.addOperation {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        print(responseMessage)
                        NavigationHelper.showSimpleAlert(message:responseMessage)
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
    func linkAddress(rightID:String){
        
        let json: [String: Any] = ["ObjectName": "linker_contacts_companies",
                                   "LeftId": leftID,
                                   "LeftObjectName": "contact",
                                   "RightId": rightID,
                                   "RightObjectName": "company",
                                   "PassKey": passKey,
                                   "OrganizationId": currentOrgID]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
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
extension AddLinkedAccountController:URLSessionDelegate {
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
