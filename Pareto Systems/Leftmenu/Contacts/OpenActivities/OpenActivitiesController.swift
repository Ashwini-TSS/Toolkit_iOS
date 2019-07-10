//
//  OpenActivitiesController.swift
//  Pareto Systems
//
//  Created by Thabresh on 22/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class OpenActivitiesController: UITableViewController {
    
    var linkParentID:String = ""
    var searchResult:[OpenActivityActivity] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
         self.searchResult = []
        getLinkedAccountList()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResult.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:OpenActivitiesCell = tableView.dequeueReusableCell(withIdentifier: "OpenActivitiesCell", for: indexPath) as! OpenActivitiesCell
         let result:OpenActivityActivity = searchResult[indexPath.row]
//        print(result.activity.startTime)
//        print(result.activity.startTime)
//        print(result.activity.location)
//        print(result.type)

        cell.lblPhone.text =  result.activity.location
        cell.lblEmail.text = converDateToString(dateString: result.activity.startTime)
        cell.lblName.text =  result.activity.subject
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result:OpenActivityActivity = self.searchResult[indexPath.row]


        if result.type == "Task" {
            let controller:NewTaskController = (self.storyboard?.instantiateViewController(withIdentifier: "NewTaskController") as? NewTaskController)!
            controller.linkParentID = self.linkParentID
            controller.openedActivties = result
            self.navigationController?.pushViewController(controller, animated: true)
        }else if result.type == "Appointment" || result.type == "Appointments" {
            let controller:NewAppointmentsController = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentsController") as? NewAppointmentsController)!
            controller.linkParentID = self.linkParentID
            controller.openedActivties = result
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let result:OpenActivityActivity = self.searchResult[indexPath.row]
            print(result.activity.id)
            
            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    print(index,title)
                    if title == "Yes" {
                        self.deleteInviteUser(contactID: result.activity.id)
                    }
                })
            })
        })
        // 5
        return [shareAction]
    }
    func deleteInviteUser(contactID:String){
        
        let headers = [
            "Content-Type": "application/json"
        ]
        let parameters = [
            "ObjectName": "appointment",
            "OrganizationId": currentOrgID,
            "ObjectId": contactID,
            "PassKey": passKey
            ] as [String : Any]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/delete.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription as Any)
            } else {
                
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
                
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Deleted") { (index, title) in
                        OperationQueue.main.addOperation {
                            self.getLinkedAccountList()
                        }
                    }
                })
            }
        })
        
        dataTask.resume()
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
            dateFormatter.dateFormat = "YYYY-MM-dd" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }
    
    func getLinkedAccountList() {
        
        let json: [String: Any] = ["PageOffset": 1,
                                   "ResultsPerPage": 1000,
                                   "IncludeAppointments": true,
                                   "IncludeTasks": true,
                                   "Invert": false,
                                   "ReturnTotal":true,
                                   "ForContacts":[linkParentID],
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        
        
        APIManager.sharedInstance.postRequestCall(postURL: getIncompleteActivitiesURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let result = OpenActivityModel.init(fromDictionary: jsonResponse)
                print(result.responseMessage)
                
                if result.valid == true {
                    self.searchResult = result.activities
                    self.tableView.reloadData()
                }else{
                    self.searchResult = []
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }

    
    
    //MARK: - Button Action
    
    @IBAction func tappedAddBtn(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: " ", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Appointment", style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
            OperationQueue.main.addOperation {
                let controller:NewAppointmentsController = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentsController") as? NewAppointmentsController)!
                controller.linkParentID = self.linkParentID
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "task", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
            OperationQueue.main.addOperation {
                let controller:NewTaskController = (self.storyboard?.instantiateViewController(withIdentifier: "NewTaskController") as? NewTaskController)!
                controller.linkParentID = self.linkParentID
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Recurrence", style: .default , handler:{ (UIAlertAction)in
            print("User click Delete button")
            OperationQueue.main.addOperation {
                let controller:NewRecurrenceController = (self.storyboard?.instantiateViewController(withIdentifier: "NewRecurrenceController") as? NewRecurrenceController)!
                controller.linkParentID = self.linkParentID
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: .destructive , handler:{ (UIAlertAction)in
            print("User click Delete button")
        }))
          self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
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

extension OpenActivitiesController:URLSessionDelegate {
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
