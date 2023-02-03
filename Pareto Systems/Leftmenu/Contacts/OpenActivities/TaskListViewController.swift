//



//  TaskListViewController.swift
//  Blue Square
//
//  Created by mac on 14/11/18.
//  Copyright © 2018 VividInfotech. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController{
    
    @IBOutlet weak var PickerView: UIView!
    @IBOutlet weak var SelectorPicker: UIPickerView!
    @IBOutlet weak var HeaderView: UIView!
    @IBOutlet weak var SelectorView: UIView!
    @IBOutlet weak var btnAddTask: UIBarButtonItem!
    @IBOutlet weak var BtnUserFilter: UIButton!
    @IBOutlet weak var TblviewTasklist: UITableView!
    @IBOutlet weak var Selectorbtn: UIButton!
    @IBOutlet weak var Selectorlbl: UILabel!
    @IBOutlet weak var LblData: UILabel!
    
    var Condition : String!
    var task : String?
    var ConditionModel : String!
    var taskmodelobj : Taskmodel?
    var taskpickerobj : ResultModel?
    var SelectorTaskArray : NSMutableArray = []
    var UserTaskArray : NSMutableArray!
    var UserString : String!
    
    
    var StatusCondition : String!
    var SelectedIndex : String!
    
    
    var ArraySubject : NSMutableArray = []
    var ArrayDueToday : NSMutableArray = []
    var Arraypriority : NSMutableArray = []
    var ArrayStatus : NSMutableArray = []
    
    var ArrayRecurringActivityId : NSMutableArray = []
    var ArrayCreatedOn : NSMutableArray = []
    var ArrayModifiedBy : NSMutableArray = []
    var ArrayModifiedOn : NSMutableArray = []
    
    var ArrayAdvocateProcessIndex : NSMutableArray = []
    var ArrayAppliedAdvocateProcessId : NSMutableArray = []
    var ArrayPercentComplete : NSMutableArray = []
    var ArrayDescription : NSMutableArray = []
    
    var ArrayId : NSMutableArray = []
    var ArrayRollOver : NSMutableArray = []
    var ArrayLocation : NSMutableArray = []
    var ArrayCreatedBy : NSMutableArray = []
    
    var ArrayRecurrenceIndex : NSMutableArray = []
    var ArrayStartTime : NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItem()
        if(UserString != "filterr"){
        UserDefaults.standard.set("Due Today", forKey: "typetask")
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UserTaskArray = []
        SetUIComponents()
        Selectorlbl.text = "Due Today"
        SelectedIndex = "Due Today"
        PickerView.isHidden = true
        StatusCondition = "Due Today"
        Condition = "close"
        SelectorTaskArray = ["Due Today","Due & Upcoming", "All Open","All Completed","All"]
        let tasks : String = UserDefaults.standard.object(forKey: "FilterTask") as? String ?? ""
        if(tasks == "filter"){
            let placesData = UserDefaults.standard.object(forKey: "UserFilter") as? NSData
            if let placesData = placesData {
                UserTaskArray = NSKeyedUnarchiver.unarchiveObject(with: placesData as Data) as? NSMutableArray
                print(UserTaskArray)
            }
            let name = UserDefaults.standard.string(forKey: "typetask")
            Selectorlbl.text = name
            SelectedIndex = name
            ServiceResponseUserFilter()
        }
       else {
            let name = UserDefaults.standard.string(forKey: "typetask")
            if(name == "Due & Upcoming"){
                Selectorlbl.text = "Due & Upcoming"
                SelectedIndex = "Due & Upcoming"
                self.changeValuesByPickerSelectionCurrentUpcoming()
            }
            else if(name == "All Open"){
                Selectorlbl.text = "All Open"
                SelectedIndex = "All Open"
                self.changeValuesByPickerSelectionOpen()
            }
            else if(name == "All"){
                Selectorlbl.text = "All"
                SelectedIndex = "All"
                self.GetTaskList()
            }
            else if(name == "All Completed"){
                Selectorlbl.text = "All Completed"
                SelectedIndex = "All Completed"
                self.changeValuesByPickerSelectionCompleted()
            }
            else{
                Selectorlbl.text = "Due Today"
                SelectedIndex = "Due Today"
                self.changeValuesByPickerSelectionDueToday()
            }
        }
    }
    
    func SetUIComponents(){
        
        //HeaderView UIComponents
        HeaderView.layer.borderColor = UIColor.black.cgColor
        HeaderView.layer.borderWidth = 0.8
        
        //SelectorView UIComponents
        SelectorView.layer.borderColor = UIColor.black.cgColor
        SelectorView.layer.borderWidth = 0.8
        
        //UserFilter UIComponents
        BtnUserFilter.layer.borderWidth = 0.5
        BtnUserFilter.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func GetTaskList(){
        
        let json: [String: Any] = [
            "IncludeAppointments": false,
            "IncludeAttendees": false,
            "IncludeTasks": true,
            "Invert": false,
            "ResultsPerPage":1000,
            "PageOffset":1,
            "ReturnTotal":false,
            "PassKey":passKey,
            "OrganizationId":currentOrgID
        ]
        UserDefaults.standard.set(true, forKey: "tasklist")
        print(json)
        let url:String = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.calendar.VCCalendarEndpoint/getIncompleteActivities.json"
        APIManager.sharedInstance.postRequestCall(postURL: url, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let udata = UserDefaults.standard.value(forKey: "Taskdata") as? Data
                if((udata) != nil)
                {
                    self.ConditionModel = "Task"
                    self.Arraypriority = []
                    self.ArraySubject = []
                    self.ArrayDueToday = []
                    self.ArrayStatus = []
                    
                    self.ArrayRecurringActivityId = []
                    self.ArrayCreatedOn = []
                    self.ArrayModifiedBy = []
                    self.ArrayModifiedOn = []
                    
                    self.ArrayAdvocateProcessIndex = []
                    self.ArrayAppliedAdvocateProcessId = []
                    self.ArrayPercentComplete  = []
                    self.ArrayDescription  = []
                    
                    self.ArrayId  = []
                    self.ArrayRollOver  = []
                    self.ArrayLocation  = []
                    self.ArrayCreatedBy  = []
                    
                    self.ArrayRecurrenceIndex = []
                    self.ArrayStartTime = []
                    
                    
                    let ActivityArrayres = json["Activities"]
                    print(ActivityArrayres)
                    for act in ActivityArrayres
                    {
                        let dictoval = act.1
                        for(key,value) in dictoval
                        {
                            if(key == "Activity")
                            {
                                self.ArraySubject.add(value["Subject"].string as Any)
                                self.ArrayDueToday.add(value["DueTime"].string as Any)
                                self.Arraypriority.add(value["Priority"].string as Any)
                                self.ArrayStatus.add(value["Status"].string as Any)
                                
                                self.ArrayRecurringActivityId.add(value["RecurringActivityId"].string as Any)
                                self.ArrayCreatedOn.add(value["CreatedOn"].string as Any)
                                self.ArrayModifiedBy.add(value["ModifiedBy"].string as Any)
                                self.ArrayModifiedOn.add(value["ModifiedOn"].string as Any)
                                
                                self.ArrayAdvocateProcessIndex.add(value["AdvocateProcessIndex"].string as Any)
                                self.ArrayAppliedAdvocateProcessId.add(value["AppliedAdvocateProcessId"].string as Any)
                                self.ArrayPercentComplete.add("\(value["PercentComplete"].number ?? 0)")
                                self.ArrayDescription.add(value["Description"].string as Any)
                                
                                
                                self.ArrayStartTime.add(value["StartTime"].string as Any)
                                self.ArrayId.add(value["Id"].string as Any)
                                self.ArrayRollOver.add(value["RollOver"].string as Any)
                                self.ArrayLocation.add(value["Location"].string as Any)
                                
                                self.ArrayCreatedBy.add(value["CreatedBy"].string as Any)
                                self.ArrayRecurrenceIndex.add(value["RecurrenceIndex"].string as Any)
                                
                            }
                        }
                        
                    }
                    self.TblviewTasklist.reloadData()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    // MARK: Button Actions
    @IBAction func TappedSelectorBtn(_ sender: Any){
        tappedcondition()
    }
    
    @IBAction func TappedSelection(_ sender: Any) {
        tappedcondition()
    }
    func tappedcondition(){
        if(Condition == "close"){
            PickerView.isHidden = false
            Condition = "Expand"
            Selectorbtn.setImage(UIImage(named:"Uplist"), for:UIControlState.normal)
        }
        else {
            Condition = "close"
            PickerView.isHidden = true
            self.view.endEditing(true)
            Selectorbtn.setImage(UIImage(named:"DownList"), for:UIControlState.normal)
        }
    }
    
    @IBAction func TappedUserFilter(_ sender: Any) {
        let controller:FilterListController = self.storyboard?.instantiateViewController(withIdentifier: "FilterListController") as! FilterListController
        UserDefaults.standard.set("task", forKey: "condi")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func TappedAddTask(_ sender: Any) {
        let alertController = UIAlertController(title: "Choose Option", message: "", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Task", style: .default) { (action:UIAlertAction!) in
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewtaskVC") as! UpdatenewtaskVC
            self.navigationController?.pushViewController(controller, animated: true)
        }
        alertController.addAction(OKAction)
        let cancelAction = UIAlertAction(title: "Recurrence", style: .default) { (action:UIAlertAction!) in
            let controller1:CreateRecurrencePattern = (self.storyboard?.instantiateViewController(withIdentifier: "CreateRecurrencePattern") as? CreateRecurrencePattern)!
            self.navigationController?.pushViewController(controller1, animated: true)
        }
        alertController.addAction(cancelAction)
        let doneAction = UIAlertAction(title: "Cancel", style: .destructive) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    
    func ServiceResponseUserFilter(){
        print(UserTaskArray)
        let json: [String: Any] = ["ForUsers":UserTaskArray,
                                   "ResultsPerPage":5000,
                                   "IncludeAppointments":false,
                                   "IncludeAttendees": true,
                                   "IncludeTasks":true,
                                   "Invert":false,
                                   "OrganizationId":currentOrgID,
                                   "PageOffset":1,
                                   "ReturnTotal":false,
                                   "PassKey":passKey,
                                   ]
        UserDefaults.standard.set(true, forKey: "pickerdata")
        print(json)
        let url:String = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.calendar.VCCalendarEndpoint/getIncompleteActivities.json"
        APIManager.sharedInstance.postRequestCall(postURL: url, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let picdata = UserDefaults.standard.value(forKey: "pickervalue") as? Data
                if((picdata) != nil)
                {
                    self.Arraypriority = []
                    self.ArraySubject = []
                    self.ArrayDueToday = []
                    self.ArrayStatus = []
                    
                    self.ArrayRecurringActivityId = []
                    self.ArrayCreatedOn = []
                    self.ArrayModifiedBy = []
                    self.ArrayModifiedOn = []
                    
                    self.ArrayAdvocateProcessIndex = []
                    self.ArrayAppliedAdvocateProcessId = []
                    self.ArrayPercentComplete  = []
                    self.ArrayDescription  = []
                    
                    self.ArrayId  = []
                    self.ArrayRollOver  = []
                    self.ArrayLocation  = []
                    self.ArrayCreatedBy  = []
                    
                    self.ArrayRecurrenceIndex = []
                    self.ArrayStartTime = []
                    
                    let valid = json["Valid"].boolValue
                    
                    let response = json["ResponseMessage"].stringValue
                    
                    if(valid){
                    let ActivityArrayres = json["Activities"]
                    print(ActivityArrayres)
                    for act in ActivityArrayres
                    {
                        let dictoval = act.1
                        for(key,value) in dictoval
                        {
                            if(key == "Activity")
                            {
                                
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                formatter.locale = Locale(identifier: "en_US_POSIX")
                                let today = formatter.string(from: Date()) // string purpose I add here
                                
                                
                                let due = value["DueTime"].stringValue
                                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                                formatter.locale = Locale(identifier: "en_US_POSIX")
                                let yourDate = formatter.date(from: due)
                                let formatter1 = DateFormatter()
                                formatter1.dateFormat = "yyyy-MM-dd"
                                formatter1.locale = Locale(identifier: "en_US_POSIX")
                                let finaldate = formatter1.string(from: yourDate!)
                                print(finaldate)
                                
                                if(self.SelectedIndex == "Due Today"){
                                if(finaldate > today){
                                    //                                    print("fsdhkdjs")
                                }
                                else {
                                self.ArraySubject.add(value["Subject"].string as Any)
                                self.ArrayDueToday.add(value["DueTime"].string as Any)
                                self.Arraypriority.add(value["Priority"].string as Any)
                                self.ArrayStatus.add(value["Status"].string as Any)
                                
                                self.ArrayRecurringActivityId.add(value["RecurringActivityId"].string as Any)
                                self.ArrayCreatedOn.add(value["CreatedOn"].string as Any)
                                self.ArrayModifiedBy.add(value["ModifiedBy"].string as Any)
                                self.ArrayModifiedOn.add(value["ModifiedOn"].string as Any)
                                
                                self.ArrayAdvocateProcessIndex.add(value["AdvocateProcessIndex"].string as Any)
                                self.ArrayAppliedAdvocateProcessId.add(value["AppliedAdvocateProcessId"].string as Any)
                                self.ArrayPercentComplete.add("\(value["PercentComplete"].number ?? 0)")
                                self.ArrayDescription.add(value["Description"].string as Any)
                                
                                
                                self.ArrayStartTime.add(value["StartTime"].string as Any)
                                self.ArrayId.add(value["Id"].string as Any)
                                self.ArrayRollOver.add(value["RollOver"].string as Any)
                                self.ArrayLocation.add(value["Location"].string as Any)
                                
                                self.ArrayCreatedBy.add(value["CreatedBy"].string as Any)
                                self.ArrayRecurrenceIndex.add(value["RecurrenceIndex"].string as Any)
                                }
                                }
                                else{
                                    self.ArraySubject.add(value["Subject"].string as Any)
                                    self.ArrayDueToday.add(value["DueTime"].string as Any)
                                    self.Arraypriority.add(value["Priority"].string as Any)
                                    self.ArrayStatus.add(value["Status"].string as Any)
                                    
                                    self.ArrayRecurringActivityId.add(value["RecurringActivityId"].string as Any)
                                    self.ArrayCreatedOn.add(value["CreatedOn"].string as Any)
                                    self.ArrayModifiedBy.add(value["ModifiedBy"].string as Any)
                                    self.ArrayModifiedOn.add(value["ModifiedOn"].string as Any)
                                    
                                    self.ArrayAdvocateProcessIndex.add(value["AdvocateProcessIndex"].string as Any)
                                    self.ArrayAppliedAdvocateProcessId.add(value["AppliedAdvocateProcessId"].string as Any)
                                    self.ArrayPercentComplete.add("\(value["PercentComplete"].number ?? 0)")
                                    self.ArrayDescription.add(value["Description"].string as Any)
                                    
                                    
                                    self.ArrayStartTime.add(value["StartTime"].string as Any)
                                    self.ArrayId.add(value["Id"].string as Any)
                                    self.ArrayRollOver.add(value["RollOver"].string as Any)
                                    self.ArrayLocation.add(value["Location"].string as Any)
                                    
                                    self.ArrayCreatedBy.add(value["CreatedBy"].string as Any)
                                    self.ArrayRecurrenceIndex.add(value["RecurrenceIndex"].string as Any)
                                }
                            }
                        }
                        
                    }
                }
                self.TblviewTasklist.reloadData()
                }
            }
        },onFailure: { error in
            print(error.localizedDescription)
        })
        
    }
    
    
}

extension TaskListViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LblData.isHidden = true
        if(ArraySubject.count > 0){
            return ArraySubject.count
        }
        else{
            LblData.isHidden = false
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TaskListCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskListCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        let date1 = ArrayDueToday[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let responsedate = dateFormatter.date(from: date1 as! String)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let resudate = dateFormatter.string(from: responsedate!)
        let date = dateFormatter.date(from: resudate)
        
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "YYYY-MM-dd"
        let resudate1 = dateFormatter1.string(from: responsedate!)
        let currentdate = Date()
        let current = dateFormatter1.string(from: currentdate)
        
        if current == resudate1
        {
            if(Selectorlbl.text == "Due Today" || Selectorlbl.text == "Due & Upcoming"){
             cell.backgroundColor = UIColor(red: 241.0/255.0, green: 229/255.0, blue: 140.0/255.0, alpha: 1.0)
            }
            else{
                cell.backgroundColor = UIColor.white
            }
            //cell.backgroundColor = UIColor.yellow
        }
        else if currentdate > responsedate!
        {
            let status:String = ArrayStatus[indexPath.row] as! String
            if(SelectedIndex == "Due Today" || SelectedIndex == "Due & Upcoming" ){
                if(status == "InProgress"){
                    cell.backgroundColor = UIColor(red: 255/255.0, green: 127.0/255.0, blue: 135.0/255.0, alpha: 1.0)
                }
                else if(status == "All Completed"){
                    cell.backgroundColor = UIColor.lightGray
                }
                else{
                    cell.backgroundColor = UIColor(red: 255/255.0, green: 127.0/255.0, blue: 135.0/255.0, alpha: 1.0)
                }
            }
            else{
                cell.backgroundColor = UIColor.white
            }
            
        }
        else if currentdate < responsedate!
        {
            let status:String = ArrayStatus[indexPath.row] as! String
            cell.backgroundColor = UIColor.white
        }
        cell.LblDuedate!.text = dateFormatter1.string(from: date!)
        cell.LblPriority!.text = Arraypriority[indexPath.row] as! String
        cell.LblSubject!.text = ArraySubject[indexPath.row] as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewtaskVC") as! UpdatenewtaskVC
        
        controller.Editvalue = "edit"
        
        if ArrayRecurringActivityId[indexPath.row] is String {
            controller.RecurringActivityId = ArrayRecurringActivityId[indexPath.row] as! String
        }
        if ArrayAppliedAdvocateProcessId[indexPath.row] is String {
            controller.AppliedAdvocateProcessId = ArrayAppliedAdvocateProcessId[indexPath.row] as! String
        }
        if ArrayCreatedOn[indexPath.row] is  String {
            controller.CreatedOn = ArrayCreatedOn[indexPath.row] as! String
        }
        if ArrayModifiedBy[indexPath.row] is String{
            controller.ModifiedBy = ArrayModifiedBy[indexPath.row] as! String
        }
        if ArrayModifiedOn[indexPath.row] is String{
            controller.ModifiedOn = ArrayModifiedOn[indexPath.row] as! String
        }
        if ArrayAdvocateProcessIndex[indexPath.row] is String {
            controller.AdvocateProcessIndex = ArrayAdvocateProcessIndex[indexPath.row] as! String
        }
        if Arraypriority[indexPath.row] is String {
            controller.PriorityValue = Arraypriority[indexPath.row] as! String
        }
        
        if ArrayPercentComplete[indexPath.row] is String {
            controller.PercentComplete = "\(ArrayPercentComplete[indexPath.row] as! String)"
            print(controller.PercentComplete)
        }
        
        if ArrayDescription[indexPath.row] is String {
            controller.DescriptionValue = ArrayDescription[indexPath.row] as! String
        }
        if ArrayStartTime[indexPath.row] is String {
            controller.StartTime = ArrayStartTime[indexPath.row] as! String
        }
        
        if ArrayId[indexPath.row] is String {
            controller.Id = ArrayId[indexPath.row] as! String
        }
        
        if ArrayDueToday[indexPath.row] is String {
            controller.DueTime = ArrayDueToday[indexPath.row] as! String
        }
        
        if ArrayStatus[indexPath.row] is String {
            controller.StatusValue = ArrayStatus[indexPath.row] as! String
        }
        if ArrayRollOver[indexPath.row] is String {
            controller.RollOver = ArrayRollOver[indexPath.row] as! String
        }
        
        if ArrayLocation[indexPath.row] is String {
            controller.LocationValue = ArrayLocation[indexPath.row] as! String
        }
        if ArrayCreatedBy[indexPath.row] is String {
            controller.CreatedBy = ArrayCreatedBy[indexPath.row] as! String
        }
        if ArrayRecurrenceIndex[indexPath.row] is String {
            controller.RecurrenceIndex = ArrayRecurrenceIndex[indexPath.row] as! String
        }
        if ArraySubject[indexPath.row] is String {
            controller.SubjectValue = ArraySubject[indexPath.row] as! String
        }
        
        controller.IsEdit = true
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension TaskListViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SelectorTaskArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SelectorTaskArray[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        Selectorlbl.text = SelectorTaskArray[row] as? String
        PickerView.isHidden = true
        self.view.endEditing(true)
        Condition = "close"
        Selectorbtn.setImage(UIImage(named:"DownList"), for:UIControlState.normal)
        SelectedIndex = SelectorTaskArray[row] as? String ?? ""
        UserDefaults.standard.set(SelectorTaskArray[row], forKey: "typetask")
        if(SelectedIndex == "Due & Upcoming"){
            self.changeValuesByPickerSelectionCurrentUpcoming()
        }
        else if(SelectedIndex == "All Open"){
            self.changeValuesByPickerSelectionOpen()
        }
        else if(SelectedIndex == "All"){
            self.GetTaskList()
        }
        else if(SelectedIndex == "All Completed"){
            self.changeValuesByPickerSelectionCompleted()
        }
        else{
            self.changeValuesByPickerSelectionDueToday()
        }
        
    }
    
    func changeValuesByPickerSelectionOpen()
    {
        let json: [String: Any] = [
            "ResultsPerPage":1000,
            "IncludeAppointments":false,
            "IncludeAttendees":true,
            "IncludeTasks":true,
            "Invert":false,
            "OrganizationId":currentOrgID,
            "PageOffset":1,
            "ReturnTotal":true,
            "ForUsers":UserTaskArray,
            "PassKey":passKey,
            ]
        UserDefaults.standard.set(true, forKey: "pickerdata")
        print(json)
        let url:String = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.calendar.VCCalendarEndpoint/getIncompleteActivities.json"
        APIManager.sharedInstance.postRequestCall(postURL: url, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                let picdata = UserDefaults.standard.value(forKey: "pickervalue") as? Data
                if((picdata) != nil)
                {
                    self.Arraypriority = []
                    self.ArraySubject = []
                    self.ArrayDueToday = []
                    self.ArrayStatus = []
                    
                    self.ArrayRecurringActivityId = []
                    self.ArrayCreatedOn = []
                    self.ArrayModifiedBy = []
                    self.ArrayModifiedOn = []
                    
                    self.ArrayAdvocateProcessIndex = []
                    self.ArrayAppliedAdvocateProcessId = []
                    self.ArrayPercentComplete  = []
                    self.ArrayDescription  = []
                    
                    self.ArrayId  = []
                    self.ArrayRollOver  = []
                    self.ArrayLocation  = []
                    self.ArrayCreatedBy  = []
                    
                    self.ArrayRecurrenceIndex = []
                    self.ArrayStartTime = []
                    
                    
                    
                    let ActivityArrayres = json["Activities"]
                    print(ActivityArrayres)
                    for act in ActivityArrayres
                    {
                        let dictoval = act.1
                        for(key,value) in dictoval
                        {
                            if(key == "Activity")
                            {
                                
                                self.ArraySubject.add(value["Subject"].string as Any)
                                self.ArrayDueToday.add(value["DueTime"].string as Any)
                                self.Arraypriority.add(value["Priority"].string as Any)
                                self.ArrayStatus.add(value["Status"].string as Any)
                                
                                self.ArrayRecurringActivityId.add(value["RecurringActivityId"].string as Any)
                                self.ArrayCreatedOn.add(value["CreatedOn"].string as Any)
                                self.ArrayModifiedBy.add(value["ModifiedBy"].string as Any)
                                self.ArrayModifiedOn.add(value["ModifiedOn"].string as Any)
                                
                                self.ArrayAdvocateProcessIndex.add(value["AdvocateProcessIndex"].string as Any)
                                self.ArrayAppliedAdvocateProcessId.add(value["AppliedAdvocateProcessId"].string as Any)
                                self.ArrayPercentComplete.add("\(value["PercentComplete"].number ?? 0)")
                                self.ArrayDescription.add(value["Description"].string as Any)
                                
                                
                                self.ArrayStartTime.add(value["StartTime"].string as Any)
                                self.ArrayId.add(value["Id"].string as Any)
                                self.ArrayRollOver.add(value["RollOver"].string as Any)
                                self.ArrayLocation.add(value["Location"].string as Any)
                                
                                self.ArrayCreatedBy.add(value["CreatedBy"].string as Any)
                                self.ArrayRecurrenceIndex.add(value["RecurrenceIndex"].string as Any)
                                
                                
                            }
                        }
                        
                    }
                    self.TblviewTasklist.reloadData()
                    
                }
            }
            
        },onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    func loginUser(){
        var userEmail : String!
        var userPwd : String!
        if let data = UserDefaults.standard.object(forKey: "userEmail") as? String{
            userEmail = data
        }
        if let data = UserDefaults.standard.object(forKey: "userPassword") as? String{
            userPwd = data
        }
        let json: [String: Any] = ["UserName": userEmail,
                                   "Password": userPwd]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: loginURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                let logModel:LoginModel = LoginModel.init(fromDictionary: jsonResponse)
                
                if logModel.valid {
                    passKey = logModel.passKey
                    self.changeValuesByPickerSelectionDueToday()
                }else{
                    NavigationHelper.showSimpleAlert(message:logModel.responseMessage)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    func changeValuesByPickerSelectionDueToday()
    {
        
        let json: [String: Any] = [
            "ResultsPerPage":11000,
            "IncludeAppointments":false,
            "IncludeAttendees": true,
            "IncludeTasks":true,
            "Invert":false,
            "OrganizationId":currentOrgID,
            "PageOffset":1,
            "ReturnTotal":true,
            "ForUsers":UserTaskArray,
            "PassKey":passKey,
            ]
        UserDefaults.standard.set(true, forKey: "pickerdata")
        print(json)
        let url:String = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.calendar.VCCalendarEndpoint/getIncompleteActivities.json"
        APIManager.sharedInstance.postRequestCall(postURL: url, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(jsonResponse)
                print(json)
//                let ActivityValid = jsonResponse["valid"].boolValue
//                if(!ActivityValid ){
//                    self.loginUser()
//                }
//                else {
                let picdata = UserDefaults.standard.value(forKey: "pickervalue") as? Data
                if((picdata) != nil)
                {
                    self.Arraypriority = []
                    self.ArraySubject = []
                    self.ArrayDueToday = []
                    self.ArrayStatus = []
                    
                    self.ArrayRecurringActivityId = []
                    self.ArrayCreatedOn = []
                    self.ArrayModifiedBy = []
                    self.ArrayModifiedOn = []
                    
                    self.ArrayAdvocateProcessIndex = []
                    self.ArrayAppliedAdvocateProcessId = []
                    self.ArrayPercentComplete  = []
                    self.ArrayDescription  = []
                    
                    self.ArrayId  = []
                    self.ArrayRollOver  = []
                    self.ArrayLocation  = []
                    self.ArrayCreatedBy  = []
                    
                    self.ArrayRecurrenceIndex = []
                    self.ArrayStartTime = []
                    
                    
                    let ActivityArrayres = json["Activities"]
                    print(ActivityArrayres)
                    for act in ActivityArrayres
                    {
                        let dictoval = act.1
                        for(key,value) in dictoval
                        {
                            if(key == "Activity")
                            {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                formatter.locale = Locale(identifier: "en_US_POSIX")
                                let today = formatter.string(from: Date()) // string purpose I add here
                                
                                
                                let due = value["DueTime"].stringValue
                                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                                formatter.locale = Locale(identifier: "en_US_POSIX")
                                let yourDate = formatter.date(from: due)
                                let formatter1 = DateFormatter()
                                formatter1.dateFormat = "yyyy-MM-dd"
                                formatter1.locale = Locale(identifier: "en_US_POSIX")
                                let finaldate = formatter1.string(from: yourDate!)
                                print(finaldate)
                                
                                
                                if(finaldate > today){
//                                    print("fsdhkdjs")
                                }
                                else {
                                    self.ArrayDueToday.add(value["DueTime"].string as Any)
                                    self.ArraySubject.add(value["Subject"].string as Any)
                                    self.Arraypriority.add(value["Priority"].string as Any)
                                    self.ArrayStatus.add(value["Status"].string as Any)
                                    
                                    self.ArrayRecurringActivityId.add(value["RecurringActivityId"].string as Any)
                                    self.ArrayCreatedOn.add(value["CreatedOn"].string as Any)
                                    self.ArrayModifiedBy.add(value["ModifiedBy"].string as Any)
                                    self.ArrayModifiedOn.add(value["ModifiedOn"].string as Any)
                                    
                                    self.ArrayAdvocateProcessIndex.add(value["AdvocateProcessIndex"].string as Any)
                                    self.ArrayAppliedAdvocateProcessId.add(value["AppliedAdvocateProcessId"].string as Any)
                                    self.ArrayPercentComplete.add("\(value["PercentComplete"].number ?? 0)")
                                    self.ArrayDescription.add(value["Description"].string as Any)
                                    
                                    
                                    self.ArrayStartTime.add(value["StartTime"].string as Any)
                                    self.ArrayId.add(value["Id"].string as Any)
                                    self.ArrayRollOver.add(value["RollOver"].string as Any)
                                    self.ArrayLocation.add(value["Location"].string as Any)
                                    
                                    self.ArrayCreatedBy.add(value["CreatedBy"].string as Any)
                                    self.ArrayRecurrenceIndex.add(value["RecurrenceIndex"].string as Any)
                                }
                            }
                        }
                        
                    }
                    self.TblviewTasklist.reloadData()
                }
           // }
            }
            
        },onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    
    func changeValuesByPickerSelectionCompleted()
    {
        let json: [String: Any] = [
            "ResultsPerPage":1000,
            "IncludeAppointments":false,
            "IncludeAttendees":true,
            "IncludeTasks":true,
            "Invert":true,
            "OrganizationId":currentOrgID,
            "PageOffset":1,
            "ReturnTotal":true,
            "ForUsers":UserTaskArray,
            "PassKey":passKey,
            ]
        UserDefaults.standard.set(true, forKey: "pickerdata")
        print(json)
        let url:String = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.calendar.VCCalendarEndpoint/getIncompleteActivities.json"
        APIManager.sharedInstance.postRequestCall(postURL: url, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let picdata = UserDefaults.standard.value(forKey: "pickervalue") as? Data
                if((picdata) != nil)
                {
                    self.Arraypriority = []
                    self.ArraySubject = []
                    self.ArrayDueToday = []
                    self.ArrayStatus = []
                    
                    self.ArrayRecurringActivityId = []
                    self.ArrayCreatedOn = []
                    self.ArrayModifiedBy = []
                    self.ArrayModifiedOn = []
                    
                    self.ArrayAdvocateProcessIndex = []
                    self.ArrayAppliedAdvocateProcessId = []
                    self.ArrayPercentComplete  = []
                    self.ArrayDescription  = []
                    
                    self.ArrayId  = []
                    self.ArrayRollOver  = []
                    self.ArrayLocation  = []
                    self.ArrayCreatedBy  = []
                    
                    self.ArrayRecurrenceIndex = []
                    self.ArrayStartTime = []
                    
                    
                    
                    let ActivityArrayres = json["Activities"]
                    print(ActivityArrayres)
                    for act in ActivityArrayres
                    {
                        let dictoval = act.1
                        for(key,value) in dictoval
                        {
                            if(key == "Activity")
                            {
                                self.ArraySubject.add(value["Subject"].string as Any)
                                self.ArrayDueToday.add(value["DueTime"].string as Any)
                                self.Arraypriority.add(value["Priority"].string as Any)
                                self.ArrayStatus.add(value["Status"].string as Any)
                                
                                self.ArrayRecurringActivityId.add(value["RecurringActivityId"].string as Any)
                                self.ArrayCreatedOn.add(value["CreatedOn"].string as Any)
                                self.ArrayModifiedBy.add(value["ModifiedBy"].string as Any)
                                self.ArrayModifiedOn.add(value["ModifiedOn"].string as Any)
                                
                                self.ArrayAdvocateProcessIndex.add(value["AdvocateProcessIndex"].string as Any)
                                self.ArrayAppliedAdvocateProcessId.add(value["AppliedAdvocateProcessId"].string as Any)
                                self.ArrayPercentComplete.add("\(value["PercentComplete"].number ?? 0)")

//                                self.ArrayPercentComplete.add(value["PercentComplete"].string as Any)
                                self.ArrayDescription.add(value["Description"].string as Any)
                                
                                self.ArrayStartTime.add(value["StartTime"].string as Any)
                                self.ArrayId.add(value["Id"].string as Any)
                                self.ArrayRollOver.add(value["RollOver"].string as Any)
                                self.ArrayLocation.add(value["Location"].string as Any)
                                
                                self.ArrayCreatedBy.add(value["CreatedBy"].string as Any)
                                self.ArrayRecurrenceIndex.add(value["RecurrenceIndex"].string as Any)
                            }
                        }
                        
                    }
                    self.TblviewTasklist.reloadData()
                    
                }
            }
            
        },onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    
    func changeValuesByPickerSelectionCurrentUpcoming()
    {
        let json: [String: Any] = [
            "ResultsPerPage":1000,
            "IncludeAppointments":false,
            "IncludeAttendees": false,
            "IncludeTasks":true,
            "Invert":false,
            "OrganizationId":currentOrgID,
            "PageOffset":1,
            "ReturnTotal":false,
            "ForUsers":UserTaskArray,
            "PassKey":passKey,
            ]
        UserDefaults.standard.set(true, forKey: "pickerdata")
        print(json)
        let url:String = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.calendar.VCCalendarEndpoint/getIncompleteActivities.json"
        APIManager.sharedInstance.postRequestCall(postURL: url, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                let picdata = UserDefaults.standard.value(forKey: "pickervalue") as? Data
                if((picdata) != nil)
                {
                    self.Arraypriority = []
                    self.ArraySubject = []
                    self.ArrayDueToday = []
                    self.ArrayStatus = []
                    
                    self.ArrayRecurringActivityId = []
                    self.ArrayCreatedOn = []
                    self.ArrayModifiedBy = []
                    self.ArrayModifiedOn = []
                    
                    self.ArrayAdvocateProcessIndex = []
                    self.ArrayAppliedAdvocateProcessId = []
                    self.ArrayPercentComplete  = []
                    self.ArrayDescription  = []
                    
                    self.ArrayId  = []
                    self.ArrayRollOver  = []
                    self.ArrayLocation  = []
                    self.ArrayCreatedBy  = []
                    
                    self.ArrayRecurrenceIndex = []
                    self.ArrayStartTime = []
                    
                    let ActivityArrayres = json["Activities"]
                    print(ActivityArrayres)
                    for act in ActivityArrayres
                    {
                        let dictoval = act.1
                        for(key,value) in dictoval
                        {
                            if(key == "Activity")
                            {
                                self.ArraySubject.add(value["Subject"].string as Any)
                                self.ArrayDueToday.add(value["DueTime"].string as Any)
                                self.Arraypriority.add(value["Priority"].string as Any)
                                self.ArrayStatus.add(value["Status"].string as Any)
                                
                                self.ArrayRecurringActivityId.add(value["RecurringActivityId"].string as Any)
                                self.ArrayCreatedOn.add(value["CreatedOn"].string as Any)
                                self.ArrayModifiedBy.add(value["ModifiedBy"].string as Any)
                                self.ArrayModifiedOn.add(value["ModifiedOn"].string as Any)
                                
                                self.ArrayAdvocateProcessIndex.add(value["AdvocateProcessIndex"].string as Any)
                                self.ArrayAppliedAdvocateProcessId.add(value["AppliedAdvocateProcessId"].string as Any)
                                self.ArrayPercentComplete.add("\(value["PercentComplete"].number ?? 0)")
                                self.ArrayDescription.add(value["Description"].string as Any)
                                
                                
                                self.ArrayStartTime.add(value["StartTime"].string as Any)
                                self.ArrayId.add(value["Id"].string as Any)
                                self.ArrayRollOver.add(value["RollOver"].string as Any)
                                self.ArrayLocation.add(value["Location"].string as Any)
                                
                                self.ArrayCreatedBy.add(value["CreatedBy"].string as Any)
                                self.ArrayRecurrenceIndex.add(value["RecurrenceIndex"].string as Any)
                            }
                        }
                        
                    }
                    self.TblviewTasklist.reloadData()
                    
                }
            }
            
        },onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    
}

extension TaskListViewController:URLSessionDelegate {
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
