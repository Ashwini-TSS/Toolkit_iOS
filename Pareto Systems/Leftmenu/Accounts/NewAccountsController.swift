//
//  NewAccountsController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 18/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import MobileCoreServices

class NewAccountsController: UIViewController {
    var tappedContact:Bool = true
    var selectedNoteID : String = ""
    var isfromcontactPAge:Bool = false
    var rightContactID:String = ""
    var contactAdd:Bool = false
    var globalRegType : String = ""
    var iscommentExpand:Bool = false
    @IBOutlet weak var tblAccount: UITableView!
    var contactInfoDetail:GetAccountsListResult!
    var getSpouseContactListModel:GetSpouseContactModel!
    var passTaskList : Taskmodel!
    var passAppointmentList : GetAppointmentModelModel!
    var primaryContactID:String = ""
    var countryCode:String = "+1"
    var ObjectId : String = ""
    var allcommentExpandArray : [Int] = []
    var contactTypes:NSArray = ["Appointment","Contact","Company","Task"]
    var selecyedAdditioanlAddressIDList:[String] = []
    var selectedLinkedAccountIDList:[String] = []
    var isNoteCellPresent : Bool = false
    var  companynotedata : [NoteList] = []
    var  noteobj : NoteModel!
    var selectedAppointmentList:[String] = []
    var selectedTaskList:[String] = []
    var  noteregardingData : [Any] = []
    var  noteattachmentData : [Any] = []
    var  notecommentData : [Any] = []
    var allmainaccountList:[GetAccountsListResult] = []
    var selectedContactsList:[String] = []
    var selectedContactWholeValue:[String] = []
    var allcreatedRegardingID  : [String] = []
    var allregardingObjectID : [String] = []
    var selectedContactIndx:NSMutableArray = []
    static let companynotify = "companynotify"
    var commentselectedindex : Int = 1111111111
    var iscommentapimethod : Bool = false
    var usersList:[UserlistUser] = []
    static let accountnotify = "accountnotify"
    static let conatctnotify = "conatctnotify"
    static let accoundownnotify = "accoundownnotify"
    static let taskregardingnotify = "taskregardingnotify"
    static let appointementregardingnotify = "appointementregardingnotify"

    var allContactList:[ContactListResult] = []
    var searchCurrNoteid : String!

    var selectedIndexPath_condition:Int = 0
    var selectedNoteIndx : Int = -1

    var primaryContactArray : [String] = []
    var SelectedPrimaryContact : String!
    
    var resultsArray : [JSON] = []
    var linkcontactArray : [String] = []
    
    var resultsaddressArray : [JSON] = []
    var linkaddressArray : [String] = []
    var globalCommentCount : Int = 0

