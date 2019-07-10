//
//  StepsListController.swift
//  Processes
//
//  Created by Test Technologies PVT LTD on 02/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class StepsListController: UITableViewController {

    var stepsTag:String = ""
    var stepsList:[GetStepsResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

      tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getStepsList()
    }
    
    @IBAction func tappedAdd(_ sender: Any) {
        let controller:NewStepsController = self.storyboard?.instantiateViewController(withIdentifier: "NewStepsController") as! NewStepsController
        controller.advProcessID = stepsTag
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func getStepsList(){
        let json: [String: Any] = ["PageOffset": 1,
                                   "ResultsPerPage": 5000,
                                   "ObjectName":"advocate_process_template",
                                   "ParentObjectName":"advocate_process",
                                   "ParentId":stepsTag,
                                   "AscendingOrder":true,
                                   "OrderBy":"Sequence",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let steps:GetStepsModel = GetStepsModel.init(fromDictionary: jsonResponse)
                if steps.valid {
                    self.stepsList = steps.results
                }else{
                    
                }
                self.tableView.reloadData()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
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
        return self.stepsList.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StepsListCell = tableView.dequeueReusableCell(withIdentifier: "StepsListCell", for: indexPath) as! StepsListCell
        let getResult:GetStepsResult = self.stepsList[indexPath.row]
        cell.lblSubject.text = getResult.subject
//        cell.lblLocation.text = getResult.location
//        cell.lblSequence.text = "\(getResult.sequence!)"
        cell.lblStartTime.text = "\(getResult.sequence!)"
        cell.lblActivityType.text = getResult.activityType
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let getResult:GetStepsResult = self.stepsList[indexPath.row]
        let controller:NewStepsController = self.storyboard?.instantiateViewController(withIdentifier: "NewStepsController") as! NewStepsController
        controller.previousProcessesValue = getResult
        controller.advProcessID = stepsTag
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let getResult:GetStepsResult = self.stepsList[indexPath.row]
            print(getResult.id)
            
            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    print(index,title)
                    if title == "Yes" {
                        self.deleteInviteUser(contactID: getResult.id)
                    }
                })
            })
        })
        // 5
        return [shareAction]
    }
    func deleteInviteUser(contactID:String){
        let parameters = [
            "ObjectName": "advocate_process_template",
            "OrganizationId": currentOrgID,
            "ObjectId": contactID,
            "PassKey": passKey
            ] as [String : Any]
        
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                self.getStepsList()
              
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
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
            dateFormatter.dateFormat = "hh:mm a" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 107
    }

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
extension StepsListController:URLSessionDelegate {
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
