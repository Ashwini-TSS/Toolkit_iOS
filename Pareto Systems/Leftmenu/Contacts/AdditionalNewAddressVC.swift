//
//  AdditionalNewAddressVC.swift
//  Pareto Systems
//
//  Created by Thabresh on 20/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class AdditionalNewAddressVC: UITableViewController {

    @IBOutlet weak var longitudeField: ACFloatingTextfield!
    @IBOutlet weak var latitudeField: ACFloatingTextfield!
    @IBOutlet weak var faxField: ACFloatingTextfield!
    @IBOutlet weak var tele3Field: ACFloatingTextfield!
    @IBOutlet weak var tele2Field: ACFloatingTextfield!
    @IBOutlet weak var telephoneField: ACFloatingTextfield!
    @IBOutlet weak var poboxField: ACFloatingTextfield!
    @IBOutlet weak var countryField: ACFloatingTextfield!
    @IBOutlet weak var postalCodeField: ACFloatingTextfield!
    @IBOutlet weak var stateField: ACFloatingTextfield!
    @IBOutlet weak var cityField: ACFloatingTextfield!
    @IBOutlet weak var address3Field: ACFloatingTextfield!
    @IBOutlet weak var address2Field: ACFloatingTextfield!
    @IBOutlet weak var address1Field: ACFloatingTextfield!
    @IBOutlet weak var nameField: ACFloatingTextfield!
    var additionalAddressDetail:AdditionalAddsResult!
    var leftID:String = ""
    var fromAccounts:Bool = false
    var bottomView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            telephoneField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
            tele2Field.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
            tele3Field.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        if additionalAddressDetail != nil {
            self.title = "Address"
            nameField.text = additionalAddressDetail.name
            address1Field.text = additionalAddressDetail.line1
            address2Field.text = additionalAddressDetail.line2
            address3Field.text = additionalAddressDetail.line3
            cityField.text = additionalAddressDetail.city
            stateField.text = additionalAddressDetail.stateOrProvince
            postalCodeField.text = additionalAddressDetail.postalCode
            countryField.text = additionalAddressDetail.country
            poboxField.text = additionalAddressDetail.postOfficeBox
            telephoneField.text = additionalAddressDetail.telephone1
            tele2Field.text = additionalAddressDetail.telephone2
            tele3Field.text = additionalAddressDetail.telephone3
            faxField.text = additionalAddressDetail.fax

            if (additionalAddressDetail.latitude) != nil {
                latitudeField.text = additionalAddressDetail.latitude.stringValue
            }
            if (additionalAddressDetail.longitude) != nil {
                longitudeField.text = additionalAddressDetail.longitude.stringValue
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        setupBottomView()
    }
    func setupBottomView() {
        bottomView.removeFromSuperview()
        bottomView = UIView()
        bottomView.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height - 67.0, width: UIScreen.main.bounds.width, height: 67.0)
        bottomView.backgroundColor = UIColor.PSNavigaitonController()
        
        let cancelBtn = UIButton()
        cancelBtn.setTitle("Close", for: .normal)
        cancelBtn.frame = CGRect(x: 15.0, y: 9.0, width: 168.0, height: 38)
        cancelBtn.backgroundColor = UIColor.white
        cancelBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        cancelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        cancelBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchUpInside)
        
        bottomView.addSubview(cancelBtn)
        
        let donelBtn = UIButton()
        donelBtn.setTitle("Save", for: .normal)
        donelBtn.frame = CGRect(x: UIScreen.main.bounds.width-182, y: 9.0, width: 168.0, height: 38)
        donelBtn.backgroundColor = UIColor.white
        donelBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        donelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        donelBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchUpInside)
        
        bottomView.addSubview(donelBtn)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.addSubview(bottomView)
    }
    
    func removeBottomView(){
        bottomView.removeFromSuperview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeBottomView()
    }
    
    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tappedSave(_ sender: Any) {
        
        var mainURL:String = createContact
        
        let insertData:NSMutableDictionary = [:]
        insertData.setValue(nameField.text!, forKey: "Name")
        insertData.setValue(address1Field.text!, forKey: "Line1")
        insertData.setValue(address2Field.text!, forKey: "Line2")
        insertData.setValue(address3Field.text!, forKey: "Line3")
        insertData.setValue(cityField.text!, forKey: "City")
        insertData.setValue(stateField.text!, forKey: "StateOrProvince")
        
        insertData.setValue(postalCodeField.text!, forKey: "PostalCode")
        insertData.setValue(countryField.text!, forKey: "County")
        insertData.setValue(countryField.text!, forKey: "Country")
        
        insertData.setValue(poboxField.text!, forKey: "PostOfficeBox")
        insertData.setValue(telephoneField.text!, forKey: "Telephone1")
        insertData.setValue(tele2Field.text!, forKey: "Telephone2")
        insertData.setValue(tele3Field.text!, forKey: "Telephone3")
        insertData.setValue(faxField.text!, forKey: "Fax")
        if (latitudeField.text?.count)! > 0 {
            let myFloat = (latitudeField.text! as NSString).floatValue
            insertData.setValue(myFloat, forKey: "Latitude")
        }
        if (longitudeField.text?.count)! > 0 {
            let myFloat = (longitudeField.text! as NSString).floatValue
            insertData.setValue(myFloat, forKey: "Longitude")
        }
        
        if additionalAddressDetail != nil {
            mainURL = modifyURL
            insertData.setValue(additionalAddressDetail.id, forKey: "Id")
        }
        
     
        let json: [String: Any] = ["ObjectName": "address",
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
        var LeftObjectName:String = "contact"
        var ObjectName:String = "linker_contacts_addresses"

        if fromAccounts {
            LeftObjectName = "company"
            ObjectName = "linker_companies_addresses"
        }
        let json: [String: Any] = ["ObjectName": ObjectName,
                                   "LeftId": leftID,
                                   "LeftObjectName": LeftObjectName,
                                   "RightId": rightID,
                                   "RightObjectName": "address",
                                   "PassKey": passKey,
                                   "OrganizationId": currentOrgID]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                OperationQueue.main.addOperation {
                    self.navigationController?.popViewController(animated: true)
                    NavigationHelper.showSimpleAlert(message:"Added Successfully")
                }
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
        return 15
    }
    @objc func textFieldDidChange(textField : UITextField){
        textField.text = NavigationHelper.USPhoneFormat(number: textField.text!)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        
        return 50
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
extension AdditionalNewAddressVC:URLSessionDelegate {
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