    var selectedIndexPath:Int = 1992001
    var isExpand:Bool = false
    var headerTitles:[String] = ["Additional Addresses","Linked Contacts","Open Activities","Completed Activities","Notes"]
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
    var allTaskregardingSubject : [TaskResult] = []
    var allAppointmentregardingSubject : [GetAppointmentModelData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCustomView()

        if isfromcontactPAge {
            isEditable = true
            print(rightContactID)
        }
        self.listOfUsersBasedOnOrganization()
        tblAccount.register(UINib(nibName: "NoteHeaderCell", bundle: nil), forCellReuseIdentifier: "NoteHeaderCell")
        tblAccount.register(UINib(nibName: "NotesListCell", bundle: nil), forCellReuseIdentifier: "NotesListCell")
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
                //                editBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
            }else{
                if contactInfoDetail != nil {
                    self.title = contactInfoDetail.name
                    self.setupCustomView()
                }
                
                //                editBtn.setTitle("Edit", for: .normal)
                //                self.editBtn.removeTarget(nil, action: nil, for: .allEvents)
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
        
        APIManager.sharedInstance.postRequestCall(postURL: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
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
                let controller:UpdatenewappointmentVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewappointmentVC") as? UpdatenewappointmentVC)!
                controller.linkParentID = self.contactInfoDetail.id!
                controller.accountname = self.contactInfoDetail.name!
                controller.fromAccounts = true
                self.navigationController?.pushViewController(controller, animated: true)
            })
            let Task = UIAlertAction(title: "New Task", style: .default, handler: { (action) -> Void in
                let controller:UpdatenewtaskVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewtaskVC") as? UpdatenewtaskVC)!
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
        
        let addnote = UIAlertAction(title: "Add Note", style: .default, handler: { (action) -> Void in
            let controller:NoteDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailsVC") as! NoteDetailsVC
            controller.fromviewcontroller = "company"
            controller.accountListResult = self.contactInfoDetail
            controller.passDefaultContactname = self.contactInfoDetail.name
            controller.editModeON = false
            self.navigationController?.pushViewController(controller, animated: true)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alertController.addAction(addnote)
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
        self.isNoteCellPresent = false
        self.isExpand = false
        self.pullNotesListFromServerApi()
        tblAccount.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        self.tblAccount.scrollToRow(at: indexPath, at: .top, animated: false)
        setupBasicInfo()
          NotificationCenter.default.addObserver(self, selector: #selector(self.CommentApiMethod(notfication:)), name: NSNotification.Name(rawValue: NewAccountsController.companynotify), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(self.movetheRegardingAccounts(notfication:)), name: NSNotification.Name(rawValue: NewAccountsController.accountnotify), object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(self.movetheRegardingConatcts(notfication:)), name: NSNotification.Name(rawValue: NewAccountsController.conatctnotify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.movetheRegardingAppoinments(notfication:)), name: NSNotification.Name(rawValue: NewAccountsController.appointementregardingnotify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openContactAttachmentFile(notfication:)), name: NSNotification.Name(rawValue: NewAccountsController.accoundownnotify), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        selectedIndexPath = 1992001
        isExpand = false
        
        
        tblAccount.setContentOffset(.zero, animated: false)
        tblAccount.reloadData()
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.tblAccount.scrollToRow(at: indexPath, at: .top, animated: false)
    
        bottomView.removeFromSuperview()
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: NewAccountsController.companynotify), object: nil)
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: NewAccountsController.accountnotify), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  NewAccountsController.accoundownnotify) , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  NewAccountsController.conatctnotify) , object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:  NewAccountsController.appointementregardingnotify) , object: nil)

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
        
        APIManager.sharedInstance.postRequestCall(postURL:globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/delete.json", parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
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
    
    //MARK: - PullNotesDataFromServer
    func pullNotesListFromServerApi()
    {
        self.companynotedata.removeAll()
        self.allcommentExpandArray.removeAll()
        if contactInfoDetail != nil {
            let json: [String: Any] = ["OrderBy":"CreatedOn",
                                       "AscendingOrder":false,
                                       "ResultsPerPage":100,
                                       "PageOffset":1,
                                       "ParentId":self.contactInfoDetail.id,
                                       "ObjectName":"company",
                                       "PassKey":passKey,
                                       "OrganizationId":currentOrgID]
            OperationQueue.main.addOperation {
                SVProgressHUD.show()
            }
            let url = URL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/listNotes.json")!
            var request = URLRequest(url: url)
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.addValue("en", forHTTPHeaderField: "Accept-Language")
            request.httpMethod = "POST"
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
                request.httpBody = jsonData
            }
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            let task = session.dataTask(with: request){ data, response, error in
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                    self.noteobj = try? JSONDecoder().decode(NoteModel.self, from: data)
                    self.companynotedata =  self.noteobj.notedata!
                    for(_,_) in self.companynotedata.enumerated()
                    {
                        self.allcommentExpandArray.append(0)
                    }
                    self.PullDownAllNoteRegardingsFromServer()
                    self.PullDownAllCommentsFromServer()
                }
            }
            task.resume()
        }
    }
    //MARK: - PullDownAllNoteRegardingsFromServer
    func PullDownAllNoteRegardingsFromServer()
    {
        self.noteregardingData.removeAll()
        for(index,element) in self.companynotedata.enumerated()
        {
            let json: [String: Any] = [
                "ParentId":element.note?.id,
                "ParentObjectName":"note",
                "ObjectName": "notes_regarding",
                "PassKey":passKey,
                "OrganizationId":currentOrgID,
                "AscendingOrder":true]
            
            OperationQueue.main.addOperation {
                SVProgressHUD.show()
            }
            let url = URL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json")!
            var request = URLRequest(url: url)
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.addValue("en", forHTTPHeaderField: "Accept-Language")
            request.httpMethod = "POST"
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
                request.httpBody = jsonData
            }
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            let task = session.dataTask(with: request){ data, response, error in
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                    let reobj = try? JSONDecoder().decode(NoteRegardingModel.self, from: data)
                    self.noteregardingData.append(reobj?.regardingobj)
                    DispatchQueue.main.async {
                        self.tblAccount.reloadData()
                    }
                    if(index == self.companynotedata.count - 1)
                    {
                        self.PullDownAllNoteAttachmentFromServer()
                    }
                }
            }
            task.resume()
            
        }
    }
    //MARK: - PullDownAllNoteAttachmentFromServer
    func PullDownAllNoteAttachmentFromServer()
    {
        self.noteattachmentData.removeAll()
        for(index,element) in self.companynotedata.enumerated()
        {
            let json: [String: Any] = [
                "ParentId":element.note?.id as? String,
                "ParentObjectName":"note",
                "ObjectName": "note_attachment",
                "PassKey":passKey,
                "OrganizationId":currentOrgID,
                "AscendingOrder":true]
            let url = URL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json")!
            var request = URLRequest(url: url)
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.addValue("en", forHTTPHeaderField: "Accept-Language")
            request.httpMethod = "POST"
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
                request.httpBody = jsonData
            }
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            let task = session.dataTask(with: request){ data, response, error in
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                    let reobj = try? JSONDecoder().decode(NoteRegardingModel.self, from: data)
                    if((reobj?.regardingobj!.count)! > 0){
                        self.noteattachmentData.append(reobj?.regardingobj!)
                    }
                }
            }
            task.resume()
        }
    }
    //MARK: - PullDownAllCommentsFromServer
    func PullDownAllCommentsFromServer()
    {
        self.notecommentData.removeAll()
        for(indexs,element) in self.companynotedata.enumerated()
        {
            let json: [String: Any] = [
                "ParentId":element.note?.id as? String,
                "ParentObjectName":"note",
                "ObjectName": "note_comment",
                "PageOffset":1,
                "ResultsPerPage":100,
                "OrderBy":"CreatedOn",
                "PassKey":passKey,
                "OrganizationId":currentOrgID,
                "AscendingOrder":false]
            let url = URL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json")!
            var request = URLRequest(url: url)
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.addValue("en", forHTTPHeaderField: "Accept-Language")
            request.httpMethod = "POST"
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
                request.httpBody = jsonData
            }
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            let task = session.dataTask(with: request){ data, response, error in
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                    if(indexs == self.companynotedata.count - 1){
                        if(self.iscommentapimethod)
                        {
                            self.iscommentapimethod = false
                            DispatchQueue.main.async {
                                self.tblAccount.reloadData()
                            }
                        }}
                    let reobj = try? JSONDecoder().decode(NoteCommentModel.self, from: data)
                    if((reobj?.commentdata!.count)! > 0){
                        self.notecommentData.append(reobj?.commentdata!)
                        self.tblAccount.reloadData()
                    }
                }
            }
            task.resume()
        }
    }
    //MARK: - Regarding's Action
    @objc func searchNoteButtonTapped(_ sender: UIButton)
    {
        self.selectedNoteIndx = sender.tag
        self.selectedNoteID =  self.companynotedata[sender.tag].note!.id
        searchCurrNoteid = self.companynotedata[sender.tag].note?.id
        self.showContactsPicker()
    }
    //MARK: - Attach Action
    @objc func attachNoteButtonTapped(_ sender: UIButton)
    {
        self.selectedNoteIndx = sender.tag
        self.selectedNoteID =  self.companynotedata[sender.tag].note!.id
        var types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet,kUTTypeGIF,kUTTypePNG,kUTTypeHTML,kUTTypeJPEG,kUTTypeMPEG,kUTTypeAudio,kUTTypeMP3,kUTTypeMovie,kUTTypeMPEG4,kUTTypeBMP,kUTTypeXML,kUTTypeICO,kUTTypeText,kUTTypeTIFF]
        types.append("com.microsoft.word.doc" as CFString)
        types.append("com.apple.iwork.pages.pages" as CFString)
        types.append("com.apple.iwork.keynote.key" as CFString)
        types.append("com.apple.application" as CFString)
        types.append("public.item" as CFString)
        types.append("public.data" as CFString)
        types.append("public.content" as CFString)
        types.append("public.audiovisual-content" as CFString)
        types.append("public.movie" as CFString)
        types.append("public.audio" as CFString)
        types.append("public.text" as CFString)
        types.append("public.data" as CFString)
        types.append("public.zip-archive" as CFString)
        types.append("public.composite-content" as CFString)
        types.append("public.text" as CFString)
        let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
        importMenu.delegate = self
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.blue], for: .normal)
        self.present(importMenu, animated: true, completion: nil)
    }
    //MARK: - Edit Action
    @objc func editNoteButtonTapped(_ sender: UIButton)
    {
        self.selectedNoteID =  self.companynotedata[sender.tag].note!.id
        let controller:NoteDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailsVC") as! NoteDetailsVC
        controller.fromviewcontroller = "company"
        controller.accountListResult = self.contactInfoDetail
        controller.editModeON = true
        controller.editContactList = self.allContactList
        controller.mainaccountList = self.allmainaccountList
        controller.editpassTaskmodel = self.passTaskList
        controller.editpassAppoinementmodel = self.passAppointmentList
        controller.editNoteID = self.companynotedata[sender.tag].note!.id
        controller.editnotetext = self.companynotedata[sender.tag].note!.note ?? ""
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK: - Comment Action
    @objc func commentTableviewExpandAction(_ sender: UIButton)
    {
        iscommentExpand = true
        if(self.allcommentExpandArray[sender.tag] == 0)
        {
            self.allcommentExpandArray.insert(1, at: sender.tag)
            self.allcommentExpandArray.remove(at: sender.tag + 1)
        }else
        {
            self.allcommentExpandArray.insert(0, at: sender.tag)
            self.allcommentExpandArray.remove(at: sender.tag + 1)
        }
        let currNoteid = self.companynotedata[sender.tag].note?.id
        for(indx,_) in self.notecommentData.enumerated()
        {
            let valu = self.notecommentData[indx] as? [CommnetResults]
            if (currNoteid == valu?.first?.noteID)
            {
                self.globalCommentCount = valu!.count
            }
        }
        self.tblAccount.reloadSections(IndexSet(integer: 9), with: .none)
        let indexPath = IndexPath(row: sender.tag + 1, section: 9)
        self.tblAccount.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    @objc func commentNoteButtonTapped(_ sender: UIButton)
    {
        self.selectedNoteID =  self.companynotedata[sender.tag].note!.id
        let modalViewController:AddCommentVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCommentVC") as! AddCommentVC
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.istype = "comment"
        modalViewController.fromviewController = "company"
        self.present(modalViewController, animated: true, completion: nil)
    }
    //MARK: - Add Button Action
    @objc func AddNoteButtonTapped(_ button: UIButton) {
        let controller:NoteDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "NoteDetailsVC") as! NoteDetailsVC
        controller.fromviewcontroller = "company"
        controller.accountListResult = self.contactInfoDetail
        controller.passDefaultContactname = contactInfoDetail.name
        controller.editModeON = false
        self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK: - Show Type Picker
    func showContactsPicker(){
        let selecttypeindx:NSMutableArray = []
        let picker = CZPickerView(headerTitle: "Apply To Type", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        selecttypeindx.add(2)
        picker?.setSelectedRows(selecttypeindx as? [Any])
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = false
        picker?.tag = 0
        picker?.show()
    }
    //MARK: - Show Appointment Picker
    func showChooseAppointmentPicker(){
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Appointment", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        for (index,elemnt) in self.passAppointmentList.results.enumerated() {
            
            if (self.selectedContactsList.contains(elemnt.id!))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1114
        picker?.show()
    }
    //MARK: - Show Task Picker
    func showChooseTaskPicker(){
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Task", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        for (index,elemnt) in self.passTaskList.results.enumerated() {
            
            if (self.selectedContactsList.contains(elemnt.id!))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1116
        picker?.show()
    }
    //MARK: - Show Conatcts Picker
    func showChooseContactsPicker(){
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Contact", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        for (index,elemnt) in self.allContactList.enumerated() {
            
            if (self.selectedContactsList.contains(elemnt.id))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1112
        picker?.show()
    }
    //MARK: - Show Company Picker
    func showChooseCompanysPicker(){
        self.selectedContactIndx = []
        let picker = CZPickerView(headerTitle: "Choose Company", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        
        for (index,elemnt) in self.allmainaccountList.enumerated() {
            
            if (self.selectedContactsList.contains(elemnt.id))
            {
                self.selectedContactIndx.add(index)
            }
        }
        if(self.selectedContactIndx.count > 0)
        {
            picker?.setSelectedRows(selectedContactIndx as? [Any])
        }
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 1002
        picker?.show()
    }
    // Mark:- selected cells of regarding
    @objc func movetheRegardingAccounts(notfication : NSNotification)
    {
        guard let selecteditem = notfication.userInfo?["item"] as? GetAccountsListResult else
        {
            return
        }
        if(contactInfoDetail.id == selecteditem.id){
            return
        }else{
            
            let controller:NewAccountsController = self.storyboard?.instantiateViewController(withIdentifier:"NewAccountsController") as! NewAccountsController
            controller.contactInfoDetail = selecteditem
            controller.allmainaccountList = allmainaccountList
            controller.allContactList = self.allContactList
            controller.passAppointmentList = self.passAppointmentList
            controller.passTaskList = self.passTaskList
            self.navigationController?.pushViewController(controller, animated: true)
    }
    }
    @objc func movetheRegardingConatcts(notfication : NSNotification)
    {
        guard let selecteditem = notfication.userInfo?["item"] as? ContactListResult else
        {
            return
        }
        
            let controller:ContactssController = self.storyboard?.instantiateViewController(withIdentifier:"ContactssController") as! ContactssController
            controller.contactInfoDetail = selecteditem
            controller.allContactList = allContactList
        controller.passAppointmentList = self.passAppointmentList
        controller.passTaskList = self.passTaskList
        controller.allmainaccountList = self.allmainaccountList
            self.navigationController?.pushViewController(controller, animated: true)
    }
    @objc func movetheRegardingAppoinments(notfication : NSNotification)
    {
        guard let selecteditem = notfication.userInfo?["item"] as? GetAppointmentModelData else
        {
            return
        }
        
        var gDict = [String : Any]()
        gDict["RecurringActivityId"] = selecteditem.recurringActivityID
        gDict["DueTime"] = ""
        gDict["Priority"] = 0
        gDict["AdvocateProcessIndex"] = selecteditem.advocateProcessIndex
        gDict["PercentComplete"] = 0
        gDict["AppointmentTypeId"] = selecteditem.appointmentTypeID
        gDict["AllDay"] = selecteditem.allDay
        gDict["AppliedAdvocateProcessId"] = selecteditem.appliedAdvocateProcessID
        gDict["Complete"] = selecteditem.complete
        gDict["CreatedBy"] = selecteditem.createdBy
        gDict["CreatedOn"] = selecteditem.createdOn
        gDict["Description"] = selecteditem.resultDescription
        gDict["EndTime"] = selecteditem.endTime
        gDict["Id"] = selecteditem.id
        gDict["Location"] = selecteditem.location
        gDict["ModifiedBy"] = selecteditem.modifiedBy
        gDict["ModifiedOn"] = selecteditem.modifiedOn
        gDict["RecurrenceIndex"] = selecteditem.recurrenceIndex
        gDict["RollOver"] = selecteditem.rollOver
        gDict["StartTime"] = selecteditem.startTime
        gDict["Subject"] = selecteditem.subject
        gDict["Activity"] = nil
        gDict["Type"] = ""

        
        
        
        var cDict = [String : Any]()
        cDict["RecurringActivityId"] = selecteditem.recurringActivityID
        cDict["DueTime"] = ""
        cDict["Priority"] = 0
        cDict["AdvocateProcessIndex"] = selecteditem.advocateProcessIndex
        cDict["PercentComplete"] = 0
        cDict["AppointmentTypeId"] = selecteditem.appointmentTypeID
        cDict["AllDay"] = selecteditem.allDay
        cDict["AppliedAdvocateProcessId"] = selecteditem.appliedAdvocateProcessID
        cDict["Complete"] = selecteditem.complete
        cDict["CreatedBy"] = selecteditem.createdBy
        cDict["CreatedOn"] = selecteditem.createdOn
        cDict["Description"] = selecteditem.resultDescription
        cDict["EndTime"] = selecteditem.endTime
        cDict["Id"] = selecteditem.id
        cDict["Location"] = selecteditem.location
        cDict["ModifiedBy"] = selecteditem.modifiedBy
        cDict["ModifiedOn"] = selecteditem.modifiedOn
        cDict["RecurrenceIndex"] = selecteditem.recurrenceIndex
        cDict["RollOver"] = selecteditem.rollOver
        cDict["StartTime"] = selecteditem.startTime
        cDict["Subject"] = selecteditem.subject
        cDict["Activity"] = gDict
        cDict["Type"] = ""
        
    let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: cDict )
    let controller:UpdatenewappointmentVC = self.storyboard?.instantiateViewController(withIdentifier:"UpdatenewappointmentVC") as! UpdatenewappointmentVC
        controller.openedActivties = getAddress
        controller.contactList = self.allContactList
        controller.importaccountList = self.allmainaccountList
        controller.appointmentList = self.passAppointmentList
        controller.taskmodelobj = self.passTaskList
    self.navigationController?.pushViewController(controller, animated: true)
    }
    //MARK: - Height for the text view
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    //MARK: - Open Attachment file
    @objc func openContactAttachmentFile(notfication : NSNotification)
    {
        
        guard let noteid = notfication.userInfo?["noteid"] as? String else
        {
            return
        }
        guard let attachid = notfication.userInfo?["attachid"] as? String else
        {
            return
        }
        guard let filename = notfication.userInfo?["filename"] as? String else
        {
            return
        }
        let currentTime = String(Date().toMillis())
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
        }
        let urlString = globalURL+"/note_attachment/\(currentOrgID)/\(noteid)/\(attachid)"
        let separr = filename.components(separatedBy: ".")
        let firststr = separr.first! + currentTime
        let secstr = firststr + "." + (separr.last?.lowercased())!
        // Create destination URL
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent("\(secstr)")
        //Create URL to the source file you want to download
        let fileURL = URL(string: urlString)
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        var request = URLRequest(url:fileURL!)
        request.setValue(passKey, forHTTPHeaderField: "X-VCPassKey")
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                do {
                    OperationQueue.main.addOperation {
                        SVProgressHUD.dismiss()
                    }
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    do {
                            //Show UIActivityViewController to save the downloaded file
                            let contents  = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                            for indexx in 0..<contents.count {
                                if contents[indexx].lastPathComponent == destinationFileUrl.lastPathComponent {
                                    DispatchQueue.main.async {

                                    let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                                    self.present(activityViewController, animated: true, completion: nil)
                                    }
                                }
                            }
                    }
                    catch (let err) {
                        print("error: \(err)")
                    }
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(error?.localizedDescription ?? "")")
            }
        }
        task.resume()
    }
    //MARK: - Comment Action
    func listOfUsersBasedOnOrganization() {
        
        let json: [String: Any] = ["OrganizationId": currentOrgID,
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: userListByOrgURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:UserlistMapping = UserlistMapping.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    self.usersList = logModel.users
                    OperationQueue.main.addOperation {
                        print(self.usersList.count)
                        
                    }
                }else{
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    @objc func CommentApiMethod(notfication: NSNotification)
    {
        let cmtMsg = notfication.userInfo?["msg"] as? String
        let json: [String: Any] = ["ObjectName":"note_comment",
                                   "DataObject": [
                                    "NoteId": self.selectedNoteID,
                                    "Comment": cmtMsg],
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey] as [String : Any]
        
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                
                self.iscommentapimethod = true
                self.PullDownAllCommentsFromServer()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    func deleteRegardingContactAction(ObjectId : String)
    {
        let json: [String: Any] = ["ObjectName":"notes_regarding",
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey,
                                   "ObjectId":ObjectId
        ]
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print("jsonSecond:",json)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func secondCreateAPi(noteID : String, RegardingId : String){
        var regtype : String = ""
        if(self.globalRegType == "contact")
        {
            regtype = "contact"
        }else if(self.globalRegType == "appointment")
        {
            regtype = "appointment"
        }
        else if(self.globalRegType == "task")
        {
            regtype = "task"
        }
        else
        {
             regtype = "company"
        }
        let json: [String: Any] = ["ObjectName":"notes_regarding",
                                   "DataObject": [
                                    "NoteId" : noteID,
                                    "RegardingId": RegardingId,
                                    "RegardingType":regtype],
                                   "OrganizationId":currentOrgID,
                                   "PassKey": passKey] as [String : Any]
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print("jsonSecond:",json)
//                self.allcreatedRegardingID.append(RegardingId)
//                self.allregardingObjectID.append( json["DataObject"]["Id"].stringValue)
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
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
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars = Set("+1234567890")
        return text.filter {okayChars.contains($0) }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag < 0 && !isEditable {
            if textField.tag == -1 || textField.tag == -2 || textField.tag == -3 || textField.tag == -4 {
                if textField.text!.count > 0 {
                    let result = removeSpecialCharsFromString(text:textField.text!)
                    if let url = URL(string: "tel://\(result)") {
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
                                   "ResultsPerPage": 5000,
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
                                   "ResultsPerPage": 5000,
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
//                        var abc : GetIncompleteActivity!
//                        var sample : GetIncompleteActivity!
//                        var dateString : String!
//                        for (index,element) in model.activities.enumerated()
//                        {
//                            var appoinid = element.activity.AppliedAdvocateProcessId as? String
//                            if(appoinid != nil){
//                            }
//                            else{
//                                appoinid = ""
//                            }
//                            let start : String = model.activities[index].activity.startTime
//                            var end : String = model.activities[index].activity.endTime
//                            if(end == ""){
//                                end = model.activities[index].activity.DueTime
//                            }
//                            let dateFormatter = DateFormatter()
//                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//                            var st_date : Date = dateFormatter.date(from: start)!
//                            let en_date : Date = dateFormatter.date(from: end)!
//                            let diff = Calendar.current.dateComponents([.day], from: st_date, to: en_date)
//                            if diff.day == 0 {
//                            } else {
//                                for i in stride(from: diff.day!, to: 0, by: -1) {
//                                    let tomorrow = Calendar.current.date(byAdding:.day,value: 1,to: st_date)
//                                    dateString = dateFormatter.string(from: tomorrow!)
//                                    st_date = tomorrow!
//                                    sample = element.copy() as? GetIncompleteActivity
//                                    abc = element.activity.copy() as? GetIncompleteActivity
//                                    abc.startTime = dateString
//                                    sample.activity = abc
//                                    model.activities.append(sample)
//                                }
//                            }
//                        }
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
extension NewAccountsController: UIDocumentPickerDelegate,UINavigationControllerDelegate
{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
        let urlString: String = myURL.absoluteString
        let fullNameArr = urlString.components(separatedBy: "/")
        let filename = fullNameArr.last
        var originalfile = filename?.replacingOccurrences(of: "%20", with: "")
        
        let filePath: NSString = myURL.path as NSString
        let fileSize : UInt64
        do{
            let attr:NSDictionary? = try FileManager.default.attributesOfItem(atPath: filePath as String) as NSDictionary
            if let _attr = attr {
                fileSize = _attr.fileSize();
                let formatter = ByteCountFormatter()
                formatter.allowedUnits = [.useMB]
                formatter.countStyle = .file
                let displaySize = formatter.string(fromByteCount: Int64(fileSize))
                print(displaySize)// prints: 2.6 MB
                if(displaySize > "50.0 MB")
                {
                    NavigationHelper.showSimpleAlert(message:"Your file is \(displaySize) long. we allow size only upto 50 MB.")
                    return
                }
            }
        }
        catch{
            print(error.localizedDescription)
        }
        let path = myURL.path
        let imgdata = FileManager.default.contents(atPath: path)!
        self.request(withImages: ["X-VCPassKey": passKey], parameters: nil, imageNames: [originalfile!], images: [imgdata]) { (data, error, status) in
            print(data!)
            print(status)
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func request(withImages headers:[String:String]?, parameters: [String:Any]?,imageNames : [String], images:[Data], completion: @escaping(Any?, Error?, Bool)->Void) {
        
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
        }
        let stringUrl = globalURL+"/note_attachment/\(currentOrgID)/\(self.selectedNoteID)"
        
        let boundary = UUID().uuidString
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        print("\n\ncomplete Url :-------------- ",stringUrl," \n\n-------------: complete Url")
        guard let url = URL(string: stringUrl) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        if headers != nil{
            print("\n\nHeaders :-------------- ",headers as Any,"\n\n --------------: Headers")
            for (key, value) in headers! {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        if parameters != nil{
            for(key, value) in parameters!{
                // Add the reqtype field and its value to the raw http request data
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                data.append("\(value)".data(using: .utf8)!)
            }
        }
        for (index,imageData) in images.enumerated() {
            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(imageNames[index])\"; filename=\"\(imageNames[index])\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            data.append(imageData)
        }
        
        // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: request, from: data, completionHandler: { data, response, error in
            
            OperationQueue.main.addOperation {
                SVProgressHUD.dismiss()
            }
            
            if let checkResponse = response as? HTTPURLResponse{
                if checkResponse.statusCode == 200{
                    guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.allowFragments]) else {
                        completion(nil, error, false)
                        return
                    }
                    do{
                        DispatchQueue.main.async {
                            let reobj = try? JSONDecoder().decode(NoteRegardingModel.self, from: data)
                            var isadded : Bool = false
                            if((reobj?.regardingobj!.count)! > 0){
                                for(indx,_) in self.noteattachmentData.enumerated()
                                {
                                    var valu = self.noteattachmentData[indx] as? [NoteRegardingList]
                                    
                                    if (self.selectedNoteID == valu?.first?.noteID)
                                    {
                                        isadded = true
                                        valu?.append((reobj?.regardingobj!.first)!)
                                        self.noteattachmentData.append(valu!)
                                    }
                                }
                                if(!isadded)
                                {
                                    self.noteattachmentData.append(reobj?.regardingobj!)
                                }
                                self.tblAccount.reloadData()
                            }
                        }
                    }
                    catch
                    {
                        print(error.localizedDescription)
                    }
                    completion(json, nil, true)
                }else{
                    guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                        completion(nil, error, false)
                        return
                    }
                    let jsonString = String(data: data, encoding: .utf8)!
                    print("\n\n---------------------------\n\n"+jsonString+"\n\n---------------------------\n\n")
                    
                    completion(json, nil, false)
                }
            }else{
                guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    completion(nil, error, false)
                    return
                }
                completion(json, nil, false)
            }
            
        }).resume()
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
        }else if section == 9 {
            if section == 9 {
                if(isNoteCellPresent)
                {
                    return self.companynotedata.count + 1
                }else
                {
                    return 1
                }
            }
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
        }else if indexPath.section == 9 {
            
            if(indexPath.row == 0)
            {
                let notecell:NoteHeaderCell = tableView.dequeueReusableCell(withIdentifier: "NoteHeaderCell", for: indexPath) as! NoteHeaderCell
                if(isExpand && selectedIndexPath_condition == indexPath.section){
                    notecell.addnotebtn.isHidden = false
                }
                else{
                    notecell.addnotebtn.isHidden = true
                }
                if selectedIndexPath == 10 {
                    notecell.imgarrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
                }else{
                    notecell.imgarrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
                }
                notecell.addnotebtn.tag = indexPath.section
                notecell.isUserInteractionEnabled = true
                notecell.addnotebtn.addTarget(self, action: #selector(AddNoteButtonTapped(_:)), for: .touchUpInside)
                return notecell
            }else
            {
                let notedetailcell:NotesListCell = tableView.dequeueReusableCell(withIdentifier: "NotesListCell", for: indexPath) as! NotesListCell
                if !(self.companynotedata.count > 0){
                     return notedetailcell
                }
                let isdraft = (self.companynotedata[indexPath.row - 1].note?.draft)!
                if(isdraft)
                {
                    notedetailcell.draftLblOutlet.isHidden = false
                    notedetailcell.editWidthConstraint.constant = 22 // displayed edit buttonediting
                }else{
                    notedetailcell.draftLblOutlet.isHidden = true
                    notedetailcell.editWidthConstraint.constant = 0 // hide edit button
                }
                
                // created on - date
                let sdate = (self.companynotedata[indexPath.row - 1].note?.createdOn)!
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                let st_date : Date = dateFormatter.date(from: sdate)!
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let firdate = dateFormatter.string(from: st_date)
                dateFormatter.dateFormat = "hh:mm:ss a"
                let secdate = dateFormatter.string(from: st_date)
                
                //created by - organization name
                
                for(_,elem) in self.usersList.enumerated()
                {
                    if(self.companynotedata[indexPath.row - 1].note?.createdBy == elem.id)
                    {
                        let cname = elem.firstName + " " + elem.lastName
                        notedetailcell.createOnLbl.text = firdate + ", " + secdate + " by " + cname
                        break
                    }
                }
                // note text
                let noteee = self.companynotedata[indexPath.row - 1].note!.note
                if(noteee != nil && noteee != ""){
                    notedetailcell.noteTxtViewOutlet.isHidden = false
                }else
                {
                    notedetailcell.noteTxtViewOutlet.isHidden = false
                }
                notedetailcell.noteTxtViewOutlet.text = self.companynotedata[indexPath.row - 1].note!.note
                
                //regarding contact name
                var allregardingID : [String] = []
                let currNoteid = self.companynotedata[indexPath.row - 1].note?.id
                for(index,_) in self.noteregardingData.enumerated(){
                    
                    let valu = self.noteregardingData[index] as? [NoteRegardingList]
                    
                    if(currNoteid == valu?.first?.noteID)
                    {
                        for(_,ele) in (valu?.enumerated())!
                        {
                            allregardingID.append(ele.regardingID!) // add all note - regarding id into array
                        }
                        break
                    }
                }
                // to fetch contact name
                var collectallname : [String] = []
                var allregardingname : [GetAccountsListResult] = []
                var contactregardingname : [ContactListResult] = []
                for(_, elem) in allregardingID.enumerated()
                {
                    for(_,ele) in self.allmainaccountList.enumerated(){
                        if(elem == ele.id)
                        {
                            allregardingname.append(ele)
                            collectallname.append(ele.name)
                        }
                    }
                    for(_,ele) in self.allContactList.enumerated(){
                        if(elem == ele.id)
                        {
                            contactregardingname.append(ele)
                            collectallname.append(ele.fullName)
                        }
                    }
                    if(self.passAppointmentList != nil){
                    for(_,ele) in self.passAppointmentList.results.enumerated()
                    {
                        if(elem == ele.id)
                        {
                            allAppointmentregardingSubject.append(ele)
                            collectallname.append(ele.subject!)
                        }
                    }
                    }
                    if(self.passTaskList != nil){
                    for(_,ele) in self.passTaskList.results.enumerated()
                    {
                        if(elem == ele.id)
                        {
                            allTaskregardingSubject.append(ele)
                            collectallname.append(ele.subject!)

                        }
                    }
                    }
                }
                // assign regarding name to cell
                notedetailcell.regattachlist = contactregardingname
                notedetailcell.regaccountlist = allregardingname
                notedetailcell.regTasklist = allTaskregardingSubject
                notedetailcell.regAppointmentlist = allAppointmentregardingSubject
                notedetailcell.allnames = collectallname
                notedetailcell.noteplace = "account"
                if(collectallname.count > 0)
                {
                    if(collectallname.count <= 2)
                    {
                        notedetailcell.regardingheightConstraint.constant = 48
                    }else
                    {
                        if(collectallname.count % 2 == 0) // if even set height below
                        {
                            notedetailcell.regardingheightConstraint.constant = CGFloat((collectallname.count/2) * 48)
                        }
                        else // if odd set height below
                        {
                            let hght = CGFloat((collectallname.count/2) * 48)
                            notedetailcell.regardingheightConstraint.constant = hght + 48
                        }
                    }
                }
                notedetailcell.regardingCollectionview.reloadData()
                var isvaluepresent : Bool = false
                
                // attachment collectionview passing values
                for(indx,_) in self.noteattachmentData.enumerated()
                {
                    let valu = self.noteattachmentData[indx] as? [NoteRegardingList]
                    
                    if (currNoteid == valu?.first?.noteID)
                    {
                        notedetailcell.attachlblHeight.constant = 18
                        isvaluepresent = true
                        notedetailcell.typeattachlist = valu!
                        if(valu!.count > 0)
                        {
                            if(valu!.count <= 2)
                            {
                                notedetailcell.attachCollectionViewHeightConstraint.constant = 48
                            }else
                            {
                                if(valu!.count % 2 == 0) // if even set height below
                                {
                                    notedetailcell.attachCollectionViewHeightConstraint.constant = CGFloat((allregardingname.count/2) * 48)
                                }else // if odd set height below
                                {
                                    let hght = CGFloat((allregardingname.count/2) * 48)
                                    notedetailcell.attachCollectionViewHeightConstraint.constant = hght + 50
                                }
                            }
                        }
                        notedetailcell.attachCollectionView.reloadData()
                    }
                }
                if(!isvaluepresent) // if no attachment is present for current note
                {
                    notedetailcell.typeattachlist = []
                    notedetailcell.attachlblHeight.constant = 0
                    notedetailcell.attachCollectionViewHeightConstraint.constant = 0
                }
                
                // attachment collectionview passing values
                for(indx,_) in self.noteattachmentData.enumerated()
                {
                    let valu = self.noteattachmentData[indx] as? [NoteRegardingList]
                    if (currNoteid == valu?.first?.noteID)
                    {
                        notedetailcell.attachlblHeight.constant = 18
                        isvaluepresent = true
                        notedetailcell.typeattachlist = valu!
                        if(valu!.count > 0)
                        {
                            if(valu!.count <= 2)
                            {
                                notedetailcell.attachCollectionViewHeightConstraint.constant = 48
                            }else
                            {
                                if(valu!.count % 2 == 0) // if even set height below
                                {
                                    notedetailcell.attachCollectionViewHeightConstraint.constant = CGFloat((valu!.count/2) * 48)
                                }else // if odd set height below
                                {
                                    let hght = CGFloat((valu!.count/2) * 48)
                                    notedetailcell.attachCollectionViewHeightConstraint.constant = hght + 50
                                }
                            }
                        }
                        notedetailcell.attachCollectionView.reloadData()
                    }
                }
                if(!isvaluepresent) // if no attachment is present for current note
                {
                    notedetailcell.typeattachlist = []
                    notedetailcell.attachlblHeight.constant = 0
                    notedetailcell.attachCollectionViewHeightConstraint.constant = 0
                }
                
                // comment tableview passing values
                var iscommentpresent : Bool = false
                var height : CGFloat = 0.0
                if(iscommentExpand){
                    if(self.allcommentExpandArray[indexPath.row - 1] == 1){
                        for(indx,_) in self.notecommentData.enumerated()
                        {
                            let valu = self.notecommentData[indx] as? [CommnetResults]
                            if (currNoteid == valu?.first?.noteID)
                            {
                                iscommentpresent = true
                                notedetailcell.cellusersList = self.usersList
                                notedetailcell.comments = valu!
                                let font = UIFont(name: "Helvetica", size: 14.0)!
                                for(indx,_) in (valu?.enumerated())!
                                {
                                    height += heightForView(text: notedetailcell.comments[indx].comment!, font: font, width: notedetailcell.commentTableview.frame.width) + 40
                                }
                                notedetailcell.commentTablHeightConstarint.constant = height
                                notedetailcell.commentsBtnHeightConstraint.constant =  40
                                notedetailcell.commentExpandOutlet.isHidden = false
                                notedetailcell.commentImage.isHidden = false
                                notedetailcell.commentImage.image = UIImage(named: "ic_down_arrow_black")
                                notedetailcell.commentTableview.reloadData()
                            }
                        }
                        if(!iscommentpresent) // if no attachment is present for current note
                        {
                            notedetailcell.comments = []
                            notedetailcell.commentExpandOutlet.isHidden = true
                            notedetailcell.commentImage.isHidden = true
                            notedetailcell.commentsBtnHeightConstraint.constant =  0
                            notedetailcell.commentTablHeightConstarint.constant = 0
                            notedetailcell.commentTableview.reloadData()
                        }}
                    else
                    {
                        if(self.notecommentData.count > 0){
                            for(indx,_) in self.notecommentData.enumerated()
                            {
                                let valu = self.notecommentData[indx] as? [CommnetResults]
                                if (currNoteid == valu?.first?.noteID)
                                {
                                    iscommentpresent = true
                                    notedetailcell.comments = []
                                    notedetailcell.commentImage.image = UIImage(named: "ic_forward")
                                    notedetailcell.commentExpandOutlet.isHidden = false
                                    notedetailcell.commentImage.isHidden = false
                                    notedetailcell.commentsBtnHeightConstraint.constant =  40
                                    notedetailcell.commentTablHeightConstarint.constant = 0
                                    notedetailcell.commentTableview.reloadData()
                                }
                            }
                            if(!iscommentpresent) // if no attachment is present for current note
                            {
                                notedetailcell.comments = []
                                notedetailcell.commentExpandOutlet.isHidden = true
                                notedetailcell.commentImage.isHidden = true
                                notedetailcell.commentsBtnHeightConstraint.constant =  0
                                notedetailcell.commentTablHeightConstarint.constant = 0
                                notedetailcell.commentTableview.reloadData()
                            }}else
                        {
                            notedetailcell.comments = []
                            notedetailcell.commentExpandOutlet.isHidden = true
                            notedetailcell.commentImage.isHidden = true
                            notedetailcell.commentsBtnHeightConstraint.constant =  0
                            notedetailcell.commentTablHeightConstarint.constant = 0
                            notedetailcell.commentTableview.reloadData()
                        }
                        
                    }
                }else
                {
                    if(self.notecommentData.count > 0){
                        for(indx,_) in self.notecommentData.enumerated()
                        {
                              let valu = self.notecommentData[indx] as? [CommnetResults]
                            if (currNoteid == valu?.first?.noteID)
                            {
                                iscommentpresent = true
                                notedetailcell.comments = []
                                notedetailcell.commentImage.image = UIImage(named: "ic_forward")
                                notedetailcell.commentExpandOutlet.isHidden = false
                                notedetailcell.commentImage.isHidden = false
                                notedetailcell.commentsBtnHeightConstraint.constant =  40
                                notedetailcell.commentTablHeightConstarint.constant = 0
                                notedetailcell.commentTableview.reloadData()
                            }
                        }
                        if(!iscommentpresent) // if no attachment is present for current note
                        {
                            notedetailcell.comments = []
                            notedetailcell.commentExpandOutlet.isHidden = true
                            notedetailcell.commentImage.isHidden = true
                            notedetailcell.commentsBtnHeightConstraint.constant =  0
                            notedetailcell.commentTablHeightConstarint.constant = 0
                            notedetailcell.commentTableview.reloadData()
                        }}else
                    {
                        notedetailcell.comments = []
                        notedetailcell.commentExpandOutlet.isHidden = true
                        notedetailcell.commentImage.isHidden = true
                        notedetailcell.commentsBtnHeightConstraint.constant =  0
                        notedetailcell.commentTablHeightConstarint.constant = 0
                        notedetailcell.commentTableview.reloadData()
                    }
                    
                }
                let contentSizetxt = notedetailcell.noteTxtViewOutlet.sizeThatFits(notedetailcell.noteTxtViewOutlet.bounds.size)
                
                let txtheight =  contentSizetxt.height
                
//                if(notedetailcell.commentsBtnHeightConstraint.constant ==  0){
//                   notedetailcell.noteviewHeightConstraint.constant = CGFloat(defaultNoteCellHeight + commentHeight) + notedetailcell.attachCollectionViewHeightConstraint.constant + txtheight +  notedetailcell.regardingheightConstraint.constant + notedetailcell.attachlblHeight.constant + notedetailcell.commentsBtnHeightConstraint.constant + notedetailcell.commentTablHeightConstarint.constant - 20
//                }
//                else{
                    notedetailcell.noteviewHeightConstraint.constant = CGFloat(defaultNoteCellHeight + commentHeight) + notedetailcell.attachCollectionViewHeightConstraint.constant + txtheight +  notedetailcell.regardingheightConstraint.constant + notedetailcell.attachlblHeight.constant + notedetailcell.commentsBtnHeightConstraint.constant + notedetailcell.commentTablHeightConstarint.constant
//                }
               
                // other button action
                notedetailcell.commentExpandOutlet.tag = indexPath.row - 1
                notedetailcell.commentExpandOutlet.addTarget(self, action: #selector(self.commentTableviewExpandAction(_:)), for: .touchUpInside)
                notedetailcell.commentbtnOutlet.tag = indexPath.row - 1
                notedetailcell.commentbtnOutlet.addTarget(self, action: #selector(self.commentNoteButtonTapped(_:)), for: .touchUpInside)
                notedetailcell.attachBtnOutlet.tag = indexPath.row - 1
                notedetailcell.attachBtnOutlet.addTarget(self, action: #selector(self.attachNoteButtonTapped(_:)), for: .touchUpInside)
                notedetailcell.searchBtnOutlet.tag = indexPath.row - 1
                notedetailcell.searchBtnOutlet.addTarget(self, action: #selector(self.searchNoteButtonTapped(_:)), for: .touchUpInside)
                notedetailcell.editbtnOutlet.tag = indexPath.row - 1
                notedetailcell.editbtnOutlet.addTarget(self, action: #selector(self.editNoteButtonTapped(_:)), for: .touchUpInside)
                return notedetailcell
            }
            
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
            if section == 9 {
                return 50
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
        APIManager.sharedInstance.postRequestCall(postURL:globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
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
//                            APIManager.sharedInstance.postRequestCall(postURL: "https://toolkit.bluesquareapps.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/link.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
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
        
        
        APIManager.sharedInstance.postRequestCall(postURL:globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
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
//                            APIManager.sharedInstance.postRequestCall(postURL: "https://toolkit.bluesquareapps.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/link.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
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
                    let controller:UpdatenewappointmentVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewappointmentVC") as? UpdatenewappointmentVC)!
                    controller.linkParentID = self.contactInfoDetail.id!
                    controller.accountname = self.contactInfoDetail.name!
                    controller.fromAccounts = true
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Task", style: .default , handler:{ (UIAlertAction)in
                print("User click Edit button")
                OperationQueue.main.addOperation {
                    let controller:UpdatenewtaskVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewtaskVC") as? UpdatenewtaskVC)!
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
        if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 5 || indexPath.section == 7 {
            if indexPath.section == selectedIndexPath - 1 {
                selectedIndexPath = 2123123
                   isExpand = false
            }else{
                selectedIndexPath = indexPath.section + 1
                isExpand = true
            }
            
             selectedIndexPath_condition = indexPath.section
            if(self.isNoteCellPresent)
            {
                isNoteCellPresent = false
                tableView.reloadSections(IndexSet(integer: 9), with: .bottom)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let indexPath = IndexPath(item: 0, section: 1)
            let indexPath1 = IndexPath(item: 0, section: 3)
            let indexPath2 = IndexPath(item: 0, section: 5)
            let indexPath3 = IndexPath(item: 0, section: 7)
            tableView.reloadRows(at: [indexPath,indexPath1,indexPath2,indexPath3], with: .bottom)
        }
        }
        else if (indexPath.section == 9)
        {
            if indexPath.section == selectedIndexPath - 1 {
                isNoteCellPresent = false
                selectedIndexPath = 2123123
                isExpand = false
            }else{
                selectedIndexPath = indexPath.section + 1
                isExpand = true
                isNoteCellPresent = true
            }
            selectedIndexPath_condition = indexPath.section
            tableView.reloadSections(IndexSet(integer: 9), with: .bottom)
            tableView.scrollToRow(at: IndexPath(row: 0, section: 9), at: .bottom, animated: true)
        }
        else if indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 {
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
                    let controller:UpdatenewtaskVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewtaskVC") as? UpdatenewtaskVC)!
                    controller.linkParentID = contactInfoDetail.id!
                    controller.openedActivties = getAddress
                    controller.fromAccounts = true
                    controller.Editvalue = "edit"
                    controller.IsEdit = true
                    controller.StrAccount = "Accounts"
                    self.navigationController?.pushViewController(controller, animated: true)
                }else if getAddress.type == "Appointment" || getAddress.type == "Appointments" {
                    let controller:UpdatenewappointmentVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewappointmentVC") as? UpdatenewappointmentVC)!
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
                    let controller:UpdatenewtaskVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewtaskVC") as? UpdatenewtaskVC)!
                    controller.linkParentID = contactInfoDetail.id!
                    controller.Editvalue = "edit"
                    controller.openedActivties = getAddress
                    controller.fromAccounts = true
                    self.navigationController?.pushViewController(controller, animated: true)
                }else if getAddress.type == "Appointment" || getAddress.type == "Appointments" {
                    let controller:UpdatenewappointmentVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewappointmentVC") as? UpdatenewappointmentVC)!
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
        else if indexPath.section == 9 && isExpand && selectedIndexPath_condition == indexPath.section {
            if(indexPath.row == 0)
            {
                return 109
            }else
            {
                return UITableViewAutomaticDimension
            }
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
        if pickerView.tag == 0 {
            return contactTypes.count
        }
        if pickerView.tag == 321 {
            return primaryContactArray.count
        }
        else if pickerView.tag == 12 {
            return linkaddressArray.count
        }else if pickerView.tag == 13 {
            return linkaddressArray.count
        }
        if pickerView.tag == 1112 {
            return self.allContactList.count
        }
        if pickerView.tag == 1002 {
            return self.allmainaccountList.count
        }
        if pickerView.tag == 1114 {
            if(self.passAppointmentList != nil)
            {
            return self.passAppointmentList.results.count
            }else
            {
                return 0
            }
        }
        if pickerView.tag == 1116 {
            if(self.passTaskList != nil)
            {
            return self.passTaskList.results.count
            }else
            {
                return 0
            }
        }
        return 0
    }
    
    func czpickerView(_ pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
        return nil
    }
    
    func numberOfRowsInPickerView(pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 0 {
            return contactTypes.count
        }
        if pickerView.tag == 321 {
            return primaryContactArray.count
        }
        if pickerView.tag == 12 || pickerView.tag == 13 {
            return linkaddressArray.count
        }
        if pickerView.tag == 1002 {
            return self.allmainaccountList.count
        }
        if pickerView.tag == 1112 {
            return self.allContactList.count
        }
        if pickerView.tag == 1114 {
            if(self.passAppointmentList != nil)
            {
            return self.passAppointmentList.results.count
            }else
            {
                return 0
            }
        }
        if pickerView.tag == 1116 {
            if(self.passTaskList != nil)
            {
            return self.passTaskList.results.count
            }else
            {
                return 0
            }
        }
        return 0
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        if pickerView.tag == 0 {
            return contactTypes[row] as? String
        }
        if pickerView.tag == 12 || pickerView.tag == 13 {
            return linkaddressArray[row]
        }
        if pickerView.tag == 321{
            return primaryContactArray[row]
        }
        if pickerView.tag == 1002 {
            return self.allmainaccountList[row].name
        }
        if pickerView.tag == 1112 {
            return self.allContactList[row].fullName
        }
        if pickerView.tag == 1114 {
            return self.passAppointmentList.results[row].subject
        }
        if pickerView.tag == 1116 {
            return self.passTaskList.results[row].subject
        }
        return ""
    }
    
    
    func czpickerView(_ pickerView: CZPickerView!) -> NSMutableArray{
        if pickerView.tag == 0 {
            let Arrayname : NSMutableArray = []
            for i in 0 ..< contactTypes.count {
                let getContact = contactTypes[i]
                Arrayname.add(getContact)
            }
            return Arrayname
        }
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
        else if pickerView.tag == 1002 {
            //linkaddressArray
            //getLinkedAccountsResult
            let arr:NSMutableArray = []
            for index in 0..<self.allmainaccountList.count {
                arr.add(allmainaccountList[index].name)
            }
            
            return arr
        }
        else if pickerView.tag == 1112 {
            //linkaddressArray
            //getLinkedAccountsResult
            let arr:NSMutableArray = []
            for index in 0..<self.allContactList.count {
                arr.add(allContactList[index].fullName)
            }
            return arr
        }
        else if pickerView.tag == 1114 {
            //linkaddressArray
            //getLinkedAccountsResult
            let arr:NSMutableArray = []
            for index in 0..<self.passAppointmentList.results.count {
                arr.add(self.passAppointmentList.results[index].subject)
            }
            return arr
        }
        else if pickerView.tag == 1116 {
            //linkaddressArray
            //getLinkedAccountsResult
            let arr:NSMutableArray = []
            for index in 0..<self.passTaskList.results.count {
                arr.add(self.passTaskList.results[index].subject)
            }
            return arr
        }
        return []
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        if pickerView.tag == 0 {
            if row == 0 {
                self.tappedContact = true
                self.globalRegType = "appointment"
                self.selectedContactsList = []
                self.allcreatedRegardingID.removeAll()
                self.allregardingObjectID.removeAll()
                for(index,_) in self.noteregardingData.enumerated(){
                    let valu = self.noteregardingData[index] as? [NoteRegardingList]
                    
                    if(searchCurrNoteid == valu?.first?.noteID)
                    {
                        for(_,ele) in (valu?.enumerated())!
                        {
                            if(ele.regardingType == "appointment"){
                            self.selectedContactsList.append(ele.regardingID!)
                            self.allcreatedRegardingID.append(ele.regardingID!)
                            self.allregardingObjectID.append(ele.id!)
                            // add all note - regarding id into array
                            }
                        }
                        break
                    }
                }
                self.showChooseAppointmentPicker()
            }
            
            else if row == 1 {
                self.tappedContact = true
                self.globalRegType = "contact"
                self.selectedContactsList = []
                self.allcreatedRegardingID.removeAll()
                self.allregardingObjectID.removeAll()
                for(index,_) in self.noteregardingData.enumerated(){
                    let valu = self.noteregardingData[index] as? [NoteRegardingList]
                    
                    if(searchCurrNoteid == valu?.first?.noteID)
                    {
                        for(_,ele) in (valu?.enumerated())!
                        {
                            if(ele.regardingType == "contact"){
                                self.selectedContactsList.append(ele.regardingID!)
                                self.allcreatedRegardingID.append(ele.regardingID!)
                                self.allregardingObjectID.append(ele.id!)
                                // add all note - regarding id into array
                            }
                        }
                        break
                    }
                }
             self.showChooseContactsPicker()
            }else if row == 2 {
                self.tappedContact = false
                self.globalRegType = "company"
                self.selectedContactsList = []
                self.allcreatedRegardingID.removeAll()
                self.allregardingObjectID.removeAll()
                for(index,_) in self.noteregardingData.enumerated(){
                    let valu = self.noteregardingData[index] as? [NoteRegardingList]
                    
                    if(searchCurrNoteid == valu?.first?.noteID)
                    {
                        for(_,ele) in (valu?.enumerated())!
                        {
                            if(ele.regardingType == "company"){
                                self.selectedContactsList.append(ele.regardingID!)
                                self.allcreatedRegardingID.append(ele.regardingID!)
                                self.allregardingObjectID.append(ele.id!)
                                // add all note - regarding id into array
                            }
                        }
                        break
                    }
                }
                self.showChooseCompanysPicker()
            }
            if row == 3 {
                self.tappedContact = true
                self.globalRegType = "task"
                self.selectedContactsList = []
                self.allcreatedRegardingID.removeAll()
                self.allregardingObjectID.removeAll()
                for(index,_) in self.noteregardingData.enumerated(){
                    let valu = self.noteregardingData[index] as? [NoteRegardingList]
                    
                    if(searchCurrNoteid == valu?.first?.noteID)
                    {
                        for(_,ele) in (valu?.enumerated())!
                        {
                            if(ele.regardingType == "task"){
                                self.selectedContactsList.append(ele.regardingID!)
                            self.allcreatedRegardingID.append(ele.regardingID!)
                            self.allregardingObjectID.append(ele.id!)
                            // add all note - regarding id into array
                            }
                        }
                        break
                    }
                }
                self.showChooseTaskPicker()
            }
        }
        else if (pickerView.tag == 321)
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
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, with value: Bool, arrayvalue array: NSMutableArray!) {
        if(value) {
      if pickerView.tag == 1112
        {
          self.selectedContactWholeValue.removeAll()
          self.selectedContactsList.removeAll()
          for row in rows {
              if let row = row as? Int {
                let getContact = array[row] as? String ?? ""
                for index in 0..<allContactList.count {
                    let getContacts = allContactList[index]
                    if getContacts.fullName == getContact {
                        self.selectedContactsList.append(getContacts.fullName)
                        self.selectedContactWholeValue.append(getContacts.id)
                    }
                }
                 
              }
          }
          for(index, element) in self.allcreatedRegardingID.enumerated()
          {
              if(!self.selectedContactWholeValue.contains(element))
              {
                  self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
              }
          }
          for(_,element) in self.selectedContactWholeValue.enumerated(){
              if(!self.allcreatedRegardingID.contains(element))
              {
                  self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
              }
          }
        
          self.isExpand = false
          self.isNoteCellPresent = false
          self.selectedIndexPath = 111111111
        self.tblAccount.reloadData()
          self.pullNotesListFromServerApi()
          return
        }
        else if pickerView.tag == 1002
        {
          self.selectedContactWholeValue.removeAll()
          self.selectedContactsList.removeAll()
          for row in rows {
              if let row = row as? Int {
                let getContact = array[row] as? String ?? ""
                for index in 0..<allmainaccountList.count {
                    let getContacts = allmainaccountList[index]
                    if getContacts.name == getContact {
                        self.selectedContactsList.append(getContacts.name)
                        self.selectedContactWholeValue.append(getContacts.id)
                    }
                
                }
                  
              }
          }
          for(index, element) in self.allcreatedRegardingID.enumerated()
          {
              if(!self.selectedContactWholeValue.contains(element))
              {
                  self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
              }
          }
          for(_,element) in self.selectedContactWholeValue.enumerated(){
              if(!self.allcreatedRegardingID.contains(element))
              {
                  self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
              }
          }
          self.isExpand = false
          self.isNoteCellPresent = false
          self.selectedIndexPath = 111111111
            self.tblAccount.reloadData()

          self.pullNotesListFromServerApi()
          return
        }
        else if pickerView.tag == 1114 {
            self.selectedContactWholeValue = []
            self.selectedContactsList = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = self.passAppointmentList.results[row].id ?? ""
                    for index in 0..<self.passAppointmentList.results.count {
                        let getContacts = self.passAppointmentList.results[index]
                        if getContacts.id == getContact {
                            self.selectedContactsList.append(getContacts.subject!)
                            self.selectedContactWholeValue.append(getContacts.id!)
                        }
                    }
                    
                   
                }
            }
            for(index, element) in self.allcreatedRegardingID.enumerated()
            {
                if(!self.selectedContactWholeValue.contains(element))
                {
                    self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
                }
            }
            for(_,element) in self.selectedContactWholeValue.enumerated(){
                if(!self.allcreatedRegardingID.contains(element))
                {
                    self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
                }
            }
            self.isExpand = false
            self.isNoteCellPresent = false
//            self.Viewheightconstant.constant = 950
            self.selectedIndexPath = 111111111
            self.tblAccount.reloadData()

            self.pullNotesListFromServerApi()
            return
        }
        else if pickerView.tag == 1116 {
            self.selectedContactWholeValue = []
            self.selectedContactsList = []
            for row in rows {
                if let row = row as? Int {
                    let getContact = self.passTaskList.results[row].id ?? ""
                    for index in 0..<self.passTaskList.results.count {
                        let getContacts = self.passTaskList.results[index]
                        if getContacts.id == getContact {
                            self.selectedContactsList.append(getContacts.subject!)
                            self.selectedContactWholeValue.append(getContacts.id!)
                        }
                    }
                 
                }
            }
            for(index, element) in self.allcreatedRegardingID.enumerated()
            {
                if(!self.selectedContactWholeValue.contains(element))
                {
                    self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
                }
            }
            for(_,element) in self.selectedContactWholeValue.enumerated(){
                if(!self.allcreatedRegardingID.contains(element))
                {
                    self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
                }
            }
            self.isExpand = false
            self.isNoteCellPresent = false
//            self.Viewheightconstant.constant = 950
            self.selectedIndexPath = 111111111
            self.tblAccount.reloadData()

            self.pullNotesListFromServerApi()
            return
        }
        }
    }
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, withoutBool value: Bool) {
        if(!value){
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
          else if pickerView.tag == 1112
          {
            self.selectedContactWholeValue.removeAll()
            self.selectedContactsList.removeAll()
            for row in rows {
                if let row = row as? Int {
                    self.selectedContactsList.append(self.allContactList[row].fullName)
                    self.selectedContactWholeValue.append(self.allContactList[row].id)
                }
            }
            for(index, element) in self.allcreatedRegardingID.enumerated()
            {
                if(!self.selectedContactWholeValue.contains(element))
                {
                    self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
                }
            }
            for(_,element) in self.selectedContactWholeValue.enumerated(){
                if(!self.allcreatedRegardingID.contains(element))
                {
                    self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
                }
            }
            self.isExpand = false
            self.isNoteCellPresent = false
            self.selectedIndexPath = 111111111
            self.tblAccount.reloadData()
            self.pullNotesListFromServerApi()
            return
          }
          else if pickerView.tag == 1002
          {
            self.selectedContactWholeValue.removeAll()
            self.selectedContactsList.removeAll()
            for row in rows {
                if let row = row as? Int {
                    self.selectedContactsList.append(self.allmainaccountList[row].name)
                    self.selectedContactWholeValue.append(self.allmainaccountList[row].id)
                }
            }
            for(index, element) in self.allcreatedRegardingID.enumerated()
            {
                if(!self.selectedContactWholeValue.contains(element))
                {
                    self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
                }
            }
            for(_,element) in self.selectedContactWholeValue.enumerated(){
                if(!self.allcreatedRegardingID.contains(element))
                {
                    self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
                }
            }
            self.isExpand = false
            self.isNoteCellPresent = false
            self.selectedIndexPath = 111111111
            self.tblAccount.reloadData()
            self.pullNotesListFromServerApi()
            return
          }
          else if pickerView.tag == 1114 {
              self.selectedContactWholeValue = []
              self.selectedContactsList = []
              for row in rows {
                  if let row = row as? Int {
                      self.selectedContactsList.append(self.passAppointmentList.results[row].subject!)
                      self.selectedContactWholeValue.append(self.passAppointmentList.results[row].id!)
                  }
              }
              for(index, element) in self.allcreatedRegardingID.enumerated()
              {
                  if(!self.selectedContactWholeValue.contains(element))
                  {
                      self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
                  }
              }
              for(_,element) in self.selectedContactWholeValue.enumerated(){
                  if(!self.allcreatedRegardingID.contains(element))
                  {
                      self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
                  }
              }
              self.isExpand = false
              self.isNoteCellPresent = false
              self.selectedIndexPath = 111111111
              self.tblAccount.reloadData()
              self.pullNotesListFromServerApi()
              return
          }
          else if pickerView.tag == 1116 {
              self.selectedContactWholeValue = []
              self.selectedContactsList = []
              for row in rows {
                  if let row = row as? Int {
                      self.selectedContactsList.append(self.passTaskList.results[row].subject!)
                      self.selectedContactWholeValue.append(self.passTaskList.results[row].id!)
                  }
              }
              for(index, element) in self.allcreatedRegardingID.enumerated()
              {
                  if(!self.selectedContactWholeValue.contains(element))
                  {
                      self.deleteRegardingContactAction(ObjectId: self.allregardingObjectID[index])
                  }
              }
              for(_,element) in self.selectedContactWholeValue.enumerated(){
                  if(!self.allcreatedRegardingID.contains(element))
                  {
                      self.secondCreateAPi(noteID:self.selectedNoteID, RegardingId: element)
                  }
              }
              self.isExpand = false
              self.isNoteCellPresent = false
              self.selectedIndexPath = 111111111
              self.tblAccount.reloadData()
              self.pullNotesListFromServerApi()
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

