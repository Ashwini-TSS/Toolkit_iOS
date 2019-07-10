//
//  ProcessesController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 04/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ProcessesController: UIViewController {
    @IBOutlet weak var btnDropDown: UIBarButtonItem!
    
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var processesList:[GetProcessesResult] = []
    @IBOutlet weak var tblItems: UITableView!
    let kHeaderSectionTag: Int = 6900;
    var isDisappeared:Bool = false
    
    var CellHeight : Int!
    
    @IBOutlet weak var btnViewAppliedProcess: UIButton!
    var items: [[DropdownItem]]!
    var showSection: Bool = true
    var selectedRow: Int = 0
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    var strRetiveData:String = ""
    var expandData = [NSMutableDictionary]()
    var stepsList:[GetStepsResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        CellHeight = 2
        self.title = "Processes"
        setNavigationBarItem()
     
        btnViewAppliedProcess.layer.borderColor = UIColor.PSNavigaitonController().cgColor
        btnViewAppliedProcess.layer.borderWidth = 1.0
        btnViewAppliedProcess.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        var setTableHeight = UIScreen.main.bounds.height - topBarHeight
         setTableHeight = setTableHeight - 67
        tblItems.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: setTableHeight)

        let createBtn = UIButton()
        createBtn.frame = CGRect(x: 50.0, y: setTableHeight+10 , width: UIScreen.main.bounds.width - 100, height: 40)
        createBtn.setTitle("View Applied Processes", for: .normal)
        createBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        createBtn.titleLabel?.font =  UIFont(name: "Raleway-Regular", size: 17.0)!
        createBtn.backgroundColor = UIColor.white
        createBtn.addTarget(self, action: #selector(tappedAppliedProcess), for: .touchUpInside)
        self.view.addSubview(createBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        strRetiveData = "Retrieving data.\nPlease wait."
        
//        NavigationHelper().setupScreen(vc: self)
//
//        let tabView = NavigationHelper().setupBarSqureImage()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            let setupImage:UIImage = tabView.takeScreenshot()
//            self.btnDropDown.image = setupImage
//        }

//        btnDropDown.title = "\(addPreviousControllers.count)"
//        btnDropDown.
        isDisappeared = false
        getProcessList()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        isDisappeared = true
        tblItems.reloadData()
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
    func getProcessList(){
        let json: [String: Any] = ["ObjectName": "advocate_process",
                                   "OrderBy": "Name",
                                   "AscendingOrder":true,
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        print(orgListURL)
        
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                self.processesList = []
                self.expandData = []
                
                let getModel:GetProcessesModel = GetProcessesModel.init(fromDictionary: jsonResponse)
                
                if getModel.valid {
                    self.processesList = getModel.results
                    self.processesList = self.processesList.sorted(by:{ $0.name.compare($1.name) == .orderedAscending })
                    

                    if self.processesList.count == 0 {
                        self.strRetiveData = "No Results Found"
                    }
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
    
    @IBAction func tappedAdd(_ sender: Any) {
        let controller:NewAdvocateProcess = self.storyboard?.instantiateViewController(withIdentifier: "NewAdvocateProcess") as! NewAdvocateProcess
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tappedAppliedProcess(_ sender: Any) {
        let controller:AppliedProcessVC = self.storyboard?.instantiateViewController(withIdentifier: "AppliedProcessVC") as! AppliedProcessVC
        self.navigationController?.pushViewController(controller, animated: true)
        
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

extension ProcessesController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.expandData[section].value(forKey: "isOpen") as! String == "1"{
            return 0
        }else{
            if let dataarray = self.expandData[section].value(forKey: "data") as? [GetStepsResult] {
                return dataarray.count + 1
            }
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.expandData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                if(CellHeight == 2){
                   return 172
                }
                return 115
            }
            if expandData.count == 0 {
                if(CellHeight == 2){
                    return 133
                }
                return 88
            }
            return 44
        }
        if ((self.expandData[indexPath.section].value(forKey: "data")) != nil){
            let dataarray = self.expandData[indexPath.section].value(forKey: "data") as? [GetServicesListResult]
            if dataarray?.count == 0 {
                if(CellHeight == 2){
                    return 172
                }
                return 115
            }else {
                if indexPath.row == 0 {
                    if(CellHeight == 2){
                        return 133
                    }
                    return 88
                }else{
                    return 44
                }
            }
        }
        return 133
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:ProcessCell = tableView.dequeueReusableCell(withIdentifier: "ProcessCell", for: indexPath) as! ProcessCell
            let eachOrg:GetProcessesResult = self.processesList[indexPath.section]
            cell.lblName.text = eachOrg.name
            if(eachOrg.descriptionField != ""){
            cell.lblDescription.text = eachOrg.descriptionField
            CellHeight = 2
            cell.DescriptionHeight.constant = 45
            }
            else {
                cell.DescriptionHeight.constant = 0
                CellHeight = 1
            }
            cell.btnSteps.tag = indexPath.section
            cell.btnSteps.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            return cell
        }
        let cell:StepsListCell = tableView.dequeueReusableCell(withIdentifier: "StepsListCell", for: indexPath) as! StepsListCell
        let getResult:GetStepsResult = self.stepsList[indexPath.row - 1]
        cell.lblSubject.text = getResult.subject
        cell.lblStartTime.text = "\(getResult.sequence!)"
        cell.lblActivityType.text = getResult.activityType
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            let getResult:GetStepsResult = self.stepsList[indexPath.row - 1]
            let controller:NewStepsController = self.storyboard?.instantiateViewController(withIdentifier: "NewStepsController") as! NewStepsController
            controller.previousProcessesValue = getResult
            controller.advProcessID = getResult.id
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        print(btnsendtag)
        let eachOrg:GetProcessesResult = self.processesList[btnsendtag.tag]
        print(eachOrg.id)
        
        let controller:NewStepsController = self.storyboard?.instantiateViewController(withIdentifier: "NewStepsController") as! NewStepsController
        controller.advProcessID = eachOrg.id
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 60))
        headerView.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 40, y: 10, width: headerView.frame.size.width - 80, height: 40))
        label.font = UIFont.init(name: "Raleway-Regular", size: 15.0)
        let eachOrg:GetProcessesResult = self.processesList[section]
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
        print(btnsendtag)
        let alert = UIAlertController(title: "", message: "Process", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Apply Process", style: .default , handler:{ (UIAlertAction)in
            
            let eachOrg:GetProcessesResult = self.processesList[btnsendtag.tag]
            print(eachOrg.name)
            
            let controller:NewAppliedProcess = self.storyboard?.instantiateViewController(withIdentifier: "NewAppliedProcess") as! NewAppliedProcess
            controller.processList = eachOrg
            controller.isFromApplyProcess = true
            self.navigationController?.pushViewController(controller, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Edit Process", style: .default , handler:{ (UIAlertAction)in
            let eachOrg:GetProcessesResult = self.processesList[btnsendtag.tag]
            print(eachOrg.name)
            
            let controller:NewAdvocateProcess = self.storyboard?.instantiateViewController(withIdentifier: "NewAdvocateProcess") as! NewAdvocateProcess
            controller.processList = eachOrg
            self.navigationController?.pushViewController(controller, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete Process", style: .destructive , handler:{ (UIAlertAction)in
            
            let eachOrg:GetProcessesResult = self.processesList[btnsendtag.tag]
            
            
            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    print(index,title)
                    if title == "Yes" {
                        self.deleteInviteUser(contactID: eachOrg.id)
                    }
                })
            })
            
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
        if(self.expandData[(sender.view?.tag)! - 100].value(forKey: "isOpen") as! String == "1"){
            self.expandData = []
            for _ in 0..<self.processesList.count {
                self.expandData.append(["isOpen":"1","data":[]])
            }
            self.tblItems.reloadData()
            let eachOrg:GetProcessesResult = self.processesList[(sender.view?.tag)! - 100]
            self.getSubCategoriesAPI(stepsTag: eachOrg.id, tag: (sender.view?.tag)!)
           return
        }else{
            self.expandData[(sender.view?.tag)! - 100].setValue("1", forKey: "isOpen")
        }
        self.tblItems.reloadSections(IndexSet(integer: (sender.view?.tag)! - 100), with: .automatic)
    }
    func getSubCategoriesAPI(stepsTag:String,tag:Int){
        let json: [String: Any] = ["PageOffset": 1,
                                   "ResultsPerPage": 5000,
                                   "ObjectName":"advocate_process_template",
                                   "ParentObjectName":"advocate_process",
                                   "ParentId":stepsTag,
                                   "AscendingOrder":true,
                                   "OrderBy":"Sequence",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let steps:GetStepsModel = GetStepsModel.init(fromDictionary: jsonResponse)
                if steps.valid {
                    self.stepsList = steps.results
                    self.expandData[tag - 100].setValue(self.stepsList, forKey: "data")
                }
                self.expandData[tag - 100].setValue("0", forKey: "isOpen")

                self.tblItems.reloadSections(IndexSet(integer: tag - 100), with: .automatic)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    func deleteInviteUser(contactID:String){
        let parameters = [
            "ObjectName": "advocate_process",
            "ObjectId": contactID,
            "OrganizationId": currentOrgID,
            "PassKey": passKey
            ] as [String : Any]
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Deleted") { (index, title) in
                        OperationQueue.main.addOperation {
                            self.getProcessList()
                        }
                    }
                })
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
}
/*
extension ProcessesController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.processesList.count > 0 {
            tableView.backgroundView = nil
            return processesList.count
        } else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = strRetiveData
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
        if isDisappeared {
            let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.contentView.backgroundColor = UIColor.clear
            header.textLabel?.textColor = UIColor.black
            
            let headerFrame = self.view.frame.size
            
            let seperatorLine = UILabel(frame: CGRect(x: 0, y: 62.0, width: headerFrame.width, height: 1));
            seperatorLine.backgroundColor = UIColor.darkGray
            header.contentView.addSubview(seperatorLine)
            
            let headerTitle = UILabel()
            headerTitle.frame = CGRect(x: 35.0, y: 18, width: headerFrame.width - 60, height: 30)

            headerTitle.text = ""
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
        }else{
            //recast your view as a UITableViewHeaderFooterView
            let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.contentView.backgroundColor = UIColor.clear
            header.textLabel?.textColor = UIColor.black
            
            let headerFrame = self.view.frame.size
            
            let seperatorLine = UILabel(frame: CGRect(x: 0, y: 62.0, width: headerFrame.width, height: 1));
            seperatorLine.backgroundColor = UIColor.darkGray
            header.contentView.addSubview(seperatorLine)
            
            let headerTitle = UILabel()
            headerTitle.frame = CGRect(x: 30.0, y: 18, width: headerFrame.width - 60, height: 30)

            let eachOrg:GetProcessesResult = self.processesList[section]
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
        
    }
    @objc func tappedMenu(sender: UIButton!){
        let btnsendtag: UIButton = sender
        print(btnsendtag.tag)
        
        let alert = UIAlertController(title: "", message: "Process", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Apply Process", style: .default , handler:{ (UIAlertAction)in
            
            let eachOrg:GetProcessesResult = self.processesList[btnsendtag.tag]
            print(eachOrg.name)
            
            let controller:NewAppliedProcess = self.storyboard?.instantiateViewController(withIdentifier: "NewAppliedProcess") as! NewAppliedProcess
            controller.processList = eachOrg
            self.navigationController?.pushViewController(controller, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Edit Process", style: .default , handler:{ (UIAlertAction)in
            let eachOrg:GetProcessesResult = self.processesList[btnsendtag.tag]
            print(eachOrg.name)
            
            let controller:NewAdvocateProcess = self.storyboard?.instantiateViewController(withIdentifier: "NewAdvocateProcess") as! NewAdvocateProcess
            controller.processList = eachOrg
            self.navigationController?.pushViewController(controller, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete Process", style: .destructive , handler:{ (UIAlertAction)in

            let eachOrg:GetProcessesResult = self.processesList[btnsendtag.tag]

            
            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    print(index,title)
                    if title == "Yes" {
                        self.deleteInviteUser(contactID: eachOrg.id)
                    }
                })
            })
            
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
        
    }
    func deleteInviteUser(contactID:String){
        let parameters = [
            "ObjectName": "advocate_process",
            "ObjectId": contactID,
            "OrganizationId": currentOrgID,
            "PassKey": passKey
            ] as [String : Any]
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Deleted") { (index, title) in
                        OperationQueue.main.addOperation {
                            self.getProcessList()
                        }
                    }
                })
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProcessCell = tableView.dequeueReusableCell(withIdentifier: "ProcessCell", for: indexPath) as! ProcessCell
        let eachOrg:GetProcessesResult = self.processesList[indexPath.section]
        cell.lblName.text = eachOrg.name
        cell.lblDescription.text = eachOrg.descriptionField
        cell.btnSteps.tag = indexPath.section
        cell.btnSteps.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return cell
    }
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        print(btnsendtag)
        let eachOrg:GetProcessesResult = self.processesList[btnsendtag.tag]
        print(eachOrg.id)
        
         let controller:NewStepsController = self.storyboard?.instantiateViewController(withIdentifier: "NewStepsController") as! NewStepsController
         controller.advProcessID = eachOrg.id
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
extension ProcessesController: DropdownMenuDelegate {
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
extension ProcessesController:URLSessionDelegate {
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
