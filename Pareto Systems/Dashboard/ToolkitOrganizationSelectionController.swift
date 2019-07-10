//
//  ToolkitOrganizationSelectionController.swift
//  Pareto Systems
//
//  Created by Imcrinox Technologies PVT LTD on 09/10/18.
//  Copyright © 2018 VividInfotech. All rights reserved.
//

import UIKit

class ToolkitOrganizationSelectionController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblOrganization: UITableView!
    var package:PurchaseListVerticalPackage!
    var organizationsList:[Organization] = []
    var orgIndex:Int = 0
    var orgStatusCheck:NSMutableArray = []
    var planPrice:String = ""
    var VerticalPackageId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblOrganization.tableFooterView = UIView()
        
        if package != nil {
            lblTitle.text = package.name
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func tappedContinue(_ sender: Any) {
        if VerticalPackageId.count == 0 {
            NavigationHelper.showSimpleAlert(message: "You must select one Account")
            return
        }
        getDefaultPaymentCards()
    }
    
    func getDefaultPaymentCards(){
        let json: [String: Any] = ["OrganizationId": currentOrgID,
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: getDefaultPaymentCardURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:GetDefaultPaymentCardsModel = GetDefaultPaymentCardsModel.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    if logModel.paymentCard == nil {
                        OperationQueue.main.addOperation {
                            let controller:AddCardsController = self.storyboard?.instantiateViewController(withIdentifier: "AddCardsController") as! AddCardsController
                            controller.orgID = currentOrgID
                            self.navigationController?.pushViewController(controller, animated: true)
                        }
                    }else{
                        let lastDigits:String = logModel.paymentCard.last4
                        let alertTitle:String = "The Payment card, ending in *\(lastDigits), will be charged \(self.planPrice) for the new subscription."
                        self.showAlert(alertMessage: alertTitle)
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
    
    func showAlert(alertMessage:String){
        let alert = UIAlertController(title: alertMessage, message: "Clicking 'Checkout' will complete the subscription.\nIf you do not wish to continue, click 'Cancel'.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Checkout", style: .default, handler: { action in
            print("Yay! You brought your towel!")
            self.purchaseThePackage()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in

        }))
        self.present(alert, animated: true)
    }
    
    func purchaseThePackage(){
        let json: [String: Any] = ["OrganizationId": currentOrgID,
                                   "PassKey": passKey,
                                   "VerticalPackageId":package.id!,
                                   "Subscribe":true,
                                   "Frequency":"Monthly"]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: purchasePackageURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            
            DispatchQueue.main.async {
                print(json)
               
                let model:PurchaseToolkitModel = PurchaseToolkitModel.init(fromDictionary: jsonResponse)
                if model.valid {
                    NavigationHelper.showSimpleAlert(message: "Your subscription has been setup successfully.")
                    NavigationHelper().createMenuView()
                }else{
                    NavigationHelper.showSimpleAlert(message: model.responseMessage)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    @IBAction func tappedCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        orgStatusCheck = []
        self.orgIndex = 0

        listOrganizations()
    }
    
    func listOrganizations(){
        let json: [String: Any] = ["OrderBy": "Name",
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: listByOrgURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            
            DispatchQueue.main.async {
                print(json)
                let logModel:OrganizationMapping = OrganizationMapping.init(fromDictionary: jsonResponse)
                self.orgIndex = 0
                self.organizationsList = logModel.organizations
                
                self.getOrganizationStatus()
                OperationQueue.main.addOperation {
                    self.tblOrganization.reloadData()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    func getOrganizationStatus(){
        if organizationsList.count > orgIndex {
            let json: [String: Any] = ["OrganizationId": organizationsList[orgIndex].id,
                                       "PassKey": passKey]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL: getOrganizationStatusInfo, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                self.orgIndex = self.orgIndex + 1

                self.getOrganizationStatus()
                DispatchQueue.main.async {
                    print(json)
                    let logModel:ToolkitOrgStatus = ToolkitOrgStatus.init(fromDictionary: jsonResponse)
                    if logModel.valid {
                        if logModel.organizationStatus.billingEnabled == true {
                            self.orgStatusCheck.add("1")
                        }else{
                            self.orgStatusCheck.add("0")
                        }
                    }
                }
            },  onFailure: { error in
                print(error.localizedDescription)
            })
            
        }else{
            OperationQueue.main.addOperation {
                self.tblOrganization.reloadData()
            }
        }
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
extension ToolkitOrganizationSelectionController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizationsList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ToolkitOrgCell = tableView.dequeueReusableCell(withIdentifier: "ToolkitOrgCell") as! ToolkitOrgCell
        cell.lblOrganizationTitle.text = organizationsList[indexPath.row].name
        if orgStatusCheck.count > 0 {
            if orgStatusCheck[indexPath.row] as! String == "0" {
                cell.btnCheckbox.setImage(UIImage.init(named:"ic_close_checkbox"), for: .normal)
            }else if orgStatusCheck[indexPath.row] as! String == "2" {
                cell.btnCheckbox.setImage(UIImage.init(named:"ic_check"), for: .normal)
            }else{
                cell.btnCheckbox.setImage(UIImage.init(named:"ic_uncheck"), for: .normal)
            }
        }
        cell.btnCheckbox.tag = indexPath.row
        cell.btnCheckbox.addTarget(self, action: #selector(buyAction), for: .touchUpInside)
        return cell
    }
    @objc func buyAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        print(btnsendtag.tag)
        
        if btnsendtag.imageView?.image == UIImage.init(named:"ic_uncheck") {
            resetButtons()
            VerticalPackageId = organizationsList[btnsendtag.tag].id
            orgStatusCheck.replaceObject(at: btnsendtag.tag, with: "2")
            sender.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }else if btnsendtag.imageView?.image == UIImage.init(named:"ic_check") {
            resetButtons()
        }
        
    }
    func resetButtons(){
        for inex in 0..<orgStatusCheck.count {
           if orgStatusCheck[inex] as! String == "2" {
             VerticalPackageId = ""
             orgStatusCheck.replaceObject(at: inex, with: "1")
           }
        }
        self.tblOrganization.reloadData()
    }
}
extension ToolkitOrganizationSelectionController:URLSessionDelegate {
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
