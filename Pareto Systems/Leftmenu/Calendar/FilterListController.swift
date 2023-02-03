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
    var selectedFilterList : [String] = []
    var patternmodal : GetPatternAppointmentUsers!
    var userSelectedList : [String] = []
    var checkMarkStatus:NSMutableArray = []
    var checkMarkUser:NSMutableArray = []
    var activityTypes:[String] = ["Appointment"]
    var currentUserID : String = ""
    var isFirstTime : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getUserProfile()
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
                    self.patternmodal = GetPatternAppointmentUsers.init(fromDictionary: jsonResponse)
                    self.getAppointmentModel = []
                    if getModel.valid {
                        self.getAppointmentModel = getModel.results
    self.getAppointmentModel = self.getAppointmentModel.sorted(by:{ $0.name.compare($1.name) == .orderedAscending })
                        //                        self.getAppointmentModel = self.getAppointmentModel.sorted(by: {
                        //                            $0.name.compare($1.name) == .orderedAscending
                        //                        })
                    }
                    forAppointmentTypes = forAppointmenttest
                    self.selectedFilterList.removeAll()

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
                    
                    
                    let value =  UserDefaults.standard.string(forKey: "condi")
                    if(value == "calendar"){
                        let valstr = UserDefaults.standard.string(forKey: "filter_team")
                        let valarr = valstr?.components(separatedBy: ",") ?? []
                        forUsers = valarr as NSArray
                    }
                    else{
                        let data = UserDefaults.standard.data(forKey: "UserFilter")
                        do{
                            if(data != nil){
                            let taskarr = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as? NSArray
                            forUsers = taskarr ?? []
                            }
                        }catch
                        {
                            print("error")
                        }
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
    func getUserProfile(){
        let json: [String: Any] = ["PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: getUserURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:whoamimapping = whoamimapping.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    self.currentUserID = logModel.user.id
                    self.tblList.reloadData()
                }else {
                    NavigationHelper.showSimpleAlert(message:logModel.responseMessage)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
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
            forAppointmenttest = selectedUsers.mutableCopy() as! NSArray
        }
        if(UserDefaults.standard.string(forKey: "condi") != nil){
            let value =  UserDefaults.standard.string(forKey: "condi")
            if(value == "calendar"){
                //                NotificationCenter.default.removeObserver(self)
                
                let controller:CalendarController = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
                if(self.selectedFilterList.count > 0)
                {
                    controller.parseFilterList = self.selectedFilterList
                    globalselectedFilterList = selectedFilterList
                    UserDefaults.standard.set(true, forKey: "filterparse")
                }
                if(self.userSelectedList.count > 0)
                {
                    controller.parseUserList = self.userSelectedList
                }
                
                self.navigationController?.pushViewController(controller, animated: true)}
            else{
                let controller:TaskListViewController = self.storyboard?.instantiateViewController(withIdentifier: "TaskListViewController") as! TaskListViewController
                controller.task = "filter"
                UserDefaults.standard.set("filter", forKey: "FilterTask")
                let placesData = NSKeyedArchiver.archivedData(withRootObject: forUsers)
                UserDefaults.standard.set(placesData, forKey: "UserFilter")
                controller.UserTaskArray = forUsers.mutableCopy() as? NSMutableArray
                controller.UserString = "filterr"
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
            if status == 1
            {
                if(!selectedFilterList.contains(self.getAppointmentModel[indexPath.row].id)){
                    self.selectedFilterList.append(self.getAppointmentModel[indexPath.row].id)}
            }else if status == 0
            {
                if(!userSelectedList.contains(self.getModel[indexPath.row].id)){
                    self.userSelectedList.append(self.getModel[indexPath.row].id)}
            }
        }
        if(self.status == 0)
        {
            if(self.userSelectedList.count == 0 && self.isFirstTime == true){
                if(self.currentUserID == self.getModel[indexPath.row].id)
                {
                    self.isFirstTime = false
                    cell.btnCheckMark.setImage(UIImage.init(named:"ic_check"), for: .normal)
                    self.checkMarkUser.add(self.getModel[indexPath.row].id)
                    self.userSelectedList.append(self.getModel[indexPath.row].id)
                    checkMarkStatus.replaceObject(at: indexPath.row, with: "1")
                }
            }
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
            if status == 1
            {
                if(!selectedFilterList.contains(self.getAppointmentModel[sender.tag].id)){
                self.selectedFilterList.append(self.getAppointmentModel[sender.tag].id)}
            }else if status == 0
            {
                if(!userSelectedList.contains(self.getModel[sender.tag].id)){
                self.userSelectedList.append(self.getModel[sender.tag].id)}
            }else if(status == 2)
            {
                self.selectedFilterList.append(activityTypes[sender.tag])
            }
            checkMarkStatus.replaceObject(at: sender.tag, with: "1")
        }else{
            if(self.getModel.count > 0){
                self.checkMarkUser.remove(self.getModel[sender.tag].id)
            }
            if(status == 1)
            {
                var removeindex : Int = -1
                for (index,element) in self.selectedFilterList.enumerated()
                {
                    let strelement = element
                    if(strelement == self.getAppointmentModel[sender.tag].id)
                    {
                        removeindex = index
                    }
                }
                if(removeindex != -1)
                {
                    self.selectedFilterList.remove(at: removeindex)
                }
            }
            else if(status == 0)
            {
                var removeindex : Int = -1
                for (index,element) in self.userSelectedList.enumerated()
                {
                    let strelement = element
                    if(strelement == self.getModel[sender.tag].id)
                    {
                        removeindex = index
                    }
                }
                if(removeindex != -1)
                {
                    self.userSelectedList.remove(at: removeindex)
                }
            }
            checkMarkStatus.replaceObject(at: sender.tag, with: "0")
        }
        let value =  UserDefaults.standard.string(forKey: "condi")
        if(value == "calendar"){
        if(self.status == 1){
        if(self.selectedFilterList.count > 0)
        {
            let filterappoinment = self.selectedFilterList.joined(separator: ",")
            UserDefaults.standard.set(filterappoinment, forKey: "filter_appoin")
        }else
        {
            UserDefaults.standard.set(nil, forKey: "filter_appoin")
            }}
        else{
         if(self.userSelectedList.count > 0)
        {
            let filteruser = self.userSelectedList.joined(separator: ",")
            UserDefaults.standard.set(filteruser, forKey: "filter_team")
        }
        else
         {
            UserDefaults.standard.set(nil, forKey: "filter_team")
            }}
        }
        tblList.reloadData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if checkMarkStatus[indexPath.row] as! String == "0" {
            if(self.status == 1)
            {
                if(self.patternmodal.results.count > 0){
                    self.checkMarkUser.add(self.patternmodal.results[indexPath.row].id)
                    self.selectedFilterList.append(self.patternmodal.results[indexPath.row].id)
                }
            }
            else
            {
                if(self.getModel.count > 0){
                    self.checkMarkUser.add(self.getModel[indexPath.row].id)
                    self.userSelectedList.append(self.getModel[indexPath.row].id)
                }
            }
            checkMarkStatus.replaceObject(at: indexPath.row, with: "1")
        }else{
            if(self.status == 0)
            {
                if(self.getModel.count > 0){
                    self.checkMarkUser.remove(self.getModel[indexPath.row].id)
                    for(indx,elem) in self.userSelectedList.enumerated()
                    {
                            if(elem == self.getModel[indexPath.row].id)
                            {
                                self.userSelectedList.remove(at: indx)
                                if(self.checkMarkUser.contains(elem))
                                {
                                    self.checkMarkUser.remove(elem)
                                }
                                checkMarkStatus.replaceObject(at: indexPath.row, with: "0")
                                tblList.reloadData()
                                return
                            }
                        }
                }
            }
            else
            {
                if(self.self.patternmodal.results.count > 0){
                   // self.checkMarkUser.remove(self.patternmodal.results[indexPath.row].id)
                    for (index,element) in self.checkMarkStatus.enumerated()
                    {
                        let strelement = element as! String
                        for(indx,elem) in self.selectedFilterList.enumerated()
                        {
                            if(elem == self.patternmodal.results[indexPath.row].id)
                            {
                                self.selectedFilterList.remove(at: indx)
                                checkMarkStatus.replaceObject(at: indexPath.row, with: "0")
                                tblList.reloadData()
                               return
                            }
                        }
                    }
                }

            }
        }
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
