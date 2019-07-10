//
//  OccupationNotesVC.swift
//  Pareto Systems
//
//  Created by Thabresh on 19/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class OccupationNotesVC: UITableViewController {

    @IBOutlet weak var recreationNotesField: KMPlaceholderTextView!
    @IBOutlet weak var occpationNotesField: KMPlaceholderTextView!
    @IBOutlet weak var assistantPhoneField: ACFloatingTextfield!
    @IBOutlet weak var departmentField: ACFloatingTextfield!
    @IBOutlet weak var jobTitleField: ACFloatingTextfield!
    @IBOutlet weak var assistantField: ACFloatingTextfield!
    @IBOutlet weak var companyAccountField: ACFloatingTextfield!
    @IBOutlet weak var companyFiel: ACFloatingTextfield!
    var getSearchList:[searchAccountResult] = []
    var companyID:String = ""
    var headerTitle:[String] = ["Occupation","Recreation"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recreationNotesField.layer.cornerRadius = 5.0
        recreationNotesField.layer.borderColor = UIColor.lightGray.cgColor
        recreationNotesField.layer.borderWidth = 1.0
        recreationNotesField.clipsToBounds = true
        
        occpationNotesField.layer.cornerRadius = 5.0
        occpationNotesField.layer.borderColor = UIColor.lightGray.cgColor
        occpationNotesField.layer.borderWidth = 1.0
        occpationNotesField.clipsToBounds = true
        
        getClientClasses()
        if selectedContactInfo != nil {
            companyFiel.text = selectedContactInfo.companyName
            companyAccountField.text = selectedContactInfo.companyId
            assistantField.text = selectedContactInfo.assistantName
            occpationNotesField.text = selectedContactInfo.occupationNotes
            jobTitleField.text = selectedContactInfo.jobTitle
            departmentField.text = selectedContactInfo.department
            assistantPhoneField.text = selectedContactInfo.assistantPhone
            recreationNotesField.text = selectedContactInfo.recreationNotes
        }else{
            if let data = UserDefaults.standard.object(forKey: "OccupationInfo") as? NSDictionary{
                companyFiel.text = data.value(forKey: "CompanyName") as? String
                companyAccountField.text = data.value(forKey: "CompanyId") as? String
                assistantField.text = data.value(forKey: "AssistantName") as? String
                occpationNotesField.text = data.value(forKey: "OccupationNotes") as? String
                jobTitleField.text = data.value(forKey: "JobTitle") as? String
                departmentField.text = data.value(forKey: "Department") as? String
                assistantPhoneField.text = data.value(forKey: "AssistantPhone") as? String
                recreationNotesField.text = data.value(forKey: "RecreationNotes") as? String
            }
        }
      
    // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func tappedSave(_ sender: Any) {
        let dataObject:NSMutableDictionary = [:]
        //Occupution
        dataObject.setValue(companyFiel.text!, forKey: "CompanyName")
        dataObject.setValue(companyID, forKey: "CompanyId")
        dataObject.setValue(assistantField.text!, forKey: "AssistantName")
        dataObject.setValue(occpationNotesField.text!, forKey: "OccupationNotes")
        dataObject.setValue(jobTitleField.text!, forKey: "JobTitle")
        dataObject.setValue(departmentField.text!, forKey: "Department")
        dataObject.setValue(assistantPhoneField.text!, forKey: "AssistantPhone")
        
        //Recreation
        dataObject.setValue(recreationNotesField.text!, forKey: "RecreationNotes")
        
        UserDefaults.standard.set(dataObject, forKey: "OccupationInfo")
        self.navigationController?.popViewController(animated: true)
    }
    
    func getClientClasses(){
        let json: [String: Any] = ["ObjectName":"company",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "SearchTerm":""]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let model = searchAccountClassModel.init(fromDictionary: jsonResponse)
                if model.valid == true {
                    self.getSearchList = model.results
                    
                    for index in 0..<self.getSearchList.count {
                        let getValues:searchAccountResult = self.getSearchList[index]
                        if getValues.id == self.companyAccountField.text {
                            self.companyAccountField.text = getValues.name
                            self.companyID = getValues.id
                        }
                    }
                }else{
                    self.getSearchList = []
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
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 1 {
            return 1
        }
        return 7
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
extension OccupationNotesVC:UITextFieldDelegate {
    
    func showClientClassPicker(){
        // Strings Picker
        let valuesOfArr:NSMutableArray = []
        for index in 0..<self.getSearchList.count {
            let getValues:searchAccountResult = self.getSearchList[index]
            valuesOfArr.add(getValues.name)
        }
        DPPickerManager.shared.showPicker(title: "Company Account", selected: "", strings: valuesOfArr as! [String]) { (value, index, cancel) in
            if !cancel {
                
                let getValues:searchAccountResult = self.getSearchList[index]
                self.companyAccountField.text = getValues.name
                self.companyID = getValues.id
                // TODO: you code here
                debugPrint(value as Any)
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == companyAccountField {
            showClientClassPicker()
            return false
        }
        return true
    }
}
extension OccupationNotesVC:URLSessionDelegate {
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
