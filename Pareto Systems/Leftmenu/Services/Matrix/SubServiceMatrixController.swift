//
//  SubServiceMatrixController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 30/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class SubServiceMatrixController: UIViewController {

    @IBOutlet weak var tblService: UITableView!
    var responseClasses:[getClientResult] = []
    var servicesList:[GetServicesListResult] = []
    var tappedSection:NSInteger = 103420003
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblService.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getProcessList()
    }
    func getProcessList(){
        //getContactListURL
        
        let json: [String: Any] = ["ObjectName": "client_class",
                                   "AscendingOrder":true,
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let result = getClientClassModel.init(fromDictionary: jsonResponse)
                if result.valid == true {
                    self.responseClasses = result.results
                }else{
                    self.responseClasses = []
                }
                self.tblService.reloadData()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        
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
extension SubServiceMatrixController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.responseClasses.count
        }
        return servicesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:MatrixHeaderCell = tableView.dequeueReusableCell(withIdentifier: "MatrixHeaderCell") as! MatrixHeaderCell
            cell.lblTitle.text = self.responseClasses[indexPath.row].name
            return cell
        }
        let cell:MatrixFooterCell = tableView.dequeueReusableCell(withIdentifier: "MatrixFooterCell") as! MatrixFooterCell
        cell.lblTitle.text = self.servicesList[indexPath.row].subject
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 54
        }else if indexPath.section == 1 && indexPath.row == tappedSection {
            return 54
        }
        return 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tappedSection = indexPath.row
            let json = ["ObjectName":"service_matrix_template",
                    "AscendingOrder":true,
                    "ParentObjectName":"client_class",
                    "ParentId":"",
                    "PassKey":passKey,
                    "OrganizationId":currentOrgID] as [String : Any]
            APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    self.servicesList = []
                    let model = GetServicesListModel.init(fromDictionary: jsonResponse)
                    if model.valid {
                        self.servicesList = model.results
                        self.tblService.reloadData()
                    }
                    self.tblService.reloadData()
                }
            },  onFailure: { error in
                print(error.localizedDescription)
            })
        }
    }
}
extension SubServiceMatrixController:URLSessionDelegate {
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
