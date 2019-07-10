//
//  MyProfileVC.swift
//  Pareto Systems
//
//  Created by Thabresh on 06/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class MyProfileVC: UITableViewController {

    @IBOutlet weak var titleField: ACFloatingTextfield!
    @IBOutlet weak var countryField: ACFloatingTextfield!
    @IBOutlet weak var zipcodeField: ACFloatingTextfield!
    @IBOutlet weak var stateField: ACFloatingTextfield!
    @IBOutlet weak var phoneField: ACFloatingTextfield!
    @IBOutlet weak var secondaryPhone: ACFloatingTextfield!
    @IBOutlet weak var cityField: ACFloatingTextfield!
    @IBOutlet weak var addressField: ACFloatingTextfield!
    @IBOutlet weak var address2Field: ACFloatingTextfield!
    @IBOutlet weak var address3Field: ACFloatingTextfield!
    @IBOutlet weak var companyField: ACFloatingTextfield!
    @IBOutlet weak var emailField: ACFloatingTextfield!
    @IBOutlet weak var firstnameField: ACFloatingTextfield!
    @IBOutlet weak var lastnameField: ACFloatingTextfield!
    @IBOutlet weak var websiteField: ACFloatingTextfield!
    var whoUser:whoamiUser!
    var countryCode:String = "+1"
    var bottomView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCode = UserDefaults.standard.string(forKey: "Extension") ?? "+1"
        phoneField.text = countryCode
        secondaryPhone.text = countryCode

//        phoneField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
//        secondaryPhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)


        getUserProfile()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cancelBtn.addTarget(self, action: #selector(tappedCancel(_:)), for: .touchUpInside)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupBottomView()
        
    }
    
    func removeBottomView(){
        bottomView.removeFromSuperview()
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeBottomView()
    }
    
    
    @objc func textFieldDidChange(textField : UITextField){
        //textField.text = NavigationHelper.USPhoneFormat(number: textField.text!)
    }
    func getUserProfile(){
        let json: [String: Any] = ["PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: getUserURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:whoamimapping = whoamimapping.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    
                    OperationQueue.main.addOperation {
                        self.whoUser = logModel.user
                        
                        self.titleField.text = self.whoUser.jobTitle
                        self.websiteField.text = self.whoUser.website
                        self.secondaryPhone.text = self.whoUser.secondaryPhone
                        self.address2Field.text = self.whoUser.addressLine2
                        self.address3Field.text = self.whoUser.addressLine3
                        self.countryField.text = self.whoUser.country
                        self.zipcodeField.text = self.whoUser.zip
                        self.stateField.text = self.whoUser.state
                        self.cityField.text = self.whoUser.city
                        self.addressField.text = self.whoUser.addressLine1
                        self.emailField.text = self.whoUser.emailAddress
                        self.firstnameField.text = self.whoUser.firstName
                        self.lastnameField.text = self.whoUser.lastName
                        
                        

                        
                        if let mainPhone = self.whoUser.mainPhone {
//                            self.phoneField.text = mainPhone
                            
                            self.phoneField.text = mainPhone.count > 0 ? mainPhone : self.countryCode


                        }
//                        self.modifyUser()

                    }
                }else {
                    NavigationHelper.showSimpleAlert(message:logModel.responseMessage)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    func modifyUser(){
        
   
            let detailDict:NSMutableDictionary = [:]
            detailDict.setValue(zipcodeField.text!,      forKey: "Zip")
            detailDict.setValue(self.whoUser.userName, forKey: "UserName")
            detailDict.setValue(firstnameField.text!, forKey: "FirstName")
            detailDict.setValue(websiteField.text!, forKey: "Website")
            detailDict.setValue(cityField.text!, forKey: "City")
            detailDict.setValue(titleField.text!, forKey: "JobTitle")
            detailDict.setValue(self.whoUser.emailAddress, forKey: "EmailAddress")
            detailDict.setValue(address3Field.text!, forKey: "AddressLine3")
            detailDict.setValue(address2Field.text!, forKey: "AddressLine2")
            detailDict.setValue(secondaryPhone.text!, forKey: "SecondaryPhone")
            detailDict.setValue(addressField.text!, forKey: "AddressLine1")
            detailDict.setValue(stateField.text!, forKey: "State")
            detailDict.setValue(phoneField.text!, forKey: "MainPhone")
            detailDict.setValue(countryField.text!, forKey: "Country")
            detailDict.setValue(lastnameField.text!, forKey: "LastName")
            detailDict.setValue(self.whoUser.id, forKey: "Id")
            let json: [String: Any] = ["User": detailDict,
                                       //"UserMeta": useMeta,
                                       "PassKey": passKey]
            print(json)
            print(modifyUserURL)
            APIManager.sharedInstance.postRequestCall(postURL: modifyUserURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    let alert = UIAlertController(title: "User profile updated successfully", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
       
    }
    func profileUpdateAlert(){
        let alert = UIAlertController(title: "Are you sure you want update the profile?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.modifyUser()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func tappedSave(_ sender: Any) {
        profileUpdateAlert()
    }
    @IBAction func tappedCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        return 15
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 7 {
            return 0
        }
        return 59
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 45
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
extension MyProfileVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.tag == -1 || textField.tag == -2  {
            let combinedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: "\(string)")
            if (combinedText?.count ?? 0) < countryCode.count || !(combinedText?.hasPrefix(countryCode) ?? false) {
                return false
            }
            
            if (combinedText?.count ?? 0) > countryCode.count + 10 {
                return false
            }
            return true
        }
        return true
    }
}
extension MyProfileVC:URLSessionDelegate {
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
