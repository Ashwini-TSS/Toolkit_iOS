//
//  FilterListController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 21/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class FilterListController: UIViewController {

    @IBOutlet weak var tblList: UITableView!
    var status:Int = 0
    var getModel:[GetAssigneeResult] = []
    var getAppointmentModel:[GetPatternAppointmentResult] = []

    var checkMarkStatus:NSMutableArray = []
    
    var checkMarkUser:NSMutableArray = []
    var activityTypes:[String] = ["Appointment"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tblList.tableFooterView = UIView()
        if status == 0 {
            self.title = "User"
            self.getList(objName: "organization_user")
        }else if status == 2 {
            self.title = "Activity"
            for index in 0..<activityTypes.count {
                if index == 0 && includeAppointments{
                    checkMarkStatus.add("1")
                }else if index == 1 && includeTasks{
                    checkMarkStatus.add("1")
                }else{
                    checkMarkStatus.add("0")
                }
            }
        }else if status == 1 {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(menuButtonTapped))
            
            self.title = "Appointment Types"
            self.getList(objName: "appointment_type")
            
        }
    }
    
    @objc func menuButtonTapped(sender: UIBarButtonItem) {
        let controller:NewAppointmentTypeContorller = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentTypeContorller") as? NewAppointmentTypeContorller)!
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func getList(objName:String){
        let json:[String: Any] = ["ObjectName":objName,
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID,
                                  "AscendingOrder":true]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: getOrgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                if self.status == 1 {
                    let getModel = GetPatternAppointmentUsers.init(fromDictionary: jsonResponse)
                    self.getAppointmentModel = []
                    if getModel.valid {
                        self.getAppointmentModel = getModel.results
                        self.getAppointmentModel = self.getAppointmentModel.sorted(by:{ $0.name.compare($1.name) == .orderedAscending })
//                        self.getAppointmentModel = self.getAppointmentModel.sorted(by: {
//                            $0.name.compare($1.name) == .orderedAscending
//                        })
                    }
                    for index in 0..<self.getAppointmentModel.count {
                        if forAppointmentTypes.contains(self.getAppointmentModel[index].id!) {
                            self.checkMarkStatus.add("1")
                        }else{
                            self.checkMarkStatus.add("0")
                        }
                    }
                    //forAppointmentTypes
                }else{
                    self.getModel = []
                    let getModel = GetAssigneeModel.init(fromDictionary: jsonResponse)
                    if getModel.valid {
                        self.getModel = getModel.results
                        
                    }
                    for index in 0..<self.getModel.count {
                        if forUsers.contains(self.getModel[index].id!) {
                            self.checkMarkStatus.add("1")
                        }else{
                            self.checkMarkStatus.add("0")
                        }
                    }
                }
                
                self.tblList.reloadData()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }

    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedSave(_ sender: Any) {
        if status == 0 {
            let selectedUsers:NSMutableArray = []
            for index in 0..<checkMarkStatus.count {
                let markStatus:String = checkMarkStatus.object(at: index) as! String
                if markStatus == "1"{
                    selectedUsers.add(self.getModel[index].id!)
                }
            }
            forUsers = selectedUsers.mutableCopy() as! NSArray
            
        }else if status == 2 {
            for index in 0..<activityTypes.count {
                if index == 0 {
                    let markStatus:String = checkMarkStatus.object(at: 0) as! String
                    if markStatus == "0"{
                        includeAppointments = false
                    }else  if markStatus == "1"{
                        includeAppointments = true
                    }
                }
                
                if index == 1 {
                    let markStatus:String = checkMarkStatus.object(at: 1) as! String
                    if markStatus == "0"{
                        includeTasks = false
                    }else  if markStatus == "1"{
                        includeTasks = true
                    }
                }
            }
        }else if status == 1 {
            let selectedUsers:NSMutableArray = []
            for index in 0..<checkMarkStatus.count {
                let markStatus:String = checkMarkStatus.object(at: index) as! String
                if markStatus == "1"{
                    selectedUsers.add(self.getAppointmentModel[index].id!)
                }
            }
            forAppointmentTypes = selectedUsers.mutableCopy() as! NSArray
        }
        if(UserDefaults.standard.string(forKey: "condi") != nil){
            let value =  UserDefaults.standard.string(forKey: "condi")
            if(value == "calendar"){
//                NotificationCenter.default.removeObserver(self)

        let controller:CalendarController = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
                self.navigationController?.pushViewController(controller, animated: true)}
            else{
        let controller:TaskListViewController = self.storyboard?.instantiateViewController(withIdentifier: "TaskListViewController") as! TaskListViewController
        controller.task = "filter"
        UserDefaults.standard.set("filter", forKey: "FilterTask")
        let placesData = NSKeyedArchiver.archivedData(withRootObject: checkMarkUser)
        UserDefaults.standard.set(placesData, forKey: "UserFilter")
        controller.UserTaskArray = checkMarkUser
        self.navigationController?.pushViewController(controller, animated: true)
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
extension FilterListController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if status == 0 {
            return self.getModel.count-1
        }else if status == 1 {
            return getAppointmentModel.count
        }
        return activityTypes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FilterListCell = tableView.dequeueReusableCell(withIdentifier: "FilterListCell") as! FilterListCell
        
        if status == 0 {
            if let strName = self.getModel[indexPath.row].fullName {
                cell.lblTitle.text = strName
            }else{
                cell.lblTitle.text = self.getModel[indexPath.row].firstName + " " + self.getModel[indexPath.row].lastName
            }
        }else if status == 1 {
            cell.lblTitle.text = self.getAppointmentModel[indexPath.row].name
        }else if status == 2 {
            cell.lblTitle.text = activityTypes[indexPath.row]
        }
        if checkMarkStatus[indexPath.row] as! String == "0" {
            cell.btnCheckMark.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
        }else{
            cell.btnCheckMark.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }
        cell.btnCheckMark.addTarget(self, action:#selector(buttonPressed(_:)), for:.touchUpInside)
        cell.btnCheckMark.tag = indexPath.row
        
        return cell
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        if checkMarkStatus[sender.tag] as! String == "0" {
            if(self.getModel.count > 0){
            self.checkMarkUser.add(self.getModel[sender.tag].id)
            }
            checkMarkStatus.replaceObject(at: sender.tag, with: "1")
        }else{
            if(self.getModel.count > 0){
            self.checkMarkUser.remove(self.getModel[sender.tag].id)
            }
            checkMarkStatus.replaceObject(at: sender.tag, with: "0")
        }
        tblList.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if checkMarkStatus[indexPath.row] as! String == "0" {
            if(self.getModel.count > 0){
                self.checkMarkUser.add(self.getModel[indexPath.row].id)
            }
            checkMarkStatus.replaceObject(at: indexPath.row, with: "1")
        }else{
            if(self.getModel.count > 0){
                self.checkMarkUser.remove(self.getModel[indexPath.row].id)
            }
            checkMarkStatus.replaceObject(at: indexPath.row, with: "0")
        }
        tblList.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
}
extension FilterListController:URLSessionDelegate {
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
