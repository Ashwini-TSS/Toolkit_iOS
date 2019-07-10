//
//  ServiceMatrixController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 30/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ServiceMatrixController: UITableViewController {
    
    var matrixResult:[ServiceMatrixResult] = []
     var responseClasses:[getClientResult] = []
    var servicesList:[GetServicesListResult] = []
    var tappedSection:NSInteger = 103420003
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Service Matrix"
        tableView.tableFooterView = UIView()
          // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func tappedAdd(_ sender: Any) {
        let controller:CreatingNewService = self.storyboard?.instantiateViewController(withIdentifier: "CreatingNewService") as! CreatingNewService
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        getProcessList()
    }
    func getProcessList(){
        //getContactListURL
        
        let json: [String: Any] = ["ObjectName": "service_deliverable_template",
                                   "AscendingOrder":true,
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            self.getClientClass()
            DispatchQueue.main.async {
                print(json)
                let modeel = ServiceMatrixModel.init(fromDictionary: jsonResponse)
                if modeel.valid {
                    self.matrixResult = modeel.results
                }
                self.tableView.reloadData()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        
    }
    
    func getClientClass(){
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
                self.tableView.reloadData()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let controller:SubServiceMatrixController = self.storyboard?.instantiateViewController(withIdentifier: "SubServiceMatrixController") as! SubServiceMatrixController
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if responseClasses.count > 0 {
            return matrixResult.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if section == 0 {
//            return matrixResult.count
//         }
        
        return responseClasses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Raleway-Bold", size: 17.0)!
//        if indexPath.section == 0{
//            let getResult:ServiceMatrixResult = matrixResult[indexPath.row]
//            cell.textLabel?.text = getResult.subject!
//        }else{
//            let getResult:getClientResult = responseClasses[indexPath.row]
//            cell.textLabel?.text = getResult.name!
//        }
        let getResult:getClientResult = responseClasses[indexPath.row]
        cell.textLabel?.text = getResult.name!
 
        return cell
    }
  
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let backView = UIView()
        backView.frame = CGRect(x: 0.0, y: 0.0, width: tableView.frame.size.width, height: 58.0)
        backView.backgroundColor = UIColor.PSNavigaitonController()
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 10.0, y: 10.0, width: tableView.frame.size.width - 50, height: 38.0)
        titleLabel.text = matrixResult[section].subject
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: "Raleway-Bold", size: 17.0)!
        backView.addSubview(titleLabel)
        
        let tapBtn = UIButton()
        tapBtn.frame = CGRect(x: 0.0, y: 0.0, width: tableView.frame.size.width, height: 58.0)
        tapBtn.backgroundColor = UIColor.clear
        tapBtn.setTitle("", for: .normal)
        tapBtn.addTarget(self, action: #selector(pressButton(_:)), for: .touchUpInside)
        tapBtn.tag = section
        backView.addSubview(tapBtn)
        
        let arrowImg = UIImageView()
        arrowImg.frame = CGRect(x: tableView.frame.size.width - 40, y: 10.0, width: 25.0, height: 25.0)

        if section == tappedSection {
            arrowImg.image = UIImage.init(named:"ic_down_arrow")
        }else{
            arrowImg.image = UIImage.init(named:"ic_right_black_arrow")
        }
        backView.addSubview(arrowImg)
        
        
        return backView
    }
    @objc func pressButton(_ button: UIButton) {
        print("Button with tag: \(button.tag) clicked!")
        if tappedSection == button.tag {
            tappedSection = 103420003
        }else{
            tappedSection = button.tag
        }
        tableView.reloadData()
        
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 58.0
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tappedSection == indexPath.section {
            return 50.0
        }
        return 0
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
extension ServiceMatrixController:URLSessionDelegate {
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
