//
//  ContactBasicVC.swift
//  Pareto Systems
//
//  Created by Thabresh on 18/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ContactBasicVC: UITableViewController {

    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var faxField: ACFloatingTextfield!
    @IBOutlet weak var pagerField: ACFloatingTextfield!
    @IBOutlet weak var mobilePhone: ACFloatingTextfield!
    @IBOutlet weak var alternatePhone: ACFloatingTextfield!
    @IBOutlet weak var eveningPhone: ACFloatingTextfield!
    @IBOutlet weak var businessPhone: ACFloatingTextfield!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var middleNameField: UITextField!
    @IBOutlet weak var anniversaryField: UITextField!
    @IBOutlet weak var clientSinceField: UITextField!
    @IBOutlet weak var birthField: UITextField!
    @IBOutlet weak var clientClassField: UITextField!
    @IBOutlet weak var licenseexpiryField: UITextField!
    @IBOutlet weak var descriptionField: KMPlaceholderTextView!
    @IBOutlet weak var ownerField: UITextField!
    @IBOutlet weak var reviewField: UITextField!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var suffixField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var govtIDField: UITextField!
    @IBOutlet weak var licensenoField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var saluation: UITextField!
    var responseClasses:[getClientResult] = []
    var repsonseOrganizationUser:[getOrganizationResult] = []

    var selectedClientClassID:String = ""
    var owningOrganizationUserID:String = ""

    var headerTitle:[String] = ["Contacts","Phone Numbers"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionField.layer.cornerRadius = 5.0
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        descriptionField.layer.borderWidth = 1.0
        descriptionField.clipsToBounds = true
        
        getClientClasses()

                mobilePhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        if selectedContactInfo != nil {
            saluation.text = selectedContactInfo.salutation
            firstnameField.text = selectedContactInfo.firstName
            middleNameField.text = selectedContactInfo.middleName
            lastnameField.text = selectedContactInfo.lastName
            genderField.text = selectedContactInfo.gender
            
            if (selectedContactInfo.anniversay != nil) {
                anniversaryField.text = converDateToString(dateString: selectedContactInfo.anniversay)
            }
            if (selectedContactInfo.clientSince != nil) {
                clientSinceField.text = converDateToString(dateString: selectedContactInfo.clientSince)
            }
            if (selectedContactInfo.clientClassId != nil) {
                clientClassField.text = selectedContactInfo.clientClassId
            }
            if (selectedContactInfo.BirthDate != nil) {
                birthField.text = converDateToString(dateString: selectedContactInfo.BirthDate)
            }
            if (selectedContactInfo.renewDate != nil) {
                reviewField.text = converDateToString(dateString: selectedContactInfo.renewDate)
            }
            if (selectedContactInfo.licenseExpiry != nil) {
                licenseexpiryField.text = converDateToString(dateString: selectedContactInfo.licenseExpiry)
            }
            licensenoField.text = selectedContactInfo.driversLicenseNumber
            govtIDField.text = selectedContactInfo.governmentIdent
            titleField.text = selectedContactInfo.title
            suffixField.text = selectedContactInfo.suffix
            nicknameField.text = selectedContactInfo.nickName
            
            
            if selectedContactInfo.privateField == true {
                btnYes.setImage(UIImage.init(named:"ic_check"), for: .normal)
                btnNo.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
            }else if selectedContactInfo.privateField == false{
                btnYes.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
                btnNo.setImage(UIImage.init(named:"ic_check"), for: .normal)
            }else{
                btnNo.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
                btnYes.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
            }
           
            ownerField.text = selectedContactInfo.owningOrganizationUserId
            descriptionField.text = selectedContactInfo.descriptionField
            businessPhone.text = selectedContactInfo.telephone1
            alternatePhone.text = selectedContactInfo.telephone2
            pagerField.text = selectedContactInfo.pager
            eveningPhone.text = selectedContactInfo.telephone3
            mobilePhone.text = NavigationHelper.USPhoneFormat(number: selectedContactInfo.mobilePhone)
            faxField.text = selectedContactInfo.fax
        }else{
            if let data:NSDictionary = UserDefaults.standard.object(forKey: "BasicInfo") as? NSDictionary {
                saluation.text = data.value(forKey: "Salutation") as? String
                firstnameField.text = data.value(forKey: "FirstName") as? String
                middleNameField.text = data.value(forKey: "MiddleName") as? String
                lastnameField.text = data.value(forKey: "LastName") as? String
                genderField.text = data.value(forKey: "Gender") as? String
                anniversaryField.text = converDateToString(dateString: (data.value(forKey: "Anniversary") as? String)!)
                clientSinceField.text = converDateToString(dateString: (data.value(forKey: "ClientSince")as? String)!)
                licensenoField.text = data.value(forKey: "DriversLicenseNumber")as? String
                govtIDField.text = data.value(forKey: "GovernmentIdent")as? String
                clientClassField.text = data.value(forKey: "ClientClassId")as? String
                titleField.text = data.value(forKey: "Title")as? String
                suffixField.text = data.value(forKey: "Suffix")as? String
                nicknameField.text = data.value(forKey: "NickName")as? String
                if selectedContactInfo.privateField == true {
                    btnYes.setImage(UIImage.init(named:"ic_check"), for: .normal)
                    btnNo.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
                }else if selectedContactInfo.privateField == false{
                    btnYes.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
                    btnNo.setImage(UIImage.init(named:"ic_check"), for: .normal)
                }else{
                    btnNo.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
                    btnYes.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
                }
                birthField.text = converDateToString(dateString: (data.value(forKey: "BirthDate")as? String)!)
                reviewField.text = converDateToString(dateString: (data.value(forKey: "ReviewDate")as? String)!)
                licenseexpiryField.text = converDateToString(dateString: (data.value(forKey: "DriversLicenseExpiry")as? String)!)
                ownerField.text = data.value(forKey: "OwningOrganizationUserId")as? String
                descriptionField.text = data.value(forKey: "Description")as? String
                
                businessPhone.text = NavigationHelper.USPhoneFormat(number: (data.value(forKey: "Telephone1") as? String)!)
                alternatePhone.text = NavigationHelper.USPhoneFormat(number: (data.value(forKey: "Telephone2") as? String)!)

                eveningPhone.text = NavigationHelper.USPhoneFormat(number: (data.value(forKey: "Telephone3") as? String)!)
                mobilePhone.text = NavigationHelper.USPhoneFormat(number: (data.value(forKey: "MobilePhone") as? String)!)

            
                pagerField.text = data.value(forKey: "Pager")as? String
           
                faxField.text = data.value(forKey: "Fax")as? String
                return
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @objc func textFieldDidChange(textField : UITextField){
        textField.text = NavigationHelper.USPhoneFormat(number: textField.text!)
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
            dateFormatter.dateFormat = "yyyy-MM-dd" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
       return ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedYes(_ sender: Any) {
        btnNo.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)

        let btnImag = (sender as AnyObject).image(for: .normal)
        if btnImag == UIImage.init(named:"ic_uncheck") {
            btnYes.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            btnYes.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
        }
    }
    @IBAction func tappedNo(_ sender: Any) {
        btnYes.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)

        let btnImag = (sender as AnyObject).image(for: .normal)
        if btnImag == UIImage.init(named:"ic_uncheck") {
            btnNo.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else{
            btnNo.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
        }
    }
    func getClientClasses(){

        let json: [String: Any] = ["ObjectName":"client_class",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "SearchTerm":""]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            self.getOrganizationUser()
            DispatchQueue.main.async {
                print(json)
                
                let result = getClientClassModel.init(fromDictionary: jsonResponse)
                print(result.responseMessage)
                
                if result.valid == true {
                    self.responseClasses = result.results
                    
                    //clientClassField.text
                    
                    
                    for index in 0..<self.responseClasses.count {
                        let getValues:getClientResult = self.responseClasses[index]
                        if getValues.id == self.clientClassField.text {
                            self.selectedClientClassID = getValues.id
                            self.clientClassField.text = getValues.name
                        }
                    }
                }else{
                    self.responseClasses = []
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    func getOrganizationUser(){
        let json: [String: Any] = ["ObjectName":"organization_user",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "SearchTerm":""]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                //getOrganizationClassModel
                
                let result = getOrganizationClassModel.init(fromDictionary: jsonResponse)
                print(result.responseMessage)
                if result.valid == true {
                    self.repsonseOrganizationUser = result.results
                    
                    for index in 0..<self.repsonseOrganizationUser.count {
                        let getValues:getOrganizationResult = self.repsonseOrganizationUser[index]
                        if getValues.id == self.ownerField.text {
                            self.owningOrganizationUserID = getValues.id
                            self.ownerField.text = getValues.fullName
                        }
                    }
                    
                }else{
                    self.repsonseOrganizationUser = []
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    @IBAction func tappedSave(_ sender: Any) {
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(saluation.text!, forKey: "Salutation")
        dataObject.setValue(firstnameField.text!, forKey: "FirstName")
        dataObject.setValue(middleNameField.text!, forKey: "MiddleName")
        dataObject.setValue(lastnameField.text!, forKey: "LastName")
        dataObject.setValue(genderField.text!, forKey: "Gender")
        
        if (anniversaryField.text?.count)! > 0 {
            dataObject.setValue(anniversaryField.text! + "T06:30:00.000Z", forKey: "Anniversary")
        }else{
            dataObject.setValue("", forKey: "Anniversary")
        }
        
        dataObject.setValue(titleField.text!, forKey: "Title")
        dataObject.setValue(suffixField.text!, forKey: "Suffix")
        dataObject.setValue(nicknameField.text!, forKey: "NickName")
        
        var isPrivate:Bool = false
        var isPrivateFalse:Bool = false

        let btnImag = btnYes.image(for: .normal)
        if btnImag == UIImage.init(named:"ic_check") {
            isPrivate = true
        }
        let btnImag1 = btnNo.image(for: .normal)
        if btnImag1 == UIImage.init(named:"ic_check") {
            isPrivateFalse = true
        }
        if isPrivate && isPrivateFalse {
            dataObject.setValue(isPrivate, forKey: "Private")
        }else{
            //dataObject.setValue("", forKey: "Private")
        }
        dataObject.setValue(govtIDField.text!, forKey: "GovernmentIdent")
        dataObject.setValue(licensenoField.text!, forKey: "DriversLicenseNumber")
        if (birthField.text?.count)! > 0 {
            dataObject.setValue(birthField.text! + "T06:30:00.000Z", forKey: "BirthDate")
        }else{
            dataObject.setValue("", forKey: "BirthDate")
        }
        if (clientSinceField.text?.count)! > 0 {
            dataObject.setValue(clientSinceField.text! + "T06:30:00.000Z", forKey: "ClientSince")
        }else{
            dataObject.setValue("", forKey: "ClientSince")
        }
        if (reviewField.text?.count)! > 0 {
            dataObject.setValue(reviewField.text! + "T06:30:00.000Z", forKey: "ReviewDate")
        }else{
            dataObject.setValue("", forKey: "ReviewDate")
        }
        if (licenseexpiryField.text?.count)! > 0 {
            dataObject.setValue(licenseexpiryField.text! + "T06:30:00.000Z", forKey: "DriversLicenseExpiry")
        }else{
            dataObject.setValue("", forKey: "DriversLicenseExpiry")
        }
        dataObject.setValue(selectedClientClassID, forKey: "ClientClassId")
        dataObject.setValue(descriptionField.text!, forKey: "Description")
        dataObject.setValue(mobilePhone.text!, forKey: "MobilePhone")
        dataObject.setValue(pagerField.text!, forKey: "Pager")
        dataObject.setValue(businessPhone.text!, forKey: "Telephone1")
        dataObject.setValue(eveningPhone.text!, forKey: "Telephone2")
        dataObject.setValue(alternatePhone.text!, forKey: "Telephone3")
        dataObject.setValue(faxField.text!, forKey: "Fax")
        dataObject.setValue(owningOrganizationUserID, forKey: "OwningOrganizationUserId")
        
        print(dataObject)
        
        UserDefaults.standard.set(dataObject, forKey: "BasicInfo")
        
        self.navigationController?.popViewController(animated: true)
        

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return 6
        }
        return 19
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 40))
        headerView.backgroundColor = UIColor.init(red: 143.0/255.0, green: 143.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        
        let label = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: tableView.bounds.size.width - 20, height: 30.0))
        label.text = headerTitle[section]
        headerView.addSubview(label)
        
        return headerView
    }
}
extension ContactBasicVC:UITextFieldDelegate {
    
    func showGenderSheet(){
        let alertController = UIAlertController(title: "Gender", message: nil, preferredStyle: .actionSheet)
        
        let sendButton = UIAlertAction(title: "Male", style: .default, handler: { (action) -> Void in
            self.genderField.text = "Male"
        })
        let femaleButton = UIAlertAction(title: "Female", style: .default, handler: { (action) -> Void in
            self.genderField.text = "Female"
        })
        let  deleteButton = UIAlertAction(title: "Other", style: .destructive, handler: { (action) -> Void in
            self.genderField.text = "Other"
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            self.genderField.text = ""
        })
        
        alertController.addAction(sendButton)
        alertController.addAction(femaleButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    func showClientClassPicker(){
        // Strings Picker
        let valuesOfArr:NSMutableArray = []
        for index in 0..<self.responseClasses.count {
            let getValues:getClientResult = self.responseClasses[index]
            valuesOfArr.add(getValues.name)
        }
        DPPickerManager.shared.showPicker(title: "Client Class", selected: "", strings: valuesOfArr as! [String]) { (value, index, cancel) in
            if !cancel {
                
                let getValues:getClientResult = self.responseClasses[index]
                self.selectedClientClassID = getValues.id
                self.clientClassField.text = value
                // TODO: you code here
                debugPrint(value as Any)
            }
        }
    }
    func showOrganizationUser(){
        //repsonseOrganizationUser
        let valuesOfArr:NSMutableArray = []
        for index in 0..<self.repsonseOrganizationUser.count {
            let getValues:getOrganizationResult = self.repsonseOrganizationUser[index]
            valuesOfArr.add(getValues.fullName)
        }
        DPPickerManager.shared.showPicker(title: "Owner", selected: "", strings: valuesOfArr as! [String]) { (value, index, cancel) in
            if !cancel {
                let getValues:getOrganizationResult = self.repsonseOrganizationUser[index]
                self.owningOrganizationUserID = getValues.id
                self.ownerField.text = value
                // TODO: you code here
                debugPrint(value as Any)
            }
        }
    }
    func showDatePicker(pickTag:NSInteger){
        // Date Picker
//        let min = Date()
//        let max = min.addingTimeInterval(31536000) // 1 year
        DPPickerManager.shared.showPicker(title: "Choose Date", selected: Date(), min: nil, max: nil) { (date, cancel) in
            if !cancel {
                // TODO: you code here
                debugPrint(date as Any)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd"
                if pickTag == 0 {
                    self.clientSinceField.text = formatter.string(from: date!)
                }else if pickTag == 1 {
                    self.birthField.text = formatter.string(from: date!)
                }else if pickTag == 2 {
                    self.reviewField.text = formatter.string(from: date!)
                }else if pickTag == 3 {
                    self.licenseexpiryField.text = formatter.string(from: date!)
                }else if pickTag == 4 {
                    self.anniversaryField.text = formatter.string(from: date!)
                }
            }
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == genderField {
            textField.resignFirstResponder()

            showGenderSheet()
            return false
        }else if textField == clientClassField {
            textField.resignFirstResponder()

            showClientClassPicker()
            return false
        }else if textField == ownerField {
            textField.resignFirstResponder()

            showOrganizationUser()
            return false
        }else if textField == clientSinceField {
            textField.resignFirstResponder()

            showDatePicker(pickTag: 0)
            return false
        }else if textField == birthField {
            textField.resignFirstResponder()

            showDatePicker(pickTag: 1)
            return false
        }else if textField == reviewField {
            textField.resignFirstResponder()

            showDatePicker(pickTag: 2)
            return false
        }else if textField == licenseexpiryField {
            textField.resignFirstResponder()

            showDatePicker(pickTag: 3)
            return false
        }else if textField == anniversaryField {
            textField.resignFirstResponder()

            showDatePicker(pickTag: 4)
            return false
        }
        return true
    }
}
extension ContactBasicVC:URLSessionDelegate {
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
