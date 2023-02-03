//
//  MyAccountsController.swift
//  Pareto Systems
//
//  Created by Thabresh on 30/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class MyAccountsController: UIViewController {
    
    @IBOutlet weak var tblItems: UITableView!
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var organizationList:[Organization] = []
    var tappedIndex:Int = -1
    
    
    var ArrayOrganisationID : [String] = []
    var ArrayOrganisationName : [String] = []
    
    var organizationIndex : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        organizationIndex = 0
        tblItems.tableFooterView = UIView()
        self.title = "My Accounts"
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        listByOrganization()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func listByOrganization() {
        
        let json: [String: Any] = ["PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: listByOrgURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:OrganizationMapping = OrganizationMapping.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    self.organizationList = logModel.organizations
                    if let data:String = UserDefaults.standard.object(forKey: "userOrganizationID") as? String {
                        if data.count == 0{
                            if logModel.organizations.count > 0 {
                                let getOrgID = logModel.organizations[0]
                                UserDefaults.standard.set(getOrgID.id!, forKey: "userOrganizationID")
                                UserDefaults.standard.set(getOrgID.name!, forKey: "loggedUserName")
                                currentOrgID = getOrgID.id
                                currentUserName = getOrgID.name
                            }
                        }
                    }
                    OperationQueue.main.addOperation {
                        self.GetToolkitEnabled()
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Invalid session.")
                    self.GetToolkitEnabled()
                    NavigationHelper().setRootViewController()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    
    func GetToolkitEnabled(){
        
        print(self.organizationList)
        if(self.organizationList.count > 0){
        if(self.organizationList.count-1 >= self.organizationIndex){
        let json: [String: Any] = [
                                 "OrganizationId":self.organizationList[organizationIndex].id!,
                                   "PassKey": passKey
                                  ]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL:globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/organizationStatus.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                print(json["Status"]["ToolKitEnabled"])
                if(json["Status"]["ToolKitEnabled"]).boolValue{
            self.ArrayOrganisationID.append(self.organizationList[self.organizationIndex].id!)
            self.ArrayOrganisationName.append(self.organizationList[self.organizationIndex].name!)
                }
                    self.organizationIndex = self.organizationIndex + 1
                    self.GetToolkitEnabled()
                }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
        }
        else{
            self.expandedSectionHeaderNumber = -1
            self.tblItems.reloadData()
            }
        }
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
extension MyAccountsController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if ArrayOrganisationID.count > 0 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArrayOrganisationID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell:MenuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
////        let section = sectionItems[indexPath.section] as! NSArray
//        cell.itemTitle.text = officeDropDownItems[indexPath.row] as? String
//        return cell
        
        let cell:MyAccountHeaderCell = tableView.dequeueReusableCell(withIdentifier: "MyAccountHeaderCell") as! MyAccountHeaderCell
        if currentOrgID == ArrayOrganisationID[indexPath.row]{
            cell.imgSync.isHidden = false
        }else{
            cell.imgSync.isHidden = true
        }
        if tappedIndex == indexPath.row {
            cell.imgRight.image = UIImage.init(named: "ic_down_arrow_black")
        }else{
            cell.imgRight.image = UIImage.init(named: "ic_right_black_arrow")
        }
        cell.lblOrganizationName.text = ArrayOrganisationName[indexPath.row]
        cell.tappedExpand.tag = indexPath.row
        cell.tappedExpand.addTarget(self, action:#selector(buttonPressed(_:)), for:.touchUpInside)
        
        cell.tappedUser.tag = indexPath.row
        cell.tappedUser.addTarget(self, action:#selector(forUsers(_:)), for:.touchUpInside)
        
        cell.tappedPayment.tag = indexPath.row
        cell.tappedPayment.addTarget(self, action:#selector(forPayment(_:)), for:.touchUpInside)
        
        cell.tappedSync.tag = indexPath.row
        cell.tappedSync.addTarget(self, action:#selector(forSync(_:)), for:.touchUpInside)
        
        return cell
    }
    
    @objc func buttonPressed(_ sender: AnyObject) {
        let button = sender as? UIButton
        if tappedIndex == button?.tag {
            tappedIndex = -1
        }else{
            tappedIndex = (button?.tag)!
        }
        tblItems.reloadData()
    }
    @objc func forPayment(_ sender: AnyObject) {
//        let button = sender as? UIButton
//        let eachOrg  = ArrayOrganisationID[(button?.tag)!]
//        let controller:PaymentController = self.storyboard?.instantiateViewController(withIdentifier: "PaymentController") as! PaymentController
//        controller.organizationID = eachOrg
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func forUsers(_ sender: AnyObject) {
        let button = sender as? UIButton
        let eachOrg = ArrayOrganisationID[(button?.tag)!]
        let controller:UsersController = self.storyboard?.instantiateViewController(withIdentifier: "UsersController") as! UsersController
        controller.organizationID = eachOrg
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func forSync(_ sender: AnyObject) {
        let button = sender as? UIButton
        let eachOrg = ArrayOrganisationID[(button?.tag)!]
        let controller:SyncController = self.storyboard?.instantiateViewController(withIdentifier: "SyncController") as! SyncController
        controller.selectedSyncID = eachOrg
        controller.selectedUserName = ArrayOrganisationName[(button?.tag)!]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tappedIndex == indexPath.row {
            return 199
        }
        return 54
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        let eachOrg:Organization = organizationList[indexPath.section]
//
//        if indexPath.row == 0 {
//            let controller:UsersController = self.storyboard?.instantiateViewController(withIdentifier: "UsersController") as! UsersController
//            controller.organizationID = eachOrg.id
//            self.navigationController?.pushViewController(controller, animated: true)
//        }else if indexPath.row == 1 {
//            let controller:PaymentController = self.storyboard?.instantiateViewController(withIdentifier: "PaymentController") as! PaymentController
//            controller.organizationID = eachOrg.id
//            self.navigationController?.pushViewController(controller, animated: true)
//        }else if indexPath.row == 2 {
//            let controller:SyncController = self.storyboard?.instantiateViewController(withIdentifier: "SyncController") as! SyncController
//            controller.selectedSyncID = eachOrg.id
//            controller.selectedUserName = eachOrg.name
//            self.navigationController?.pushViewController(controller, animated: true)
//        }
//    }
}
extension MyAccountsController:URLSessionDelegate {
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
