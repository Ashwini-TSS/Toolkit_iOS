//
//  FamilyVC.swift
//  Pareto Systems
//
//  Created by Thabresh on 19/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class FamilyVC: UIViewController {

    @IBOutlet weak var tblChildrans: UITableView!
    @IBOutlet weak var commentField: KMPlaceholderTextView!
    @IBOutlet weak var spouseContactField: ACFloatingTextfield!
    @IBOutlet weak var spouseField: ACFloatingTextfield!
    var childsArr:NSMutableArray = []
    var contactsList:[familyContactResult] = []
    var spouseContactID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentField.layer.cornerRadius = 5.0
        commentField.layer.borderColor = UIColor.lightGray.cgColor
        commentField.layer.borderWidth = 1.0
        commentField.clipsToBounds = true
        
        getClientClasses()
        
        if selectedContactInfo != nil {
            spouseField.text = selectedContactInfo.spousePartnerName
            spouseContactField.text = selectedContactInfo.spousePartnerID
            commentField.text = selectedContactInfo.familyNotes
            
            if let childranName:String = selectedContactInfo.ChildrensNames {
                
                if childranName.count > 0 {
                    let childranArrayList:NSArray = childranName.components(separatedBy: "\n") as NSArray
                    childsArr = childranArrayList.mutableCopy() as! NSMutableArray
                    tblChildrans.reloadData()
                }
            }
           
        }else{
            if let data = UserDefaults.standard.object(forKey: "FamilyInfo") as? NSDictionary{
                spouseField.text = data.value(forKey: "SpousePartnerName") as? String
                spouseContactField.text = data.value(forKey: "SpousePartnerId") as? String
                commentField.text = data.value(forKey: "FamilyNotes") as? String
                
                let childranName:String = (data.value(forKey: "ChildrensNames") as? String)!
                print(childranName)
                
                if childranName.count > 0 {
                    let childranArrayList:NSArray = childranName.components(separatedBy: "\n") as NSArray
                    print(childranArrayList)
                    childsArr = childranArrayList.mutableCopy() as! NSMutableArray
                    tblChildrans.reloadData()
                }

            }
        }
        // Do any additional setup after loading the view.
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
                        let getValues:familyContactResult = self.contactsList[index]
                        if getValues.id == self.spouseContactField.text {
                            self.spouseContactID = getValues.id
                            self.spouseContactField.text = getValues.fullName
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
    
    @IBAction func tappedSave(_ sender: Any) {
        
//        let childranNames:NSMutableArray = []
//
//        for index in 0..<childsArr.count {
//            let indexPath = IndexPath(row: index, section: 0)
//            let cell:FamilyCell = tblChildrans.cellForRow(at: indexPath) as! FamilyCell
//            if (cell.childranField.text?.count)! > 0 {
//                var childranName:String = cell.childranField.text!
//                childranName = childranName + "\n"
//                childranNames.add(childranName)
//            }else{
//                childranNames.add("\n")
//            }
//        }
//        print(childranNames.count)
//        print(childranNames)
//
//        let strChildrans:String = childranNames.componentsJoined(by: " ")
//        print(strChildrans)
//
//
//
//        let dataObject:NSMutableDictionary = [:]
//        //Family
//        dataObject.setValue(spouseField.text!, forKey: "SpousePartnerName")
//        dataObject.setValue(strChildrans, forKey: "ChildrensNames")
//        dataObject.setValue(spouseContactID, forKey: "SpousePartnerId")
//        dataObject.setValue(commentField.text!, forKey: "FamilyNotes")
//
//        print(dataObject)
//
//        UserDefaults.standard.set(dataObject, forKey: "FamilyInfo")
//        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedAdd(_ sender: Any) {
        childsArr.add("0")
        tblChildrans.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FamilyVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FamilyCell = tableView.dequeueReusableCell(withIdentifier: "FamilyCell") as! FamilyCell
//        let childName:String = childsArr[indexPath.row] as! String
//        if childName == "0" {
//            cell.childranField.text = ""
//        }else{
//            cell.childranField.text = childName
//        }
        
        return cell
    }
}
extension FamilyVC:UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == spouseContactField {
            showClientClassPicker()
            return false
        }
        return true
    }
    
    func showClientClassPicker(){
        // Strings Picker
        let valuesOfArr:NSMutableArray = []
        for index in 0..<self.contactsList.count {
            let getValues:familyContactResult = self.contactsList[index]
            valuesOfArr.add(getValues.fullName)
        }
        DPPickerManager.shared.showPicker(title: "spouse contact", selected: "", strings: valuesOfArr as! [String]) { (value, index, cancel) in
            if !cancel {
                
                let getValues:familyContactResult = self.contactsList[index]
                self.spouseContactField.text = getValues.fullName
                self.spouseContactID = getValues.id
                // TODO: you code here
                debugPrint(value as Any)
            }
        }
    }
}
extension FamilyVC:URLSessionDelegate {
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
