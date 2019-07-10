//
//  NewAccountsController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 18/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class NewAccountsController: UIViewController {
    
    var isfromcontactPAge:Bool = false
    var rightContactID:String = ""
    var contactAdd:Bool = false
    
    @IBOutlet weak var tblAccount: UITableView!
    var contactInfoDetail:GetAccountsListResult!
    var getSpouseContactListModel:GetSpouseContactModel!
    var primaryContactID:String = ""
    var countryCode:String = "+1"
    var ObjectId : String = ""
    var selecyedAdditioanlAddressIDList:[String] = []
    var selectedLinkedAccountIDList:[String] = []

    var selectedIndexPath_condition:Int = 0
    
    var primaryContactArray : [String] = []
    var SelectedPrimaryContact : String!
    
    var resultsArray : [JSON] = []
    var linkcontactArray : [String] = []
    
    var resultsaddressArray : [JSON] = []
    var linkaddressArray : [String] = []

    var selectedIndexPath:Int = 1992001
    var isExpand:Bool = false
    var headerTitles:[String] = ["Additional Addresses","Linked Contacts","Open Activities","Completed Activities"]
    var getAddtionalAddressesModel:[getSearchResultResult] = []
    var getLinkedAccountModel:[getCompanyListResult] = []

    var additionalResult:[GetAdditionalAddressResult] = []
    var getLinkedAccountsResult:[GetLinkedAccountsResult] = []
    var getOpenedActivitiesResult:[GetIncompleteActivity] = []
    var getCompleteActivitiesResult:[GetCompleteActivity] = []
    var bottomView = UIView()
    var editBtn = UIButton()
    var closeBtn = UIButton()
    var customView = UIView()
    var isEditable:Bool = false
    var barButton: UIButton!
    var actionBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCustomView()

        if isfromcontactPAge {
            isEditable = true
            print(rightContactID)
        }
        
        closeBtn.isUserInteractionEnabled = true
        actionBtn.isUserInteractionEnabled = true
        editBtn.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var fullWidth = UIScreen.main.bounds.width
        fullWidth = fullWidth / 3 - 15
        
        let btnOneX:CGFloat = 20
        let btnTwoX:CGFloat = btnOneX + 5 + fullWidth
        let btnThirdX:CGFloat = btnTwoX + 5 + fullWidth
        print(btnOneX)
        print(btnTwoX)
        print(btnThirdX)
        
        
        bottomView.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height - 67, width: UIScreen.main.bounds.width, height: 67)
        bottomView.backgroundColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        //edit btn (x: btnOneX, y: 5.0, width: fullWidth, height: 30)
        // Close (x: btnThirdX, y: 5.0, width: fullWidth, height: 30)
        //action (x: btnOneX, y: 5.0, width: fullWidth, height: 30)
        
        editBtn.frame = CGRect(x: 15, y: 9.0, width: 168, height: 38)
        editBtn.backgroundColor = UIColor.white
        editBtn.setTitleColor(UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
        editBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        
        if contactInfoDetail == nil {
            editBtn.setTitle("Close", for: .normal)
            self.editBtn.removeTarget(nil, action: nil, for: .allEvents)
            
            editBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchDown)
        }else{
            if isEditable {
                if contactInfoDetail != nil {
                    self.title = "Edit Account"
                    self.removeCustomView()
                }
                
                //                editBtn.setTitle("Save", for: .normal)
                //                self.editBtn.removeTarget(nil, action: nil, for: .allEvents)
                //
                //                editBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
            }else{
                if contactInfoDetail != nil {
                    self.title = contactInfoDetail.name
                    self.setupCustomView()
                }
                
                //                editBtn.setTitle("Edit", for: .normal)
                //                self.editBtn.removeTarget(nil, action: nil, for: .allEvents)
                //
                //                editBtn.addTarget(self, action: #selector(tappedEdit(_:)), for: .touchDown)
            }
        }
        bottomView.addSubview(editBtn)
        
        closeBtn.frame = CGRect(x: UIScreen.main.bounds.width-182, y: 9.0, width: 168, height: 38)
        closeBtn.backgroundColor = UIColor.white
        closeBtn.setTitleColor(UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
        closeBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        
        if contactInfoDetail == nil {
            if contactInfoDetail != nil {
                self.title = "Edit Account"
                self.removeCustomView()
            }
            
            closeBtn.setTitle("Save", for: .normal)
            closeBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
        }else{
//            closeBtn.setTitle("Close", for: .normal)
//            closeBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchDown)
            closeBtn.removeTarget(nil, action: nil, for: .allEvents)
            closeBtn.setTitle("Actions", for: .normal)
            closeBtn.addTarget(self, action: #selector(tappedAction(_:)), for: .touchDown)
        }
        bottomView.addSubview(closeBtn)
        
        if contactInfoDetail != nil {
            actionBtn.frame = CGRect(x: 15, y: 9.0, width: 168, height: 38)
            actionBtn.backgroundColor = UIColor.white
            actionBtn.setTitleColor(UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
            actionBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
            
            if isEditable {
                actionBtn.removeTarget(nil, action: nil, for: .allEvents)
                actionBtn.setTitle("Save", for: .normal)
                actionBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
            }else{
                //Thabresh
                actionBtn.removeTarget(nil, action: nil, for: .allEvents)
                actionBtn.setTitle("Close", for: .normal)
                actionBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchDown)

                
//                actionBtn.setTitle("Actions", for: .normal)
//                actionBtn.addTarget(self, action: #selector(tappedAction(_:)), for: .touchDown)
            }
            self.title = "Account"

            //            actionBtn.setTitle("Action", for: .normal)
            //            actionBtn.addTarget(self, action: #selector(tappedAction(_:)), for: .touchDown)
            
            bottomView.addSubview(actionBtn)
        }
        if isfromcontactPAge {
            self.title = "New Account"
        }
        self.navigationController?.view.addSubview(bottomView)
    }
    @IBAction func tappedBack(_ sender: Any) {
        if isEditable && contactInfoDetail == nil {
            self.navigationController?.popViewController(animated: true)
            return
        }
        if isEditable {
            self.isEditable = false
            self.editBtn.setTitle("Edit", for: .normal)
            self.editBtn.removeTarget(nil, action: nil, for: .allEvents)
            self.editBtn.addTarget(self, action: #selector(self.tappedEdit(_:)), for: .touchDown)
            
            
            self.actionBtn.removeTarget(nil, action: nil, for: .allEvents)
            
            self.actionBtn.setTitle("Actions", for: .normal)
            self.actionBtn.addTarget(self, action: #selector(self.tappedAction(_:)), for: .touchDown)
            
            setupCustomView()
            
            self.tblAccount.reloadData()
            
//            let indexPath = IndexPath(row: 0, section: 0)
//            let cell:CreateAccountsCell = tblAccount.cellForRow(at: indexPath) as! CreateAccountsCell
//            cell.fieldName.text = contactInfoDetail.name
//            cell.fieldLegalName.text = contactInfoDetail.legalName
//            cell.fieldDescription.text = contactInfoDetail.descriptionField
//
//            cell.fieldPrimaryPhone.text = contactInfoDetail.telephone1
//            cell.fieldSecondaryName.text = contactInfoDetail.telephone2
//            cell.fieldMobilePhone.text = contactInfoDetail.mobilePhone
//            cell.fieldOtherPhone.text = contactInfoDetail.telephone3
//
//            cell.fieldFax.text = contactInfoDetail.fax
//            cell.fieldPager.text = contactInfoDetail.pager
//
//            cell.addressLine1.text = contactInfoDetail.addressLine1
//            cell.addressLine2.text = contactInfoDetail.addressLine2
//            cell.addressLine3.text = contactInfoDetail.addressLine3
//            cell.fieldCity.text = contactInfoDetail.city
//            cell.fieldCountry.text = contactInfoDetail.country
//            cell.fieldPostal.text = contactInfoDetail.postal
//            cell.fieldPOBox.text = contactInfoDetail.poBox
//            cell.fieldState.text = contactInfoDetail.state
//
//            cell.fieldEmail1.text = contactInfoDetail.eMailAddress1
//            cell.fieldEmail2.text = contactInfoDetail.eMailAddress2
//            cell.fieldEmail3.text = contactInfoDetail.eMailAddress3
//            cell.fieldWebsite.text = contactInfoDetail.webSiteUrl
//            cell.fieldFTPSite.text = contactInfoDetail.ftpSiteUrl
//
//            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    func setupCustomView(){
        
        if contactInfoDetail == nil {
            return
        }
        self.navigationItem.titleView?.isHidden = false
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        print(topBarHeight)
        
        customView = UIView()
        customView.frame = CGRect(x: 50.0, y: 0, width: UIScreen.main.bounds.width - 50, height: topBarHeight)
        customView.backgroundColor = UIColor.clear
        
        barButton = UIButton.init(type: .custom)
        //set image for button
        barButton.setImage(UIImage(named: "ic_pencil"), for: UIControlState.normal)
        //add function for button
        barButton.addTarget(self, action:  #selector(tappedEdit(_:)), for: UIControlEvents.touchUpInside)
        //set frame
        barButton.frame = CGRect(x: customView.bounds.width - 40, y: 8.0, width: 25, height: 25)
        
        customView.addSubview(barButton)
        
        if contactInfoDetail.legalName == nil {
            let lblUsername = UILabel()
            lblUsername.frame =  CGRect(x: 0.0, y: 10.0, width: customView.bounds.width - 50, height: 22)
            lblUsername.text = contactInfoDetail.name!
            lblUsername.textAlignment = .center
            lblUsername.textColor = UIColor.white
            lblUsername.font = UIFont(name: "Raleway-Bold", size: 18.0)!
            customView.addSubview(lblUsername)
            self.navigationItem.titleView = customView
            return
        }
        
        let lblUsername = UILabel()
        lblUsername.frame =  CGRect(x: 0.0, y: 0, width: customView.bounds.width - 50, height: 22)
        lblUsername.text = contactInfoDetail.name!
        lblUsername.textAlignment = .center
        lblUsername.textColor = UIColor.white
        lblUsername.font = UIFont(name: "Raleway-Bold", size: 18.0)!
        customView.addSubview(lblUsername)
        
        let lblCompany = UILabel()
        lblCompany.frame =  CGRect(x: 0.0, y: 22, width: customView.bounds.width - 50, height: 22)
        lblCompany.text = contactInfoDetail.legalName!
        lblCompany.textAlignment = .center
        lblCompany.textColor = UIColor.white
        lblCompany.font = UIFont(name: "Raleway-Regular", size: 15.0)!
        customView.addSubview(lblCompany)
        
        self.navigationItem.titleView = customView
    }
        
    
    func removeCustomView(){
        if contactInfoDetail == nil {
            return
        }
        
        self.navigationItem.titleView?.isHidden = false
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        print(topBarHeight)
        
        customView = UIView()
        customView.frame = CGRect(x: 50.0, y: 0, width: UIScreen.main.bounds.width - 50, height: topBarHeight)
        customView.backgroundColor = UIColor.clear
        
        let lblUsername = UILabel()
        lblUsername.frame =  CGRect(x: 0.0, y: 10.0, width: customView.bounds.width - 50, height: 22)
        lblUsername.text = "Edit Account"
        lblUsername.textAlignment = .center
        lblUsername.textColor = UIColor.white
        lblUsername.font = UIFont(name: "Raleway-Bold", size: 18.0)!
        customView.addSubview(lblUsername)
        
        self.navigationItem.titleView = customView
    }
    @IBAction func tappedEdit(_ sender: Any) {
        isEditable = true
        
        if contactInfoDetail != nil {
            self.title = "Edit Account"
            self.removeCustomView()
        }
        
        actionBtn.removeTarget(nil, action: nil, for: .allEvents)
        actionBtn.setTitle("Close", for: .normal)
        actionBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchDown)
        
        editBtn.removeTarget(nil, action: nil, for: .allEvents)
        editBtn.setTitle("Save1", for: .normal)
        editBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
        
        closeBtn.removeTarget(nil, action: nil, for: .allEvents)
        closeBtn.setTitle("Save", for: .normal)
        closeBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)

        tblAccount?.visibleCells.forEach { cell in
            if let cell = cell as? CreateAccountsCell {
                cell.checkIfEditable(value: isEditable)
            }
        }
        
    }
    
    @IBAction func tappedClose(_ sender: Any) {
        if contactAdd{
            self.navigationController?.popViewController(animated: true)
            return
        }
        if isEditable && contactInfoDetail == nil {
            self.navigationController?.popViewController(animated: true)
            return
        }
        if isEditable {
            self.isEditable = false
            editBtn.setTitle("Close", for: .normal)
            self.editBtn.removeTarget(nil, action: nil, for: .allEvents)
            
            editBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchDown)
            
            self.closeBtn.removeTarget(nil, action: nil, for: .allEvents)
            self.closeBtn.setTitle("Actions", for: .normal)
            self.closeBtn.addTarget(self, action: #selector(self.tappedAction(_:)), for: .touchDown)
            
            self.actionBtn.removeTarget(nil, action: nil, for: .allEvents)
            
            self.actionBtn.setTitle("Close", for: .normal)
            self.actionBtn.addTarget(self, action: #selector(self.tappedClose(_:)), for: .touchDown)
            
            let indexPath = IndexPath(row: 0, section: 0)
            self.tblAccount.scrollToRow(at: indexPath, at: .top, animated: false)
            setupCustomView()

            self.tblAccount.reloadData()
            return
        }
        self.navigationController?.popViewController(animated: true)
    }
    func reloadContact(){
        
        
        let json: [String: Any] = ["ObjectName": "company",
                                   "ObjectId": contactInfoDetail.id!,
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                
                print(json)
                let contactModel = GetAccountsListResult.init(fromDictionary: (jsonResponse["DataObject"] as! NSDictionary) as! [String : Any])
                self.contactInfoDetail = contactModel
                self.viewWillAppear(true)
                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
        
    }
    @IBAction func tappedAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        let sendButton = UIAlertAction(title: "Apply Process", style: .default, handler: { (action) -> Void in
            let controller:NewAppliedProcess = self.storyboard?.instantiateViewController(withIdentifier:  "NewAppliedProcess") as! NewAppliedProcess
            controller.conditionType = "Account"
            controller.isFromAccount = true
            controller.contactInfoDetail = self.contactInfoDetail
            self.navigationController?.pushViewController(controller, animated: true)
        })
        let Reload = UIAlertAction(title: "Add Activity", style: .default, handler: { (action) -> Void in
            let alertController1 = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
            let Appointment = UIAlertAction(title: "New Appointment", style: .default, handler: { (action) -> Void in
                let controller:NewAppointmentsController = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentsController") as? NewAppointmentsController)!
                controller.linkParentID = self.contactInfoDetail.id!
                controller.accountname = self.contactInfoDetail.name!
                controller.fromAccounts = true
                self.navigationController?.pushViewController(controller, animated: true)
            })
            let Task = UIAlertAction(title: "New Task", style: .default, handler: { (action) -> Void in
                let controller:NewTaskController = (self.storyboard?.instantiateViewController(withIdentifier: "NewTaskController") as? NewTaskController)!
                controller.linkParentID = self.contactInfoDetail.id!
                controller.accountname = self.contactInfoDetail.name!
                controller.fromAccounts = true
                self.navigationController?.pushViewController(controller, animated: true)
            })
            let Recurrence = UIAlertAction(title: "New Recurrence", style: .default, handler: { (action) -> Void in
                let controller:CreateRecurrencePattern = (self.storyboard?.instantiateViewController(withIdentifier: "CreateRecurrencePattern") as? CreateRecurrencePattern)!
                controller.linkParentID = self.contactInfoDetail.id!
                controller.accountname = self.contactInfoDetail.name!
                controller.fromAccounts = true
                self.navigationController?.pushViewController(controller, animated: true)
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                print("Cancel button tapped")
            })
            alertController1.addAction(Appointment)
            alertController1.addAction(Task)
            alertController1.addAction(Recurrence)
            alertController1.addAction(cancelButton)
            
            self.navigationController?.present(alertController1, animated: true, completion: nil)
            
        })
        let changeHistory = UIAlertAction(title: "Change History", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            
            //            self.historyBG.frame = self.view.frame
            //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //            appDelegate.window?.addSubview(self.historyBG)
            //
            //            self.getChangeHistory()
            // self.view.addSubview(createView)
        })
        let closeButton = UIAlertAction(title: "Close", style: .default, handler: { (action) -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        
        let ReloadButton = UIAlertAction(title: "Reload", style: .default, handler: { (action) -> Void in
        })
        let deleteButton = UIAlertAction(title: "Delete", style: .default, handler: { (action) -> Void in
            DispatchQueue.main.async(execute: {
                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                    print(index,title)
                    if title == "Yes" {
                       self.deleteInviteUser(contactID: self.contactInfoDetail.id!)
                    }
                })
            })
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alertController.addAction(Reload)
        alertController.addAction(sendButton)
        
        alertController.addAction(ReloadButton)
        alertController.addAction(closeButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // tblAccount.setContentOffset(.zero, animated: false)
        tblAccount.reloadData()
       
        let indexPath = IndexPath(row: 0, section: 0)
        self.tblAccount.scrollToRow(at: indexPath, at: .top, animated: false)

        setupBasicInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        selectedIndexPath = 1992001
        isExpand = false
        
        
        tblAccount.setContentOffset(.zero, animated: false)
        tblAccount.reloadData()
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.tblAccount.scrollToRow(at: indexPath, at: .top, animated: false)
    
        bottomView.removeFromSuperview()
    }
    
    func deleteInviteUser(contactID : String){
        var objectname = ""
        print(contactInfoDetail.primaryContactId!)
        if((contactInfoDetail.primaryContactId != "<null>") && (contactInfoDetail.primaryContactId != "")){
           objectname = "contact"
        }
        else{
            objectname = "company"
        }
        let parameters = [
            "ObjectName": objectname,
            "ObjectId": contactID,
            "OrganizationId": currentOrgID,
            "PassKey": passKey
            ] as [String : Any]
        
        APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/delete.json", parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let response : String = json["ResponseMessage"].string!
                DispatchQueue.main.async(execute: {
                    if(response == "success"){
                    AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Deleted") { (index, title) in
                        OperationQueue.main.addOperation {
                            self.navigationController?.popViewController(animated:true)
                        }
                    }
                    }
                    else{
                         NavigationHelper.showSimpleAlert(message:response)
                    }
                    
                })
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
  
    
    func setupBasicInfo(){
        if contactInfoDetail != nil {
            
            self.title = "Edit Account"
            tblAccount.reloadData()
            let indexPath = IndexPath(row: 0, section: 0)
            let cell:CreateAccountsCell = tblAccount.cellForRow(at: indexPath) as! CreateAccountsCell
            
            if(contactInfoDetail.telephone1 != ""){
            cell.fieldPrimaryPhone.text = contactInfoDetail.telephone1.count > 0 ? contactInfoDetail.telephone1 : ""
            }
            else{
                cell.fieldPrimaryPhone.text = countryCode
            }
            if(contactInfoDetail.telephone2 != ""){
            cell.fieldSecondaryName.text = contactInfoDetail.telephone2.count > 0 ? contactInfoDetail.telephone2 : ""
            }
            else{
                cell.fieldSecondaryName.text = countryCode
            }

            cell.fieldName.text = contactInfoDetail.name
            cell.fieldLegalName.text = contactInfoDetail.legalName
            cell.fieldDescription.text = contactInfoDetail.descriptionField
            
            if(contactInfoDetail.mobilePhone != ""){
                 cell.fieldMobilePhone.text = contactInfoDetail.mobilePhone
            }
            else{
                cell.fieldMobilePhone.text = countryCode
            }
            if(contactInfoDetail.telephone3 != ""){
            cell.fieldOtherPhone.text = contactInfoDetail.telephone3
            }
            else{
                cell.fieldOtherPhone.text = countryCode
            }

            
            cell.fieldFax.text = contactInfoDetail.fax
            cell.fieldPager.text = contactInfoDetail.pager
            
            cell.addressLine1.text = contactInfoDetail.addressLine1
            cell.addressLine2.text = contactInfoDetail.addressLine2
            cell.addressLine3.text = contactInfoDetail.addressLine3
            cell.fieldCity.text = contactInfoDetail.city
            cell.fieldCountry.text = contactInfoDetail.country
            cell.fieldPostal.text = contactInfoDetail.postal
            cell.fieldPOBox.text = contactInfoDetail.poBox
            cell.fieldState.text = contactInfoDetail.state
            
            cell.fieldEmail1.text = contactInfoDetail.eMailAddress1
            cell.fieldEmail2.text = contactInfoDetail.eMailAddress2
            cell.fieldEmail3.text = contactInfoDetail.eMailAddress3
            cell.fieldWebsite.text = contactInfoDetail.webSiteUrl
            cell.fieldFTPSite.text = contactInfoDetail.ftpSiteUrl
            cell.fieldPrimaryContct.text = contactInfoDetail.primaryContactId
            if contactInfoDetail.primaryContactId != nil {
                
                primaryContactID = contactInfoDetail.primaryContactId
                
                if contactInfoDetail.primaryContactId.count > 0 {
                    let parameter:[String:Any] = ["SearchTerm":"",
                                                  "ObjectName":"contact",
                                                  "PassKey":passKey,
                                                  "OrganizationId":currentOrgID,
                                                  "PageOffset": 1,
                                                  "ResultsPerPage": 5000]
                    requestAPICall(input: parameter, tag: 1, textField: cell.fieldPrimaryContct)
                }else{
                    getAdditionalAddress()
                }
                
            }else{
                getAdditionalAddress()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tappedSave(_ sender: Any) {
        if checkValidation(){
            actionBtn.isUserInteractionEnabled = false
            editBtn.isUserInteractionEnabled = false
            
            let indexPath = IndexPath(row: 0, section: 0)
            let cell:CreateAccountsCell = tblAccount.cellForRow(at: indexPath) as! CreateAccountsCell
            
            let dataObject:NSMutableDictionary = [:]
            dataObject.setValue(cell.fieldName.text!, forKey: "Name")
            dataObject.setValue(cell.fieldLegalName.text!, forKey: "LegalName")
            dataObject.setValue(cell.fieldDescription.text!, forKey: "Description")
            dataObject.setValue(cell.fieldEmail1.text!, forKey: "EMailAddress1")
            dataObject.setValue(cell.fieldEmail2.text!, forKey: "EMailAddress2")
            dataObject.setValue(cell.fieldEmail3.text!, forKey: "EMailAddress3")
            dataObject.setValue(cell.fieldWebsite.text!, forKey: "WebSiteUrl")
            dataObject.setValue(cell.fieldFTPSite.text!, forKey: "FtpSiteUrl")
            dataObject.setValue(cell.fieldMobilePhone.text!, forKey: "MobilePhone")
            dataObject.setValue(cell.fieldPager.text!, forKey: "Pager")
            dataObject.setValue(cell.fieldFax.text!, forKey: "Fax")
            dataObject.setValue(cell.fieldPrimaryPhone.text!, forKey: "Telephone1")
            dataObject.setValue(cell.fieldSecondaryName.text!, forKey: "Telephone2")
            dataObject.setValue(cell.fieldOtherPhone.text!, forKey: "Telephone3")
            dataObject.setValue("", forKey: "LetterheadLogoId")
            dataObject.setValue(primaryContactID, forKey: "PrimaryContactId")
            dataObject.setValue(cell.addressLine1.text!, forKey: "AddressLine1")
            dataObject.setValue(cell.addressLine2.text!, forKey: "AddressLine2")
            dataObject.setValue(cell.addressLine3.text!, forKey: "AddressLine3")
            dataObject.setValue(cell.fieldCity.text!, forKey: "City")
            dataObject.setValue(cell.fieldState.text!, forKey: "State")
            dataObject.setValue(cell.fieldPostal.text!, forKey: "Postal")
            if (cell.fieldCountry.text?.count)! != 0 {
            dataObject.setValue(cell.fieldCountry.text!, forKey: "Country")
            }
            else{
             dataObject.setValue("", forKey: "Country")
            }
            dataObject.setValue(cell.fieldPOBox.text!, forKey: "PoBox")
            
            var mainURL:String = createContact
            if contactInfoDetail != nil {
                mainURL = modifyURL
                dataObject.setValue(contactInfoDetail.id!, forKey: "Id")
            }
            let json: [String: Any] = ["ObjectName": "company",
                                       "PassKey": passKey,
                                       "OrganizationId":currentOrgID,
                                       "DataObject":dataObject]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL: mainURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    
                    if self.contactInfoDetail != nil {
                        if self.isEditable {
                            //disable all keyboards
                            if self.contactInfoDetail != nil {
                                self.title = self.contactInfoDetail.name
                                self.setupCustomView()
                            }
                            
                            self.isEditable = false
                            //                        self.barButton.isHidden = false
                            
                            self.actionBtn.removeTarget(nil, action: nil, for: .allEvents)
                            
                            self.actionBtn.setTitle("Close", for: .normal)
                            self.actionBtn.addTarget(self, action: #selector(self.tappedClose(_:)), for: .touchDown)
                            
                            self.closeBtn.removeTarget(nil, action: nil, for: .allEvents)
                            self.closeBtn.setTitle("Actions", for: .normal)
                            self.closeBtn.addTarget(self, action: #selector(self.tappedAction(_:)), for: .touchDown)
                            
                            
//                            self.editBtn.setTitle("Close", for: .normal)
//                            self.editBtn.removeTarget(nil, action: nil, for: .allEvents)
                            
                            self.editBtn.addTarget(self, action: #selector(self.tappedClose(_:)), for: .touchDown)
                            
                            let indexPath = IndexPath(row: 0, section: 0)
                            self.tblAccount.scrollToRow(at: indexPath, at: .top, animated: false)
                            
                            self.tblAccount.reloadData()
                            
                            if self.contactAdd {
                                OperationQueue.main.addOperation {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                            
                            return
                        }
                        
                    }
                    if self.isfromcontactPAge {
                        print(jsonResponse)
                        if let dataObject = jsonResponse["DataObject"] as? NSDictionary {
                            print(dataObject["Id"] as Any)
                            let getIDString:String = dataObject["Id"] as! String
                            print(getIDString)
                            self.linkAAccountToContact(leftID: getIDString)
                        }
                    }else {
                        OperationQueue.main.addOperation {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
            
        }
    }
    
    func linkAAccountToContact(leftID:String){
        let json: [String: Any] = ["ObjectName": "linker_contacts_companies",
                                   "LeftId":self.rightContactID,
                                   "LeftObjectName":"contact",
                                   "RightId":leftID,
                                   "RightObjectName":"company",
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                OperationQueue.main.addOperation {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        },  onFailure: { error in
            OperationQueue.main.addOperation {
                self.navigationController?.popViewController(animated: true)
            }
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    func checkValidation() -> Bool {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell:CreateAccountsCell = tblAccount.cellForRow(at: indexPath) as! CreateAccountsCell
        if (cell.fieldName.text?.count)! == 0 {
            NavigationHelper.showSimpleAlert(message:"Please enter the name")
            return false
        }
        return true
    }
    func ShowPrimaryContactDetails(){
        
        let picker = CZPickerView(headerTitle: "Primary Contacts", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = false
        primaryContactArray = []
        var selectedRowsIndex:[Int] = []
        for index in 0..<self.getSpouseContactListModel.results.count {
            primaryContactArray.append(self.getSpouseContactListModel.results[index].lastName + " " + self.getSpouseContactListModel.results[index].firstName)
        }
        for index in 0..<self.getSpouseContactListModel.results.count {
            if(self.contactInfoDetail !=  nil)
            {
            if(self.contactInfoDetail.primaryContactId != nil){
            if self.getSpouseContactListModel.results[index].id! == self.contactInfoDetail.primaryContactId! {
                let point = self.getSpouseContactListModel.results[index].lastName + " " + self.getSpouseContactListModel.results[index].firstName
                if(point == SelectedPrimaryContact){
                    selectedRowsIndex.append(index)
                }
            }
            }}
        }
        picker?.setSelectedRows(selectedRowsIndex)
        picker?.tag = 321
        picker?.show()
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
extension NewAccountsController:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField.tag == -3 || textField.tag == -4 || textField.tag == -1 || textField.tag == -2 {
            let combinedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: "\(string)")
            if (combinedText?.count ?? 0) < countryCode.count || !(combinedText?.hasPrefix(countryCode) ?? false) {
                return false
            }
            return checkEnglishPhoneNumberFormat(string: string, str: str , textfield:textField)
            
        }else{
            return true
        }
    }
    
    func checkEnglishPhoneNumberFormat(string: String?, str: String?,textfield : UITextField) -> Bool{
        if string == ""{
            return true
        }else if str!.count == 3{
            textfield.text = textfield.text! + "("
        }else if str!.count == 7{
            textfield.text = textfield.text! + ") "
        }else if str!.count == 12{
            textfield.text = textfield.text! + "-"
        }else if str!.count > 16{
            return false
        }
        return true
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag < 0 && !isEditable {
            if textField.tag == -1 || textField.tag == -2 || textField.tag == -3 || textField.tag == -4 {
                if textField.text!.count > 0 {
                    if let url = URL(string: "tel://\(textField.text!)") {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }else{
                        NavigationHelper.showSimpleAlert(message:"Invalid Number")
                    }
                }
            }else if textField.tag == -5 || textField.tag == -6 || textField.tag == -7  {
                if textField.text!.count > 0 {
                    if let url = URL(string: "mailto:\(textField.text!)") {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }else{
                        NavigationHelper.showSimpleAlert(message:"Invalid Email ID")
                    }
                }
            }else if textField.tag == -8 {
                if textField.text!.count > 0 {
                    if let url = URL(string: textField.text!) {
                        UIApplication.shared.open(url, options: [:])
                    }else{
                        NavigationHelper.showSimpleAlert(message:"Invalid Website")
                    }
                }
            }
            
            self.view.endEditing(true)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
        }
        
        if textField.tag == 10 {
            var pickerData:NSMutableArray = []
            var pickerTitle:String = "Country"
            pickerData = []
            for code in NSLocale.isoCountryCodes as [String] {
                let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
                if(name != "United States"){
                    if( name != "Canada"){
                        pickerData.add(name)
                    }
                }
            }
            let sorter = NSSortDescriptor(key: nil, ascending: true)
            let sorters = [sorter]
            let sortedArray = (pickerData as NSMutableArray).sortedArray(using: sorters)
            pickerData = []
            //United States,Canada
            pickerData.addObjects(from:["USA"])
            pickerData.addObjects(from:["Canada"])
            if let anArray = sortedArray as? [String] {
                pickerData.addObjects(from: anArray)
            }
            showPicker(pickerTag: 0, pickerTitle: pickerTitle, pickerData: pickerData, textField: textField)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false

        }else if textField.tag == 20 {
            if getSpouseContactListModel != nil {
//                let pickerData:NSMutableArray = []
//                for index in 0..<self.getSpouseContactListModel.results.count {
//                    pickerData.add(self.getSpouseContactListModel.results[index].lastName + " " + self.getSpouseContactListModel.results[index].firstName)
//                }
//                let indexPath = IndexPath(row: 0, section: 0)
//                let cell:CreateAccountsCell = tblAccount.cellForRow(at: indexPath) as! CreateAccountsCell
//
//
//                self.showPicker(pickerTag: 1, pickerTitle: "Search Contacts", pickerData: pickerData, textField: cell.fieldPrimaryContct)
                ShowPrimaryContactDetails()
                UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
                return false

            }
            let parameter:[String:Any] = ["SearchTerm":"",
                                          "ObjectName":"contact",
                                          "PassKey":passKey,
                                          "OrganizationId":currentOrgID,
                                          "PageOffset": 1,
                                          "ResultsPerPage": 5000]
            requestAPICall(input: parameter, tag: 11, textField: textField)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);

            return false

        }
        
        return true
    }
  
    func showPicker(pickerTag:Int,pickerTitle:String,pickerData:NSMutableArray,textField:UITextField) {
        PickerDialog().show(title: pickerTitle, options: pickerData) { (value, index) in
            textField.text = value
            if pickerTag == 1 {
                self.primaryContactID = self.getSpouseContactListModel.results[index].id!
            }else if pickerTag == 11 {
                self.primaryContactID = self.getSpouseContactListModel.results[index].id!
            }else if pickerTag == 244 {
                let result:[getSearchResultResult] = self.getAddtionalAddressesModel
                self.linkAdditonalAddressToContact(additionalAddressID: result[index].id!,isLinkedContactAddress: true)
            }else if pickerTag == 344 {
                let result:[getCompanyListResult] = self.getLinkedAccountModel
                self.linkAdditonalAddressToContact(additionalAddressID: result[index].id!,isLinkedContactAddress: false)
            }
        }
    }
    func linkAdditonalAddressToContact(additionalAddressID:String,isLinkedContactAddress:Bool) {
        var json: [String: Any] = [:]
        var objectName:String = "linker_companies_addresses"
        var rightObjectName:String = "address"
        var leftObjectName:String = "company"
        if !isLinkedContactAddress {
            objectName = "linker_contacts_companies"
            rightObjectName = "company"
            leftObjectName = "contact"
            json = ["ObjectName": objectName,
                    "LeftId": additionalAddressID,
                    "LeftObjectName": leftObjectName,
                    "RightId":  self.contactInfoDetail.id!,
                    "RightObjectName": rightObjectName,
                    "PassKey": passKey,
                    "OrganizationId": currentOrgID]
        }else{
            json = ["ObjectName": objectName,
                    "LeftId": self.contactInfoDetail.id!,
                    "LeftObjectName": leftObjectName,
                    "RightId": additionalAddressID,
                    "RightObjectName": rightObjectName,
                    "PassKey": passKey,
                    "OrganizationId": currentOrgID]
        }
     
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                OperationQueue.main.addOperation {
                    if !isLinkedContactAddress {
                        self.getLinkedAccounts()
                        return
                    }
                    self.getAdditionalAddress()
                }
            }
        },  onFailure: { error in
            OperationQueue.main.addOperation {
                self.navigationController?.popViewController(animated: true)
            }
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func requestAPICall(input:[String:Any],tag:Int,textField:UITextField) {
        self.view.endEditing(true)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: input, senderVC: self, onSuccess: { (jsonResponse, json) in
            if self.contactInfoDetail != nil {
                self.getAdditionalAddress()
            }
            DispatchQueue.main.async {
                print(json)
                if tag == 0 {
                    self.getSpouseContactListModel = GetSpouseContactModel.init(fromDictionary: jsonResponse)
                    
                    let pickerData:NSMutableArray = []
                    for index in 0..<self.getSpouseContactListModel.results.count {
                        pickerData.add(self.getSpouseContactListModel.results[index].lastName + " " + self.getSpouseContactListModel.results[index].firstName)
                    }
                    
                    self.showPicker(pickerTag: tag, pickerTitle: "Search Contacts", pickerData: pickerData, textField: textField)
                }else if tag == 1 {
                    self.getSpouseContactListModel = GetSpouseContactModel.init(fromDictionary: jsonResponse)
                    
                    for index in 0..<self.getSpouseContactListModel.results.count {
                        
                        if self.getSpouseContactListModel.results[index].id! == self.contactInfoDetail.primaryContactId! {
                            textField.text = self.getSpouseContactListModel.results[index].lastName + " " + self.getSpouseContactListModel.results[index].firstName
                            self.SelectedPrimaryContact = self.getSpouseContactListModel.results[index].lastName + " " + self.getSpouseContactListModel.results[index].firstName
                        }
                    }
                }else if tag == 11 {
                    self.getSpouseContactListModel = GetSpouseContactModel.init(fromDictionary: jsonResponse)
//
//                    let pickerData:NSMutableArray = []
//                    for index in 0..<self.getSpouseContactListModel.results.count {
//                        pickerData.add(self.getSpouseContactListModel.results[index].lastName + " " + self.getSpouseContactListModel.results[index].firstName)
//                    }
//
//                    self.showPicker(pickerTag: tag, pickerTitle: "Search Contacts", pickerData: pickerData, textField: textField)
                    if self.getSpouseContactListModel != nil {
                    self.ShowPrimaryContactDetails()
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    func getAdditionalAddress(){
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ListObjectName": "address",
                                       "ObjectName": "linker_companies_addresses",
                                       "LinkParentId": contactInfoDetail.id!,
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            self.requestAPI(input: json, tag: 4)
        }
    }
    func getLinkedAccounts(){
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ListObjectName": "contact",
                                       "ObjectName": "linker_contacts_companies",
                                       "LinkParentId": contactInfoDetail.id!,
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID,
                                       "AscendingOrder":true]
            print(json)
            self.requestAPI(input: json, tag: 5)
        }
    }
    func getOpenedActivities(){
        if contactInfoDetail == nil {
            return
        }
        let json: [String: Any] = ["PageOffset": 1,
                                   "ResultsPerPage": 500,
                                   "IncludeAppointments": true,
                                   "IncludeTasks": true,
                                   "Invert": false,
                                   "ReturnTotal":true,
                                   "ForCompanies":[contactInfoDetail.id!],
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        
        self.requestAPI(input: json, tag: 6)
    }
    func getClosedActivities(){
        if contactInfoDetail == nil {
            return
        }
        let json: [String: Any] = ["PageOffset": 1,
                                   "ResultsPerPage": 500,
                                   "IncludeAppointments": true,
                                   "IncludeTasks": true,
                                   "Invert": true,
                                   "ReturnTotal":true,
                                   "ForCompanies":[contactInfoDetail.id!],
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        
        self.requestAPI(input: json, tag: 7)
    }
    
    func requestAPI(input:[String:Any],tag:Int){
        
        var mainURL:String = searchURL
        if tag == 4 || tag == 5 {
            mainURL = linkedURL
        }else if tag == 6 || tag == 7 {
            mainURL = getIncompleteActivitiesURL
        }
        
        APIManager.sharedInstance.postRequestCall(postURL: mainURL, parameters: input, senderVC: self, onSuccess: { (jsonResponse, json) in
            
            if tag == 3 {
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
                    
                }else if tag == 1 {
                    
                }else if tag == 2 {
                    
                }else if tag == 3 {
                    
                }else if tag == 4 {
                    let model = GetAdditionalAddressModel.init(fromDictionary: jsonResponse)
                    self.additionalResult = []
                    if model.valid {
                        self.additionalResult = model.results
                        self.selecyedAdditioanlAddressIDList = []
                        for index in 0..<self.additionalResult.count {
                            let strID:String = self.additionalResult[index].id
                            self.selecyedAdditioanlAddressIDList.append(strID)
                        }
                    }
                    self.tblAccount.reloadData()
                }else if tag == 5 {
                    let model = GetLinkedAccountsModel.init(fromDictionary: jsonResponse)
                    self.getLinkedAccountsResult = []
                    if model.valid {
                        self.getLinkedAccountsResult = model.results
                        self.selectedLinkedAccountIDList = []
                        for index in 0..<self.getLinkedAccountsResult.count {
                            let strID:String = self.getLinkedAccountsResult[index].id
                            self.selectedLinkedAccountIDList.append(strID)
                        }
                    }
                    self.tblAccount.reloadData()
                }else if tag == 6 {
                    let model = GetIncompleteModel.init(fromDictionary: jsonResponse)
                    self.getOpenedActivitiesResult = []
                    if model.valid {
                        self.getOpenedActivitiesResult = model.activities
                    }
                    self.tblAccount.reloadData()
                }else if tag == 7 {
                    let model = GetCompleteModel.init(fromDictionary: jsonResponse)
                    self.getCompleteActivitiesResult = []
                    if model.valid {
                        self.getCompleteActivitiesResult = model.activities
                    }
                    self.tblAccount.reloadData()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
}

extension NewAccountsController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if contactInfoDetail != nil {
            if contactAdd {
                closeBtn.removeTarget(nil, action: nil, for: .allEvents)
                closeBtn.setTitle("Save", for: .normal)
                closeBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
                
                actionBtn.removeTarget(nil, action: nil, for: .allEvents)
                actionBtn.setTitle("Close", for: .normal)
                actionBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchDown)
                
                return 1
            }
            return headerTitles.count + 5
        }
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return additionalResult.count
        }else if section == 4 {
            return getLinkedAccountsResult.count
        }else if section == 6 {
            return getOpenedActivitiesResult.count
        }else if section == 8 {
            return getCompleteActivitiesResult.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:CreateAccountsCell = tableView.dequeueReusableCell(withIdentifier: "CreateAccountsCell") as! CreateAccountsCell
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(NewAccountsController.handleTap(_:)))
            tapGR.delegate = self
            tapGR.numberOfTapsRequired = 2
            cell.addGestureRecognizer(tapGR)
            if contactInfoDetail != nil {
            }else{
                cell.fieldMobilePhone.delegate = self
                cell.fieldOtherPhone.delegate = self
                cell.fieldPrimaryPhone.delegate = self
                cell.fieldSecondaryName.delegate = self

                if(cell.fieldMobilePhone.text == "")
                {
                    cell.fieldMobilePhone.text = countryCode
                }else{
                    cell.fieldMobilePhone.text = cell.fieldMobilePhone.text
                }
                if(cell.fieldOtherPhone.text == "")
                {
                    cell.fieldOtherPhone.text = countryCode
                }else{
                    cell.fieldOtherPhone.text = cell.fieldOtherPhone.text
                }
                if(cell.fieldPrimaryPhone.text == "")
                {
                    cell.fieldPrimaryPhone.text = countryCode
                }else{
                    cell.fieldPrimaryPhone.text = cell.fieldPrimaryPhone.text
                }
                if(cell.fieldSecondaryName.text == "")
                {
                    cell.fieldSecondaryName.text = countryCode
                }else{
                    cell.fieldSecondaryName.text = cell.fieldSecondaryName.text
                }
                cell.checkIfEditable(value: isEditable)
            }
            cell.checkIfEditable(value: isEditable)
            return cell
        }else if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 5 || indexPath.section == 7 {
//            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.lblNoDataAvailable.isHidden = true
            
            if indexPath.section == 1 && selectedIndexPath - 1 == indexPath.section && isExpand && additionalResult.count == 0 {
                cell.lblNoDataAvailable.isHidden = false
            }
            if indexPath.section == 3 && selectedIndexPath - 1 == indexPath.section && isExpand && getLinkedAccountsResult.count == 0 {
                cell.lblNoDataAvailable.isHidden = false
            }
            if indexPath.section == 5 && selectedIndexPath - 1 == indexPath.section && isExpand && getOpenedActivitiesResult.count == 0 {
                cell.lblNoDataAvailable.isHidden = false
            }
            if indexPath.section == 7 && selectedIndexPath - 1 == indexPath.section && isExpand && getCompleteActivitiesResult.count == 0 {
                cell.lblNoDataAvailable.isHidden = false
            }
            
           
            
            cell.lblItem1.text = "Name"
            cell.lblItem2.text = "Primary Contact"
            cell.lblItem3.text = "Primary Phone"
            
            cell.lblItem1.isHidden = true
            cell.lblItem2.isHidden = true
            cell.lblItem3.isHidden = true
            if indexPath.section == 1 && selectedIndexPath - 1 == indexPath.section && isExpand {
                cell.AddTopConstraint.constant = 9
                cell.AddHeightConstraint.constant = 26
                cell.SearchHeightConstraint.constant = 24
                cell.searchTopConstraint.constant = 10
                cell.lblItem1.isHidden = false
                cell.lblItem2.isHidden = false
                cell.lblItem3.isHidden = false
            }
            if indexPath.section == 3 && selectedIndexPath - 1 == indexPath.section && isExpand {
                cell.AddTopConstraint.constant = 9
                cell.AddHeightConstraint.constant = 26
                cell.SearchHeightConstraint.constant = 24
                cell.searchTopConstraint.constant = 10
                cell.lblItem1.isHidden = false
                cell.lblItem2.isHidden = false
                cell.lblItem3.isHidden = false
            }
            if indexPath.section == 5 && selectedIndexPath - 1 == indexPath.section && isExpand {
                cell.AddTopConstraint.constant = 9
                cell.AddHeightConstraint.constant = 26
                cell.SearchHeightConstraint.constant = 24
                cell.searchTopConstraint.constant = 10
                
                cell.lblItem1.text = "Subject"
                cell.lblItem2.text = "Start Time"
                cell.lblItem3.text = "Type"
                
                cell.lblItem1.isHidden = false
                cell.lblItem2.isHidden = false
                cell.lblItem3.isHidden = false
            }
            if indexPath.section == 7 && selectedIndexPath - 1 == indexPath.section && isExpand {
                cell.AddTopConstraint.constant = 15
                cell.AddHeightConstraint.constant = 0
                cell.SearchHeightConstraint.constant = 0
                cell.searchTopConstraint.constant = 15
                
                cell.lblItem1.text = "Subject"
                cell.lblItem2.text = "Start Time"
                cell.lblItem3.text = "Type"
                
                cell.lblItem1.isHidden = false
                cell.lblItem2.isHidden = false
                cell.lblItem3.isHidden = false
            }
            if indexPath.section == 1 {
                if(isExpand && selectedIndexPath_condition == indexPath.section){
                    cell.Viewheader.isHidden = false
                }
                else{
                    cell.Viewheader.isHidden = true
                }
                
                cell.lblItem1.text = "Name"
                cell.lblItem2.text = ""
                cell.lblItem3.text = "Address1"
                
                cell.lblItem3.textAlignment = .left
                
                cell.lblHeader.text = headerTitles[0]
                cell.btnAdd.isHidden = false
                cell.btnSearch.isHidden = false
                
                cell.btnSearch.tag = indexPath.section
                cell.btnSearch.addTarget(self, action: #selector(tblSearchAddressButtonTapped(_:)), for: .touchDown)
                
                cell.btnAdd.tag = indexPath.section
                cell.btnAdd.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchDown)
                if selectedIndexPath == 2 {
                    cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
                }else{
                    cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
                }
                if !isEditable {
//                    cell.btnSearch.isHidden = true
//                    cell.btnAdd.isHidden = true
                }
                return cell
            }else if indexPath.section == 3 {
                if(isExpand && selectedIndexPath_condition == indexPath.section){
                    cell.Viewheader.isHidden = false
                }
                else{
                    cell.Viewheader.isHidden = true
                }
                
                cell.lblItem1.text = "Name"
                cell.lblItem2.text = ""
                cell.lblItem3.text = "Primary Contact"
                cell.lblItem3.textAlignment = .left

                cell.lblHeader.text = headerTitles[1]
                cell.btnAdd.isHidden = false
                cell.btnSearch.isHidden = false
                
                if selectedIndexPath == 4 {
                    cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
                }else{
                    cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
                }
                cell.btnAdd.tag = indexPath.section
                cell.btnAdd.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchDown)
                
                cell.btnSearch.tag = indexPath.section
                cell.btnSearch.addTarget(self, action: #selector(tblSearchButtonTapped(_:)), for: .touchDown)
                
                if !isEditable {
//                    cell.btnAdd.isHidden = true
//                    cell.btnSearch.isHidden = true
                }
                return cell
            }else if indexPath.section == 5 {
                if(isExpand && selectedIndexPath_condition == indexPath.section){
                    cell.Viewheader.isHidden = false
                }
                else{
                    cell.Viewheader.isHidden = true
                }
                
                cell.lblHeader.text = headerTitles[2]
                cell.btnAdd.isHidden = false
                cell.btnSearch.isHidden = true
                
                if selectedIndexPath == 6 {
                    cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
                }else{
                    cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
                }
                cell.btnSearch.tag = indexPath.section
                
                cell.btnAdd.tag = indexPath.section
                cell.btnAdd.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchDown)
                if !isEditable {
//                    cell.btnAdd.isHidden = true
//                    cell.btnSearch.isHidden = true
                }
                return cell
            }else if indexPath.section == 7 {
                if(isExpand && selectedIndexPath_condition == indexPath.section){
                    cell.Viewheader.isHidden = false
                }
                else{
                    cell.Viewheader.isHidden = true
                }
                
                cell.lblHeader.text = headerTitles[3]
                cell.btnAdd.isHidden = true
                cell.btnSearch.isHidden = true
                if selectedIndexPath == 8 {
                    cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
                }else{
                    cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
                }
                if !isEditable {
                    cell.btnSearch.isHidden = true

                    cell.btnAdd.isHidden = true
                }
                return cell
            }
            return cell
        }else if indexPath.section == 2 {
            let cell:AccountHeaderCell = tableView.dequeueReusableCell(withIdentifier: "AccountHeaderCell") as! AccountHeaderCell
//            let cell:AddAddtionalCell = tableView.dequeueReusableCell(withIdentifier: "AddAddtionalCell") as! AddAddtionalCell
            cell.lblName2.textAlignment = .left
            cell.lblName1.text = additionalResult[indexPath.row].name
            cell.lblName2.text = additionalResult[indexPath.row].line1
//            cell.lblCity.text = additionalResult[indexPath.row].city
            return cell
        }else if indexPath.section == 4 {
            let cell:AccountHeaderCell = tableView.dequeueReusableCell(withIdentifier: "AccountHeaderCell") as! AccountHeaderCell
            cell.lblName2.textAlignment = .center

//            let cell:AdditionalAddressCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalAddressCell") as! AdditionalAddressCell
            cell.lblName1.text = getLinkedAccountsResult[indexPath.row].fullName
            cell.lblName2.text = getLinkedAccountsResult[indexPath.row].mobilePhone
//            cell.lblCity.text = getLinkedAccountsResult[indexPath.row].telephone1
            return cell
        }else if indexPath.section == 6 {
            let cell:AdditionalAddressCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalAddressCell") as! AdditionalAddressCell
            cell.lblName.text = getOpenedActivitiesResult[indexPath.row].activity.subject
            cell.lblAddress.text = getOpenedActivitiesResult[indexPath.row].activity.startTime.convertYearMonthDatehourMin()
            cell.lblCity.text = getOpenedActivitiesResult[indexPath.row].type
            
            return cell
        }else {
            let cell:AdditionalAddressCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalAddressCell") as! AdditionalAddressCell
            cell.lblName.text = getCompleteActivitiesResult[indexPath.row].activity.subject
            if(getOpenedActivitiesResult.count > 0){
                if((getOpenedActivitiesResult[indexPath.row].activity.startTime) != nil || (getOpenedActivitiesResult[indexPath.row].activity.startTime) != ""){
               cell.lblAddress.text = getOpenedActivitiesResult[indexPath.row].activity.startTime.convertYearMonthDatehourMin()
                }
               cell.lblCity.text = getOpenedActivitiesResult[indexPath.row].type
            }
            else {
                cell.lblAddress.text = ""
                cell.lblCity.text = ""
            }
            

            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if contactInfoDetail == nil {
            return 25
        }else {
            if section == 8 {
                return 25
            }
        }
        return 0
    }
    @objc func tblSearchButtonTapped(_ button: UIButton) {
        print(button.tag)
        if(button.tag == 3){
        let json:[String: Any] = ["AscendingOrder":true,
                                  "ObjectName":"contact",
                                  "PassKey":passKey,
                                  "OrderBy": "FullName",
                                  "OrganizationId":currentOrgID,
                                  "PageOffset":1,
                                  "ResultsPerPage":100]
        
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                self.resultsaddressArray = []
                self.linkaddressArray = []
                self.linkcontactArray = []
                self.resultsArray = json["Results"].arrayValue
                self.resultsaddressArray = json["Results"].arrayValue
                for dic in self.resultsArray{
                    let value = dic["FullName"].string
                    self.linkcontactArray.append(value!)
                    self.linkaddressArray.append(value!)
                }
                if(self.linkcontactArray.count > 0){
                    
                    self.showLinkedContactsPicker()

//                    DPPickerManager.shared.showPicker(title: "Contacts", selected: "", strings: self.linkcontactArray) { (value, index, cancel) in
//                        if !cancel {
//                            print(index)
//                            let dict = self.resultsArray[index]
//                            print(dict)
//                            let id : String = dict["Id"].string!
//                            let json:[String:Any] = ["LeftId":id,
//                                                     "RightId":self.contactInfoDetail.id!,
//                                                     "LeftObjectName":"contact",
//                                                     "ObjectName":"linker_contacts_companies",
//                                                     "PassKey":passKey,
//                                                     "OrganizationId":currentOrgID,
//                                                     "RightObjectName":"company"]
//                            print(json)
//                            APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/link.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
//                                DispatchQueue.main.async {
//                                    print(json)
//                                    OperationQueue.main.addOperation {
//                                        let response = json["ResponseMessage"].string
//                                        if(response == "success"){
//
//                                            DispatchQueue.main.async(execute: {
//                                                AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Added Successfully") { (index, title) in
//                                                    print(index,title)
//                                                    self.getLinkedAccounts()
//                                                }
//                                            })
//
//                                        }
//                                        else{
//                                             NavigationHelper.showSimpleAlert(message:"Unable to add")
//                                        }
//                                    }
//                                }
//                            },  onFailure: { error in
//                                print(error.localizedDescription)
//                                print(error.localizedDescription)
//                            })
//                        }
//                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        }
        
    }
    
    @objc func tblSearchAddressButtonTapped(_ button: UIButton) {
        
        if(button.tag == 1){
        
        let json:[String: Any] = ["AscendingOrder":true,
                                  "ObjectName":"address",
                                  "PassKey":passKey,
                                  "OrderBy": "Name",
                                  "OrganizationId":currentOrgID,
                                  "PageOffset":1,
                                  "ResultsPerPage":100]
        print(json)
        
        
        APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                self.resultsaddressArray = []
                self.linkaddressArray = []
                self.resultsaddressArray = json["Results"].arrayValue
                for dic in self.resultsaddressArray{
                    let value = dic["Name"].string
                    self.linkaddressArray.append(value!)
                }
                if(self.linkaddressArray.count > 0){
                    self.showAdditionalAddressPicker()
                    
//                    DPPickerManager.shared.showPicker(title: "Addresses", selected: "", strings: self.linkaddressArray) { (value, index, cancel) in
//                        if !cancel {
//                            print(index)
//                            let dict = self.resultsaddressArray[index]
//                            print(dict)
//                            let id : String = dict["Id"].string!
//                            let json:[String:Any] = ["LeftId":self.contactInfoDetail.id!,
//                                                     "RightId":id,
//                                                     "LeftObjectName":"company",
//                                                     "ObjectName":"linker_companies_addresses",
//                                                     "PassKey":passKey,
//                                                     "OrganizationId":currentOrgID,
//                                                     "RightObjectName":"address"]
//                            print(json)
//                            APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/link.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
//                                DispatchQueue.main.async {
//                                    print(json)
//                                    OperationQueue.main.addOperation {
//                                        let response = json["ResponseMessage"].string
//                                        if(response == "success"){
//                                            NavigationHelper.showSimpleAlert(message:"Added Successfully")
//                                            self.tblAccount.reloadData()
//                                        }
//                                        else{
//                                            NavigationHelper.showSimpleAlert(message:"Unable to add Address")
//                                        }
//                                    }
//                                }
//                            },  onFailure: { error in
//                                print(error.localizedDescription)
//                            })
//
//                        }
//                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        }
        
    }
    @objc func tappedTblSearch(_ button: UIButton) {
//        let btnTag = button.tag
//        print(btnTag)
//        if btnTag == 1 {
//            getSearchAPI(objectName: "address")
//        }else if btnTag == 3 {
//            getSearchAPI(objectName: "contact")
//        }else if btnTag == 5 {
//            
//        }
    }
    func getSearchAPI(objectName:String){
        let json:[String: Any] = ["SearchTerm": "",
                                  "ObjectName":objectName,
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID,
                                  "PageOffset":1,
                                  "ResultsPerPage":100]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                if objectName == "address" {
                    let getModel = getSearchResultRootClass.init(fromDictionary: jsonResponse)
                    if getModel.valid {
                        self.getAddtionalAddressesModel = getModel.results
                        let pickerData:NSMutableArray = []
                        let result:[getSearchResultResult] = self.getAddtionalAddressesModel
                        for index in 0..<result.count {
                            pickerData.add(result[index].name!)
                        }
                        self.showPicker(pickerTag: 244, pickerTitle: "Additional Addresses", pickerData: pickerData, textField: UITextField())
                    }
                }else if objectName == "contact" {
                    let getModel = getCompanyListModel.init(fromDictionary: jsonResponse)
                    if getModel.valid {
                        self.getLinkedAccountModel = getModel.results
                        let pickerData:NSMutableArray = []
                        let result:[getCompanyListResult] = self.getLinkedAccountModel
                        for index in 0..<result.count {
                            pickerData.add(result[index].fullName!)
                        }
                        self.showPicker(pickerTag: 344, pickerTitle: "Linked Accounts", pickerData: pickerData, textField: UITextField())
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    @objc func ratingButtonTapped(_ button: UIButton) {
        let btnTag = button.tag
        
        if btnTag == 1 {
            let controller:AdditionalNewAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "AdditionalNewAddressVC") as! AdditionalNewAddressVC
            controller.fromAccounts = true
            controller.leftID = self.contactInfoDetail.id!
            self.navigationController?.pushViewController(controller, animated: true)
        }else if btnTag == 3 {
            
            let controller:ContactssController = self.storyboard?.instantiateViewController(withIdentifier:"ContactssController") as! ContactssController
            controller.isEditable = true
            controller.leftid = self.contactInfoDetail.id!
            controller.linkaccount = "link"
            self.navigationController?.pushViewController(controller, animated: true)

        }else if btnTag == 5 {
            let alert = UIAlertController(title: " ", message: "Please Select an Option", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Appointment", style: .default , handler:{ (UIAlertAction)in
                print("User click Approve button")
                OperationQueue.main.addOperation {
                    let controller:NewAppointmentsController = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentsController") as? NewAppointmentsController)!
                    controller.linkParentID = self.contactInfoDetail.id!
                    controller.accountname = self.contactInfoDetail.name!
                    controller.fromAccounts = true
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Task", style: .default , handler:{ (UIAlertAction)in
                print("User click Edit button")
                OperationQueue.main.addOperation {
                    let controller:NewTaskController = (self.storyboard?.instantiateViewController(withIdentifier: "NewTaskController") as? NewTaskController)!
                    controller.linkParentID = self.contactInfoDetail.id!
                    controller.accountname = self.contactInfoDetail.name!
                    controller.fromAccounts = true
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Recurrence", style: .default , handler:{ (UIAlertAction)in
                print("User click Delete button")
                OperationQueue.main.addOperation {
                    let controller:CreateRecurrencePattern = (self.storyboard?.instantiateViewController(withIdentifier: "CreateRecurrencePattern") as? CreateRecurrencePattern)!
                    controller.linkParentID = self.contactInfoDetail.id!
                    controller.accountname = self.contactInfoDetail.name!
                    controller.fromAccounts = true
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 5 || indexPath.section == 7   {
            if indexPath.section == selectedIndexPath - 1 {
                selectedIndexPath = 2123123
                isExpand = false
            }else{
                selectedIndexPath = indexPath.section + 1
                isExpand = true
            }
             selectedIndexPath_condition = indexPath.section
            tableView.beginUpdates()
            tableView.endUpdates()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                tableView.reloadData()
                let indexPath = IndexPath(row: 0, section: indexPath.section)
                tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }else if indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 {
//            if !isEditable {
//                return
//            }
            if indexPath.section == 2 {
                let getAddress:AdditionalAddsResult = AdditionalAddsResult.init(fromDictionary: additionalResult[indexPath.row].toDictionary())
                let controller:AdditionalNewAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "AdditionalNewAddressVC") as! AdditionalNewAddressVC
                controller.fromAccounts = true
                controller.additionalAddressDetail = getAddress
                self.navigationController?.pushViewController(controller, animated: true)
            }else if indexPath.section == 4 {
                let getAddress:ContactListResult = ContactListResult.init(fromDictionary: getLinkedAccountsResult[indexPath.row].toDictionary())
                let controller:ContactssController = self.storyboard?.instantiateViewController(withIdentifier: "ContactssController") as! ContactssController
                controller.isEditable = true
                controller.leftid = self.contactInfoDetail.id!
                controller.contactAdd = true
                controller.contactInfoDetail = getAddress
                self.navigationController?.pushViewController(controller, animated: true)
//                let getAddress:LinkedAccountsResult = LinkedAccountsResult.init(fromDictionary: getLinkedAccountsResult[indexPath.row].toDictionary())
//                let controller:AddLinkedAccountController = self.storyboard?.instantiateViewController(withIdentifier: "AddLinkedAccountController") as! AddLinkedAccountController
////                controller.fromAccounts = true
//                controller.additionalAddressDetail = getAddress
//                self.navigationController?.pushViewController(controller, animated: true)
            }else if indexPath.section == 6 {
                let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: getOpenedActivitiesResult[indexPath.row].toDictionary())
                print(getOpenedActivitiesResult[indexPath.row])
                if getAddress.type == "Task" {
                    let controller:NewTaskController = (self.storyboard?.instantiateViewController(withIdentifier: "NewTaskController") as? NewTaskController)!
                    controller.linkParentID = contactInfoDetail.id!
                    controller.openedActivties = getAddress
                    controller.fromAccounts = true
                    controller.Editvalue = "edit"
                    controller.IsEdit = true
                    controller.StrAccount = "Accounts"
                    self.navigationController?.pushViewController(controller, animated: true)
                }else if getAddress.type == "Appointment" || getAddress.type == "Appointments" {
                    let controller:NewAppointmentsController = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentsController") as? NewAppointmentsController)!
                    controller.linkParentID = contactInfoDetail.id!
                    controller.Editvalue = "edit"
                     UserDefaults.standard.set(getAddress.activity.id, forKey: "appointmentTypeID")
                    controller.openedActivties = getAddress
                    controller.fromAccounts = true

                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }else if indexPath.section == 8 {
                let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: getCompleteActivitiesResult[indexPath.row].toDictionary())
                if getAddress.type == "Task" {
                    let controller:NewTaskController = (self.storyboard?.instantiateViewController(withIdentifier: "NewTaskController") as? NewTaskController)!
                    controller.linkParentID = contactInfoDetail.id!
                    controller.Editvalue = "edit"
                    controller.openedActivties = getAddress
                    controller.fromAccounts = true
                    self.navigationController?.pushViewController(controller, animated: true)
                }else if getAddress.type == "Appointment" || getAddress.type == "Appointments" {
                    let controller:NewAppointmentsController = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentsController") as? NewAppointmentsController)!
                    controller.linkParentID = contactInfoDetail.id!
                    controller.Editvalue = "edit"
                     UserDefaults.standard.set(getAddress.activity.id, forKey: "appointmentTypeID")
                    controller.openedActivties = getAddress
                    controller.fromAccounts = true
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 1464
        }
        if indexPath.section == 1 && !isExpand || indexPath.section == 3 && !isExpand || indexPath.section == 5 && !isExpand || indexPath.section == 7 && !isExpand {
            return 65
        }
        if indexPath.section == 2 {
            if isExpand {
                if selectedIndexPath == 2 {
                    return 46
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 4 {
            if isExpand {
                if selectedIndexPath == 4 {
                    return 46
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 6 {
            if isExpand {
                if selectedIndexPath == 6 {
                    return 46
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        if indexPath.section == 8 {
            if isExpand {
                if selectedIndexPath == 8 {
                    return 46
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
        
        else if indexPath.section == 1 && isExpand && selectedIndexPath_condition == indexPath.section {
            if(additionalResult.count == 0){
                return 158
            }
            return 130
        }
        else if  indexPath.section == 3 && isExpand && selectedIndexPath_condition == indexPath.section {
            if(getLinkedAccountsResult.count == 0){
                return 158
            }
            return 130
        }
        else if indexPath.section == 5 && isExpand && selectedIndexPath_condition == indexPath.section {
            if(getOpenedActivitiesResult.count == 0){
                return 158
            }
            return 130
        }
        else if indexPath.section == 7 && isExpand && selectedIndexPath_condition == indexPath.section {
            if(getCompleteActivitiesResult.count == 0){
                return 158
            }
            return 130
        }
      
        return 65
    }
    
}

extension NewAccountsController:URLSessionDelegate {
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

extension NewAccountsController:CZPickerViewDelegate,CZPickerViewDataSource {
    func showAdditionalAddressPicker(){
        let picker = CZPickerView(headerTitle: "Additional Addresses", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        var selectedRowsIndex:[Int] = []
        for index in 0..<linkaddressArray.count {
            let joinName = linkaddressArray[index]
            for index1 in 0..<additionalResult.count {
                var pointName:String = additionalResult[index1].name
                pointName = pointName.trimmingCharacters(in: .whitespaces)
                if pointName == joinName {
                    selectedRowsIndex.append(index)
                }
            }
        }
        picker?.setSelectedRows(selectedRowsIndex)
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 12
        picker?.show()
    }
    func showLinkedContactsPicker(){
        let picker = CZPickerView(headerTitle: "Linked Contacts", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        var selectedRowsIndex:[Int] = []
        for index in 0..<linkaddressArray.count {
            let joinName = linkaddressArray[index]
            for index1 in 0..<getLinkedAccountsResult.count {
                var pointName:String = getLinkedAccountsResult[index1].fullName
                pointName = pointName.trimmingCharacters(in: .whitespaces)
                if pointName == joinName {
                    selectedRowsIndex.append(index)
                }
            }
        }
        picker?.setSelectedRows(selectedRowsIndex)
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 13
        picker?.show()
    }
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 321 {
            return primaryContactArray.count
        }
        else if pickerView.tag == 12 {
            return linkaddressArray.count
        }else if pickerView.tag == 13 {
            return linkaddressArray.count
        }
        
        return 0
    }
    
    func czpickerView(_ pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
        return nil
    }
    
    func numberOfRowsInPickerView(pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 321 {
            return primaryContactArray.count
        }
        if pickerView.tag == 12 || pickerView.tag == 13 {
            return linkaddressArray.count
        }
        return 0
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        if pickerView.tag == 12 || pickerView.tag == 13 {
            return linkaddressArray[row]
        }
        if pickerView.tag == 321{
            return primaryContactArray[row]
        }
        return ""
    }
    
    
    func czpickerView(_ pickerView: CZPickerView!) -> NSMutableArray{
        if pickerView.tag == 12 {
            let arr:NSMutableArray = []
            for index in 0..<linkaddressArray.count {
                arr.add(linkaddressArray[index])
            }
            return arr
        }else if pickerView.tag == 13 {
            //linkaddressArray
            //getLinkedAccountsResult
            let arr:NSMutableArray = []
            for index in 0..<linkaddressArray.count {
                arr.add(linkaddressArray[index])
            }
            return arr
        }
        else if pickerView.tag == 321 {
            //linkaddressArray
            //getLinkedAccountsResult
            let arr:NSMutableArray = []
            for index in 0..<primaryContactArray.count {
                arr.add(primaryContactArray[index])
            }
            
            return arr
        }
        return []
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        //        self.selectedContacts = []
        
        if (pickerView.tag == 321)
        {
            
            let indexPath = IndexPath(row: 0, section: 0)
            let cell:CreateAccountsCell = tblAccount.cellForRow(at: indexPath) as! CreateAccountsCell
            cell.fieldPrimaryContct.text = primaryContactArray[row]
            cell.fieldPrimaryContct.text = primaryContactArray[row]
            SelectedPrimaryContact = primaryContactArray[row]
            self.primaryContactID = self.getSpouseContactListModel.results[row].id!
        }
    }
    
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)        setupBottomView()
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, withoutBool value: Bool) {
          if pickerView.tag == 12 {
            var idsList:[String] = []
            //selectedRecreationIDList
            var tempRemoveIdLists:[String] = []

            var isFromFilter:Bool = false
            if let getObject = UserDefaults.standard.object(forKey: "FilteredObject") as? String {
                if getObject == "YES" {
                    isFromFilter = true
                }
            }
            
            for row in rows {
                if let row = row as? Int {
                    let dict = self.resultsaddressArray[row]
                    let id : String = dict["Id"].string!
                    idsList.append(id)
                }
            }
            if selecyedAdditioanlAddressIDList.count > 0 {
                for index in 0..<selecyedAdditioanlAddressIDList.count {
                    if !idsList.contains(selecyedAdditioanlAddressIDList[index]) {
                        tempRemoveIdLists.append(selecyedAdditioanlAddressIDList[index])
                    }
                }
            }
            if isFromFilter {
                tempRemoveIdLists = []
            }
            if idsList.count > 0 {
                self.linkContactCategorie(leftid: self.contactInfoDetail.id, rightid: idsList[0], idList: idsList, index: 0, removeList: tempRemoveIdLists)
            }
            return
        }
        else if pickerView.tag == 321 {
            return
          }else if pickerView.tag == 13 {
            //linkaddressArray
//            getLinkedAccountsResult
            var idsList:[String] = []
            //selectedRecreationIDList
            var tempRemoveIdLists:[String] = []
            var isFromFilter:Bool = false
            if let getObject = UserDefaults.standard.object(forKey: "FilteredObject") as? String {
                if getObject == "YES" {
                    isFromFilter = true
                }
            }
            for row in rows {
                if let row = row as? Int {
                    let dict = self.resultsaddressArray[row]
                    let id : String = dict["Id"].string!
                    idsList.append(id)
                }
            }
            if selectedLinkedAccountIDList.count > 0 {
                for index in 0..<selectedLinkedAccountIDList.count {
                    if !idsList.contains(selectedLinkedAccountIDList[index]) {
                        tempRemoveIdLists.append(selectedLinkedAccountIDList[index])
                    }
                }
            }
            if isFromFilter {
                tempRemoveIdLists = []
            }
            if idsList.count > 0 {
                self.linkLinkedCategorie(leftid: self.contactInfoDetail.id, rightid: idsList[0], idList: idsList, index: 0, removeList: tempRemoveIdLists)
            }
            return
        }
//        var idsList:[String] = []
//        //selectedRecreationIDList
//        var tempRemoveIdLists:[String] = []
//
//        var selectedContacts:[String] = []
//        for row in rows {
//            if let row = row as? Int {
//                let getContact = getRecreationCategoriesList.results[row]
//                selectedContacts.append(getContact.name!)
//                idsList.append(getContact.id!)
//            }
//        }
//
//        if selectedRecreationIDList.count > 0 {
//            for index in 0..<selectedRecreationIDList.count {
//                if !idsList.contains(selectedRecreationIDList[index]) {
//                    tempRemoveIdLists.append(selectedRecreationIDList[index])
//                }
//            }
//        }
//
//
//        if selectedContacts.count > 0 {
//            let stringRepresentation = selectedContacts.joined(separator: ", ")
//            getRecreationNames = stringRepresentation
//            self.linkRecreationCategorie(leftid: self.contactInfoDetail.id, rightid: idsList[0], idList: idsList, index: 0, removeList: tempRemoveIdLists)
//        }
//
//        setCategories = true
//        self.tableView.reloadData()
    }
    
    func linkLinkedCategorie(leftid:String,rightid:String,idList:[String],index:Int,removeList:[String]){
        let json: [String: Any] = ["ObjectName": "linker_contacts_companies",
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID,
                                   "LeftId":rightid,
                                   "LeftObjectName":"contact",
                                   "RightId":leftid,
                                   "RightObjectName":"company"]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let getIndex = index + 1
                
                if getIndex < idList.count {
                    self.linkLinkedCategorie(leftid: leftid, rightid: idList[getIndex], idList: idList, index: getIndex, removeList: removeList)
                }else{
                    if removeList.count > 0 {
                        self.removeLinkAccountCategorie(leftid: leftid, rightid: removeList[0], idList: idList, index: getIndex, removeList: removeList)
                    }else{
                        self.refreshLinkedAccounts()
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func removeLinkAccountCategorie(leftid:String,rightid:String,idList:[String],index:Int,removeList:[String]){
        let json: [String: Any] = ["ObjectName": "linker_contacts_companies",
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID,
                                   "LeftId":rightid,
                                   "LeftObjectName":"contact",
                                   "RightId":leftid,
                                   "RightObjectName":"company"]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: removeLinkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let getIndex = index + 1
                if getIndex <= removeList.count {
                    self.removeLinkAccountCategorie(leftid: leftid, rightid: removeList[index], idList: idList, index: getIndex, removeList: removeList)
                }else{
                    self.refreshLinkedAccounts()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func linkContactCategorie(leftid:String,rightid:String,idList:[String],index:Int,removeList:[String]){
        let json: [String: Any] = ["ObjectName": "linker_companies_addresses",
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID,
                                   "LeftId":leftid,
                                   "LeftObjectName":"company",
                                   "RightId":rightid,
                                   "RightObjectName":"address"]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let getIndex = index + 1
                
                if getIndex < idList.count {
                    self.linkContactCategorie(leftid: leftid, rightid: idList[getIndex], idList: idList, index: getIndex, removeList: removeList)
                }else{
                    if removeList.count > 0 {
                        self.removeLinkContactCategorie(leftid: leftid, rightid: removeList[0], idList: idList, index: getIndex, removeList: removeList)
                    }else{
                        self.refreshAdditionalAddress()
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func removeLinkContactCategorie(leftid:String,rightid:String,idList:[String],index:Int,removeList:[String]){
        let json: [String: Any] = ["ObjectName": "linker_companies_addresses",
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID,
                                   "LeftId":leftid,
                                   "LeftObjectName":"company",
                                   "RightId":rightid,
                                   "RightObjectName":"address"]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: removeLinkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let getIndex = index + 1
                if getIndex <= removeList.count {
                    self.removeLinkContactCategorie(leftid: leftid, rightid: removeList[index], idList: idList, index: getIndex, removeList: removeList)
                }else{
                    self.refreshAdditionalAddress()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func refreshAdditionalAddress(){
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ListObjectName": "address",
                                       "ObjectName": "linker_companies_addresses",
                                       "LinkParentId": contactInfoDetail.id!,
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL: linkedURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    let model = GetAdditionalAddressModel.init(fromDictionary: jsonResponse)
                    self.additionalResult = []
                    if model.valid {
                        self.additionalResult = model.results
                        self.selecyedAdditioanlAddressIDList = []
                        for index in 0..<self.additionalResult.count {
                            let strID:String = self.additionalResult[index].id
                            self.selecyedAdditioanlAddressIDList.append(strID)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tblAccount.reloadData()
                    }
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
            
        }
        
    }
    func refreshLinkedAccounts(){
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ListObjectName": "contact",
                                       "ObjectName": "linker_contacts_companies",
                                       "LinkParentId": contactInfoDetail.id!,
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID,
                                       "AscendingOrder":true]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL: linkedURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    let model = GetLinkedAccountsModel.init(fromDictionary: jsonResponse)
                    self.getLinkedAccountsResult = []
                    if model.valid {
                        self.getLinkedAccountsResult = model.results
                        self.selectedLinkedAccountIDList = []
                        for index in 0..<self.getLinkedAccountsResult.count {
                            let strID:String = self.getLinkedAccountsResult[index].id
                            self.selectedLinkedAccountIDList.append(strID)
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.tblAccount.reloadData()
                    }
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
            
        }
        
    }
}
extension NewAccountsController: UIGestureRecognizerDelegate {
    @objc  func handleTap(_ gesture: UITapGestureRecognizer){
        print("tappp")
        isEditable = true
        
        tblAccount?.visibleCells.forEach { cell in
            if let cell = cell as? CreateAccountsCell {
                cell.checkIfEditable(value: isEditable)
            }
        }
        
        actionBtn.removeTarget(nil, action: nil, for: .allEvents)
        actionBtn.setTitle("Close", for: .normal)
        actionBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchDown)
        
        editBtn.removeTarget(nil, action: nil, for: .allEvents)
        editBtn.setTitle("Save1", for: .normal)
        editBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
        
        closeBtn.removeTarget(nil, action: nil, for: .allEvents)
        closeBtn.setTitle("Save", for: .normal)
        closeBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
        
        if contactInfoDetail != nil {
            self.title = "Edit Account"
            self.removeCustomView()
        }
        
    }
}

