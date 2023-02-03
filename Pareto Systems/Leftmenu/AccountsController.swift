//
//  AccountsController.swift
//  Pareto Systems
//
//  Created by Thabresh on 14/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class AccountsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var contactList:[AccountsListResult] = []
    var userOrgID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItem()
       tableView.tableFooterView = UIView() 
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        // listByOrganization()
        
        self.userOrgID = currentOrgID
        self.getContactListAPI(orgID: self.userOrgID)
    }
    func listByOrganization() {
        
        let json: [String: Any] = ["OrderBy": "Name",
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: listByOrgURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:OrganizationMapping = OrganizationMapping.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    if logModel.organizations.count > 0 {
                        let getOrgID = logModel.organizations[0]
                        print(getOrgID.id)
                        
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Invalid session.")
                    NavigationHelper().setRootViewController()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    
    
    
    
    func getContactListAPI(orgID:String){
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
//            MBProgressHUD.showAdded(to: self.view, animated: true)

        }
        let headers = [
            "Content-Type": "application/json"
        ]
        let parameters = [
            "OrderBy": "",
            "ParentId": "",
            "ResultsPerPage": 3000,
            "OrganizationId": orgID,
            "PassKey": passKey,
            "ParentObjectName": "",
            "PageOffset": 1,
            "ObjectName": "company"
            ] as [String : Any]
        
        let request = NSMutableURLRequest(url: NSURL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            OperationQueue.main.addOperation {
                SVProgressHUD.dismiss()
//                MBProgressHUD.hide(for: self.view, animated: true)

            }
            guard let data = data, error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObj)
                
                guard let _:Dictionary = jsonObj as? [String:AnyObject] else{
                    return
                }
                let result = try JSON(data: data)
                print(result)
                
                let contactModel = AccountsListModel.init(fromDictionary: jsonObj as! NSDictionary)
                print(contactModel.responseMessage)
                
                self.contactList = contactModel.results
                
                self.tableView.reloadData()
                //                onSuccess(jsonObj as! NSDictionary, result)
            }catch {
                print(error.localizedDescription)
            }
        })
        
        dataTask.resume()
        //
        //        let json: [String: Any] = [
        //            "OrderBy": "",
        //            "ParentId": "",
        //            "ResultsPerPage": 50,
        //            "OrganizationId": "c27304fa-3ce6-40f7-90d4-f51e1723a882",
        //            "PassKey": passKey,
        //            "ParentObjectName": "",
        //            "PageOffset": 1,
        //            "ObjectName": "contact"
        //        ]
        //        print(json)
        //        APIManager.sharedInstance.postRequestCall(postURL: getContactListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
        //            DispatchQueue.main.async {
        //                print(json)
        //            }
        //        },  onFailure: { error in
        //            print(error.localizedDescription)
        //            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        //
        //        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension AccountsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if contactList.count > 0 {
            tableView.backgroundView = nil
            return 1
        } else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "Retrieving data.\nPlease wait."
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "Raleway-Regular", size: 17.0)!
            messageLabel.sizeToFit()
            tableView.backgroundView = messageLabel;
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:contactsCell = tableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath) as! contactsCell
        let getContact = contactList[indexPath.row]
        cell.lblFirstname.text = getContact.name
        cell.lblLastname.text = getContact.eMailAddress1
        cell.lblCreatedBy.text = getContact.telephone1
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let getContact = contactList[indexPath.row]
        let controller:AccountDeatilController = self.storyboard?.instantiateViewController(withIdentifier: "AccountDeatilController") as! AccountDeatilController
        controller.contactList = getContact
        controller.orgID = userOrgID
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension AccountsController:URLSessionDelegate {
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
