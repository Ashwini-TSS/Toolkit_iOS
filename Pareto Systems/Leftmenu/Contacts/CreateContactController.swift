//
//  CreateContactController.swift
//  ContactsModule
//
//  Created by Test Technologies PVT LTD on 11/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class CreateContactController: UITableViewController {
    
    var fieldClientClass:String = ""
    
    var selectedIndexPath:Int = 1992001
    var isExpand:Bool = false
    var headerTitles:[String] = ["Contact","Web Addresses","Phone Numbers","Address","Other Contact Information","Family","Occupation","Recreation","Money","Additional Addresses","Linked Accounts","Open Activities","Completed Activities"]
    
    //Models
    var getClientClassModel:GetClientClassModel!
    var getOwnersListModel:GetOwnersListModel!
    var getSpouseContactListModel:GetSpouseContactModel!
    var getCompanyListModel:GetCompanyListModel!
    var additionalResult:[GetAdditionalAddressResult] = []
    var getLinkedAccountsResult:[GetLinkedAccountsResult] = []
    var getOpenedActivitiesResult:[GetIncompleteActivity] = []
    var getCompleteActivitiesResult:[GetCompleteActivity] = []
    
    //API
    var clientClassID:String = ""
    var ownerID:String = ""
    var spouseID:String = ""
    var companyID:String = ""
    var executorID:String = ""
    var powerAttroneyID:String = ""
    
    var cell1:Bool = false
    var cell2:Bool = false
    var cell3:Bool = false
    var cell4:Bool = false
    var cell5:Bool = false
    var cell6:Bool = false
    var cell7:Bool = false
    var cell8:Bool = false
    var cell9:Bool = false
    
    var clientClassName:String = ""
    var fieldOwnerName:String = ""
    var fieldSpouseName:String = ""
    var fieldExecutorName:String = ""
    var fieldPowerAttName:String = ""
    var fieldCompName:String = ""
    
    var contactInfoDetail:ContactListResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.setContentOffset(.zero, animated: true)
        
        tableView.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // do stuff 42 seconds laters
            
            
            self.setupContactInfo()
        }
    }
    func getClientClass(textField:UITextField){
        if getClientClassModel != nil {
            if getClientClassModel.valid && getClientClassModel.results.count > 0 {
                self.showPicker(pickerTag: 0, textField: textField)
                return
            }
        }else{
            let parameter:[String:Any] = ["SearchTerm":"",
                                          "ObjectName":"client_class",
                                          "PassKey":passKey,
                                          "OrganizationId":currentOrgID]
            requestAPICall(input: parameter, tag: 0, textField: textField)
        }
    }
    
    func getOwnerList(textField:UITextField){
        if getOwnersListModel != nil {
            if getOwnersListModel.valid && getOwnersListModel.results.count > 0 {
                self.showPicker(pickerTag: 3, textField: textField)
                return
            }
        }else{
            let parameter:[String:Any] = ["SearchTerm":"",
                                          "ObjectName":"organization_user",
                                          "PassKey":passKey,
                                          "OrganizationId":currentOrgID]
            requestAPICall(input: parameter, tag: 3, textField: textField)
        }
    }
    func getSpouseContactList(tag:Int,textField:UITextField){
        if getSpouseContactListModel != nil {
            if getSpouseContactListModel.valid && getSpouseContactListModel.results.count > 0 {
                self.showPicker(pickerTag: tag, textField: textField)
                return
            }
        }else{
            let parameter:[String:Any] = ["SearchTerm":"",
                                          "ObjectName":"contact",
                                          "PassKey":passKey,
                                          "OrganizationId":currentOrgID]
            requestAPICall(input: parameter, tag: tag, textField: textField)
        }
    }
    func getCompanyList(textField:UITextField){
        if getCompanyListModel != nil {
            if getCompanyListModel.valid && getCompanyListModel.results.count > 0 {
                self.showPicker(pickerTag: 6, textField: textField)
                return
            }
        }else{
            let parameter:[String:Any] = ["SearchTerm":"",
                                          "ObjectName":"company",
                                          "PassKey":passKey,
                                          "OrganizationId":currentOrgID]
            requestAPICall(input: parameter, tag: 6, textField: textField)
        }
    }
    func requestAPICall(input:[String:Any],tag:Int,textField:UITextField) {
        self.view.endEditing(true)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: input, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                if tag == 0 {
                    self.getClientClassModel = GetClientClassModel.init(fromDictionary: jsonResponse)
                    self.showPicker(pickerTag: tag, textField: textField)
                }else if tag == 3 {
                    self.getOwnersListModel = GetOwnersListModel.init(fromDictionary: jsonResponse)
                    self.showPicker(pickerTag: tag, textField: textField)
                }else if tag == 4 {
                    self.getSpouseContactListModel = GetSpouseContactModel.init(fromDictionary: jsonResponse)
                    self.showPicker(pickerTag: tag, textField: textField)
                }else if tag == 6 {
                    self.getCompanyListModel = GetCompanyListModel.init(fromDictionary: jsonResponse)
                    self.showPicker(pickerTag: tag, textField: textField)
                }else if tag == 7 {
                    self.getSpouseContactListModel = GetSpouseContactModel.init(fromDictionary: jsonResponse)
                    self.showPicker(pickerTag: tag, textField: textField)
                }else if tag == 8 {
                    self.getSpouseContactListModel = GetSpouseContactModel.init(fromDictionary: jsonResponse)
                    self.showPicker(pickerTag: tag, textField: textField)
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if contactInfoDetail != nil {
            return 26
        }
        return 18
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 19 {
            return additionalResult.count
        }
        if section == 21 {
            return getLinkedAccountsResult.count
        }
        if section == 23 {
            return getOpenedActivitiesResult.count
        }
        if section == 25 {
            return getCompleteActivitiesResult.count
        }
        return 1
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.isHidden = true
            return cell
        }else if indexPath.section == 1 {
            let cell:ContactFieldsCell = tableView.dequeueReusableCell(withIdentifier: "ContactFieldsCell") as! ContactFieldsCell
            
            if cell1 == true && contactInfoDetail != nil && clientClassName.count > 0 {
                cell.fieldClientClass.text = self.clientClassName
                clientClassName = ""
            }
            //            cell.contactInfoDetail = contactInfoDetail
            //            cell.setupInfo()
            return cell
        }else if indexPath.section == 2 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 1]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.isHidden = true
            
            return cell
        }else if indexPath.section == 3 {
            let cell:WebAddressCell = tableView.dequeueReusableCell(withIdentifier: "WebAddressCell") as! WebAddressCell
            
            //            cell.contactInfoDetail = contactInfoDetail
            return cell
        }else if indexPath.section == 4 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 2]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.isHidden = true
            
            return cell
        }else if indexPath.section == 5 {
            let cell:PhoneNumberCell = tableView.dequeueReusableCell(withIdentifier: "PhoneNumberCell") as! PhoneNumberCell
            //            cell.contactInfoDetail = contactInfoDetail
            return cell
        }else if indexPath.section == 6 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 3]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.isHidden = true
            
            return cell
        }else if indexPath.section == 7 {
            let cell:AddressCell = tableView.dequeueReusableCell(withIdentifier: "AddressCell") as! AddressCell
            //            cell.contactInfoDetail = contactInfoDetail
            return cell
        }else if indexPath.section == 8 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 4]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.isHidden = true
            
            return cell
        }else if indexPath.section == 9 {
            let cell:OtherContactCell = tableView.dequeueReusableCell(withIdentifier: "OtherContactCell") as! OtherContactCell
            if cell5 == true && contactInfoDetail != nil && fieldOwnerName.count > 0 {
                cell.fieldOwner.text = self.fieldOwnerName
                fieldOwnerName = ""
                
            }
            //            cell.contactInfoDetail = contactInfoDetail
            return cell
        }else if indexPath.section == 10 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 5]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.isHidden = true
            
            return cell
        }else if indexPath.section == 11 {
            let cell:FamilyCell = tableView.dequeueReusableCell(withIdentifier: "FamilyCell") as! FamilyCell
            //            cell.contactInfoDetail = contactInfoDetail
            //cell6
            if cell6 == true && contactInfoDetail != nil && fieldSpouseName.count > 0 {
                cell.fieldSpouse2.text = self.fieldSpouseName
                fieldSpouseName = ""
                
            }
            return cell
        }else if indexPath.section == 12 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 6]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.isHidden = true
            
            return cell
        }else if indexPath.section == 13 {
            let cell:OccupationCell = tableView.dequeueReusableCell(withIdentifier: "OccupationCell") as! OccupationCell
            if cell7 == true && contactInfoDetail != nil && fieldCompName.count > 0 {
                cell.fieldCompany.text = self.fieldCompName
                fieldCompName = ""
                
            }
            //            cell.contactInfoDetail = contactInfoDetail
            return cell
        }else if indexPath.section == 14 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 7]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.isHidden = true
            
            return cell
        }else if indexPath.section == 15 {
            let cell:RecreationCell = tableView.dequeueReusableCell(withIdentifier: "RecreationCell") as! RecreationCell
            //            cell.contactInfoDetail = contactInfoDetail
            return cell
        }else if indexPath.section == 16 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 8]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.isHidden = true
            
            return cell
        }else if indexPath.section == 17 {
            let cell:MoneyCell = tableView.dequeueReusableCell(withIdentifier: "MoneyCell") as! MoneyCell
            //            cell.contactInfoDetail = contactInfoDetail
            if cell9 == true && contactInfoDetail != nil && fieldPowerAttName.count > 0  {
                cell.fieldPowerAtroney.text = self.fieldPowerAttName
                fieldPowerAttName = ""
                
            }
            if cell9 == true && contactInfoDetail != nil && fieldExecutorName.count > 0  {
                cell.fieldExecutor.text = self.fieldExecutorName
                fieldExecutorName = ""
                
            }
            return cell
        }else if indexPath.section == 18 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 9]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.tag = indexPath.section
            cell.btnAdd.isHidden = false
            cell.btnAdd.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchDown)
            return cell
        }else if indexPath.section == 19 {
            let cell:AdditionalAddressCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalAddressCell") as! AdditionalAddressCell
            cell.lblItem1.text = "Name : "
            cell.lblItem2.text = "Telephone : "
            cell.lblItem3.text = "Address : "
            cell.lblItem4.text = "City : "
            cell.lblItem5.text = "State/Province : "
            
            cell.lblName.text = additionalResult[indexPath.row].name
            cell.lblAddress.text = additionalResult[indexPath.row].telephone1
            cell.lblCity.text = additionalResult[indexPath.row].line1
            cell.lblStateProvince.text = additionalResult[indexPath.row].city
            cell.lblTelephone.text = additionalResult[indexPath.row].stateOrProvince
            
            return cell
        }else if indexPath.section == 20 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 10]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.tag = indexPath.section
            
            cell.btnAdd.isHidden = false
            cell.btnAdd.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchDown)
            
            return cell
        }else if indexPath.section == 21 {
            let cell:AdditionalAddressCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalAddressCell") as! AdditionalAddressCell
            
            cell.lblItem1.text = "Name : "
            cell.lblItem2.text = "Telephone : "
            cell.lblItem3.text = "Email : "
            cell.lblItem4.text = "Website : "
            cell.lblItem5.text = "City : "
            
            cell.lblName.text = getLinkedAccountsResult[indexPath.row].name
            cell.lblTelephone.text = getLinkedAccountsResult[indexPath.row].telephone1
            cell.lblStateProvince.text = getLinkedAccountsResult[indexPath.row].eMailAddress1
            cell.lblAddress.text = getLinkedAccountsResult[indexPath.row].webSiteUrl
            cell.lblCity.text = getLinkedAccountsResult[indexPath.row].city
            return cell
        }else if indexPath.section == 22 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 11]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            
            cell.btnAdd.tag = indexPath.section
            cell.btnAdd.isHidden = false
            cell.btnAdd.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchDown)
            
            return cell
        }else if indexPath.section == 23 {
            let cell:AdditionalAddressCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalAddressCell") as! AdditionalAddressCell
            
            cell.lblItem1.text = "Subject : "
            cell.lblItem2.text = "Type : "
            cell.lblItem3.text = "Start Time : "
            cell.lblItem4.text = "Location : "
            cell.lblItem5.text = "End Time : "
            
            cell.lblName.text = getOpenedActivitiesResult[indexPath.row].activity.subject
            cell.lblTelephone.text = getOpenedActivitiesResult[indexPath.row].type
            cell.lblStateProvince.text = getOpenedActivitiesResult[indexPath.row].activity.startTime.converDateToString()
            cell.lblAddress.text = getOpenedActivitiesResult[indexPath.row].activity.location
            cell.lblCity.text = getOpenedActivitiesResult[indexPath.row].activity.endTime.converDateToString()
            return cell
        }else if indexPath.section == 24 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            cell.lblHeader.text = headerTitles[indexPath.section - 12]
            if indexPath.section == selectedIndexPath - 1 {
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            }else{
                cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
            }
            cell.btnAdd.isHidden = true
            
            return cell
        }else if indexPath.section == 25 {
            
            
            
            let cell:AdditionalAddressCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalAddressCell") as! AdditionalAddressCell
            
            cell.lblItem1.text = "Subject : "
            cell.lblItem2.text = "Type : "
            cell.lblItem3.text = "Start Time : "
            cell.lblItem4.text = "Location : "
            cell.lblItem5.text = "End Time : "
            
            cell.lblName.text = getCompleteActivitiesResult[indexPath.row].activity.subject
            cell.lblTelephone.text = getCompleteActivitiesResult[indexPath.row].type
            cell.lblStateProvince.text = getCompleteActivitiesResult[indexPath.row].activity.startTime.converDateToString()
            cell.lblAddress.text = getCompleteActivitiesResult[indexPath.row].activity.location
            cell.lblCity.text = getCompleteActivitiesResult[indexPath.row].activity.endTime.converDateToString()
            return cell
        }
        
        let cell:ListCell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        return cell
    }
    @objc func ratingButtonTapped(_ button: UIButton) {
        print("Button pressed 👍")
        
        let btnTag = button.tag
        print(btnTag)
        
        if btnTag == 18 {
            let controller:AdditionalNewAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "AdditionalNewAddressVC") as! AdditionalNewAddressVC
            controller.leftID = self.contactInfoDetail.id!
            self.navigationController?.pushViewController(controller, animated: true)
        }else if btnTag == 20 {
            let controller:AddLinkedAccountController = self.storyboard?.instantiateViewController(withIdentifier: "AddLinkedAccountController") as! AddLinkedAccountController
            self.navigationController?.pushViewController(controller, animated: true)
        }else if btnTag == 22 {
            let alert = UIAlertController(title: " ", message: "Please Select an Option", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Appointment", style: .default , handler:{ (UIAlertAction)in
                print("User click Approve button")
                OperationQueue.main.addOperation {
                    let controller:UpdatenewappointmentVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewappointmentVC") as? UpdatenewappointmentVC)!
                    controller.linkParentID = self.contactInfoDetail.id!
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "task", style: .default , handler:{ (UIAlertAction)in
                print("User click Edit button")
                OperationQueue.main.addOperation {
                    let controller:UpdatenewtaskVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewtaskVC") as? UpdatenewtaskVC)!
                    controller.linkParentID = self.contactInfoDetail.id!
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Recurrence", style: .default , handler:{ (UIAlertAction)in
                print("User click Delete button")
                OperationQueue.main.addOperation {
                    let controller:NewRecurrenceController = (self.storyboard?.instantiateViewController(withIdentifier: "NewRecurrenceController") as? NewRecurrenceController)!
                    controller.linkParentID = self.contactInfoDetail.id!
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "cancel", style: .destructive , handler:{ (UIAlertAction)in
                print("User click Delete button")
            }))
            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        if indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 || indexPath.section == 10 || indexPath.section == 12 || indexPath.section == 14 || indexPath.section == 16 || indexPath.section == 18 || indexPath.section == 20 || indexPath.section == 22 || indexPath.section == 24   {
            if indexPath.section == selectedIndexPath - 1 {
                selectedIndexPath = 2123123
                isExpand = false
            }else{
                selectedIndexPath = indexPath.section + 1
                isExpand = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                tableView.reloadData()
                
                let indexPath = IndexPath(row: 0, section: indexPath.section)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if isExpand {
                if selectedIndexPath == 1 {
                    return 454
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 3 {
            if isExpand {
                if selectedIndexPath == 3 {
                    return 278
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 5 {
            if isExpand {
                if selectedIndexPath == 5 {
                    return 337
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 7 {
            if isExpand {
                if selectedIndexPath == 7 {
                    return 454
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 9 {
            if isExpand {
                if selectedIndexPath == 9 {
                    return 664
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 11 {
            if isExpand {
                if selectedIndexPath == 11 {
                    return 290
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 13 {
            if isExpand {
                if selectedIndexPath == 13 {
                    return 462
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 15 {
            if isExpand {
                if selectedIndexPath == 15 {
                    return 124
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 17 {
            if isExpand {
                if selectedIndexPath == 17 {
                    return 664
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 19 {
            if isExpand {
                if selectedIndexPath == 19 {
                    return 193
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 21 {
            if isExpand {
                if selectedIndexPath == 21 {
                    return 193
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 23 {
            if isExpand {
                if selectedIndexPath == 23 {
                    return 193
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 25 {
            if isExpand {
                if selectedIndexPath == 25 {
                    return 193
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 0 || indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 || indexPath.section == 10 || indexPath.section == 12 || indexPath.section == 14 || indexPath.section == 16 || indexPath.section == 18 || indexPath.section == 20 || indexPath.section == 22 || indexPath.section == 24  {
            return 62
        }
        return 0
    }
    
    @IBAction func tappedSave(_ sender: Any) {
        
        self.selectedIndexPath = 1992001
        self.isExpand = false
        self.tableView.reloadData()
        
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
//            MBProgressHUD.showAdded(to: self.view, animated: true)

            self.tableView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            // do stuff 42 seconds laters
            self.saveContact()
        }
    }
    
    func requestAPI(input:[String:Any],tag:Int){
        
        var mainURL:String = searchURL
        if tag == 4 || tag == 5 {
            mainURL = linkedURL
        }else if tag == 6 || tag == 7 {
            mainURL = getIncompleteActivitiesURL
        }
        
        APIManager.sharedInstance.postRequestCall(postURL: mainURL, parameters: input, senderVC: self, onSuccess: { (jsonResponse, json) in
            
            if tag == 0 {
                self.getOwner()
            }else if tag == 1 {
                self.getSpouse()
            }else if tag == 2 {
                self.getCompany()
            }else if tag == 3 {
                self.getAdditionalAddress()
            }else if tag == 4 {
                self.getLinkedAccounts()
            }else if tag == 5 {
                self.getOpenedActivities()
            }else if tag == 6 {
                self.getClosedActivities()
            }
            
            DispatchQueue.main.async {
                print(json)
                if tag == 0 {
                    let clientClassModel = GetClientClassModel.init(fromDictionary: jsonResponse)
                    if clientClassModel.valid {
                        for index in 0..<clientClassModel.results.count {
                            let model = clientClassModel.results[index]
                            if model.id == self.contactInfoDetail.clientClassId {
                                //                                let indexPath = IndexPath(row: 0, section: 1)
                                //                                let cell:ContactFieldsCell = self.tableView.cellForRow(at: indexPath) as! ContactFieldsCell
                                //                                cell.fieldClientClass.text = model.name
                                self.clientClassName = model.name
                            }
                        }
                    }
                }else if tag == 1 {
                    let clientClassModel = GetOwnersListModel.init(fromDictionary: jsonResponse)
                    if clientClassModel.valid {
                        for index in 0..<clientClassModel.results.count {
                            let model = clientClassModel.results[index]
                            if model.id == self.contactInfoDetail.owningOrganizationUserId {
                                //                                let indexPath = IndexPath(row: 0, section: 9)
                                self.fieldOwnerName = model.fullName
                                //                                let cell:OtherContactCell = self.tableView.cellForRow(at: indexPath) as! OtherContactCell
                                //                                cell.fieldOwner.text = model.fullName
                            }
                        }
                    }
                }else if tag == 2 {
                    let clientClassModel = GetSpouseContactModel.init(fromDictionary: jsonResponse)
                    if clientClassModel.valid {
                        for index in 0..<clientClassModel.results.count {
                            let model = clientClassModel.results[index]
                            if model.id == self.contactInfoDetail.spousePartnerID {
                                //                                let indexPath = IndexPath(row: 0, section: 11)
                                self.fieldSpouseName = model.fullName
                                
                                //                                let cell5:FamilyCell = self.tableView.cellForRow(at: indexPath) as! FamilyCell
                                //                                cell5.fieldSpouse2.text = model.fullName
                            }
                            if model.id == self.contactInfoDetail.executorID {
                                //                                let indexPath = IndexPath(row: 0, section: 17)
                                //                                let cell5:MoneyCell = self.tableView.cellForRow(at: indexPath) as! MoneyCell
                                self.fieldExecutorName = model.fullName
                                
                                //                                cell5.fieldExecutor.text = model.fullName
                            }
                            if model.id == self.contactInfoDetail.powerOfAttronyID {
                                //                                let indexPath = IndexPath(row: 0, section: 17)
                                //                                self.fieldExecutorName = model.fullName
                                
                                //                                let cell5:MoneyCell = self.tableView.cellForRow(at: indexPath) as! MoneyCell
                                self.fieldPowerAttName = model.fullName
                                
                                //                                cell5.fieldPowerAtroney.text = model.fullName
                            }
                        }
                    }
                }else if tag == 3 {
                    let clientClassModel = GetCompanyListModel.init(fromDictionary: jsonResponse)
                    if clientClassModel.valid {
                        for index in 0..<clientClassModel.results.count {
                            let model = clientClassModel.results[index]
                            if model.id == self.contactInfoDetail.companyId {
                                //                                let indexPath = IndexPath(row: 0, section: 13)
                                //                                let cell6:OccupationCell = self.tableView.cellForRow(at: indexPath) as! OccupationCell
                                self.fieldCompName = model.name
                                
                                //                                cell6.fieldCompany.text = model.name
                            }
                        }
                    }
                }else if tag == 4 {
                    let model = GetAdditionalAddressModel.init(fromDictionary: jsonResponse)
                    self.additionalResult = []
                    if model.valid {
                        self.additionalResult = model.results
                    }
                    self.tableView.reloadData()
                }else if tag == 5 {
                    let model = GetLinkedAccountsModel.init(fromDictionary: jsonResponse)
                    self.getLinkedAccountsResult = []
                    if model.valid {
                        self.getLinkedAccountsResult = model.results
                    }
                    self.tableView.reloadData()
                }else if tag == 6 {
                    let model = GetIncompleteModel.init(fromDictionary: jsonResponse)
                    self.getOpenedActivitiesResult = []
                    if model.valid {
                        self.getOpenedActivitiesResult = model.activities
                    }
                    self.tableView.reloadData()
                }else if tag == 7 {
                    let model = GetCompleteModel.init(fromDictionary: jsonResponse)
                    self.getCompleteActivitiesResult = []
                    if model.valid {
                        self.getCompleteActivitiesResult = model.activities
                    }
                    self.tableView.reloadData()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func getContact() {
        if contactInfoDetail.clientClassId != nil {
            if contactInfoDetail.clientClassId.count > 0 {
                let parameter:[String:Any] = ["SearchTerm":"",
                                              "ObjectName":"client_class",
                                              "PassKey":passKey,
                                              "OrganizationId":currentOrgID]
                self.requestAPI(input: parameter, tag: 0)
            }else{
                getOwner()
            }
        }else{
            getOwner()
        }
    }
    func getOwner(){
        if contactInfoDetail.owningOrganizationUserId != nil {
            if contactInfoDetail.owningOrganizationUserId.count > 0 {
                let parameter:[String:Any] = ["SearchTerm":"",
                                              "ObjectName":"organization_user",
                                              "PassKey":passKey,
                                              "OrganizationId":currentOrgID]
                self.requestAPI(input: parameter, tag: 1)
            }else{
                getSpouse()
            }
        }else{
            getSpouse()
        }
    }
    func getSpouse(){
        if contactInfoDetail.spousePartnerID != nil {
            if contactInfoDetail.spousePartnerID.count > 0 {
                let parameter:[String:Any] = ["SearchTerm":"",
                                              "ObjectName":"contact",
                                              "PassKey":passKey,
                                              "OrganizationId":currentOrgID]
                self.requestAPI(input: parameter, tag: 2)
            }else{
                getCompany()
            }
        }else{
            getCompany()
        }
        
    }
    func getCompany(){
        if contactInfoDetail.companyId != nil {
            if contactInfoDetail.companyId.count > 0 {
                let parameter:[String:Any] = ["SearchTerm":"",
                                              "ObjectName":"company",
                                              "PassKey":passKey,
                                              "OrganizationId":currentOrgID]
                self.requestAPI(input: parameter, tag: 3)
            }
        }else {
            getAdditionalAddress()
        }
    }
    func getAdditionalAddress(){
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ListObjectName": "address",
                                       "ObjectName": "linker_contacts_addresses",
                                       "LinkParentId": contactInfoDetail.id!,
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            self.requestAPI(input: json, tag: 4)
        }
    }
    func getLinkedAccounts(){
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ListObjectName": "company",
                                       "ObjectName": "linker_contacts_companies",
                                       "LinkParentId": contactInfoDetail.id!,
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            self.requestAPI(input: json, tag: 5)
        }
    }
    func getOpenedActivities(){
        if contactInfoDetail == nil {
            return
        }
        let json: [String: Any] = ["PageOffset": 1,
                                   "ResultsPerPage": 5000,
                                   "IncludeAppointments": true,
                                   "IncludeTasks": true,
                                   "Invert": false,
                                   "ReturnTotal":true,
                                   "ForContacts":[contactInfoDetail.id!],
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        
        self.requestAPI(input: json, tag: 6)
        
        //getIncompleteActivitiesURL
    }
    func getClosedActivities(){
        if contactInfoDetail == nil {
            return
        }
        let json: [String: Any] = ["PageOffset": 1,
                                   "ResultsPerPage": 5000,
                                   "IncludeAppointments": true,
                                   "IncludeTasks": true,
                                   "Invert": true,
                                   "ReturnTotal":true,
                                   "ForContacts":[contactInfoDetail.id!],
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        
        self.requestAPI(input: json, tag: 7)
    }
    
    func setupContactInfo(){
        //contactInfoDetail
        if contactInfoDetail != nil {
            
            if contactInfoDetail.clientClassId != nil {
                self.clientClassID = contactInfoDetail.clientClassId
            }
            if contactInfoDetail.owningOrganizationUserId != nil {
                self.ownerID = contactInfoDetail.owningOrganizationUserId
            }
            if contactInfoDetail.spousePartnerID != nil {
                self.spouseID = contactInfoDetail.spousePartnerID
            }
            if contactInfoDetail.companyId != nil {
                self.companyID = contactInfoDetail.companyId
            }
            if contactInfoDetail.executorID != nil {
                self.executorID = contactInfoDetail.executorID
            }
            if contactInfoDetail.powerOfAttronyID != nil {
                self.powerAttroneyID = contactInfoDetail.powerOfAttronyID
            }
            
            var indexPath = IndexPath(row: 0, section: 1)
            if let cell:ContactFieldsCell = tableView.cellForRow(at: indexPath) as? ContactFieldsCell {
                cell1 = true
                cell.fieldTitle.text = contactInfoDetail.title
                cell.fieldFirstName.text = contactInfoDetail.firstName
                cell.fieldMiddleName.text = contactInfoDetail.middleName
                cell.fieldLastName.text = contactInfoDetail.lastName
                cell.fieldClientClass.text = contactInfoDetail.clientClassId
                cell.fieldSalutation.text = contactInfoDetail.salutation
                cell.fieldsuffix.text = contactInfoDetail.suffix
                cell.fieldNickName.text = contactInfoDetail.nickName
            }
            
            
            indexPath = IndexPath(row: 0, section: 3)
            if let cell1:WebAddressCell = tableView.cellForRow(at: indexPath) as? WebAddressCell {
                cell2 = true
                cell1.fieldEmail.text = contactInfoDetail.eMailAddress1
                cell1.fieldEmail2.text = contactInfoDetail.eMailAddress2
                cell1.fieldEmail3.text = contactInfoDetail.eMailAddress3
                cell1.fieldWebsite.text = contactInfoDetail.webSiteUrl
                cell1.fieldFtp.text = contactInfoDetail.ftpSiteUrl
            }
            
            
            indexPath = IndexPath(row: 0, section: 5)
            
            if let cell2:PhoneNumberCell = tableView.cellForRow(at: indexPath) as? PhoneNumberCell {
                cell3 = true
                
                cell2.fieldBusinessPhone.text = NavigationHelper.USPhoneFormat(number:contactInfoDetail.telephone1)
                cell2.fieldEveningPhone.text = NavigationHelper.USPhoneFormat(number:contactInfoDetail.telephone2)
                cell2.fieldAlternatePhone.text = NavigationHelper.USPhoneFormat(number:contactInfoDetail.telephone3)
                cell2.fieldMobilePhone.text = NavigationHelper.USPhoneFormat(number: contactInfoDetail.mobilePhone)
                cell2.fieldPager.text = contactInfoDetail.pager
                cell2.fieldFax.text = contactInfoDetail.fax
            }
            
            
            indexPath = IndexPath(row: 0, section: 7)
            if let cell3:AddressCell = tableView.cellForRow(at: indexPath) as? AddressCell {
                cell4 = true
                
                cell3.fieldAddress1.text = contactInfoDetail.addressLine1
                cell3.fieldAddress2.text = contactInfoDetail.addressLine2
                cell3.fieldAddress3.text = contactInfoDetail.addressLine3
                cell3.fieldCity.text = contactInfoDetail.city
                cell3.fieldState.text = contactInfoDetail.state
                cell3.fieldZip.text = contactInfoDetail.postal
                cell3.fieldCountry.text = contactInfoDetail.country
                cell3.fieldPOBox.text = contactInfoDetail.poBox
            }
            
            
            //Other contact information
            indexPath = IndexPath(row: 0, section: 9)
            if let cell4:OtherContactCell = tableView.cellForRow(at: indexPath) as? OtherContactCell {
                cell5 = true
                
                cell4.fieldGender.text = contactInfoDetail.gender
                
                if contactInfoDetail.privateField != nil {
                    if contactInfoDetail.privateField {
                        cell4.btnPrivate.setImage(UIImage.init(named:"ic_check"), for: .normal)
                    }
                }
                if contactInfoDetail.anniversay != nil {
                    cell4.fieldAnniversary.text = contactInfoDetail.anniversay.converDateToString()
                }
                if contactInfoDetail.clientSince != nil {
                    cell4.fieldClientSince.text = contactInfoDetail.clientSince.converDateToString()
                }
                if contactInfoDetail.BirthDate != nil {
                    cell4.fieldBirthDate.text = contactInfoDetail.BirthDate.converDateToString()
                }
                if contactInfoDetail.renewDate != nil {
                    cell4.fieldReviewDate.text = contactInfoDetail.renewDate.converDateToString()
                }
                if contactInfoDetail.licenseExpiry != nil {
                    cell4.fieldLicenseExpiry.text = contactInfoDetail.licenseExpiry.converDateToString()
                }
                
                cell4.clientLicenseNumber.text = contactInfoDetail.driversLicenseNumber
                cell4.fieldGovernmentID.text = contactInfoDetail.governmentIdent
                cell4.fieldOwner.text = contactInfoDetail.owningOrganizationUserId
                cell4.fieldDescription.text = contactInfoDetail.descriptionField
            }
            
            
            //Family
            indexPath = IndexPath(row: 0, section: 11)
            if let cell5:FamilyCell = tableView.cellForRow(at: indexPath) as? FamilyCell {
                cell6 = true
                
                cell5.fieldSpouse.text = contactInfoDetail.spousePartnerName
                cell5.fieldSpouse2.text = contactInfoDetail.spousePartnerID
                cell5.fieldMaritalStatus.text = contactInfoDetail.maritalStatus
                cell5.fieldDescription.text = contactInfoDetail.familyNotes
            }
            
            
            indexPath = IndexPath(row: 0, section: 13)
            if let cell6:OccupationCell = tableView.cellForRow(at: indexPath) as? OccupationCell {
                cell7 = true
                
                cell6.fieldCompanyName.text = contactInfoDetail.companyName
                cell6.fieldCompany.text = contactInfoDetail.companyId
                cell6.fieldAssistant.text = contactInfoDetail.assistantName
                cell6.fieldJobTitle.text = contactInfoDetail.jobTitle
                cell6.fieldDepartment.text = contactInfoDetail.department
                cell6.fieldAssistantPhone.text = contactInfoDetail.assistantPhone
                cell6.fieldDescription.text = contactInfoDetail.occupationNotes
            }
            
            
            
            indexPath = IndexPath(row: 0, section: 15)
            if let cell7:RecreationCell = tableView.cellForRow(at: indexPath) as? RecreationCell {
                cell8 = true
                
                cell7.fieldDescription.text = contactInfoDetail.recreationNotes
                
            }
            //Money
            indexPath = IndexPath(row: 0, section: 17)
            if let cell8:MoneyCell = tableView.cellForRow(at: indexPath) as? MoneyCell {
                cell9 = true
                
                cell8.fieldIncome.text = String(describing:contactInfoDetail.income ?? 0)
                cell8.fieldRevenue.text = String(describing:contactInfoDetail.revenue ?? 0)
                cell8.fieldCreditLimit.text = String(describing:contactInfoDetail.creditLimit ?? 0)
                cell8.fieldCreditOnHold.text = String(describing:contactInfoDetail.creditOnHold ?? 0)
                cell8.fieldExecutorName.text = contactInfoDetail.executorName
                cell8.fieldPowerName.text = contactInfoDetail.powerofAttorneyName
                cell8.fieldExecutor.text = contactInfoDetail.executorID
                
                cell8.fieldPowerAtroney.text = contactInfoDetail.powerOfAttronyID
                cell8.fieldGroupInsurance.text = contactInfoDetail.groupInsurance
                cell8.fieldGroupInsurancePlan.text = contactInfoDetail.groupPensionPlan
                cell8.fieldDescription.text = contactInfoDetail.moneyNotes
            }
            getContact()
            
            tableView.reloadData()
        }
        tableView.isUserInteractionEnabled = true
        
        
    }
    func saveContact(){
        //Contact
        var indexPath = IndexPath(row: 0, section: 1)
        let cell:ContactFieldsCell = tableView.cellForRow(at: indexPath) as! ContactFieldsCell
        
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(cell.fieldTitle.text!, forKey: "Title")
        dataObject.setValue(cell.fieldFirstName.text!, forKey: "FirstName")
        dataObject.setValue(cell.fieldMiddleName.text!, forKey: "MiddleName")
        dataObject.setValue(cell.fieldLastName.text!, forKey: "LastName")
        dataObject.setValue(cell.fieldSalutation.text!, forKey: "Salutation")
        dataObject.setValue(cell.fieldsuffix.text!, forKey: "Suffix")
        dataObject.setValue(cell.fieldNickName.text!, forKey: "NickName")
        dataObject.setValue(clientClassID, forKey: "ClientClassId")
        
        indexPath = IndexPath(row: 0, section: 3)
        let cell1:WebAddressCell = tableView.cellForRow(at: indexPath) as! WebAddressCell
        dataObject.setValue("", forKey: "EMailAddress1")
        dataObject.setValue("", forKey: "EMailAddress2")
        dataObject.setValue("", forKey: "EMailAddress3")
        
        if (cell1.fieldEmail.text?.count)! > 0 {
            if cell1.fieldEmail.text!.isValidEmail() {
                dataObject.setValue(cell1.fieldEmail.text!, forKey: "EMailAddress1")
            }else{
                NavigationHelper.showSimpleAlert(message:"Please enter a valid email ID")
                return
            }
        }
        if (cell1.fieldEmail2.text?.count)! > 0 {
            if cell1.fieldEmail2.text!.isValidEmail() {
                dataObject.setValue(cell1.fieldEmail2.text!, forKey: "EMailAddress2")
            }else{
                NavigationHelper.showSimpleAlert(message:"Please enter a valid email ID")
                return
            }
        }
        if (cell1.fieldEmail3.text?.count)! > 0 {
            if cell1.fieldEmail3.text!.isValidEmail() {
                dataObject.setValue(cell1.fieldEmail3.text!, forKey: "EMailAddress3")
            }else{
                NavigationHelper.showSimpleAlert(message:"Please enter a valid email ID")
                return
            }
        }
        dataObject.setValue(cell1.fieldWebsite.text!, forKey: "WebSiteUrl")
        dataObject.setValue(cell1.fieldFtp.text!, forKey: "FtpSiteUrl")
        
        
        indexPath = IndexPath(row: 0, section: 5)
        let cell2:PhoneNumberCell = tableView.cellForRow(at: indexPath) as! PhoneNumberCell
        dataObject.setValue(cell2.fieldBusinessPhone.text!, forKey: "Telephone1")
        dataObject.setValue(cell2.fieldEveningPhone.text!, forKey: "Telephone2")
        dataObject.setValue(cell2.fieldAlternatePhone.text!, forKey: "Telephone3")
        dataObject.setValue(cell2.fieldMobilePhone.text!, forKey: "MobilePhone")
        dataObject.setValue(cell2.fieldPager.text!, forKey: "Pager")
        dataObject.setValue(cell2.fieldFax.text!, forKey: "Fax")
        
        
        indexPath = IndexPath(row: 0, section: 7)
        let cell3:AddressCell = tableView.cellForRow(at: indexPath) as! AddressCell
        
        dataObject.setValue(cell3.fieldAddress1.text!, forKey: "AddressLine1")
        dataObject.setValue(cell3.fieldAddress2.text!, forKey: "AddressLine2")
        dataObject.setValue(cell3.fieldAddress3.text!, forKey: "AddressLine3")
        dataObject.setValue(cell3.fieldCity.text!, forKey: "City")
        dataObject.setValue(cell3.fieldState.text!, forKey: "State")
        dataObject.setValue(cell3.fieldZip.text!, forKey: "Postal")
        dataObject.setValue("", forKey: "Country")
        dataObject.setValue(cell3.fieldPOBox.text!, forKey: "PoBox")
        
        //Other contact information
        indexPath = IndexPath(row: 0, section: 9)
        let cell4:OtherContactCell = tableView.cellForRow(at: indexPath) as! OtherContactCell
        
        if cell4.btnPrivate.currentImage == UIImage.init(named:"ic_check") {
            dataObject.setValue(true, forKey: "Private")
        }
        
        dataObject.setValue(cell4.fieldGender.text!, forKey: "Gender")
        
        if (cell4.fieldAnniversary.text?.count)! > 0 {
            dataObject.setValue(cell4.fieldAnniversary.text! + "T06:30:00.000Z", forKey: "Anniversary")
        }else{
            dataObject.setValue("", forKey: "Anniversary")
        }
        if (cell4.fieldClientSince.text?.count)! > 0 {
            dataObject.setValue(cell4.fieldClientSince.text! + "T06:30:00.000Z", forKey: "ClientSince")
        }else{
            dataObject.setValue("", forKey: "ClientSince")
        }
        dataObject.setValue(cell4.clientLicenseNumber.text!, forKey: "DriversLicenseNumber")
        dataObject.setValue(cell4.fieldGovernmentID.text!, forKey: "GovernmentIdent")
        
        
        
        if (cell4.fieldBirthDate.text?.count)! > 0 {
            dataObject.setValue(cell4.fieldBirthDate.text! + "T06:30:00.000Z", forKey: "BirthDate")
        }else{
            dataObject.setValue("", forKey: "BirthDate")
        }
        
        if (cell4.fieldReviewDate.text?.count)! > 0 {
            dataObject.setValue(cell4.fieldReviewDate.text! + "T06:30:00.000Z", forKey: "ReviewDate")
        }else{
            dataObject.setValue("", forKey: "ReviewDate")
        }
        
        if (cell4.fieldLicenseExpiry.text?.count)! > 0 {
            dataObject.setValue(cell4.fieldLicenseExpiry.text! + "T06:30:00.000Z", forKey: "DriversLicenseExpiry")
        }else{
            dataObject.setValue("", forKey: "DriversLicenseExpiry")
        }
        
        dataObject.setValue(ownerID, forKey: "OwningOrganizationUserId")
        
        dataObject.setValue(cell4.fieldDescription.text!, forKey: "Description")
        
        
        //Family
        indexPath = IndexPath(row: 0, section: 11)
        let cell5:FamilyCell = tableView.cellForRow(at: indexPath) as! FamilyCell
        dataObject.setValue(cell5.fieldSpouse.text!, forKey: "SpousePartnerName")
        dataObject.setValue(cell5.fieldDescription.text!, forKey: "FamilyNotes")
        dataObject.setValue(spouseID, forKey: "SpousePartnerId")
        dataObject.setValue(cell5.fieldMaritalStatus.text!, forKey: "MaritalStatus")
        
        //Occupation
        indexPath = IndexPath(row: 0, section: 13)
        let cell6:OccupationCell = tableView.cellForRow(at: indexPath) as! OccupationCell
        dataObject.setValue(cell6.fieldCompanyName.text!, forKey: "CompanyName")
        dataObject.setValue(companyID, forKey: "CompanyId")
        
        dataObject.setValue(cell6.fieldAssistant.text!, forKey: "AssistantName")
        dataObject.setValue(cell6.fieldDescription.text!, forKey: "OccupationNotes")
        dataObject.setValue(cell6.fieldJobTitle.text!, forKey: "JobTitle")
        dataObject.setValue(cell6.fieldDepartment.text!, forKey: "Department")
        dataObject.setValue(cell6.fieldAssistantPhone.text!, forKey: "AssistantPhone")
        
        
        //Recreation
        indexPath = IndexPath(row: 0, section: 15)
        let cell7:RecreationCell = tableView.cellForRow(at: indexPath) as! RecreationCell
        dataObject.setValue(cell7.fieldDescription.text!, forKey: "RecreationNotes")
        
        //Money
        indexPath = IndexPath(row: 0, section: 17)
        let cell8:MoneyCell = tableView.cellForRow(at: indexPath) as! MoneyCell
        
        var incomeValue:Int = 0
        if (cell8.fieldIncome.text?.count)! > 0 {
            incomeValue = Int(cell8.fieldIncome.text!)!
        }
        
        var creditValue:Int = 0
        if (cell8.fieldCreditLimit.text?.count)! > 0 {
            creditValue = Int(cell8.fieldCreditLimit.text!)!
        }
        var revenueValue:Int = 0
        if (cell8.fieldRevenue.text?.count)! > 0 {
            revenueValue = Int(cell8.fieldRevenue.text!)!
        }
        var creditHoldValue:Int = 0
        if (cell8.fieldCreditOnHold.text?.count)! > 0 {
            creditHoldValue = Int(cell8.fieldCreditOnHold.text!)!
        }
        
        dataObject.setValue(incomeValue, forKey: "Income")
        dataObject.setValue(creditValue, forKey: "CreditLimit")
        dataObject.setValue(revenueValue, forKey: "Revenue")
        dataObject.setValue(creditHoldValue, forKey: "CreditOnHold")
        dataObject.setValue(cell8.fieldExecutorName.text!, forKey: "ExecutorName")
        dataObject.setValue(cell8.fieldPowerName.text!, forKey: "PowerofAttorneyName")
        dataObject.setValue(cell8.fieldGroupInsurance.text!, forKey: "GroupInsurance")
        dataObject.setValue(cell8.fieldGroupInsurancePlan.text!, forKey: "GroupPensionPlan")
        dataObject.setValue(cell8.fieldDescription.text!, forKey: "MoneyNotes")
        dataObject.setValue(executorID, forKey: "ExecutorId")
        dataObject.setValue(powerAttroneyID, forKey: "PowerofAttorneyId")
        print(dataObject)
        
        
        var mainURL:String = createContact
        
        
        
        
        if contactInfoDetail != nil {
            mainURL = modifyURL
            dataObject.setValue(contactInfoDetail.id, forKey: "Id")
        }
        
        let json: [String: Any] = ["ObjectName": "contact",
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID,
                                   "DataObject":dataObject]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: mainURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                OperationQueue.main.addOperation {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
        
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
extension CreateContactController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.placeholder!)
        print(textField.tag)
        if textField.tag == 5 {
            getClientClass(textField: textField)
            textField.resignFirstResponder()
        }else if textField.tag == 10 {
            showPicker(pickerTag: 1, textField: textField)
        }else if textField.tag == 15 {
            showPicker(pickerTag: 2, textField: textField)
        }else if textField.tag == 20 {
            getOwnerList(textField: textField)
        }else if textField.tag == 25 {
            getSpouseContactList(tag: 4, textField: textField)
        }else if textField.tag == 30 {
            showPicker(pickerTag: 5, textField: textField)
        }else if textField.tag == 38 {
            getCompanyList(textField: textField)
        }else if textField.tag == 35 {
            getSpouseContactList(tag: 7, textField: textField)
        }else if textField.tag == 40 {
            getSpouseContactList(tag: 8, textField: textField)
        }else if textField.tag == 45 {
            showCustomPicker(textfield: textField, title: "Anniversary")
        }else if textField.tag == 50 {
            showCustomPicker(textfield: textField, title: "Birthday")
        }else if textField.tag == 55 {
            showCustomPicker(textfield: textField, title: "Client Since")
        }else if textField.tag == 60 {
            showCustomPicker(textfield: textField, title: "Review Date")
        }else if textField.tag == 65 {
            showCustomPicker(textfield: textField, title: "License Expiry")
        }
    }
}

extension CreateContactController {
    func showCustomPicker(textfield:UITextField,title:String){
        DPPickerManager.shared.showPicker(title: title, selected: Date(), min: nil, max: nil) { (date, cancel) in
            if !cancel {
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd"
                textfield.text = formatter.string(from: date!)
            }
        }
    }
    func showPicker(pickerTag:Int,textField:UITextField){
        
        var pickerData:NSMutableArray = []
        var pickerTitle:String = ""
        
        if pickerTag == 0 {
            pickerTitle = "Client Class"
            if getClientClassModel.valid {
                let result:[GetClientClassResult] = getClientClassModel.results
                for index in 0..<result.count {
                    pickerData.add(result[index].name!)
                }
            }
        }else if pickerTag == 1 {
            pickerTitle = "Country"
            pickerData = []
            for code in NSLocale.isoCountryCodes as [String] {
                let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
                pickerData.add(name)
            }
        }else if pickerTag == 2 {
            pickerTitle = "Gender"
            pickerData = ["N/A","Male","Female","Other"]
        }else if pickerTag == 3 {
            pickerTitle = "Owner"
            if getOwnersListModel.valid {
                let result:[GetOwnersListResult] = getOwnersListModel.results
                for index in 0..<result.count {
                    pickerData.add(result[index].fullName!)
                }
            }
        }else if pickerTag == 4 {
            pickerTitle = "Spouse"
            if getSpouseContactListModel.valid {
                let result:[GetSpouseContactResult] = getSpouseContactListModel.results
                for index in 0..<result.count {
                    pickerData.add(result[index].fullName!)
                }
            }
        }else if pickerTag == 5 {
            pickerTitle = "Marital Status"
            pickerData = ["Single","Married","Seperated","Divorced","Widowed"]
        }else if pickerTag == 6 {
            pickerTitle = "Company"
            if getCompanyListModel.valid {
                let result:[GetCompanyListResult] = getCompanyListModel.results
                for index in 0..<result.count {
                    pickerData.add(result[index].name!)
                }
            }
        }else if pickerTag == 7 {
            pickerTitle = "Executor"
            if getSpouseContactListModel.valid {
                let result:[GetSpouseContactResult] = getSpouseContactListModel.results
                for index in 0..<result.count {
                    pickerData.add(result[index].fullName!)
                }
            }
        }else if pickerTag == 8 {
            pickerTitle = "Power of Attorney"
            if getSpouseContactListModel.valid {
                let result:[GetSpouseContactResult] = getSpouseContactListModel.results
                for index in 0..<result.count {
                    pickerData.add(result[index].fullName!)
                }
            }
        }
        PickerDialog().show(title: pickerTitle, options: pickerData) { (value, index) in
            print("Unit selected: \(value)")
            textField.text = value
            if pickerTag == 0 {
                if self.getClientClassModel.valid {
                    let result:[GetClientClassResult] = self.getClientClassModel.results
                    self.clientClassID = result[index].id
                }
            }else if pickerTag == 3 {
                if self.getOwnersListModel.valid {
                    let result:[GetOwnersListResult] = self.getOwnersListModel.results
                    self.ownerID = result[index].id
                }
            }else if pickerTag == 4 {
                if self.getSpouseContactListModel.valid {
                    let result:[GetSpouseContactResult] = self.getSpouseContactListModel.results
                    self.spouseID = result[index].id
                }
            }else if pickerTag == 6 {
                if self.getCompanyListModel.valid {
                    let result:[GetCompanyListResult] = self.getCompanyListModel.results
                    self.companyID = result[index].id
                }
            }else if pickerTag == 7 {
                if self.getSpouseContactListModel.valid {
                    let result:[GetSpouseContactResult] = self.getSpouseContactListModel.results
                    self.executorID = result[index].id
                }
            }else if pickerTag == 8 {
                if self.getSpouseContactListModel.valid {
                    let result:[GetSpouseContactResult] = self.getSpouseContactListModel.results
                    self.powerAttroneyID = result[index].id
                }
            }
        }
    }
}
extension CreateContactController:URLSessionDelegate {
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
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
extension String {
    func convertYearMonthDatehourMin12() -> String{
        if self.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy-MM-dd" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    
    func convertminss() -> String{
        if self.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "hh:mm a" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    
    func convertYearMonthDatehourMinn() -> String{
        if self.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    func convertYearMonthDatehourMin() -> String{
        if self.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm a" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    func convertYearMonthDate() -> String{
        if self.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy-MM-dd" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    func converDateDayToString() -> String{
        if self.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "EEE dd MMM yyy" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
    func converDateToString() -> String{
        if self.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
}
extension String {
    func converTimeToString() -> String{
        if self.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "hh:mm" ; //"dd-MM-yyyy HH:mm:ss"
            dateFormatter.locale = tempLocale // reset the locale --> but no need here
            let dateString = dateFormatter.string(from: date)
            print("EXACT_DATE : \(dateString)")
            return dateString
        }
        return ""
    }
}
