//
//  ServicesController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 18/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ServicesController: UIViewController {
    
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var processesList:[ServicesResult] = []
    @IBOutlet weak var tblItems: UITableView!
    var kHeaderSectionTag: Int = 6900;
    var servicesList:[GetServicesListResult] = []
    var ApplyProcessArray : [String] = []
    var Cellheight : Int!
    
    var SelectIndex : Int!
    
    
    var resultsArray : [JSON] = []
    var Clientclass : String!
    
    var bottomView = UIView()

    @IBOutlet weak var btnViewAllServices: UIButton!
    var items: [[DropdownItem]]!
    var selectedRow: Int = 0
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    var expandData = [NSMutableDictionary]()

    @IBOutlet weak var btnDropDown: UIBarButtonItem!

    @IBAction func tappedAdd(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "NewClientClassVC") as! NewClientClassVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func tappedServiceMatrix(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ServiceMatrixController") as! ServiceMatrixController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func tappedTab(_ sender: Any) {
        
        if addPreviousControllers.count > 0 {
//            var menuView: DropdownMenu?
//            let addItems:NSMutableArray = []
//            
//            for index in 0..<addPreviousControllers.count {
//                let item1 = DropdownItem(title: addPreviousControllers[index] as! String)
//                addItems.add(item1)
//            }
//            items = [addItems] as! [[DropdownItem]]
//            menuView = DropdownMenu(navigationController: navigationController!, items: addItems as! [DropdownItem], selectedRow: 10)
//            
//            menuView?.topOffsetY = CGFloat(0.0)
//            //menuView?.separatorStyle = .none
//            menuView?.zeroInsetSeperatorIndexPaths = [IndexPath(row: 1, section: 0)]
//            menuView?.delegate = self
//            menuView?.rowHeight = 50
//            menuView?.showMenu()
        }
        
    }
    @IBAction func tappedViewAllServices(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ServiceListController") as! ServiceListController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarItem()
        Cellheight = 2

        self.title = "Services"
        
        tblItems.tableFooterView = UIView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        var setTableHeight = UIScreen.main.bounds.height - topBarHeight
        setTableHeight = setTableHeight - 67
        tblItems.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: setTableHeight)
        
        let createBtn = UIButton()
        createBtn.frame = CGRect(x: 50.0, y: setTableHeight+10 , width: UIScreen.main.bounds.width - 100, height: 40)
        createBtn.setTitle("View All Services", for: .normal)
        createBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        createBtn.titleLabel?.font =  UIFont(name: "Raleway-Regular", size: 18.0)!
        createBtn.backgroundColor = UIColor.white
        createBtn.addTarget(self, action: #selector(tappedViewAllServices), for: .touchUpInside)
        self.view.addSubview(createBtn)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        getProcessList()
        btnViewAllServices.layer.borderColor = UIColor.PSNavigaitonController().cgColor
        btnViewAllServices.layer.borderWidth = 1.0
        btnViewAllServices.clipsToBounds = true
        
//        NavigationHelper().setupScreen(vc: self)
//
//        let tabView = NavigationHelper().setupBarSqureImage()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            let setupImage:UIImage = tabView.takeScreenshot()
//            self.btnDropDown.image = setupImage
//        }

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
                self.processesList = []
                self.expandData = []
                
                let getModel:ServicesModel = ServicesModel.init(fromDictionary: jsonResponse)
                
                if getModel.valid {
                    self.processesList = getModel.results
                    self.processesList = self.processesList.sorted(by:{ $0.name.compare($1.name) == .orderedAscending })

                }else{
                    
                }
                for _ in 0..<self.processesList.count {
                    self.expandData.append(["isOpen":"1","data":[]])
                }
                self.tblItems.reloadData()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        
    }
    
    func getApplyProcessList(){
        let json: [String: Any] = ["ObjectName": "service_deliverable_template",
                                   "AscendingOrder":true,
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
       
        APIManager.sharedInstance.postRequestCall(postURL: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                self.resultsArray = json["Results"].arrayValue
                for dic in self.resultsArray{
                        let value = dic["Subject"].string
                        self.ApplyProcessArray.append(value!)
                    }
                if(self.ApplyProcessArray.count > 0){
                DPPickerManager.shared.showPicker(title: "Apply Service", selected: "", strings: self.ApplyProcessArray) { (value, index, cancel) in
                    if !cancel {
                          print(index)
                          let dict = self.resultsArray[index]
                          print(dict)
                        let dataObject1:NSMutableDictionary = [:]
                        if dict["DeliverableType"].string == "Set Date" {
                            dataObject1.setValue(dict["DeliverableDate"].string, forKey: "DeliverableDate")
                        }else{
                            dataObject1.setValue(dict["ContactDateFieldName"].string, forKey: "ContactDateFieldName")
                        }

                        dataObject1.setValue(dict["RecurrencePatternId"].string, forKey: "RecurrencePatternId")
                        dataObject1.setValue(dict["ActivityType"].string, forKey: "ActivityType")
                        if(dict["ActivityType"].string == "Appointment"){
                            dataObject1.setValue(dict["AppointmentTypeId"].string, forKey: "AppointmentTypeId")
                        }
                        if(dict["Subject"].string is String){
                        dataObject1.setValue(dict["Subject"].string, forKey: "Subject")
                        }
                        else{
                            dataObject1.setValue("", forKey: "Subject")
                        }
                        if(dict["Description"].string is String){
                        dataObject1.setValue(dict["Description"].string, forKey: "Description")
                        }
                        else{
                            dataObject1.setValue("", forKey: "Description")
                        }
                        if(dict["Location"].string is String){
                        dataObject1.setValue(dict["Location"].string, forKey: "Location")
                        }
                        else{
                            dataObject1.setValue("", forKey: "Location")
                        }
                        if(dict["StartTime"].string is String){
                        dataObject1.setValue(dict["StartTime"].string, forKey: "StartTime")
                        }
                        else{
                            dataObject1.setValue("", forKey: "StartTime")
                        }
                        if(dict["EndTime"].string is String){
                        dataObject1.setValue(dict["EndTime"].string, forKey: "EndTime")
                        }
                        else{
                            dataObject1.setValue("", forKey: "EndTime")
                        }
                        if(dict["DayOffset"].int != 0){
                        dataObject1.setValue(dict["DayOffset"].int, forKey: "DayOffset")
                        }
                        else{
                            dataObject1.setValue(0, forKey: "DayOffset")
                        }
                        dataObject1.setValue(dict["AllDay"].bool, forKey: "AllDay")
                        dataObject1.setValue(dict["RollOver"].bool, forKey: "RollOver")

                       if(dict["AssigneeType"].string is String){
                        dataObject1.setValue(dict["AssigneeType"].string, forKey: "AssigneeType")
                       }
                        else{
                            dataObject1.setValue("", forKey: "AssigneeType")
                        }
                        if(dict["AssigneeId"].string is String){
                        dataObject1.setValue(dict["AssigneeId"].string, forKey: "AssigneeId")
                        }
                        else{
                            dataObject1.setValue("", forKey: "AssigneeId")
                        }
                        dataObject1.setValue(self.Clientclass, forKey:"ClientClassId")
                        dataObject1.setValue(true, forKey:"Enabled")
                        dataObject1.setValue(dict["Id"].string, forKey:"ServiceDeliverableTemplateId")
                        let json:[String:Any] = ["DataObject":dataObject1,
                                                 "ObjectName":"service_matrix_template",
                                                 "PassKey":passKey,
                                                 "OrganizationId":currentOrgID]
                        print(json)
                        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                            DispatchQueue.main.async {
                                print(json)
                                OperationQueue.main.addOperation {
                                    let response = json["ResponseMessage"].string
                                    if(response == "Unable to create ServiceMatrixTemplate"){
                                        NavigationHelper.showSimpleAlert(message:"Unable to create ServiceMatrixTemplate")
                                    }
                                    else{
                                    NavigationHelper.showSimpleAlert(message:"Saved Successfully")
                                    self.expandData[self.SelectIndex - 100].setValue("1", forKey: "isOpen")
                                    self.tblItems.reloadData()
                                    }
                                }
                            }
                        },  onFailure: { error in
                            print(error.localizedDescription)
                        })
                        
                    }
                }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension ServicesController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if(Cellheight == 2){
                return 138
                }
                return 44
            }
            if expandData.count == 0 {
                if(Cellheight == 2){
                    return 138
                }
                return 44
            }
            return 44
        }
        if let dataarray = self.expandData[indexPath.section].value(forKey: "data") as? [GetServicesListResult] {
            if dataarray.count == 0 {
                if(Cellheight == 2){
                    return 171
                }
                return 105
            }else {
                if indexPath.row == 0 {
                    if(Cellheight == 2){
                        return 138
                    }
                    return 72
                }else{
                    return 44
                }
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.expandData[section].value(forKey: "isOpen") as! String == "1"{
            return 0
        }else{
            if let dataarray = self.expandData[section].value(forKey: "data") as? [GetServicesListResult] {
                return dataarray.count + 1
            }
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.expandData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:ProcessCell = tableView.dequeueReusableCell(withIdentifier: "ProcessCell", for: indexPath) as! ProcessCell
            let eachOrg:ServicesResult = self.processesList[indexPath.section]
            cell.lblName.text = eachOrg.name
            if(eachOrg.descriptionField != ""){
            Cellheight = 2
            cell.lblDescription.text = eachOrg.descriptionField
            cell.descriHeight.constant = 65
            }
            else{
                Cellheight = 1
                cell.descriHeight.constant = 0
            }
            cell.btnSteps.tag = indexPath.section
            cell.btnSteps.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            return cell
        }
        let cell:StepsListCell = tableView.dequeueReusableCell(withIdentifier: "StepsListCell", for: indexPath) as! StepsListCell
        
        let list = servicesList[indexPath.row - 1]
//        cell.patternLbl.text = "Activity Type : "
        cell.lblStartTime.text = list.activityType //converDateToString(dateString: list.startTime!)
        cell.lblSubject.text = list.subject!
        cell.lblActivityType.text = list.descriptionField
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let list = servicesList[indexPath.row - 1]
            let eachOrg:ServicesResult = self.processesList[indexPath.row-1]
            let controller:CreatingNewService = self.storyboard?.instantiateViewController(withIdentifier: "CreatingNewService") as! CreatingNewService
            controller.ClientClassId = eachOrg.id
            controller.serviceList = list
            controller.createMethod = "service_matrix_template"
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
   
    @objc func buttonAction(sender: UIButton!) {
        let values = ["Apply Service", "New Service"]
        DPPickerManager.shared.showPicker(title: "Service", selected: "", strings: values) { (value, index, cancel) in
            if !cancel {
                if(value == "New Service"){
                    let btnsendtag: UIButton = sender
                    let eachOrg:ServicesResult = self.processesList[btnsendtag.tag]
                    let controller:CreatingNewService = self.storyboard?.instantiateViewController(withIdentifier: "CreatingNewService") as! CreatingNewService
                    controller.ClientClassId = eachOrg.id
                    
                    controller.createMethod = "service_deliverable_template"
                    self.navigationController?.pushViewController(controller, animated: true)
                }
                else {
                    let btnsendtag: UIButton = sender
                    let eachOrg:ServicesResult = self.processesList[btnsendtag.tag]
                    self.Clientclass = eachOrg.id
                    self.getApplyProcessList()
                }
            }
        }
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 60))
        headerView.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 40, y: 10, width: headerView.frame.size.width - 80, height: 40))
        label.font = UIFont.init(name: "Raleway-Regular", size: 15.0)
        let eachOrg:ServicesResult = self.processesList[section]
        label.text = eachOrg.name
        headerView.addSubview(label)
        headerView.tag = section + 100
        
        let bottomBorder = UILabel()
        bottomBorder.frame = CGRect(x: 0.0, y: 58, width: UIScreen.main.bounds.width, height: 2)
        bottomBorder.backgroundColor = UIColor.lightGray
        headerView.addSubview(bottomBorder)
        
        let arrowImg = UIImageView()
        arrowImg.frame = CGRect(x: 10.0, y: 17.5, width: 20, height: 20)
        //        if section ==
        
        if self.expandData[section].value(forKey: "isOpen") as! String == "1"{
            arrowImg.image = UIImage.init(named:"ic_right_black_arrow")
        }else{
            arrowImg.image = UIImage.init(named:"ic_down_arrow_black")
        }
        
        headerView.addSubview(arrowImg)
        
        
        let dotBtn = UIButton()
        dotBtn.frame = CGRect(x: tableView.bounds.size.width - 40, y: 20, width: 30, height: 25)
        dotBtn.setTitle("", for: .normal)
        dotBtn.setImage(UIImage.init(named:"ic_dot_menu"), for: .normal)
        dotBtn.addTarget(self, action: #selector(moreClicked), for: .touchUpInside)
        dotBtn.tag = section
        headerView.addSubview(dotBtn)
        
        
        let tapgesture = UITapGestureRecognizer(target: self , action: #selector(self.sectionTapped(_:)))
        headerView.addGestureRecognizer(tapgesture)
        return headerView
    }
    @objc func moreClicked(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        print(btnsendtag.tag)
        
        let alert = UIAlertController(title: "", message: "Services", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Client Class Details", style: .default , handler:{ (UIAlertAction)in
            
            let eachOrg:ServicesResult = self.processesList[btnsendtag.tag]
            print(eachOrg.name)
            
            let controller:NewClientClassVC = self.storyboard?.instantiateViewController(withIdentifier: "NewClientClassVC") as! NewClientClassVC
            controller.processList = eachOrg
            self.navigationController?.pushViewController(controller, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete Class", style: .default , handler:{ (UIAlertAction)in
            let eachOrg:ServicesResult = self.processesList[btnsendtag.tag]
            self.deleteService(serviceID: eachOrg.id!)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    @objc func sectionTapped(_ sender: UITapGestureRecognizer){
        
        if(self.expandData[(sender.view?.tag)! - 100].value(forKey: "isOpen") as! String == "1") {
            SelectIndex = (sender.view?.tag)!
            self.expandData = []
            
            for _ in 0..<self.processesList.count {
                self.expandData.append(["isOpen":"1","data":[]])
            }
            self.tblItems.reloadData()
            
            let eachOrg:ServicesResult = self.processesList[(sender.view?.tag)! - 100]
            self.getServicesList(stepsTag: eachOrg.id, tag: (sender.view?.tag)!)
            return
        }else{
           
            
            self.expandData[(sender.view?.tag)! - 100].setValue("1", forKey: "isOpen")
        }
        self.tblItems.reloadSections(IndexSet(integer: (sender.view?.tag)! - 100), with: .automatic)
    }
    
    func getServicesList(stepsTag:String,tag:Int){
        var json: [String: Any] = [:]
        json = ["ObjectName":"service_matrix_template",
                    "AscendingOrder":true,
                    "ParentObjectName":"client_class",
                    "ParentId":stepsTag,
                    "PassKey":passKey,
                    "OrganizationId":currentOrgID]
        
        print(json)
        print(orgListURL)
        servicesList = []
        
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                self.getServicesList1(stepsTag: stepsTag, tag: tag)
                let model = GetServicesListModel.init(fromDictionary: jsonResponse)
                if model.valid {
                    self.servicesList = model.results
                    self.expandData[tag - 100].setValue(self.servicesList, forKey: "data")
                }
                self.expandData[tag - 100].setValue("0", forKey: "isOpen")
                self.tblItems.reloadSections(IndexSet(integer: tag - 100), with: .automatic)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    func getServicesList1(stepsTag:String,tag:Int){
        var json: [String: Any] = [:]
        json = ["ObjectName":"static_deliverable_template",
                "AscendingOrder":true,
                "ParentObjectName":"client_class",
                "ParentId":stepsTag,
                "PassKey":passKey,
                "OrganizationId":currentOrgID]
        
        print(json)
        print(orgListURL)
        
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let model = GetServicesListModel.init(fromDictionary: jsonResponse)
                if model.valid {
                    self.servicesList.append(contentsOf:model.results)
                    self.expandData[tag - 100].setValue(self.servicesList, forKey: "data")
                }
                self.expandData[tag - 100].setValue("0", forKey: "isOpen")
                
                self.tblItems.reloadSections(IndexSet(integer: tag - 100), with: .automatic)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
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
    func deleteService(serviceID:String){
        let alertController = UIAlertController(title: "Alert", message: "Would you like to delete this?", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
            
            let json:[String:Any] = ["ObjectId":serviceID,
                                     "ObjectName":"client_class",
                                     "PassKey":passKey,
                                     "OrganizationId":currentOrgID]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    if let getValid = jsonResponse["Valid"] as? Bool {
                        if getValid == true {
                            self.getProcessList()
                        }else{
                            let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                            print(responseMessage)
                        }
                    }else{
                        
                    }
                }
            },  onFailure: { error in
                print(error.localizedDescription)
            })
            
        }
        
        let action2 = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
/*
extension ServicesController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.processesList.count > 0 {
            tableView.backgroundView = nil
            return processesList.count
        } else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "Retrieving data.\nPlease wait."
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            //            messageLabel.font = UIFont(name: "Raleway-Regular", size: 17.0)!
            messageLabel.sizeToFit()
            self.tblItems.backgroundView = messageLabel;
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            //            let arrayOfItems = sectionItems[section] as! NSArray
            return 1;
        } else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //        if (sectionNames.count != 0) {
        //            return sectionNames[section] as? String
        //        }
        return ""
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 63.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //recast your view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.clear
        header.textLabel?.textColor = UIColor.black
        
        let headerFrame = self.view.frame.size
        
        let seperatorLine = UILabel(frame: CGRect(x: 0, y: 62.0, width: headerFrame.width, height: 1));
        seperatorLine.backgroundColor = UIColor.darkGray
        header.contentView.addSubview(seperatorLine)
        
        let headerTitle = UILabel()
        headerTitle.frame = CGRect(x: 35.0, y: 18, width: headerFrame.width - 60, height: 30)
        
        let eachOrg:ServicesResult = self.processesList[section]
        headerTitle.text = eachOrg.name
        headerTitle.textColor = UIColor.black
        header.contentView.addSubview(headerTitle)
        
        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let theImageView = UIImageView(frame: CGRect(x: 5.0, y: 25, width: 15, height: 15));
        theImageView.image = UIImage(named: "ic_right_black_arrow")
        theImageView.tag = kHeaderSectionTag + section
        header.addSubview(theImageView)
        
        let iBtn:UIButton = UIButton(frame: CGRect(x: headerFrame.width - 35, y: 18, width: 32, height: 32));
        iBtn.setImage(UIImage(named: "ic_horizontal_menu"), for: .normal)
        iBtn.tag = section
        iBtn.addTarget(self, action: #selector(tappedMenu), for: .touchUpInside)
        header.addSubview(iBtn)
        
        // make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    @objc func tappedMenu(sender: UIButton!){
        let btnsendtag: UIButton = sender
        print(btnsendtag.tag)
        
        let alert = UIAlertController(title: "", message: "Services", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Client Class Deatils", style: .default , handler:{ (UIAlertAction)in
            
            let eachOrg:ServicesResult = self.processesList[btnsendtag.tag]
            print(eachOrg.name)
            
            let controller:NewClientClassVC = self.storyboard?.instantiateViewController(withIdentifier: "NewClientClassVC") as! NewClientClassVC
            controller.processList = eachOrg
            self.navigationController?.pushViewController(controller, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete Class", style: .default , handler:{ (UIAlertAction)in
            let eachOrg:ServicesResult = self.processesList[btnsendtag.tag]
            self.deleteService(serviceID: eachOrg.id!)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    func deleteService(serviceID:String){
        let alertController = UIAlertController(title: "Alert", message: "Would you like to delete this?", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction) in
            print("You've pressed default");
            
            let json:[String:Any] = ["ObjectId":serviceID,
                                     "ObjectName":"client_class",
                                     "PassKey":passKey,
                                     "OrganizationId":currentOrgID]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    if let getValid = jsonResponse["Valid"] as? Bool {
                        if getValid == true {
                            self.getProcessList()
                        }else{
                            let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                            print(responseMessage)
                        }
                    }else{
                        
                    }
                }
            },  onFailure: { error in
                print(error.localizedDescription)
            })
            
        }
        
        let action2 = UIAlertAction(title: "No", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProcessCell = tableView.dequeueReusableCell(withIdentifier: "ProcessCell", for: indexPath) as! ProcessCell
        let eachOrg:ServicesResult = self.processesList[indexPath.section]
        cell.lblName.text = eachOrg.name
        cell.lblDescription.text = eachOrg.descriptionField
        cell.btnSteps.tag = indexPath.section
        cell.btnSteps.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return cell
    }
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        print(btnsendtag)
        let eachOrg:ServicesResult = self.processesList[btnsendtag.tag]
        print(eachOrg.id)
        
        let controller:ServiceListController = self.storyboard?.instantiateViewController(withIdentifier: "ServiceListController") as! ServiceListController
        controller.serviceID = eachOrg.id
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Expand / Collapse Methods
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!)
            } else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        self.expandedSectionHeaderNumber = -1;
        if (self.processesList.count == 0) {
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< 1 {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            tblItems.beginUpdates()
            tblItems.deleteRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            tblItems.endUpdates()
        }
    }
    
    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
        
        
        if (self.processesList.count == 0) {
            self.expandedSectionHeaderNumber = -1;
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< 1 {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            tblItems.beginUpdates()
            tblItems.insertRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            tblItems.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }
    
}
 */
extension ServicesController: DropdownMenuDelegate {
    func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        print("DropdownMenu didselect \(indexPath.row) text:\(items[indexPath.section][indexPath.row].title)")
        if indexPath.row != items.count - 1 {
            self.selectedRow = indexPath.row
        }
        
        let indexTitle:String = "\(items[indexPath.section][indexPath.row].title)"
        print(indexTitle)
        NavigationHelper().setupRootViewController(senderVC: self, title: indexTitle)
        
        
        
    }
}
extension ServicesController:URLSessionDelegate {
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
