//
//  ServiceListController.swift
//  Processes
//
//  Created by Test Technologies PVT LTD on 10/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class ServiceListController:UIViewController,UITableViewDataSource,UITableViewDelegate  {

    var servicesList:[GetServicesListResult] = []
    var serviceID:String = ""
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "List of Services"

        tableView.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        getServicesList()
    }
    func getServicesList(){
        var json: [String: Any] = [:]
        
        if serviceID.count > 0 {
            self.title = "Active Services"
            json = ["ObjectName":"service_matrix_template",
                    "AscendingOrder":true,
                    "ParentObjectName":"client_class",
                    "ParentId":serviceID,
                    "PassKey":passKey,
                    "OrganizationId":currentOrgID]
        }else{

            json = ["PageOffset": 1,
                    "ResultsPerPage": 5000,
                    "ObjectName":"service_deliverable_template",
                    "AscendingOrder":true,
                    "OrderBy":"Sequence",
                    "PassKey":passKey,
                    "OrganizationId":currentOrgID]
        }
       
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                self.servicesList = []
                let model = GetServicesListModel.init(fromDictionary: jsonResponse)
                if model.valid {
                    self.servicesList = model.results
                    self.tableView.reloadData()
                }else{
                    //show error message
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
    
    @IBAction func tappedAdd(_ sender: Any) {
        let controller:CreatingNewService = self.storyboard?.instantiateViewController(withIdentifier: "CreatingNewService") as! CreatingNewService
        controller.ClientClassId = serviceID
        controller.createMethod = "service_deliverable_template"
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return servicesList.count
    }

  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StepsListCell = tableView.dequeueReusableCell(withIdentifier: "StepsListCell", for: indexPath) as! StepsListCell

        let list = servicesList[indexPath.row]
        if serviceID.count == 0 {
            cell.lblSubject.text = list.subject
            cell.lblActivityType.text = list.deliverableType
            cell.lblStartTime.text = converDateToString(dateString: list.startTime!)
        }else{
            cell.lblStartTime.text = converDateToString(dateString: list.startTime!)
            cell.lblSubject.text = list.subject!
            cell.lblActivityType.text = list.activityType
        }
     
        
        // Configure the cell...

        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = servicesList[indexPath.row]

        let controller:CreatingNewService = self.storyboard?.instantiateViewController(withIdentifier: "CreatingNewService") as! CreatingNewService
        controller.serviceList = list
        
         if serviceID.count == 0 {
            controller.createMethod = "service_deliverable_template"
         }else{
            controller.createMethod = "service_matrix_template"
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            let list = self.servicesList[indexPath.row]
            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    print(index,title)
                    if title == "Yes" {
                        self.deleteInviteUser(contactID: list.id)
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
        var objectName:String = ""
        
        if serviceID.count > 0 {
            objectName = "service_matrix_template"
        }else{
            objectName = "service_deliverable_template"
        }
        
        let parameters = [
            "ObjectName": objectName,
            "OrganizationId": currentOrgID,
            "ObjectId": contactID,
            "PassKey": passKey
            ] as [String : Any]
        
        let request = NSMutableURLRequest(url: NSURL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/delete.json")! as URL,
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
                            self.getServicesList()
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
            dateFormatter.dateFormat = "hh:mm a" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
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
extension ServiceListController:URLSessionDelegate {
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
