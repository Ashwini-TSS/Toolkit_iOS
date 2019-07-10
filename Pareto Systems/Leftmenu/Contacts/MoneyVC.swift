//
//  MoneyVC.swift
//  Pareto Systems
//
//  Created by Thabresh on 19/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class MoneyVC: UITableViewController {
    
    @IBOutlet weak var incomeField: ACFloatingTextfield!
    @IBOutlet weak var creditLimitField: ACFloatingTextfield!
    @IBOutlet weak var executornameField: ACFloatingTextfield!
    @IBOutlet weak var executorField: ACFloatingTextfield!
    @IBOutlet weak var groupInsuranceField: ACFloatingTextfield!
    @IBOutlet weak var revenueField: ACFloatingTextfield!
    @IBOutlet weak var creditField: ACFloatingTextfield!
    @IBOutlet weak var powerOfNameField: ACFloatingTextfield!
    @IBOutlet weak var powerOfAttorneyField: ACFloatingTextfield!
    @IBOutlet weak var groupPensionField: ACFloatingTextfield!
    @IBOutlet weak var moneyNotesField: KMPlaceholderTextView!
    var contactsList:[familyContactResult] = []
    var executorID:String = ""
    var powerID:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        moneyNotesField.layer.cornerRadius = 5.0
        moneyNotesField.layer.borderColor = UIColor.lightGray.cgColor
        moneyNotesField.layer.borderWidth = 1.0
        moneyNotesField.clipsToBounds = true
        
        if selectedContactInfo != nil {
            incomeField.text = String(describing:selectedContactInfo.income ?? 0)
            creditLimitField.text = String(describing:selectedContactInfo.creditLimit ?? 0)
            executornameField.text = selectedContactInfo.executorName
            executorField.text = selectedContactInfo.executorID
            groupInsuranceField.text = selectedContactInfo.groupInsurance
            moneyNotesField.text = selectedContactInfo.moneyNotes
            revenueField.text = String(describing:selectedContactInfo.revenue ?? 0)
            creditField.text = String(describing:selectedContactInfo.creditOnHold ?? 0)
            powerOfNameField.text = selectedContactInfo.powerofAttorneyName
            powerOfAttorneyField.text = selectedContactInfo.powerOfAttronyID
            groupPensionField.text = selectedContactInfo.groupPensionPlan
        }else{
            if let data = UserDefaults.standard.object(forKey: "MoneyInfo") as? NSDictionary{
                incomeField.text = "\(data.value(forKey: "Income") as! Int)"
                creditLimitField.text =  "\(data.value(forKey: "CreditLimit") as! Int)"
                executornameField.text = data.value(forKey: "ExecutorName") as? String
                executorField.text = data.value(forKey: "ExecutorId") as? String
                groupInsuranceField.text = data.value(forKey: "GroupInsurance") as? String
                moneyNotesField.text = data.value(forKey: "MoneyNotes") as? String
                revenueField.text = "\(data.value(forKey: "Revenue") as! Int)"
                creditField.text = "\(data.value(forKey: "CreditOnHold") as! Int)"
                powerOfNameField.text = data.value(forKey: "PowerofAttorneyName") as? String
                powerOfAttorneyField.text = data.value(forKey: "PowerofAttorneyId") as? String
                groupPensionField.text = data.value(forKey: "GroupPensionPlan") as? String
            }
        }
        
        getClientClasses()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func tappedSave(_ sender: Any) {
        var incomeValue:Int = 0
        if (incomeField.text?.count)! > 0 {
            incomeValue = Int(incomeField.text!)!
        }
        
        var creditValue:Int = 0
        if (creditLimitField.text?.count)! > 0 {
            creditValue = Int(creditLimitField.text!)!
        }
        var revenueValue:Int = 0
        if (revenueField.text?.count)! > 0 {
            revenueValue = Int(revenueField.text!)!
        }
        var creditHoldValue:Int = 0
        if (creditField.text?.count)! > 0 {
            creditHoldValue = Int(creditField.text!)!
        }
        let dataObject:NSMutableDictionary = [:]

        //Money
        dataObject.setValue(incomeValue, forKey: "Income")
        dataObject.setValue(creditValue, forKey: "CreditLimit")
        dataObject.setValue(executornameField.text!, forKey: "ExecutorName")
        dataObject.setValue(executorID, forKey: "ExecutorId")
        dataObject.setValue(groupInsuranceField.text!, forKey: "GroupInsurance")
        dataObject.setValue(moneyNotesField.text!, forKey: "MoneyNotes")
        dataObject.setValue(revenueValue, forKey: "Revenue")
        dataObject.setValue(creditHoldValue, forKey: "CreditOnHold")
        dataObject.setValue(powerOfNameField.text!, forKey: "PowerofAttorneyName")
        dataObject.setValue(powerID, forKey: "PowerofAttorneyId")
        dataObject.setValue(groupPensionField.text!, forKey: "GroupPensionPlan")
        
        UserDefaults.standard.set(dataObject, forKey: "MoneyInfo")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getClientClasses(){
        let json: [String: Any] = ["ObjectName":"contact",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "SearchTerm":""]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let result = familyContactClassModel.init(fromDictionary: jsonResponse)
                print(result.responseMessage)
                if result.valid == true {
                    self.contactsList = result.results
                    
                    
                    for index in 0..<self.contactsList.count {
                        //executorField.text
                        
                        let getValues:familyContactResult = self.contactsList[index]
                        
                        if getValues.id == self.executorField.text {
                            self.executorID = getValues.id
                            self.executorField.text = getValues.fullName
                        }
                        if getValues.id == self.powerOfAttorneyField.text {
                            self.powerID = getValues.id
                            self.powerOfAttorneyField.text = getValues.fullName
                        }
                    }
                }else{
                    self.contactsList = []
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 11
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
extension MoneyVC:UITextFieldDelegate {
    
    func showPicker(pickerTag:NSInteger){
        // Strings Picker
        let valuesOfArr:NSMutableArray = []
        for index in 0..<self.contactsList.count {
            let getValues:familyContactResult = self.contactsList[index]
            valuesOfArr.add(getValues.fullName)
        }
        DPPickerManager.shared.showPicker(title: "Account", selected: "", strings: valuesOfArr as! [String]) { (value, index, cancel) in
            if !cancel {
                  let getValues:familyContactResult = self.contactsList[index]
                if pickerTag == 0 {
                    self.executorID = getValues.id
                    self.executorField.text = getValues.fullName
                }else if pickerTag == 1 {
                    self.powerOfAttorneyField.text = getValues.fullName
                    self.powerID = getValues.id
                }
              
                // TODO: you code here
                debugPrint(value as Any)
            }
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == executorField {
            textField.resignFirstResponder()
            showPicker(pickerTag: 0)
            return false
        }else if textField == powerOfAttorneyField {
            textField.resignFirstResponder()
            showPicker(pickerTag: 1)
            return false
        }
        return true
        
    }
}
extension MoneyVC:URLSessionDelegate {
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
