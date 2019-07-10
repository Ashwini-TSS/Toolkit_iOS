//
//  ContactssController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 24/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ContactssController: UITableViewController {
    var aryTeglist = [String]()
    var chidrenPaths:[Int] = []
    //    private let KEYBOARD_ANIMATION_DURATION : CGFloat = 0.2
    //    private let MINIMUM_SCROLL_FRACTION : CGFloat = 0.4
    //    private let MAXIMUM_SCROLL_FRACTION : CGFloat = 1.0
    //    var PORTRAIT_KEYBOARD_HEIGHT : CGFloat = 420
    //    private let LANDSCAPE_KEYBOARD_HEIGHT : CGFloat = 140
    //    var animatedDistance : CGFloat = 0.0
    @IBOutlet weak var tblChildrens: UITableView!
    @IBOutlet var childrenView: UIView!
    var countryCode:String = "+1"
    var constantphone : String?
    var alternate : String?
    @IBOutlet weak var tblHistory: UITableView!
    @IBOutlet var historyBG: UIView!
    var contactInfoDetail:ContactListResult!
    var cellCalled:Bool = false
    var isEditable:Bool = false
    var setCategories:Bool = false
    
    var Spouse : String!
    var Accountstr : String!
    var Executorstr : String!
    var Attorneystr : String!
    
    var leftid : String!
    var linkaccount : String!
    var recreationAdded:Bool = false
    var contactAdd:Bool = false
    //Models
    var getAddtionalAddressesModel:[getSearchResultResult] = []
    var getLinkedAccountModel:[getLinkedResultResult] = []
    
    var getClientClassModel:GetClientClassModel!
    var getOwnersListModel:GetOwnersListModel!
    var getSpouseContactListModel:GetSpouseContactModel!
    var getCompanyListModel:GetCompanyListModel!
    var additionalResult:[GetAdditionalAddressResult] = []
    var getLinkedAccountsResult:[GetLinkedAccountsResult] = []
    var getOpenedActivitiesResult:[GetIncompleteActivity] = []
    var getCompleteActivitiesResult:[GetCompleteActivity] = []
    var getHistoryEntries:[getHistoryEntry] = []
    var getRecreationCategoriesList:getRecreationCategories!
    var getCategoriesRecreationResult:[getLinkedRecreationResult] = []
    var getRecreationNames:String = ""
    var selectedRecreationIDList:[String] = []
    var selecyedAdditioanlAddressIDList:[String] = []
    var selectedLinkedAccountIDList:[String] = []
    
    var resultsArray : [JSON] = []
    var linkcontactArray : [String] = []
    
    var resultsaddressArray : [JSON] = []
    var linkaddressArray : [String] = []
    
    
    var linkedAccountArray : [String] = []
    var linkedSpouseArray : [String] = []
    
    var linkedspouseIDArray : [String] = []
    var linkedAccountIDArray : [String] = []
    var linkedExecutorIDArray : [String] = []
    var linkedAttronyIDArray : [String] = []
    
    
    var SpouseString : String!
    var ExecutorString : String!
    var AccountString : String!
    var powerAttroney : String!
    
    //API
    var isTappedBack:Bool = false
    var clientClassID:String = ""
    var ownerID:String = ""
    var spouseID:String = ""
    var companyID:String = ""
    var executorID:String = ""
    var powerAttroneyID:String = ""
    var recreationCatID:String = ""
    var addtionalAddresssAddID:String = ""
    
    var selectedIndexPath:Int = 1992001
    
    var selectedIndexPath_condition:Int = 0
    
    
    var isExpand:Bool = false
    var headerTitles:[String] = ["Additional Addresses","Linked Accounts","Open Activities","Completed Activities"]
    var bottomView = UIView()
    var editBtn = UIButton()
    var closeBtn = UIButton()
    var actionBtn = UIButton()
    
    var customView = UIView()
    var barButton: UIButton!
    //    @IBOutlet weak var tagsCollection: TaglistCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblHistory.tableFooterView = UIView()
        tblHistory.estimatedRowHeight = 44
        tblHistory.rowHeight = UITableViewAutomaticDimension
        IQKeyboardManager.shared.enable = true
        
        
        //        if UIScreen.main.bounds.height < 812 {
        //            PORTRAIT_KEYBOARD_HEIGHT = 260
        //        }
        setupCustomView()
        
        closeBtn.isUserInteractionEnabled = true
        actionBtn.isUserInteractionEnabled = true
        editBtn.isUserInteractionEnabled = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWilslAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if contactInfoDetail != nil {
            let result = contactInfoDetail.ChildrensNames.replacingOccurrences(of: "\n", with: ", ",
                                                                               options: NSString.CompareOptions.literal, range:nil)
            print(result)
            childNames = result
        }
        //        let result = contactInfoDetail.ChildrensNames.replacingOccurrences(of: "\n", with: ", ",
        //                                                                           options: NSString.CompareOptions.literal, range:nil)
        //        print(result)
        //
        //        childNames = result
        
        self.title = "New Contact"
        if contactInfoDetail != nil {
            self.title = "Edit Contact"
            getContact()
        }else{
            isEditable = true
        }
        getAccountname()
        getPowerofAttorney()
        getExecutorname()
        getSpousename()
        
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
        
        if contactInfoDetail.companyName == nil {
            let lblUsername = UILabel()
            lblUsername.frame =  CGRect(x: 0.0, y: 10.0, width: customView.bounds.width - 50, height: 22)
            lblUsername.text = contactInfoDetail.fullName!
            lblUsername.textAlignment = .center
            lblUsername.textColor = UIColor.white
            lblUsername.font = UIFont(name: "Raleway-Regular", size: 17.0)!
            customView.addSubview(lblUsername)
            self.navigationItem.titleView = customView
            
            return
        }
        let lblUsername = UILabel()
        lblUsername.frame =  CGRect(x: 0.0, y: 0, width: customView.bounds.width - 50, height: 22)
        lblUsername.text = contactInfoDetail.fullName!
        lblUsername.textAlignment = .center
        lblUsername.textColor = UIColor.white
        lblUsername.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        customView.addSubview(lblUsername)
        
        print(contactInfoDetail.companyName)
        
        let lblCompany = UILabel()
        lblCompany.frame =  CGRect(x: 0.0, y: 22, width: customView.bounds.width - 50, height: 22)
        lblCompany.text = contactInfoDetail.companyName!
        lblCompany.textAlignment = .center
        lblCompany.textColor = UIColor.white
        lblCompany.font = UIFont(name: "Raleway-Regular", size: 17.0)!
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
        lblUsername.text = "Edit Contact"
        lblUsername.textAlignment = .center
        lblUsername.textColor = UIColor.white
        lblUsername.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        customView.addSubview(lblUsername)
        self.navigationItem.titleView = customView
    }
    
    @IBAction func tappedBack(_ sender: Any) {
        if isEditable && contactInfoDetail == nil {
            self.recreationAdded = false
            self.navigationController?.popViewController(animated: true)
            return
        }
        if isEditable {
            self.isEditable = false
            //            barButton.isHidden = false
            self.editBtn.removeTarget(nil, action: nil, for: .allEvents)
            
            self.editBtn.setTitle("Edit", for: .normal)
            self.editBtn.addTarget(self, action: #selector(self.tappedEdit(_:)), for: .touchDown)
            
            self.actionBtn.removeTarget(nil, action: nil, for: .allEvents)
            
            self.actionBtn.setTitle("Actions", for: .normal)
            self.actionBtn.addTarget(self, action: #selector(self.tappedAction(_:)), for: .touchDown)
            
            setupCustomView()
            
            cellCalled = false
            isTappedBack = true
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            return
        }
        self.recreationAdded = false
        self.navigationController?.popViewController(animated: true)
    }
    func showChildrenView(){
        self.tblChildrens.tableFooterView = UIView()
        self.childrenView.frame = self.view.frame
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.addSubview(self.childrenView)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        var fullWidth = UIScreen.main.bounds.width
        fullWidth = fullWidth / 3 - 15
        
        let btnOneX:CGFloat = 15
        let btnTwoX:CGFloat = btnOneX + 5 + fullWidth
        let btnThirdX:CGFloat = btnTwoX + 5 + fullWidth
        
        bottomView.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height - 67, width: UIScreen.main.bounds.width, height: 67)
        bottomView.backgroundColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        
        closeBtn.frame = CGRect(x: btnOneX, y: 9.0, width: 168 , height: 38)
        actionBtn.frame = CGRect(x: UIScreen.main.bounds.width-182, y: 9.0, width:168, height: 38)
        
        //        editBtn.frame = CGRect(x: btnThirdX, y: 5.0, width: fullWidth, height: 30)
        editBtn.backgroundColor = UIColor.white
        editBtn.setTitleColor(UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
        editBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        
    }
    func showRightBarbuttonItem(){
        //        let button = UIButton.init(type: .custom)
        //        //set image for button
        //        button.setImage(UIImage(named: "ic_pencil"), for: UIControlState.normal)
        //        //add function for button
        //        button.addTarget(self, action:  #selector(tappedEdit(_:)), for: UIControlEvents.touchUpInside)
        //        //set frame
        //        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        //
        //        barButton = UIBarButtonItem(customView: button)
        //        //assign button to navigationbar
        //        self.navigationItem.rightBarButtonItem = barButton
    }
    func removeRightBarbuttonItem(){
        //        self.navigationItem.rightBarButtonItem = nil
    }
    override func viewWillAppear(_ animated: Bool) {
        // super.viewWillAppear(true)
        cellCalled = false
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        selectedIndexPath = 1992001
        isExpand = false
        
        
        if contactInfoDetail == nil {
            editBtn.removeTarget(nil, action: nil, for: .allEvents)
            editBtn.setTitle("Close", for: .normal)
            editBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchDown)
        }else{
            if isEditable {
                if contactInfoDetail != nil {
                    self.title = "Edit Contact"
                    self.removeCustomView()
                }
                removeRightBarbuttonItem()
                //                barButton.isHidden = true
                
                //                editBtn.setTitle("Save", for: .normal)
                //                editBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
            }else{
                if contactInfoDetail != nil {
                    self.title = contactInfoDetail.fullName
                    self.setupCustomView()
                }
                showRightBarbuttonItem()
                //                barButton.isHidden = false
                //                editBtn.setTitle("Edit", for: .normal)
                //                editBtn.addTarget(self, action: #selector(tappedEdit(_:)), for: .touchDown)
            }
        }
        bottomView.addSubview(editBtn)
        
        var fullWidth = UIScreen.main.bounds.width
        fullWidth = fullWidth / 3 - 15
        
        let btnOneX:CGFloat = 15
        let btnTwoX:CGFloat = btnOneX + 5 + fullWidth
        let btnThirdX:CGFloat = btnTwoX + 5 + fullWidth
        
        
        editBtn.frame = CGRect(x: UIScreen.main.bounds.width-182, y: 9.0, width: 168, height: 38)
        
        closeBtn.backgroundColor = UIColor.white
        closeBtn.setTitleColor(UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
        closeBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        
        if contactInfoDetail == nil {
            if contactInfoDetail != nil {
                self.title = "Edit Contact"
                self.removeCustomView()
            }
            removeRightBarbuttonItem()
            //            barButton.isHidden = true
            //Thabresh
            closeBtn.removeTarget(nil, action: nil, for: .allEvents)
            closeBtn.setTitle("Close", for: .normal)
            closeBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchDown)
            
            //Thabresh
            editBtn.removeTarget(nil, action: nil, for: .allEvents)
            editBtn.setTitle("Save", for: .normal)
            editBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
            
            //Old
            //            closeBtn.setTitle("Save", for: .normal)
            //            closeBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
        }else{
            removeRightBarbuttonItem()
            //            barButton.isHidden = true
            closeBtn.removeTarget(nil, action: nil, for: .allEvents)
            closeBtn.setTitle("Close", for: .normal)
            closeBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchDown)
        }
        bottomView.addSubview(closeBtn)
        
        DispatchQueue.main.async {
            if self.contactInfoDetail != nil {
                
                self.actionBtn.backgroundColor = UIColor.white
                self.actionBtn.setTitleColor(UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
                self.actionBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
                
                if(self.isEditable){
                    self.actionBtn.removeTarget(nil, action: nil, for: .allEvents)
                    self.actionBtn.setTitle("Save", for: .normal)
                    self.actionBtn.addTarget(self, action: #selector(self.tappedSave(_:)), for: .touchDown)
                }
                else{
                    self.actionBtn.removeTarget(nil, action: nil, for: .allEvents)
                    self.actionBtn.setTitle("Actions", for: .normal)
                    self.actionBtn.addTarget(self, action: #selector(self.tappedAction(_:)), for: .touchDown)
                }
                
                self.bottomView.addSubview(self.actionBtn)
            }
            self.navigationController?.view.addSubview(self.bottomView)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        selectedIndexPath = 1992001
        isExpand = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // change 2 to desired number of seconds
            //self.tableView.setContentOffset(.zero, animated: false)
        }
        historyBG.removeFromSuperview()
        bottomView.removeFromSuperview()
    }
    
    func getAccountname(){
        if contactInfoDetail != nil {
        let json: [String: Any] = ["ObjectId":contactInfoDetail.companyId!,
                                   "ObjectName":"company",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                self.Accountstr = json["DataObject"]["Name"].stringValue
                self.tblHistory.reloadData()
                self.tblChildrens.reloadData()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        }
    }
    
    func getPowerofAttorney(){
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ObjectId":contactInfoDetail.powerOfAttronyID!,
                                       "ObjectName":"contact",
                                       "PassKey":passKey,
                                       "OrganizationId":currentOrgID]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    let fullname : String = json["DataObject"]["FullName"].stringValue
                    if(fullname != ""){
                        self.Attorneystr = json["DataObject"]["FullName"].stringValue
                    }
                    if(self.Attorneystr == "" || self.Attorneystr == nil){
                        self.Attorneystr = json["DataObject"]["LastName"].stringValue
                    }
                    self.tblHistory.reloadData()
                    self.tblChildrens.reloadData()
                    self.cellCalled = false
                    self.tableView.reloadData()
                }
            },  onFailure: { error in
                print(error.localizedDescription)
            })
        }
    }
    
    func getSpousename(){
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ObjectId":contactInfoDetail.spousePartnerID!,
                                       "ObjectName":"contact",
                                       "PassKey":passKey,
                                       "OrganizationId":currentOrgID]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    let fullname : String = json["DataObject"]["FullName"].stringValue
                    if(fullname != ""){
                        self.Spouse = json["DataObject"]["FullName"].stringValue
                    }
                    if(self.Spouse == "" || self.Spouse == nil){
                        self.Spouse = json["DataObject"]["LastName"].stringValue
                    }
                    self.tblHistory.reloadData()
                    self.tblChildrens.reloadData()
                }
            },  onFailure: { error in
                print(error.localizedDescription)
            })
        }
    }
    
    func getExecutorname(){
      
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ObjectId":contactInfoDetail.executorID!,
                                       "ObjectName":"contact",
                                       "PassKey":passKey,
                                       "OrganizationId":currentOrgID]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)//FullName
                    let fullname : String = json["DataObject"]["FullName"].stringValue
                    if(fullname != ""){
                     self.Executorstr = json["DataObject"]["FullName"].stringValue
                    }
                    if(self.Executorstr == "" || self.Executorstr == nil){
                       self.Executorstr = json["DataObject"]["LastName"].stringValue
                    }
                    self.cellCalled = false
                    self.tableView.reloadData()
                }
            },  onFailure: { error in
                print(error.localizedDescription)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 10 || tableView.tag == 20 {
            return 1
        }
        // #warning Incomplete implementation, return the number of sections
        if contactInfoDetail == nil {
            return 1
        }
        if contactAdd {
            return 1
        }
        return 9
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableView.tag == 10 {
            return self.getHistoryEntries.count
        }
        if tableView.tag == 20 {
            let result = childNames.replacingOccurrences(of: "\n", with: ", ",
                                                         options: NSString.CompareOptions.literal, range:nil)
            let fullNameArr = result.components(separatedBy: ", ")
            return fullNameArr.count
        }
        if section == 2 {
            return additionalResult.count
        }
        if section == 4 {
            return getLinkedAccountsResult.count
        }
        if section == 6 {
            return getOpenedActivitiesResult.count
        }
        if section == 8 {
            return getCompleteActivitiesResult.count
        }
        if section == 1 || section == 3  || section == 5 || section == 7 {
            return 1
        }
        if section == 4 {
            return 1
        }
        if section == 6 {
            return 1
        }
        if section == 8 {
            return 1
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 10 {
            return UITableViewAutomaticDimension
        }
        if tableView.tag == 20 {
            return 60
        }
        if indexPath.section == 0 {
            return 3976
        }else if indexPath.section == 1 && isExpand && selectedIndexPath_condition == indexPath.section {
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
        else if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 5 || indexPath.section == 7 {
            return 65
        }else if indexPath.section == 4 && isExpand && selectedIndexPath == indexPath.section || indexPath.section == 6 && isExpand && selectedIndexPath == indexPath.section || indexPath.section == 8 && isExpand && selectedIndexPath == indexPath.section {
            return 50
        }else if indexPath.section == 2 && isExpand && selectedIndexPath == indexPath.section {
            return 50
        }
        return 0
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 10 {
            let cell:ContactHistoryCell = tableView.dequeueReusableCell(withIdentifier: "ContactHistoryCell", for: indexPath) as! ContactHistoryCell
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(ContactssController.handleTap(_:)))
            tapGR.delegate = self
            tapGR.numberOfTapsRequired = 1
            cell.addGestureRecognizer(tapGR)
            cell.lblWho.text = getHistoryEntries[indexPath.row].action
            cell.lblWhen.text = getHistoryEntries[indexPath.row].createdOn.convertYearMonthDatehourMin()
            cell.lblEvent.text = contactInfoDetail.firstName + " " + contactInfoDetail.lastName
            return cell
        }
        if tableView.tag == 20 {
            let cell:ChildrenCell = tableView.dequeueReusableCell(withIdentifier: "ChildrenCell", for: indexPath) as! ChildrenCell
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(ContactssController.handleTap(_:)))
            tapGR.delegate = self
            tapGR.numberOfTapsRequired = 1
            cell.addGestureRecognizer(tapGR)
            let result = childNames.replacingOccurrences(of: "\n", with: ", ",
                                                         options: NSString.CompareOptions.literal, range:nil)
            let fullNameArr = result.components(separatedBy: ", ")
            cell.lblName.text = fullNameArr[indexPath.row]
            cell.btnDelete.addTarget(self, action: #selector(tappedDeleteChildrens(_:)), for: .touchDown)
            cell.btnDelete.tag = indexPath.row
            return cell
        }
        if indexPath.section == 0 {
            let cell:ContactssCell = tableView.dequeueReusableCell(withIdentifier: "ContactssCell", for: indexPath) as! ContactssCell
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(ContactssController.handleTap(_:)))
            tapGR.delegate = self
            tapGR.numberOfTapsRequired = 2
            cell.addGestureRecognizer(tapGR)
            cell.checkIfEditable(value: isEditable)
            cell.fieldFamilyDescription.delegate = self
            cell.fieldImportantInformation.delegate = self
            cell.fieldOccupationDescription.delegate = self
            cell.fieldRecreationDescription.delegate = self
            cell.fieldMoneyDescription.delegate = self
            cell.fieldMobilePhone.delegate = self
            cell.fieldBusinessPhone.delegate = self
            cell.fieldAlternatePhone.delegate = self
            cell.fieldAssistantPhone.delegate = self
            cell.btnAddChildren.addTarget(self, action: #selector(tappedAddChildrens(_:)), for: .touchDown)
            cell.BtnAdd.addTarget(self, action: #selector(tblADDCategory(_:)), for: .touchDown)
            if contactInfoDetail != nil {
            }else{
                cell.fieldMobilePhone.delegate = self
                cell.fieldAlternatePhone.delegate = self
                if(cell.fieldMobilePhone.text == "")
                {
                    cell.fieldMobilePhone.text = countryCode
                }else{
                    cell.fieldMobilePhone.text = cell.fieldMobilePhone.text
                }
                if(cell.fieldBusinessPhone.text == "")
                {
                    cell.fieldBusinessPhone.text = countryCode
                }else{
                    cell.fieldBusinessPhone.text = cell.fieldBusinessPhone.text
                }
                if(cell.fieldAlternatePhone.text == "")
                {
                    cell.fieldAlternatePhone.text = countryCode
                }else{
                    cell.fieldAlternatePhone.text = cell.fieldAlternatePhone.text
                }
                if(cell.fieldEveningPhone.text == "")
                {
                    cell.fieldEveningPhone.text = countryCode
                }else{
                    cell.fieldEveningPhone.text = cell.fieldEveningPhone.text
                }
                if(cell.fieldAssistantPhone.text == "")
                {
                    cell.fieldAssistantPhone.text = countryCode
                }else{
                    cell.fieldAssistantPhone.text = cell.fieldAssistantPhone.text
                }
                cell.checkIfEditable(value: isEditable)
            }
            
            if getRecreationNames.count > 0 && cell.fieldCategoriesRecreation.text!.count == 0 {
                cell.fieldCategoriesRecreation.text = getRecreationNames
            }
            if setCategories {
                setCategories = false
                cell.fieldCategoriesRecreation.text = getRecreationNames
            }
            if contactInfoDetail != nil {
                cell.fieldCategoriesRecreation.isHidden = false
                cell.BtnAdd.isHidden = false
                
                if isEditable {
                    cell.BtnAdd.isHidden = false
                }
                //  cell.BtnSearch.isHidden = false
            }else{
                cell.fieldCategoriesRecreation.isHidden = true
                cell.BtnAdd.isHidden = false
                // cell.BtnSearch.isHidden = true
            }
            if !cellCalled && contactInfoDetail != nil {
                cellCalled = true
                
                //                dispatch
                
                
                //                cell.tagsCollection.removeAllTags()
                
                if contactInfoDetail.clientClassId != nil && !isTappedBack{
                    self.clientClassID = contactInfoDetail.clientClassId
                }
                if contactInfoDetail.owningOrganizationUserId != nil && !isTappedBack {
                    self.ownerID = contactInfoDetail.owningOrganizationUserId
                }
                if contactInfoDetail.spousePartnerID != nil && !isTappedBack {
                    self.spouseID = contactInfoDetail.spousePartnerID
                }
                if contactInfoDetail.companyId != nil && !isTappedBack {
                    self.companyID = contactInfoDetail.companyId
                }
                if contactInfoDetail.executorID != nil && !isTappedBack{
                    self.executorID = contactInfoDetail.executorID
                }
                if contactInfoDetail.powerOfAttronyID != nil && !isTappedBack {
                    self.powerAttroneyID = contactInfoDetail.powerOfAttronyID
                }
                cell.fieldChildrenname.text = childNames
                
                cell.fieldTitle.text = contactInfoDetail.title
                cell.fieldFirstName.text = contactInfoDetail.firstName
                cell.fieldMiddleName.text = contactInfoDetail.middleName
                cell.fieldLastName.text = contactInfoDetail.lastName
                if !isTappedBack {
                    //cell.fieldClientClass.text = contactInfoDetail.clientClassId
                }
                cell.fieldSalutation.text = contactInfoDetail.salutation
                cell.fieldsuffix.text = contactInfoDetail.suffix
                cell.fieldNickName.text = contactInfoDetail.nickName
                cell.fieldEmail.text = contactInfoDetail.eMailAddress1
                cell.fieldEmail2.text = contactInfoDetail.eMailAddress2
                cell.fieldEmail3.text = contactInfoDetail.eMailAddress3
                cell.fieldWebsite.text = contactInfoDetail.webSiteUrl
                cell.fieldFtp.text = contactInfoDetail.ftpSiteUrl
                cell.fieldBusinessExt.text = contactInfoDetail.businessPhoneExt
                if(contactInfoDetail.telephone1 != ""){
                cell.fieldBusinessPhone.text = contactInfoDetail.telephone1
                }
                else{
                   cell.fieldBusinessPhone.text = countryCode
                }
                if(contactInfoDetail.telephone2 != ""){
                cell.fieldEveningPhone.text = contactInfoDetail.telephone2
                }
                else{
                    cell.fieldEveningPhone.text = countryCode
                }
                if(contactInfoDetail.telephone3 != ""){
                cell.fieldAlternatePhone.text = contactInfoDetail.telephone3
                }
                else{
                    cell.fieldAlternatePhone.text = countryCode
                }
                if(contactInfoDetail.mobilePhone != ""){
                cell.fieldMobilePhone.text = contactInfoDetail.mobilePhone
                }
                else{
                    cell.fieldMobilePhone.text = "+1"
                }
                if(contactInfoDetail.assistantPhone != ""){
                    cell.fieldAssistantPhone.text = contactInfoDetail.assistantPhone
                }
                else{
                    cell.fieldAssistantPhone.text = "+1"
                }
                cell.fieldPager.text = contactInfoDetail.pager
                cell.fieldFax.text = contactInfoDetail.fax
                cell.fieldAddress1.text = contactInfoDetail.addressLine1
                cell.fieldAddress2.text = contactInfoDetail.addressLine2
                cell.fieldAddress3.text = contactInfoDetail.addressLine3
                cell.fieldCity.text = contactInfoDetail.city
                cell.fieldState.text = contactInfoDetail.state
                cell.fieldZip.text = contactInfoDetail.postal
                cell.fieldCountry.text = contactInfoDetail.country
                cell.fieldPOBox.text = contactInfoDetail.poBox
                cell.fieldGender.text = contactInfoDetail.gender
                
                
                
                //                if contactInfoDetail.privateField != nil {
                //                    if contactInfoDetail.privateField {
                //                        cell.btnPrivate.setImage(UIImage.init(named:"ic_check"), for: .normal)
                //                    }
                //                }
                if contactInfoDetail.anniversay != nil {
                    cell.fieldAnniversary.text = contactInfoDetail.anniversay.convertYearMonthDate()
                }
                if contactInfoDetail.clientSince != nil {
                    cell.fieldClientSince.text = contactInfoDetail.clientSince.convertYearMonthDate()
                }
                if contactInfoDetail.BirthDate != nil {
                    cell.fieldBirthDate.text = contactInfoDetail.BirthDate.convertYearMonthDate()
                }
                if contactInfoDetail.renewDate != nil {
                    cell.fieldReviewDate.text = contactInfoDetail.renewDate.convertYearMonthDate()
                }
                if contactInfoDetail.licenseExpiry != nil {
                    cell.fieldLicenseExpiry.text = contactInfoDetail.licenseExpiry.convertYearMonthDate()
                }
                cell.clientLicenseNumber.text = contactInfoDetail.driversLicenseNumber
                cell.fieldGovernmentID.text = contactInfoDetail.governmentIdent
                if !isTappedBack {
                    // cell.fieldOwner.text = contactInfoDetail.owningOrganizationUserId
                }
                //                cell.fieldOwner.text = contactInfoDetail.owningOrganizationUserId
                cell.fieldImportantInformation.text = contactInfoDetail.descriptionField
                
                cell.fieldSpouse.text = contactInfoDetail.spousePartnerName
                if(Spouse != ""){
                cell.fieldSpouse2.text = Spouse
                }
                SpouseString = contactInfoDetail.spousePartnerName
                
//                if !isTappedBack {
//                    cell.fieldSpouse2.text = contactInfoDetail.spousePartnerID
//                }
                
                //                cell.fieldSpouse2.text = contactInfoDetail.spousePartnerID
                cell.fieldMaritalStatus.text = contactInfoDetail.maritalStatus
                cell.fieldFamilyDescription.text = contactInfoDetail.familyNotes
                cell.fieldCompanyName.text = contactInfoDetail.companyName
                if(Accountstr != ""){
                cell.fieldCompany.text = Accountstr
                }
                AccountString = contactInfoDetail.companyName
                //                cell.fieldCompany.text = contactInfoDetail.companyId
//                if !isTappedBack {
//                    cell.fieldCompany.text = contactInfoDetail.companyId
//                }
                cell.fieldAssistant.text = contactInfoDetail.assistantName
                cell.fieldJobTitle.text = contactInfoDetail.jobTitle
                cell.fieldDepartment.text = contactInfoDetail.department
               // cell.fieldAssistantPhone.text = NavigationHelper.USPhoneFormat(number: contactInfoDetail.assistantPhone)
                
                cell.fieldOccupationDescription.text = contactInfoDetail.occupationNotes
                cell.fieldRecreationDescription.text = contactInfoDetail.recreationNotes
                cell.fieldIncome.text = String(describing:contactInfoDetail.income ?? 0)
                cell.fieldRevenue.text = String(describing:contactInfoDetail.revenue ?? 0)
                cell.fieldCreditLimit.text = String(describing:contactInfoDetail.creditLimit ?? 0)
                cell.fieldCreditOnHold.text = String(describing:contactInfoDetail.creditOnHold ?? 0)
                cell.fieldExecutorName.text = contactInfoDetail.executorName
                if(Executorstr != ""){
                cell.fieldExecutor.text = Executorstr
                }
                ExecutorString = contactInfoDetail.executorName
                cell.fieldPowerName.text = contactInfoDetail.powerofAttorneyName
                if(Attorneystr != ""){
                cell.fieldPowerAtroney.text = Attorneystr
                }
                powerAttroney = contactInfoDetail.powerofAttorneyName
                //                cell.fieldExecutor.text = contactInfoDetail.executorID
//                if !isTappedBack {
//                    cell.fieldExecutor.text = contactInfoDetail.executorID
//                }
//                if !isTappedBack {
//                    cell.fieldPowerAtroney.text = contactInfoDetail.powerOfAttronyID
//                }
                //                cell.fieldPowerAtroney.text = contactInfoDetail.powerOfAttronyID
                cell.fieldGroupInsurance.text = contactInfoDetail.groupInsurance
                cell.fieldGroupInsurancePlan.text = contactInfoDetail.groupPensionPlan
                cell.fieldMoneyDescription.text = contactInfoDetail.moneyNotes
                
                if let amountString = cell.fieldIncome.text?.convertStringToCurrency() {
                    if amountString.count == 0 {
                        cell.fieldIncome.text = "$0.00"
                    }else{
                        cell.fieldIncome.text = amountString
                    }
                }
                isTappedBack = false
                
                //                if cell.fieldIncome.text!.count == 0 {
                //                    cell.fieldIncome.text = "$0.00"
                //                }else{
                //
                //                    print(cell.fieldIncome.text!)
                //                    print(String(describing:contactInfoDetail.income ?? 0))
                //
                //                    let myDouble = Float(cell.fieldIncome.text!)
                //                    let currencyFormatter = NumberFormatter()
                //                    currencyFormatter.usesGroupingSeparator = true
                //                    currencyFormatter.numberStyle = .currency
                //                    // localize to your grouping and decimal separator
                //                    currencyFormatter.locale = Locale.current
                //
                //                    // We'll force unwrap with the !, if you've got defined data you may need more error checking
                //
                //                    let priceString = currencyFormatter.string(from: NSNumber(value: myDouble!))!
                //                    print(priceString) // Displays $9,999.99 in the US locale
                //
                //                     cell.fieldIncome.text = priceString
                //                }
                
                
                
                //                if let amountString = cell.fieldIncome.text!.currencyInputFormatting() {
                //                    if amountString.count == 0 {
                //                        cell.fieldIncome.text = "$0.00"
                //                    }else{
                //                        cell.fieldIncome.text = amountString
                //                    }
                //                }
                if let amountString = cell.fieldCreditLimit.text?.convertStringToCurrency() {
                    if amountString.count == 0 {
                        cell.fieldCreditLimit.text = "$0.00"
                    }else{
                        cell.fieldCreditLimit.text = amountString
                    }
                }
                if let amountString = cell.fieldRevenue.text?.convertStringToCurrency() {
                    if amountString.count == 0 {
                        cell.fieldRevenue.text = "$0.00"
                    }else{
                        cell.fieldRevenue.text = amountString
                    }
                }
                if let amountString = cell.fieldCreditOnHold.text?.convertStringToCurrency() {
                    if amountString.count == 0 {
                        cell.fieldCreditOnHold.text = "$0.00"
                    }else{
                        cell.fieldCreditOnHold.text = amountString
                    }
                }
            }
            return cell
            
        }else if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 5 || indexPath.section == 7 {
            let cell:HeaderCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            cell.lblItem1.text = "Name"
            cell.lblItem2.text = "Primary Contact"
            
            cell.AddTopConstraint.constant = 2
            cell.AddHeightConstraint.constant = 26
            cell.SearchHeightConstraint.constant = 3
            cell.searchTopConstraint.constant = 24
            // cell.lblItem3.text = "Primary Phone"
            
            cell.lblItem1.isHidden = true
            cell.lblItem2.isHidden = true
            cell.lblItem3.isHidden = true
            if indexPath.section == 1 && selectedIndexPath - 1 == indexPath.section && isExpand {
                cell.AddTopConstraint.constant = 2
                cell.AddHeightConstraint.constant = 26
                cell.SearchHeightConstraint.constant = 24
                cell.searchTopConstraint.constant = 3
                cell.lblItem1.isHidden = false
                cell.lblItem2.isHidden = false
                cell.lblItem3.isHidden = false
            }
            if indexPath.section == 3 && selectedIndexPath - 1 == indexPath.section && isExpand {
                cell.AddTopConstraint.constant = 2
                cell.AddHeightConstraint.constant = 26
                cell.SearchHeightConstraint.constant = 24
                cell.searchTopConstraint.constant = 3
                cell.lblItem1.isHidden = false
                cell.lblItem2.isHidden = false
                cell.lblItem3.isHidden = false
            }
            if indexPath.section == 5 && selectedIndexPath - 1 == indexPath.section && isExpand {
                cell.AddTopConstraint.constant = 2
                cell.AddHeightConstraint.constant = 26
                cell.SearchHeightConstraint.constant = 24
                cell.searchTopConstraint.constant = 3
                
                cell.lblItem1.text = "Subject"
                cell.lblItem2.text = "Start Time"
                cell.lblItem3.text = "Type"
                
                cell.lblItem1.isHidden = false
                cell.lblItem2.isHidden = false
                cell.lblItem3.isHidden = false
            }
            if indexPath.section == 7 && selectedIndexPath - 1 == indexPath.section && isExpand {
                
                cell.lblItem1.text = "Subject"
                cell.lblItem2.text = "Start Time"
                cell.lblItem3.text = "Type"
                
                //                cell.AddTopConstraint.constant = 5
                //                cell.AddHeightConstraint.constant = 0
                //                cell.SearchHeightConstraint.constant = 0
                //                cell.searchTopConstraint.constant = 5
                
                cell.lblItem1.isHidden = false
                cell.lblItem2.isHidden = false
                cell.lblItem3.isHidden = false
            }
            if indexPath.section == 1 {
                if(isExpand && selectedIndexPath_condition == indexPath.section){
                    cell.AdditionalView.isHidden = false
                }
                else{
                    cell.AdditionalView.isHidden = true
                }
                cell.lblItem1.text = "Name"
                cell.lblItem2.text = ""
                cell.lblItem3.text = "Address1"
                cell.lblItem3.textAlignment = .center
                
                cell.lblHeader.text = headerTitles[0]
                cell.btnAdd.isHidden = false
                cell.btnSearch.isHidden = false
                
                cell.btnSearch.removeTarget(nil, action: nil, for: .allEvents)
                cell.btnSearch.tag = indexPath.section
                cell.btnSearch.addTarget(self, action: #selector(tblSearchAddressButtonTapped(_:)), for: .touchDown)
                
                cell.btnAdd.removeTarget(nil, action: nil, for: .allEvents)
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
                    cell.AdditionalView.isHidden = false
                }
                else{
                    cell.AdditionalView.isHidden = true
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
                cell.btnAdd.removeTarget(nil, action: nil, for: .allEvents)
                cell.btnAdd.tag = indexPath.section
                cell.btnAdd.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchDown)
                
                cell.btnSearch.removeTarget(nil, action: nil, for: .allEvents)
                cell.btnSearch.tag = indexPath.section
                cell.btnSearch.addTarget(self, action: #selector(tblSearchButtonTapped(_:)), for: .touchDown)
                
                if !isEditable {
                    //                    cell.btnAdd.isHidden = true
                    //                    cell.btnSearch.isHidden = true
                }
                return cell
            }else if indexPath.section == 5 {
                if(isExpand && selectedIndexPath_condition == indexPath.section){
                    cell.AdditionalView.isHidden = false
                }
                else{
                    cell.AdditionalView.isHidden = true
                }
                
                cell.lblHeader.text = headerTitles[2]
                 //cell.btnAdd.isHidden = false
                cell.btnSearch.isHidden = true
                
                if selectedIndexPath == 6 {
                    cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
                }else{
                    cell.imgArrow.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)))
                }
                cell.btnSearch.tag = indexPath.section
                //  cell.btnSearch.addTarget(self, action: #selector(tblSearchButtonTapped(_:)), for: .touchDown)
                cell.btnAdd.removeTarget(nil, action: nil, for: .allEvents)
                cell.btnSearch.removeTarget(nil, action: nil, for: .allEvents)
                
                cell.btnAdd.tag = indexPath.section
                cell.btnAdd.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchDown)
                if !isEditable {
                    //                    cell.btnAdd.isHidden = true
                    //                    cell.btnSearch.isHidden = true
                }
                return cell
            }else if indexPath.section == 7 {
                
                cell.btnAdd.removeTarget(nil, action: nil, for: .allEvents)
                cell.btnSearch.removeTarget(nil, action: nil, for: .allEvents)
                
                if(isExpand && selectedIndexPath_condition == indexPath.section){
                    cell.AdditionalView.isHidden = false
                }
                else{
                    cell.AdditionalView.isHidden = true
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
        }else{
            if indexPath.section == 2 {
                //                let cell:AdditionalAddressCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalAddressCell") as! AdditionalAddressCell
                //                cell.lblName.text = additionalResult[indexPath.row].name
                //                cell.lblAddress.text = additionalResult[indexPath.row].line1
                //                cell.lblCity.text = additionalResult[indexPath.row].telephone1
                
                let cell:AccountHeaderCell = tableView.dequeueReusableCell(withIdentifier: "AccountHeaderCell") as! AccountHeaderCell
                //            let cell:AddAddtionalCell = tableView.dequeueReusableCell(withIdentifier: "AddAddtionalCell") as! AddAddtionalCell
                cell.lblName2.textAlignment = .left
                cell.lblName1.text = additionalResult[indexPath.row].name
                cell.lblName2.text = additionalResult[indexPath.row].line1
                //            cell.lblCity.text = additionalResult[indexPath.row].city
                return cell
                
                
                //                return cell
            }else if indexPath.section == 4 {
                //                let cell:AdditionalAddressCell = tableView.dequeueReusableCell(withIdentifier: "AdditionalAddressCell") as! AdditionalAddressCell
                //
                //                cell.lblName.text = getLinkedAccountsResult[indexPath.row].name
                //                cell.lblAddress.text = getLinkedAccountsResult[indexPath.row].addressLine1
                //                cell.lblCity.text = getLinkedAccountsResult[indexPath.row].telephone1
                let cell:AccountHeaderCell = tableView.dequeueReusableCell(withIdentifier: "AccountHeaderCell") as! AccountHeaderCell
                //            let cell:AddAddtionalCell = tableView.dequeueReusableCell(withIdentifier: "AddAddtionalCell") as! AddAddtionalCell
                cell.lblName2.textAlignment = .center
                cell.lblName1.text = getLinkedAccountsResult[indexPath.row].name
                cell.lblName2.text = getLinkedAccountsResult[indexPath.row].telephone1
                
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
                cell.lblAddress.text = getCompleteActivitiesResult[indexPath.row].activity.startTime.convertYearMonthDatehourMin()
                cell.lblCity.text = getCompleteActivitiesResult[indexPath.row].type
                
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if contactInfoDetail == nil {
            return 45
        }else {
            if section == 8 {
                return 45
            }
        }
        return 0
    }
    
    //
    //    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //
    //        let bottomView = UIView()
    //        bottomView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 44)
    //        bottomView.backgroundColor = UIColor.init(UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal)
    //        let editBtn = UIButton()
    //        editBtn.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 17.0)!
    //        editBtn.frame = CGRect(x: 8.0, y: 7.0, width: 100, height: 30)
    //        editBtn.backgroundColor = UIColor.white
    //        editBtn.setTitleColor(UIColor.init(UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal), for: .normal)
    //        if contactInfoDetail == nil {
    //            editBtn.setTitle("Close", for: .normal)
    //            editBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchDown)
    //        }else{
    //
    //        }
    //
    //        bottomView.addSubview(editBtn)
    //
    //        let closeBtn = UIButton()
    //        closeBtn.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 17.0)!
    //        closeBtn.frame = CGRect(x: self.view.frame.size.width - 110, y: 7.0, width: 100, height: 30)
    //        closeBtn.backgroundColor = UIColor.white
    //        closeBtn.setTitleColor(UIColor.init(UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0), for: .normal), for: .normal)
    //        if contactInfoDetail == nil {
    //            closeBtn.setTitle("Save", for: .normal)
    //            closeBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
    //        }else{
    //
    //        }
    //        bottomView.addSubview(closeBtn)
    //
    //        return bottomView
    //    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 10 {
            return
        }
        if tableView.tag == 20 {
            //            if chidrenPaths.contains(indexPath.row) {
            //                for index in 0..<chidrenPaths.count {
            //                    let getIndex:Int = chidrenPaths[index]
            //                    if getIndex == indexPath.row {
            //                        chidrenPaths.remove(at: index)
            //                    }
            //                }
            //            }
            //            chidrenPaths.append(indexPath.row)
            //            self.tblChildrens.reloadData()
            return
        }
        print(indexPath.section)
        if indexPath.section == 1 || indexPath.section == 3 || indexPath.section == 5 || indexPath.section == 7  {
            if indexPath.section == selectedIndexPath - 1 {
                selectedIndexPath = 2123123
                isExpand = false
            }else{
                selectedIndexPath = indexPath.section + 1
                isExpand = true
            }
            selectedIndexPath_condition = indexPath.section
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let indexPath = IndexPath(item: 0, section: 1)
                let indexPath1 = IndexPath(item: 0, section: 3)
                let indexPath2 = IndexPath(item: 0, section: 5)
                let indexPath3 = IndexPath(item: 0, section: 7)
                tableView.reloadRows(at: [indexPath,indexPath1,indexPath2,indexPath3], with: .bottom)
            }
        }else if indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 {
            //            if !isEditable {
            //                return
            //            }
            if indexPath.section == 2 {
                let getAddress:AdditionalAddsResult = AdditionalAddsResult.init(fromDictionary: additionalResult[indexPath.row].toDictionary())
                let controller:AdditionalNewAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "AdditionalNewAddressVC") as! AdditionalNewAddressVC
                controller.additionalAddressDetail = getAddress
                self.navigationController?.pushViewController(controller, animated: true)
            }else if indexPath.section == 4 {
                let getAddress:GetAccountsListResult = GetAccountsListResult.init(fromDictionary: getLinkedAccountsResult[indexPath.row].toDictionary())
                let controller:NewAccountsController = self.storyboard?.instantiateViewController(withIdentifier: "NewAccountsController") as! NewAccountsController
                controller.contactAdd = true
                controller.contactInfoDetail = getAddress
                controller.isfromcontactPAge = true
                controller.rightContactID = self.contactInfoDetail.id!
                self.navigationController?.pushViewController(controller, animated: true)
                //                let getAddress:LinkedAccountsResult = LinkedAccountsResult.init(fromDictionary: getLinkedAccountsResult[indexPath.row].toDictionary())
                //                let controller:AddLinkedAccountController = self.storyboard?.instantiateViewController(withIdentifier: "AddLinkedAccountController") as! AddLinkedAccountController
                //                controller.additionalAddressDetail = getAddress
                //                self.navigationController?.pushViewController(controller, animated: true)
            }else if indexPath.section == 6 {
                let getActivty = getOpenedActivitiesResult[indexPath.row]
                let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: getActivty.toDictionary())
                if getAddress.type == "Task" {
                    let controller:NewTaskController = (self.storyboard?.instantiateViewController(withIdentifier: "NewTaskController") as? NewTaskController)!
                    controller.linkParentID = contactInfoDetail.id!
                    controller.Editvalue = "edit"
                    controller.openedActivties = getAddress
                    controller.linkParentID = contactInfoDetail.id!
                    controller.openedActivties = getAddress
                    controller.fromAccounts = true
                    controller.IsEdit = true
                    controller.StrAccount = "Accounts"
                    self.navigationController?.pushViewController(controller, animated: true)
                }else if getAddress.type == "Appointment" || getAddress.type == "Appointments" {
                    let controller:NewAppointmentsController = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentsController") as? NewAppointmentsController)!
                    controller.Editvalue = "edit"
                    controller.linkParentID = contactInfoDetail.id!
                    print(getAddress.activity.AppointmentTypeId)
                    UserDefaults.standard.set(getAddress.activity.AppointmentTypeId, forKey: "appointmentTypeID")
                    controller.openedActivties = getAddress
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }else if indexPath.section == 8 {
                let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: getCompleteActivitiesResult[indexPath.row].toDictionary())
                if getAddress.type == "Task" {
                    let controller:NewTaskController = (self.storyboard?.instantiateViewController(withIdentifier: "NewTaskController") as? NewTaskController)!
                    controller.linkParentID = contactInfoDetail.id!
                    controller.Editvalue = "edit"
                    controller.IsEdit = true
                    controller.openedActivties = getAddress
                    self.navigationController?.pushViewController(controller, animated: true)
                }else if getAddress.type == "Appointment" || getAddress.type == "Appointments" {
                    let controller:NewAppointmentsController = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentsController") as? NewAppointmentsController)!
                    controller.Editvalue = "edit"
                    controller.linkParentID = contactInfoDetail.id!
                    UserDefaults.standard.set(getAddress.activity.id, forKey: "appointmentTypeID")
                    controller.openedActivties = getAddress
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
    }
    @objc func tappedDeleteChildrens(_ button: UIButton) {
        let result = childNames.replacingOccurrences(of: "\n", with: ", ",
                                                     options: NSString.CompareOptions.literal, range:nil)
        var fullNameArr = result.components(separatedBy: ", ")
        fullNameArr.remove(at: button.tag)
        childNames = fullNameArr.joined(separator: "\n")
        
        childNames = childNames.replacingOccurrences(of: "\n", with: ", ",options: NSString.CompareOptions.literal, range:nil)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell:ContactssCell = tableView.cellForRow(at: indexPath) as! ContactssCell
        cell.fieldChildrenname.text = childNames
        //        let result2 = cell.fieldChildrenname.text!.replacingOccurrences(of: ", ", with: "\n",
        //                                                                       options: NSString.CompareOptions.literal, range:nil)
        //        childNames = result2
        self.tblChildrens.reloadData()
        
        if fullNameArr.count == 0 {
            self.navigationController?.isNavigationBarHidden = false
            childrenView.removeFromSuperview()
        }
        //        if (cell.fieldChildrenname.text?.count)! > 0 {
        //            //ChildrensNames
        //            let result = cell.fieldChildrenname.text!.replacingOccurrences(of: ", ", with: "\n",
        //                                                                           options: NSString.CompareOptions.literal, range:nil)
        //            childNames = result
        //
        //        }
        
        
    }
    @objc func tappedAddChildrens(_ button: UIButton) {
        let hmPopup = HMPopUpView.init(title: "Add Children", okButtonTitle: "Add", cancelButtonTitle: "Cancel", delegate: self)
        hmPopup?.borderColor = UIColor.PSNavigaitonController()
        hmPopup?.titleSeparatorColor = UIColor.PSNavigaitonController()
        hmPopup?.okButtonBGColor = UIColor.PSNavigaitonController()
        hmPopup?.containerColor = UIColor.PSNavigaitonController()
        hmPopup?.okButtonTextColor = UIColor.black;
        
        hmPopup?.textFieldBGColor = UIColor.PSNavigaitonController()
        hmPopup?.textFieldBoarderColor = UIColor.black;
        hmPopup?.borderWidth = 1
        hmPopup?.transitionType = .popFromBottom;
        hmPopup?.dismissType = .fadeOutTop;
        
        hmPopup?.configureHMPopUpView(withBGColor: UIColor.PSNavigaitonController(), titleColor: UIColor.white, buttonViewColor: UIColor.PSNavigaitonController(), buttonBGColor: UIColor.PSNavigaitonController(), buttonTextColor: UIColor.white)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        hmPopup?.show(in: appDelegate.window)
    }
    
    @objc func tblSearchCategory(_ button: UIButton) {
        let btnTag = button.tag
        if btnTag == 1 {
            getSearchAPI(objectName: "address")
        }else if btnTag == 3 {
            getSearchAPI(objectName: "company")
        }else if btnTag == 5 {
            
        }
    }
    @objc func tblADDCategory(_ button: UIButton) {
        self.view.endEditing(true)
        let controller:AddCategoryVC = self.storyboard?.instantiateViewController(withIdentifier: "AddCategoryVC") as! AddCategoryVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func tblSearchButtonTapped(_ button: UIButton) {
        
        if(button.tag  == 3){
            
            let json:[String: Any] = ["AscendingOrder":true,
                                      "ObjectName":"company",
                                      "PassKey":passKey,
                                      "OrderBy": "Name",
                                      "OrganizationId":currentOrgID,
                                      "PageOffset":1,
                                      "ResultsPerPage":1000]
            print(json)
            APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                DispatchQueue.main.async {
                    print(json)
                    self.resultsaddressArray = []
                    self.linkaddressArray = []
                    self.resultsArray = json["Results"].arrayValue
                    self.resultsaddressArray = json["Results"].arrayValue
                    for dic in self.resultsArray{
                        let value = dic["Name"].string
                        self.linkcontactArray.append(value!)
                        self.linkaddressArray.append(value!)
                    }
                    if(self.linkcontactArray.count > 0){
                        self.showLinkedAccounts()
                        
                        
                        //                    DPPickerManager.shared.showPicker(title: "Accounts", selected: "", strings: self.linkcontactArray) { (value, index, cancel) in
                        //                        if !cancel {
                        //                            print(index)
                        //                            let dict = self.resultsArray[index]
                        //                            print(dict)
                        //                            let id : String = dict["Id"].string!
                        //                            let json:[String:Any] = ["LeftId":self.contactInfoDetail.id!,
                        //                                                     "RightId":id,
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
                        //                                        if(response == "Unable to add accounts"){
                        //                                            NavigationHelper.showSimpleAlert(message:"Unable to create ServiceMatrixTemplate")
                        //                                        }
                        //                                        else{
                        //                                            NavigationHelper.showSimpleAlert(message:"Added Successfully")
                        //                                            self.tblHistory.reloadData()
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
    
    @objc func tblSearchAddressButtonTapped(_ button: UIButton) {
        if(button.tag == 1){
            let json:[String: Any] = ["AscendingOrder":true,
                                      "ObjectName":"address",
                                      "PassKey":passKey,
                                      "OrderBy": "Name",
                                      "OrganizationId":currentOrgID,
                                      "PageOffset":1,
                                      "ResultsPerPage":1000]
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
                        //
                        /*
                         DPPickerManager.shared.showPicker(title: "Addresses", selected: "", strings: self.linkaddressArray) { (value, index, cancel) in
                         if !cancel {
                         print(index)
                         let dict = self.resultsaddressArray[index]
                         print(dict)
                         let id : String = dict["Id"].string!
                         let json:[String:Any] = ["LeftId":self.contactInfoDetail.id!,
                         "RightId":id,
                         "LeftObjectName":"contact",
                         "ObjectName":"linker_contacts_addresses",
                         "PassKey":passKey,
                         "OrganizationId":currentOrgID,
                         "RightObjectName":"address"]
                         print(json)
                         APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/link.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                         DispatchQueue.main.async {
                         print(json)
                         OperationQueue.main.addOperation {
                         let response = json["ResponseMessage"].string
                         if(response == "success"){
                         NavigationHelper.showSimpleAlert(message:"Added Successfully")
                         self.tblHistory.reloadData()
                         }
                         else{
                         NavigationHelper.showSimpleAlert(message:"Unable to add Address")
                         
                         }
                         }
                         }
                         },  onFailure: { error in
                         print(error.localizedDescription)
                         })
                         
                         }
                         }
                         */
                    }
                }
            },  onFailure: { error in
                print(error.localizedDescription)
            })
        }
        
    }
    
    
    func getSearchAPI(objectName:String){
        
        let json:[String: Any] = ["SearchTerm": "",
                                  "ObjectName":objectName,
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID,
                                  "PageOffset":1,
                                  "ResultsPerPage":1000]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                if objectName == "address" {
                    let getModel = getSearchResultRootClass.init(fromDictionary: jsonResponse)
                    if getModel.valid {
                        self.getAddtionalAddressesModel = getModel.results
                        self.showPicker(pickerTag: 244, textField: UITextField())
                    }
                }else if objectName == "company" {
                    let getModel = getLinkedResultModell.init(fromDictionary: jsonResponse)
                    if getModel.valid {
                        self.getLinkedAccountModel = getModel.results
                        self.showPicker(pickerTag: 344, textField: UITextField())
                    }
                }
                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    @objc func ratingButtonTapped(_ button: UIButton) {
        print("Butto pressed 👍")
        
        let btnTag = button.tag
        print(btnTag)
        
        if btnTag == 1 {
            let controller:AdditionalNewAddressVC = self.storyboard?.instantiateViewController(withIdentifier: "AdditionalNewAddressVC") as! AdditionalNewAddressVC
            controller.leftID = self.contactInfoDetail.id!
            self.navigationController?.pushViewController(controller, animated: true)
        }else if btnTag == 3 {
            let controller:NewAccountsController = self.storyboard?.instantiateViewController(withIdentifier: "NewAccountsController") as! NewAccountsController
            controller.isfromcontactPAge = true
            controller.rightContactID = self.contactInfoDetail.id!
            //            controller.leftID = self.contactInfoDetail.id!
            self.navigationController?.pushViewController(controller, animated: true)
        }else if btnTag == 5 {
            let alert = UIAlertController(title: " ", message: "Please Select an Option", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Appointment", style: .default , handler:{ (UIAlertAction)in
                print("User click Approve button")
                OperationQueue.main.addOperation {
                    let controller:NewAppointmentsController = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentsController") as? NewAppointmentsController)!
                    controller.linkParentID = self.contactInfoDetail.id!
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Task", style: .default , handler:{ (UIAlertAction)in
                print("User click Edit button")
                OperationQueue.main.addOperation {
                    let controller:NewTaskController = (self.storyboard?.instantiateViewController(withIdentifier: "NewTaskController") as? NewTaskController)!
                    controller.linkParentID = self.contactInfoDetail.id!
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Recurrence", style: .default , handler:{ (UIAlertAction)in
                print("User click Delete button")
                OperationQueue.main.addOperation {
                    let controller:CreateRecurrencePattern = (self.storyboard?.instantiateViewController(withIdentifier: "CreateRecurrencePattern") as? CreateRecurrencePattern)!
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
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        if indexPath.section == 2 {
            // 1
            let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                
                let getAddress:AdditionalAddsResult = AdditionalAddsResult.init(fromDictionary: self.additionalResult[indexPath.row].toDictionary())
                
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                        print(index,title)
                        if title == "Yes" {
                            let parameters = [
                                "ObjectName": "address",
                                "OrganizationId": currentOrgID,
                                "ObjectId": getAddress.id!,
                                "PassKey": passKey
                                ] as [String : Any]
                            
                            self.deleteInviteUser(parameter: parameters)
                        }
                    })
                })
            })
            // 5
            return [shareAction]
        }else if indexPath.section == 4 {
            // 1
            let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                
                let getAddress:LinkedAccountsResult = LinkedAccountsResult.init(fromDictionary: self.getLinkedAccountsResult[indexPath.row].toDictionary())
                
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                        print(index,title)
                        if title == "Yes" {
                            let parameters = [
                                "ObjectName": "company",
                                "OrganizationId": currentOrgID,
                                "ObjectId": getAddress.id!,
                                "PassKey": passKey
                                ] as [String : Any]
                            
                            self.deleteInviteUser(parameter: parameters)
                        }
                    })
                })
            })
            // 5
            return [shareAction]
        }else if indexPath.section == 6 {
            // 1
            let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                
                let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: self.getOpenedActivitiesResult[indexPath.row].toDictionary())
                
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                        print(index,title)
                        if title == "Yes" {
                            let parameters = [
                                "ObjectName": "appointment",
                                "OrganizationId": currentOrgID,
                                "ObjectId": getAddress.id!,
                                "PassKey": passKey
                                ] as [String : Any]
                            
                            self.deleteInviteUser(parameter: parameters)
                        }
                    })
                })
            })
            // 5
            return [shareAction]
        }else if indexPath.section == 8 {
            // 1
            let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
                
                let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: self.getCompleteActivitiesResult[indexPath.row].toDictionary())
                
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                        print(index,title)
                        if title == "Yes" {
                            let parameters = [
                                "ObjectName": "appointment",
                                "OrganizationId": currentOrgID,
                                "ObjectId": getAddress.id!,
                                "PassKey": passKey
                                ] as [String : Any]
                            
                            self.deleteInviteUser(parameter: parameters)
                        }
                    })
                })
            })
            // 5
            return [shareAction]
        }
        return []
    }
    func deleteInviteUser(parameter:[String : Any]){
        APIManager.sharedInstance.postRequestCall(postURL: deleteContactListURL, parameters: parameter, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Deleted") { (index, title) in
                        OperationQueue.main.addOperation {
                            self.selectedIndexPath = 1992001
                            self.isExpand = false
                            if self.contactInfoDetail != nil {
                                self.getContact()
                            }
                        }
                    }
                })
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    @IBAction func tappedEdit(_ sender: Any) {
        // historyBG.removeFromSuperview()
        actionBtn.isUserInteractionEnabled = true
        editBtn.isUserInteractionEnabled = true
        isEditable = true
        
        if contactInfoDetail != nil {
            self.title = "Edit Contact"
            self.removeCustomView()
            //            self.navigationItem.prompt = ""
        }
        //        barButton.isHidden = true
        actionBtn.removeTarget(nil, action: nil, for: .allEvents)
        
        actionBtn.setTitle("Save", for: .normal)
        actionBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
        
        tableView?.visibleCells.forEach { cell in
            if let cell = cell as? ContactssCell {
                cell.checkIfEditable(value: isEditable)
            }
        }
        
    }
    @IBAction func tappedAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
        let sendButton = UIAlertAction(title: "Apply Process", style: .default, handler: { (action) -> Void in
            let controller:NewAppliedProcess = self.storyboard?.instantiateViewController(withIdentifier: "NewAppliedProcess") as! NewAppliedProcess
            controller.conditionType = "Contact"
            controller.isFromContact = true
            controller.contactListResult = self.contactInfoDetail
            self.navigationController?.pushViewController(controller, animated: true)
        })
        let Reload = UIAlertAction(title: "Add Activity", style: .default, handler: { (action) -> Void in
            let alertController1 = UIAlertController(title: "Actions", message: nil, preferredStyle: .actionSheet)
            let Appointment = UIAlertAction(title: "New Appointment", style: .default, handler: { (action) -> Void in
                let controller:NewAppointmentsController = (self.storyboard?.instantiateViewController(withIdentifier: "NewAppointmentsController") as? NewAppointmentsController)!
                controller.linkParentID = self.contactInfoDetail.id!
                self.navigationController?.pushViewController(controller, animated: true)
            })
            let Task = UIAlertAction(title: "New Task", style: .default, handler: { (action) -> Void in
                let controller:NewTaskController = (self.storyboard?.instantiateViewController(withIdentifier: "NewTaskController") as? NewTaskController)!
                controller.linkParentID = self.contactInfoDetail.id!
                self.navigationController?.pushViewController(controller, animated: true)
            })
            let Recurrence = UIAlertAction(title: "New Recurrence", style: .default, handler: { (action) -> Void in
                let controller:CreateRecurrencePattern = (self.storyboard?.instantiateViewController(withIdentifier: "CreateRecurrencePattern") as? CreateRecurrencePattern)!
                controller.linkParentID = self.contactInfoDetail.id!
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
            self.historyBG.frame = self.view.frame
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.addSubview(self.historyBG)
            self.getChangeHistory()
            //            self.view.addSubview(createView)
        })
        let closeButton = UIAlertAction(title: "Close", style: .default, handler: { (action) -> Void in
            self.recreationAdded = false
            self.navigationController?.popViewController(animated: true)
        })
        
        let ReloadButton = UIAlertAction(title: "Reload", style: .default, handler: { (action) -> Void in
            self.tblHistory.reloadData()
            self.tblChildrens.reloadData()
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
    func reloadContact(){
        
        let json: [String: Any] = ["ObjectName": "contact",
                                   "ObjectId": contactInfoDetail.id!,
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                
                print(json)
                let contactModel = ContactListResult.init(fromDictiary: jsonResponse["DataObject"] as! NSDictionary)
                print(contactModel.fullName!)
                
                //                if let indexPath = IndexPath(row: 0, section: 0) as? IndexPath {
                //                    if let cell:ContactssCell = self.tableView.cellForRow(at: indexPath) as? ContactssCell {
                //                        cell.fieldExecutor.text = contactModel.executorName
                ////                         cell.fieldSpouse2.text = contactModel.spousePartnerName
                ////                        cell.fieldPowerAtroney.text = contactModel.powerofAttorneyName
                //
                //                    }
                //                }
                
                
                self.contactInfoDetail = contactModel
                self.cellCalled = false
                self.viewWillAppear(true)
                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
        
    }
    func getChangeHistory(){
        
        let objectID:[String] = [contactInfoDetail.id!]
        let json: [String: Any] = ["OrganizationId": currentOrgID,
                                   "PassKey": passKey,
                                   "ObjectIds":objectID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: getHistoryURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let contactModel = getHistoryModel.init(fromDictionary: jsonResponse)
                print(contactModel.responseMessage)
                if contactModel.valid {
                    self.getHistoryEntries = contactModel.entries
                    self.tblHistory.reloadData()
                }
                //getHistoryModel
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        
    }
    @IBAction func tappedClose(_ sender: Any) {
        if contactAdd {
            self.navigationController?.popViewController(animated: true)
            return
        }
        if isEditable && contactInfoDetail == nil {
            self.recreationAdded = false
            self.navigationController?.popViewController(animated: true)
            return
        }
        if isEditable {
            self.isEditable = false
            //            barButton.isHidden = false
            self.editBtn.removeTarget(nil, action: nil, for: .allEvents)
            
            self.editBtn.setTitle("Edit", for: .normal)
            self.editBtn.addTarget(self, action: #selector(self.tappedEdit(_:)), for: .touchDown)
            
            self.actionBtn.removeTarget(nil, action: nil, for: .allEvents)
            
            self.actionBtn.setTitle("Actions", for: .normal)
            self.actionBtn.addTarget(self, action: #selector(self.tappedAction(_:)), for: .touchDown)
            
            showRightBarbuttonItem()
            //            let indexPath = IndexPath(row: 0, section: 0)
            //            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            
            self.tableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // change 2 to desired number of seconds
                // self.tableView.setContentOffset(.zero, animated: false)
            }
            
            setupCustomView()
            
            return
        }
        self.recreationAdded = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedHistoryClose(_ sender: Any) {
        historyBG.removeFromSuperview()
    }
    @IBAction func tappedChildrenSave(_ sender: Any) {
        childrenView.removeFromSuperview()
    }
    
    @IBAction func tappedChildrenClose(_ sender: Any) {
        self.navigationController?.isNavigationBarHidden = false
        
        childrenView.removeFromSuperview()
    }
    @IBAction func tappedSave(_ sender: Any) {
        
       
        
        
        if contactInfoDetail != nil {
            
            if isEditable {
                OperationQueue.main.addOperation {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // change 2 to desired number of seconds
                        //self.tableView.setContentOffset(.zero, animated: false)
                    }
                    
                    self.saveContact()
                    
                }
                return
            }else{
                isEditable = true
                
                if contactInfoDetail != nil {
                    self.title = "Edit Contact"
                    self.removeCustomView()
                    //                    self.navigationItem.prompt = ""
                }
                //                barButton.isHidden = true
                actionBtn.removeTarget(nil, action: nil, for: .allEvents)
                
                actionBtn.setTitle("Actions", for: .normal)
                actionBtn.addTarget(self, action: #selector(tappedAction(_:)), for: .touchDown)
                removeRightBarbuttonItem()
                
                //                let indexPath = IndexPath(row: 0, section: 0)
                //                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // change 2 to desired number of seconds
                    // self.tableView.setContentOffset(.zero, animated: false)
                }
                
                self.tableView.reloadData()
                return
            }
            
        }
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // change 2 to desired number of seconds
                // self.tableView.setContentOffset(.zero, animated: false)
            }
            
            
            self.saveContact()
            
        }
    }
    
    func saveContact(){
        
        //Contact
        let indexPath = IndexPath(row: 0, section: 0)
        let cell:ContactssCell = tableView.cellForRow(at: indexPath) as! ContactssCell
        if (cell.fieldChildrenname.text?.count)! > 0 {
            //ChildrensNames
            let result = cell.fieldChildrenname.text!.replacingOccurrences(of: ", ", with: "\n",
                                                                           options: NSString.CompareOptions.literal, range:nil)
            childNames = result
            
        }
        //        if cell.fieldFirstName.text?.count == 0 {
        //            NavigationHelper.showSimpleAlert(message: "Please enter the First Name")
        //            return
        //        }
        if cell.fieldLastName.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message: "Please enter the Last Name")
            return
        }
        print(cell.fieldAlternatePhone.text!)
        
        //closeBtn.isUserInteractionEnabled = false
        actionBtn.isUserInteractionEnabled = false
        editBtn.isUserInteractionEnabled = false
        
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(childNames, forKey: "ChildrensNames")
        dataObject.setValue(cell.fieldTitle.text!, forKey: "Title")
        dataObject.setValue(cell.fieldFirstName.text!, forKey: "FirstName")
        dataObject.setValue(cell.fieldMiddleName.text!, forKey: "MiddleName")
        dataObject.setValue(cell.fieldLastName.text!, forKey: "LastName")
        dataObject.setValue(cell.fieldSalutation.text!, forKey: "Salutation")
        dataObject.setValue(cell.fieldsuffix.text!, forKey: "Suffix")
        dataObject.setValue(cell.fieldNickName.text!, forKey: "NickName")
        dataObject.setValue(clientClassID, forKey: "ClientClassId")
        
        dataObject.setValue("", forKey: "EMailAddress1")
        dataObject.setValue("", forKey: "EMailAddress2")
        dataObject.setValue("", forKey: "EMailAddress3")
        
        if (cell.fieldEmail.text?.count)! > 0 {
            if cell.fieldEmail.text!.isValidEmail() {
                dataObject.setValue(cell.fieldEmail.text!, forKey: "EMailAddress1")
            }else{
                dataObject.setValue("", forKey: "EMailAddress1")
            }
        }
        if (cell.fieldEmail2.text?.count)! > 0 {
            if cell.fieldEmail2.text!.isValidEmail() {
                dataObject.setValue(cell.fieldEmail2.text!, forKey: "EMailAddress2")
            }else{
                dataObject.setValue("", forKey: "EMailAddress2")
            }
        }
        if (cell.fieldEmail3.text?.count)! > 0 {
            if cell.fieldEmail3.text!.isValidEmail() {
                dataObject.setValue(cell.fieldEmail3.text!, forKey: "EMailAddress3")
            }else{
                dataObject.setValue("", forKey: "EMailAddress3")
            }
        }
        
        if (cell.fieldCountry.text?.count)! > 0 {
            dataObject.setValue(cell.fieldCountry.text!, forKey: "Country")
        }else{
            dataObject.setValue("", forKey: "Country")
            
        }
        
        
        //dataObject.setValue(cell.fieldCountry.text!, forKey: "Country")
        dataObject.setValue(cell.fieldWebsite.text!, forKey: "WebSiteUrl")
        dataObject.setValue(cell.fieldFtp.text!, forKey: "FtpSiteUrl")
        dataObject.setValue(cell.fieldBusinessExt.text!, forKey: "Telephone1Ext")
        dataObject.setValue(cell.fieldEveningPhone.text!, forKey: "Telephone2")
        
        
        
        dataObject.setValue(cell.fieldAlternatePhone.text!, forKey: "Telephone3")
        dataObject.setValue(cell.fieldMobilePhone.text!, forKey: "MobilePhone")
        dataObject.setValue(cell.fieldBusinessPhone.text!, forKey: "Telephone1")
        
        
        dataObject.setValue(cell.fieldPager.text!, forKey: "Pager")
        dataObject.setValue(cell.fieldFax.text!, forKey: "Fax")
        
        
        
        dataObject.setValue(cell.fieldAddress1.text!, forKey: "AddressLine1")
        dataObject.setValue(cell.fieldAddress2.text!, forKey: "AddressLine2")
        dataObject.setValue(cell.fieldAddress3.text!, forKey: "AddressLine3")
        dataObject.setValue(cell.fieldCity.text!, forKey: "City")
        dataObject.setValue(cell.fieldState.text!, forKey: "State")
        dataObject.setValue(cell.fieldZip.text!, forKey: "Postal")
        
        dataObject.setValue(cell.fieldPOBox.text!, forKey: "PoBox")
        
        //Other contact information
        
        //        if cell.btnPrivate.currentImage == #imageLiteral(resourceName: "ic_check") {
        //            dataObject.setValue(true, forKey: "Private")
        //        }
        dataObject.setValue(false, forKey: "Private")
        dataObject.setValue(cell.fieldGender.text!, forKey: "Gender")
        
        if (cell.fieldAnniversary.text?.count)! > 0 {
            dataObject.setValue(cell.fieldAnniversary.text! + "T06:30:00.000Z", forKey: "Anniversary")
        }else{
            dataObject.setValue("", forKey: "Anniversary")
        }
        if (cell.fieldClientSince.text?.count)! > 0 {
            dataObject.setValue(cell.fieldClientSince.text! + "T06:30:00.000Z", forKey: "ClientSince")
        }else{
            dataObject.setValue("", forKey: "ClientSince")
        }
        dataObject.setValue(cell.clientLicenseNumber.text!, forKey: "DriversLicenseNumber")
        dataObject.setValue(cell.fieldGovernmentID.text!, forKey: "GovernmentIdent")
        
        
        if (cell.fieldBirthDate.text?.count)! > 0 {
            dataObject.setValue(cell.fieldBirthDate.text! + "T06:30:00.000Z", forKey: "BirthDate")
        }else{
            dataObject.setValue("", forKey: "BirthDate")
        }
        
        if (cell.fieldReviewDate.text?.count)! > 0 {
            dataObject.setValue(cell.fieldReviewDate.text! + "T06:30:00.000Z", forKey: "ReviewDate")
        }else{
            dataObject.setValue("", forKey: "ReviewDate")
        }
        
        if (cell.fieldLicenseExpiry.text?.count)! > 0 {
            dataObject.setValue(cell.fieldLicenseExpiry.text! + "T06:30:00.000Z", forKey: "DriversLicenseExpiry")
        }else{
            dataObject.setValue("", forKey: "DriversLicenseExpiry")
        }
        
        dataObject.setValue(ownerID, forKey: "OwningOrganizationUserId")
        
        dataObject.setValue(cell.fieldImportantInformation.text!, forKey: "Description")
        
        dataObject.setValue(cell.fieldFamilyDescription.text!, forKey: "FamilyNotes")
        dataObject.setValue(cell.fieldOccupationDescription.text!, forKey: "OccupationNotes")
        dataObject.setValue(cell.fieldRecreationDescription.text!, forKey: "RecreationNotes")
        
        dataObject.setValue(cell.fieldMoneyDescription.text!, forKey: "MoneyNotes")
        
        //Family
        
        dataObject.setValue(cell.fieldSpouse.text!, forKey: "SpousePartnerName")
        dataObject.setValue(spouseID, forKey: "SpousePartnerId")
        dataObject.setValue(cell.fieldMaritalStatus.text!, forKey: "MaritalStatus")
        
        //Occupation
        
      //  dataObject.setValue(cell.fieldCompanyName.text!, forKey: "CompanyName")
        dataObject.setValue(cell.fieldCompanyName.text!, forKey: "CompanyName")
        dataObject.setValue(companyID, forKey: "CompanyId")
        
        dataObject.setValue(cell.fieldAssistant.text!, forKey: "AssistantName")
        //        dataObject.setValue(cell.fieldDescription.text!, forKey: "OccupationNotes")
        dataObject.setValue(cell.fieldJobTitle.text!, forKey: "JobTitle")
        dataObject.setValue(cell.fieldDepartment.text!, forKey: "Department")
        dataObject.setValue(cell.fieldAssistantPhone.text!, forKey: "AssistantPhone")
        
        
        //Recreation
        
        //        dataObject.setValue(cell.fieldDescription.text!, forKey: "RecreationNotes")
        
        //Money
        
        
        var incomeValue:Int = 0
        if (cell.fieldIncome.text?.count)! > 0 {
            let amount = cell.fieldIncome.text!.removeFormatAmount() // 1000.0
            incomeValue = Int(amount)
        }
        
        var creditValue:Int = 0
        if (cell.fieldCreditLimit.text?.count)! > 0 {
            let amount = cell.fieldCreditLimit.text!.removeFormatAmount() // 1000.0
            creditValue = Int(amount)
        }
        var revenueValue:Int = 0
        if (cell.fieldRevenue.text?.count)! > 0 {
            
            let amount = cell.fieldRevenue.text!.removeFormatAmount() // 1000.0
            revenueValue = Int(amount)
            
        }
        var creditHoldValue:Int = 0
        if (cell.fieldCreditOnHold.text?.count)! > 0 {
            let amount = cell.fieldCreditOnHold.text!.removeFormatAmount() // 1000.0
            creditHoldValue = Int(amount)
            //            creditHoldValue = Int(cell.fieldCreditOnHold.text!)!
        }
        
        dataObject.setValue(incomeValue, forKey: "Income")
        dataObject.setValue(creditValue, forKey: "CreditLimit")
        dataObject.setValue(revenueValue, forKey: "Revenue")
        dataObject.setValue(creditHoldValue, forKey: "CreditOnHold")
        dataObject.setValue(cell.fieldExecutorName.text!, forKey: "ExecutorName")
        dataObject.setValue(cell.fieldPowerName.text!, forKey: "PowerofAttorneyName")
        dataObject.setValue(cell.fieldGroupInsurance.text!, forKey: "GroupInsurance")
        dataObject.setValue(cell.fieldGroupInsurancePlan.text!, forKey: "GroupPensionPlan")
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
                self.actionBtn.isUserInteractionEnabled = true
                self.editBtn.isUserInteractionEnabled = true
                if self.contactAdd {
                    OperationQueue.main.addOperation {
                        self.navigationController?.popViewController(animated: true)
                    }
                    return
                }
                if(self.linkaccount == "link"){
                    let id : String = json["DataObject"]["Id"].string!
                    let json:[String:Any] = ["LeftId":id,
                                             "RightId":self.leftid!,
                                             "LeftObjectName":"contact",
                                             "ObjectName":"linker_contacts_companies",
                                             "PassKey":passKey,
                                             "OrganizationId":currentOrgID,
                                             "RightObjectName":"company"]
                    print(json)
                    APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/link.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                        DispatchQueue.main.async {
                            print(json)
                            OperationQueue.main.addOperation {
                                let response = json["ResponseMessage"].string
                                if(response == "success"){
                                    NavigationHelper.showSimpleAlert(message:"Added Successfully")
                                    self.recreationAdded = false
                                    
                                    
                                    self.navigationController?.popViewController(animated:true)
                                }
                                else{
                                    NavigationHelper.showSimpleAlert(message:"Unable to add")
                                }
                            }
                        }
                    },  onFailure: { error in
                        print(error.localizedDescription)
                    })
                    
                }
                
                let result = cell.fieldChildrenname.text!.replacingOccurrences(of: "\n", with: ", ",
                                                                               options: NSString.CompareOptions.literal, range:nil)
                childNames = result
                
                if self.contactInfoDetail != nil {
                    if self.isEditable {
                        //disable all keyboards
                        if self.contactInfoDetail != nil {
                            if self.recreationCatID.count > 0 {
                                //                                self.linkRecreationCategories(leftid: self.contactInfoDetail.id, rightid: self.recreationCatID)
                            }
                            self.title = self.contactInfoDetail.fullName
                            self.setupCustomView()
                        }
                        
                        self.isEditable = false
                        
                        self.actionBtn.removeTarget(nil, action: nil, for: .allEvents)
                        
                        self.actionBtn.setTitle("Actions", for: .normal)
                        self.actionBtn.addTarget(self, action: #selector(self.tappedAction(_:)), for: .touchDown)
                        
                        self.editBtn.setTitle("Edit", for: .normal)
                        self.editBtn.addTarget(self, action: #selector(self.tappedEdit(_:)), for: .touchDown)
                        self.showRightBarbuttonItem()
                        
                        self.tableView.reloadData()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            // self.tableView.setContentOffset(.zero, animated: false)
                        }
                        return
                    }
                    
                }
                
                OperationQueue.main.addOperation {
                    self.recreationAdded = false
                    self.navigationController?.popViewController(animated: true)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
        
    }
    //    func linkRecreationCategories(leftid:String,rightid:String){
    //        let json: [String: Any] = ["ObjectName": "linker_contacts_recreations",
    //                                   "PassKey": passKey,
    //                                   "OrganizationId":currentOrgID,
    //                                   "LeftId":leftid,
    //                                   "LeftObjectName":"contact",
    //                                   "RightId":rightid,
    //                                   "RightObjectName":"recreation"]
    //        print(json)
    //        APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
    //            DispatchQueue.main.async {
    //                print(json)
    //
    //            }
    //        },  onFailure: { error in
    //            print(error.localizedDescription)
    //            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
    //        })
    //    }
    func deleteInviteUser(contactID:String){
        
        let headers = [
            "Content-Type": "application/json"
        ]
        let parameters = [
            "ObjectName": "contact",
            "OrganizationId": currentOrgID,
            "ObjectId": contactID,
            "PassKey": passKey
            ] as [String : Any]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/delete.json")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription as Any)
            } else {
                
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
                
                DispatchQueue.main.async(execute: {
                    AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Deleted") { (index, title) in
                        OperationQueue.main.addOperation {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                })
            }
        })
        
        dataTask.resume()
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
                }else{
                    NavigationHelper.showSimpleAlert(message:logModel.responseMessage)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
}



//Convert id to name
extension ContactssController {
    func getContact() {
        if contactInfoDetail.clientClassId != nil {
            if contactInfoDetail.clientClassId.count > 0 {
                let parameter:[String:Any] = ["SearchTerm":"",
                                              "ObjectName":"client_class",
                                              "PassKey":passKey,
                                              "OrganizationId":currentOrgID,
                                              "PageOffset": 1,
                                              "ResultsPerPage": 5000]
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
                                              "OrganizationId":currentOrgID,
                                              "PageOffset": 1,
                                              "ResultsPerPage": 5000]
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
                                              "OrganizationId":currentOrgID,
                                              "PageOffset": 1,
                                              "ResultsPerPage": 5000]
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
                                              "OrganizationId":currentOrgID,
                                              "PageOffset": 1,
                                              "ResultsPerPage": 5000]
                self.requestAPI(input: parameter, tag: 3)
            }else {
                getAdditionalAddress()
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
    func getLinkedRecreationList(){
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ListObjectName": "recreation",
                                       "ObjectName": "linker_contacts_recreations",
                                       "LinkParentId": contactInfoDetail.id!,
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID,
                                       "AscendingOrder":true]
            print(json)
            self.requestAPI(input: json, tag: 232)
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
                                   "ResultsPerPage": 500,
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
                                   "ResultsPerPage": 500,
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
    func getExectorName(){
        let json: [String: Any] = ["ObjectName": "contact",
                                   "ObjectId": contactInfoDetail.id!,
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: "https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                let contactModel = ContactListResult.init(fromDictiary: jsonResponse["DataObject"] as! NSDictionary)
                if self.contactInfoDetail != nil {
                    if self.contactInfoDetail.executorID.count > 0 {
                        if let indexPath = IndexPath(row: 0, section: 0) as? IndexPath {
                            if let cell:ContactssCell = self.tableView.cellForRow(at: indexPath) as? ContactssCell {
//                                cell.fieldExecutor.text = contactModel.fullName
//                                cell.fieldSpouse2.text = contactModel.spousePartnerName
//                                cell.fieldPowerAtroney.text = contactModel.powerofAttorneyName
                            }
                        }
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func requestAPI(input:[String:Any],tag:Int){
        
        var mainURL:String = searchURL
        if tag == 4 || tag == 5 || tag == 232 {
            mainURL = linkedURL
        }else if tag == 6 || tag == 7 {
            mainURL = getIncompleteActivitiesURL
        }
        
        APIManager.sharedInstance.postRequestCall(postURL: mainURL, parameters: input, senderVC: self, onSuccess: { (jsonResponse, json) in
            
            
            DispatchQueue.main.async {
                print(json)
                if tag == 0 {
                    let clientClassModel = GetClientClassModel.init(fromDictionary: jsonResponse)
                    if clientClassModel.valid {
                        for index in 0..<clientClassModel.results.count {
                            let model = clientClassModel.results[index]
                            if model.id == self.contactInfoDetail.clientClassId {
                                let indexPath = IndexPath(row: 0, section: 0)
                                if let cell:ContactssCell = self.tableView.cellForRow(at: indexPath) as? ContactssCell {
                                    cell.fieldClientClass.text = model.name
                                }
                            }
                        }
                    }
                }else if tag == 1 {
                    let clientClassModel = GetOwnersListModel.init(fromDictionary: jsonResponse)
                    if clientClassModel.valid {
                        for index in 0..<clientClassModel.results.count {
                            let model = clientClassModel.results[index]
                            if model.id == self.contactInfoDetail.owningOrganizationUserId {
                                let indexPath = IndexPath(row: 0, section: 0)
                                if let cell:ContactssCell = self.tableView.cellForRow(at: indexPath) as? ContactssCell {
                                    cell.fieldOwner.text = model.fullName
                                }
                            }
                        }
                    }
                }else if tag == 2 {
                    let clientClassModel = GetSpouseContactModel.init(fromDictionary: jsonResponse)
                    if clientClassModel.valid {
                        for index in 0..<clientClassModel.results.count {
                            let model = clientClassModel.results[index]
                            if model.id == self.contactInfoDetail.spousePartnerID {
                                let indexPath = IndexPath(row: 0, section: 0)
                                let cell:ContactssCell = self.tableView.cellForRow(at: indexPath) as! ContactssCell
                                cell.fieldSpouse2.text = model.fullName
                            }
                            if model.id == self.contactInfoDetail.executorID {
                                let indexPath = IndexPath(row: 0, section: 0)
                                let cell:ContactssCell = self.tableView.cellForRow(at: indexPath) as! ContactssCell
                                cell.fieldExecutor.text = model.fullName
                            }
                            if model.id == self.contactInfoDetail.powerOfAttronyID {
                                let indexPath = IndexPath(row: 0, section: 0)
                                let cell:ContactssCell = self.tableView.cellForRow(at: indexPath) as! ContactssCell
                                cell.fieldPowerAtroney.text = model.fullName
                            }
                        }
                    }
                }else if tag == 3 {
                    let clientClassModel = GetCompanyListModel.init(fromDictionary: jsonResponse)
                    if clientClassModel.valid {
                        for index in 0..<clientClassModel.results.count {
                            let model = clientClassModel.results[index]
                            if model.id == self.contactInfoDetail.companyId {
                                let indexPath = IndexPath(row: 0, section: 0)
                                let cell:ContactssCell = self.tableView.cellForRow(at: indexPath) as! ContactssCell
                                cell.fieldCompany.text = model.name
                            }
                        }
                    }
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
                    self.tableView.reloadData()
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
                }else if tag == 232 {
                    //getLinkedRecreationList
                    let model = getLinkedRecreationListModel.init(fromDictionary: jsonResponse)
                    if model.valid {
                        let modelClass:[getLinkedRecreationResult] = model.results
                        let tempArr:NSMutableArray = []
                        self.selectedRecreationIDList = []
                        
                        for index in 0..<modelClass.count {
                            tempArr.add(modelClass[index].name)
                            self.selectedRecreationIDList.append(modelClass[index].id)
                        }
                        if tempArr.count > 0 {
                            self.setCategories = true
                            self.getRecreationNames = tempArr.componentsJoined(by: ",")
                        }
                    }
                    self.tableView.reloadData()
                }
                
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
                }else if tag == 7 {
                    self.getLinkedRecreationList()
                }else if tag == 232 {
                    self.getExectorName()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
}
extension ContactssController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        animateViewMoving(up: true, moveValue: 144)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        animateViewMoving(up: false, moveValue: 144)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func textViewShouldBeginEditing(_ textField: UITextView) -> Bool {
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}
extension ContactssController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let str = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField.tag == -3 || textField.tag == -4 || textField.tag == -1 || textField.tag == -2 || textField.tag == -8{
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
        }
        else if str!.count == 3{
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
            if textField.tag == -1 || textField.tag == -2 || textField.tag == -3 || textField.tag == -4 || textField.tag == -8 {
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
            }else if textField.tag == -9 {
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
        
        
        if textField.tag == 5 {
            getClientClass(textField: textField)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
        }else if textField.tag == 10 {
            showPicker(pickerTag: 1, textField: textField)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 15 {
            showPicker(pickerTag: 2, textField: textField)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 20 {
            getOwnerList(textField: textField)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 25 {
            getSpouseContactList(tag: 4, textField: textField)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 30 {
            showPicker(pickerTag: 5, textField: textField)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 38 {
            getCompanyList(textField: textField)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 35 {
            getSpouseContactList(tag: 7, textField: textField)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 40 {
            getSpouseContactList(tag: 8, textField: textField)
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 45 {
            showCustomPicker(textfield: textField, title: "Anniversary")
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 50 {
            showCustomPickerbirthday(textfield: textField, title: "Birthday")
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }
        else if textField.tag == 144 {
            showCustomPickerCategory(textfield: textField, title: "Category")
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 55 {
            showCustomPicker(textfield: textField, title: "Client Since")
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 60 {
            showCustomPicker(textfield: textField, title: "Review Date")
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 65 {
            showCustomPicker(textfield: textField, title: "License Expiry")
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 144 {
            getRecreationContactList(tag: 144, textField: textField)
            
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
            
        }else if textField.tag == 909 {
            if childNames.count > 0 {
                self.navigationController?.isNavigationBarHidden = true
                self.tblChildrens.reloadData()
                self.showChildrenView()
            }
            UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.tag != 333 && textField.tag != 444 && textField.tag != 555 && textField.tag != 666){
            animateViewMoving1(up: true, moveValue: 144)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.tag != 333 && textField.tag != 444 && textField.tag != 555 && textField.tag != 666){
            animateViewMoving1(up: false, moveValue: 144)
        }
    }
    
    func animateViewMoving1 (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
                                          "OrganizationId":currentOrgID,
                                          "PageOffset": 1,
                                          "ResultsPerPage": 5000,
                                          "AscendingOrder":true]
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
                                          "OrganizationId":currentOrgID,
                                          "PageOffset": 1,
                                          "ResultsPerPage": 5000]
            requestAPICall(input: parameter, tag: 3, textField: textField)
        }
    }
    func getSpouseContactList(tag:Int,textField:UITextField){
        if getSpouseContactListModel != nil {
            if(tag == 7){
            if getSpouseContactListModel.valid && getSpouseContactListModel.results.count > 0 {
                if getSpouseContactListModel.valid {
                    self.linkedSpouseArray = []
                    self.linkedExecutorIDArray = []
                    let result:[GetSpouseContactResult] = getSpouseContactListModel.results
                    if(self.linkedSpouseArray.count == 0){
                    for index in 0..<result.count {
                        linkedSpouseArray.append(result[index].fullName!)
                        self.linkedExecutorIDArray.append(result[index].id!)
                    }
                    }
                }
              showExecutorDetails()
                }
            }
           else if(tag == 4){
                if getSpouseContactListModel.valid && getSpouseContactListModel.results.count > 0 {
                    if getSpouseContactListModel.valid {
                         self.linkedSpouseArray = []
                        let result:[GetSpouseContactResult] = getSpouseContactListModel.results
                        if(self.linkedSpouseArray.count == 0){
                        for index in 0..<result.count {
                            linkedSpouseArray.append(result[index].fullName!)
                            self.linkedspouseIDArray.append(result[index].id!)
                        }
                        }
                    }
                    showSpouseDetails()
                }
            }
            else if(tag == 8){
                if getSpouseContactListModel.valid && getSpouseContactListModel.results.count > 0 {
                    if getSpouseContactListModel.valid {
                         self.linkedSpouseArray = []
                        let result:[GetSpouseContactResult] = getSpouseContactListModel.results
                        if(self.linkedSpouseArray.count == 0){
                        for index in 0..<result.count {
                            linkedSpouseArray.append(result[index].fullName!)
                            self.linkedAttronyIDArray.append(result[index].id!)
                        }
                        }
                    }
                    showAttorneyDetails()
                }
            }
            
        }else{
            let parameter:[String:Any] = ["SearchTerm":"",
                                          "ObjectName":"contact",
                                          "PassKey":passKey,
                                          "OrganizationId":currentOrgID,
                                          "PageOffset": 1,
                                          "ResultsPerPage": 5000]
            requestAPICall(input: parameter, tag: tag, textField: textField)
        }
    }
    func getCompanyList(textField:UITextField){
        if getCompanyListModel != nil {
            if getCompanyListModel.valid && getCompanyListModel.results.count > 0 {
                if getCompanyListModel.valid {
                    let result:[GetCompanyListResult] = getCompanyListModel.results
                    if(self.linkedAccountArray.count == 0){
                    for index in 0..<result.count {
                        linkedAccountArray.append(result[index].name!)
                    }
                    }
                }
                showAccountsDetails()
                return
            }
        }else{
            let parameter:[String:Any] = ["SearchTerm":"",
                                          "ObjectName":"company",
                                          "PassKey":passKey,
                                          "OrganizationId":currentOrgID,
                                          "PageOffset": 1,
                                          "ResultsPerPage": 5000]
            requestAPICall(input: parameter, tag: 6, textField: textField)
        }
    }
    func getRecreationContactList(tag:Int,textField:UITextField){
        if getRecreationCategoriesList != nil {
            if getRecreationCategoriesList.valid && getRecreationCategoriesList.results.count > 0 {
                self.showCategoriesPicker()
                //                self.showPicker(pickerTag: tag, textField: textField)
            }
        }else{
            let parameter:[String:Any] = ["SearchTerm":"",
                                          "ObjectName":"recreation",
                                          "PassKey":passKey,
                                          "OrganizationId":currentOrgID,
                                          "PageOffset": 1,
                                          "ResultsPerPage": 5000]
            print(parameter)
            requestAPICall(input: parameter, tag: tag, textField: textField)
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
                    if self.getSpouseContactListModel.valid {
                        self.linkedSpouseArray = []
                        self.linkedspouseIDArray = []
                        let result:[GetSpouseContactResult] = self.getSpouseContactListModel.results
                        if(self.linkedSpouseArray.count == 0){
                        for index in 0..<result.count {
                            self.linkedSpouseArray.append(result[index].fullName!)
                            self.linkedspouseIDArray.append(result[index].id!)
                        }
                        }
                    }
                    self.showSpouseDetails()
                }else if tag == 6 {
                    self.getCompanyListModel = GetCompanyListModel.init(fromDictionary: jsonResponse)
                    if self.getCompanyListModel.valid {
                        self.linkedAccountArray = []
                        self.linkedAccountIDArray = []
                        let result:[GetCompanyListResult] = self.getCompanyListModel.results
                        if(self.linkedAccountArray.count == 0){
                        for index in 0..<result.count {
                            self.linkedAccountArray.append(result[index].name!)
                            self.linkedAccountIDArray.append(result[index].id!)
                        }
                        }
                    }
                    self.showAccountsDetails()
                }else if tag == 7 {
                    self.getSpouseContactListModel = GetSpouseContactModel.init(fromDictionary: jsonResponse)
                    if self.getSpouseContactListModel.valid {
                        self.linkedSpouseArray = []
                        self.linkedExecutorIDArray = []
                        let result:[GetSpouseContactResult] = self.getSpouseContactListModel.results
                        if(self.linkedSpouseArray.count == 0){
                        for index in 0..<result.count {
                            self.linkedSpouseArray.append(result[index].fullName!)
                            self.linkedExecutorIDArray.append(result[index].id!)
                        }
                        }
                    }
                    self.showExecutorDetails()
                }else if tag == 8 {
                    self.getSpouseContactListModel = GetSpouseContactModel.init(fromDictionary: jsonResponse)
                    if self.getSpouseContactListModel.valid {
                        self.linkedSpouseArray = []
                        self.linkedAttronyIDArray = []
                        let result:[GetSpouseContactResult] = self.getSpouseContactListModel.results
                        if(self.linkedSpouseArray.count == 0){
                        for index in 0..<result.count {
                            self.linkedSpouseArray.append(result[index].fullName!)
                            self.linkedAttronyIDArray.append(result[index].id!)
                        }
                        }
                    }
                    self.showAttorneyDetails()
                }else if tag == 144 {
                    self.getRecreationCategoriesList = getRecreationCategories.init(fromDictionary: jsonResponse)
                    //                    self.showPicker(pickerTag: tag, textField: textField)
                    self.showCategoriesPicker()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
}
extension ContactssController {
    func showCustomPicker(textfield:UITextField,title:String){
        textfield.resignFirstResponder()
        
        DPPickerManager.shared.showPicker(title: title, selected: Date(), min: nil, max: nil) { (date, cancel) in
            if !cancel {
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd"
                textfield.text = formatter.string(from: date!)
            }
        }
    }
    func showCustomPickerbirthday(textfield:UITextField,title:String){
        textfield.resignFirstResponder()
        DPPickerManager.shared.showPicker(title: title, selected: Date(), min: nil, max: Date()) { (date, cancel) in
            if !cancel {
                let formatter = DateFormatter()
                formatter.dateFormat = "YYYY-MM-dd"
                textfield.text = formatter.string(from: date!)
            }
        }
    }
    
    func showCustomPickerCategory(textfield:UITextField,title:String){
        textfield.resignFirstResponder()
        let parameter:[String:Any] = ["AscendingOrder":true,
                                      "OrderBy":"Name",
                                      "ObjectName":"recreation",
                                      "PassKey":passKey,
                                      "OrganizationId":currentOrgID,
                                      "PageOffset": 1,
                                      "ResultsPerPage": 5000]
        print(parameter)
        APIManager.sharedInstance.postRequestCall(postURL:"https://beta.paretoacademy.com/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json", parameters: parameter, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                var responseArray : [String] = []
                let response = json["ResponseMessage"]
                if(response == "success"){
                    OperationQueue.main.addOperation {
                        let resultsArray = json["Results"].arrayValue
                        for dic in resultsArray{
                            let value = dic["Name"].string
                            responseArray.append(value!)
                        }
                        self.getRecreationCategoriesList = getRecreationCategories.init(fromDictionary: jsonResponse)
                        self.showPicker(pickerTag: 144, textField: textfield)
                        //                        DPPickerManager.shared.showPicker(title: "Category", selected: "", strings: responseArray) { (value, index, cancel) in
                        //                            if !cancel {
                        //                                self.recreationAdded = true
                        //                                textfield.text = value
                        //                            }
                        //                        }
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    
    func showPicker(pickerTag:Int,textField:UITextField){
        
        textField.resignFirstResponder()
        
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
        }else if pickerTag == 144 {
            pickerTitle = "Categories"
            if getRecreationCategoriesList.valid {
                let result:[getRecreationResult] = getRecreationCategoriesList.results
                for index in 0..<result.count {
                    pickerData.add(result[index].name!)
                }
            }
            self.showCategoriesPicker()
            return
        }else if pickerTag == 244 {
            pickerTitle = "Addtional Addresses"
            let result:[getSearchResultResult] = getAddtionalAddressesModel
            for index in 0..<result.count {
                pickerData.add(result[index].name!)
            }
        }else if pickerTag == 344 {
            pickerTitle = "Linked Accounts"
            let result:[getLinkedResultResult] = getLinkedAccountModel
            for index in 0..<result.count {
                pickerData.add(result[index].name!)
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
            }else if pickerTag == 144 {
                if self.getRecreationCategoriesList.valid {
                    let result:[getRecreationResult] = self.getRecreationCategoriesList.results
                    self.recreationCatID = result[index].id
                }
            }else if pickerTag == 244 {
                let result:[getSearchResultResult] = self.getAddtionalAddressesModel
                self.addtionalAddresssAddID = result[index].id
                self.linkAdditonalAddressToContact(additionalAddressID: result[index].id!,isLinkedContactAddress: true)
            }else if pickerTag == 344 {
                let result:[getLinkedResultResult] = self.getLinkedAccountModel
                self.addtionalAddresssAddID = result[index].id
                self.linkAdditonalAddressToContact(additionalAddressID: result[index].id!,isLinkedContactAddress: false)
            }
        }
    }
    
    func linkAdditonalAddressToContact(additionalAddressID:String,isLinkedContactAddress:Bool) {
        var objectName:String = "linker_contacts_addresses"
        var rightObjectName:String = "address"
        var leftObjectName:String = "contact"
        if !isLinkedContactAddress {
            objectName = "linker_contacts_companies"
            rightObjectName = "company"
            leftObjectName = "contact"
        }
        let json: [String: Any] = ["ObjectName": objectName,
                                   "LeftId": self.contactInfoDetail.id!,
                                   "LeftObjectName": leftObjectName,
                                   "RightId": additionalAddressID,
                                   "RightObjectName": rightObjectName,
                                   "PassKey": passKey,
                                   "OrganizationId": currentOrgID]
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
                self.recreationAdded = false
                self.navigationController?.popViewController(animated: true)
            }
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
}
extension ContactssController:URLSessionDelegate {
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
    func convertStringToCurrency() -> String {
        let double = NumberFormatter().number(from: self)?.doubleValue
        
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        let priceString = currencyFormatter.string(from: double! as NSNumber)!
        print(priceString) // Displays $9,999.99 in the US locale
        
        return priceString
    }
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}
extension String {
    func removeFormatAmount() -> Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.decimalSeparator = ","
        return formatter.number(from: self) as! Double? ?? 0
    }
}
extension ContactssController: CZPickerViewDelegate, CZPickerViewDataSource {
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
    func showLinkedAccounts(){
        
        let picker = CZPickerView(headerTitle: "Linked Accounts", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        var selectedRowsIndex:[Int] = []
        for index in 0..<linkaddressArray.count {
            let joinName = linkaddressArray[index]
            for index1 in 0..<getLinkedAccountsResult.count {
                var pointName:String = getLinkedAccountsResult[index1].name
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
    
    func showAccountsDetails(){
        
        let picker = CZPickerView(headerTitle: "Accounts", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = false
        var selectedRowsIndex:[Int] = []
        for index in 0..<linkedAccountArray.count {
            var pointName:String = linkedAccountArray[index]
            pointName = pointName.trimmingCharacters(in: .whitespaces)
            if pointName == AccountString {
                selectedRowsIndex.append(index)
            }
        }
        picker?.setSelectedRows(selectedRowsIndex)
        picker?.tag = 321
        picker?.show()
    }
    
    func showExecutorDetails(){
        
        let picker = CZPickerView(headerTitle: "Executor", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        picker?.dataSource = self
        picker?.needFooterView = true
        var selectedRowsIndex:[Int] = []
        for index in 0..<linkedSpouseArray.count {
            var pointName:String = linkedSpouseArray[index]
            pointName = pointName.trimmingCharacters(in: .whitespaces)
            if pointName == ExecutorString {
                selectedRowsIndex.append(index)
            }
        }
        picker?.setSelectedRows(selectedRowsIndex)
        picker?.allowMultipleSelection = false
        picker?.tag = 654
        picker?.show()
    }
    
    func showAttorneyDetails(){
        let picker = CZPickerView(headerTitle: "Power of Attorney", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        picker?.dataSource = self
        var selectedRowsIndex:[Int] = []
        for index in 0..<linkedSpouseArray.count {
            var pointName:String = linkedSpouseArray[index]
            pointName = pointName.trimmingCharacters(in: .whitespaces)
            if pointName == powerAttroney {
                selectedRowsIndex.append(index)
            }
        }
        picker?.setSelectedRows(selectedRowsIndex)
        picker?.needFooterView = true
        picker?.allowMultipleSelection = false
        picker?.tag = 098
        picker?.show()
    }
    
    func showSpouseDetails(){
        let picker = CZPickerView(headerTitle: "Spouse", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        picker?.dataSource = self
        picker?.needFooterView = true
        var selectedRowsIndex:[Int] = []
        for index in 0..<linkedSpouseArray.count {
            var pointName:String = linkedSpouseArray[index]
            pointName = pointName.trimmingCharacters(in: .whitespaces)
            if pointName == SpouseString {
                selectedRowsIndex.append(index)
            }
        }
        picker?.setSelectedRows(selectedRowsIndex)
        picker?.allowMultipleSelection = false
        picker?.tag = 987
        picker?.show()
    }
    
    
    func showCategoriesPicker(){
        //        if getRecreationNames.count == 0 {
        //            return
        //        }
        let picker = CZPickerView(headerTitle: "Categories", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker?.delegate = self
        var selectedRowsIndex:[Int] = []
        //        for index in 0..<getLinkedAccountsResult.count {
        //            let contactName:String = getLinkedAccountsResult[index].name
        //            let selectedName:String = linkaddressArray[index]
        //            if selectedName == contactName {
        //                selectedRowsIndex.append(index)
        //            }
        //        }
        //        picker?.setSelectedRows(selectedRowsIndex)
        
        if getRecreationNames.count > 0 {
            let joinedComp = getRecreationNames.components(separatedBy: ",")
            for index in 0..<joinedComp.count {
                var joinName:String = joinedComp[index]
                joinName = joinName.trimmingCharacters(in: .whitespaces)
                
                for index1 in 0..<getRecreationCategoriesList.results.count {
                    var pointName:String = getRecreationCategoriesList.results[index1].name
                    pointName = pointName.trimmingCharacters(in: .whitespaces)
                    if pointName == joinName {
                        selectedRowsIndex.append(index1)
                    }
                }
            }
            picker?.setSelectedRows(selectedRowsIndex)
        }
        picker?.dataSource = self
        picker?.needFooterView = true
        picker?.allowMultipleSelection = true
        picker?.tag = 0
        picker?.show()
    }
    //    for index in 0..<result.count {
    //    pickerData.add(result[index].name!)
    //    }
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 12 {
            return linkaddressArray.count
        }else if pickerView.tag == 13 {
            return linkaddressArray.count
        }
        if pickerView.tag == 321 {
            
            return linkedAccountArray.count
        }
        if pickerView.tag == 654 {
            return linkedSpouseArray.count
        }
        if pickerView.tag == 987 {
            return linkedSpouseArray.count
        }
        if pickerView.tag == 098 {
            return linkedSpouseArray.count
        }
        if getRecreationCategoriesList.valid {
            let result:[getRecreationResult] = getRecreationCategoriesList.results
            return result.count
        }
        return 0
    }
    
    func czpickerView(_ pickerView: CZPickerView!, imageForRow row: Int) -> UIImage! {
        return nil
    }
    
    func numberOfRowsInPickerView(pickerView: CZPickerView!) -> Int {
        if pickerView.tag == 12 || pickerView.tag == 13 {
            return linkaddressArray.count
        }
        if pickerView.tag == 321 {
            return linkedAccountArray.count
        }
        if pickerView.tag == 654 {
            return linkedSpouseArray.count
        }
        if pickerView.tag == 987 {
            return linkedSpouseArray.count
        }
        if pickerView.tag == 098 {
            return linkedSpouseArray.count
        }
        if getRecreationCategoriesList.valid {
            let result:[getRecreationResult] = getRecreationCategoriesList.results
            return result.count
        }
        return 0
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        if pickerView.tag == 12 || pickerView.tag == 13 {
            return linkaddressArray[row]
        }
        if pickerView.tag == 321{
            return linkedAccountArray[row]
        }
        if pickerView.tag == 654 {
            return linkedSpouseArray[row]
        }
        if pickerView.tag == 987 {
            return linkedSpouseArray[row]
        }
        if pickerView.tag == 098 {
            return linkedSpouseArray[row]
        }
        if getRecreationCategoriesList.valid {
            let result:[getRecreationResult] = getRecreationCategoriesList.results
            return result[row].name!
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
            for index in 0..<linkedAccountArray.count {
                arr.add(linkedAccountArray[index])
            }
            
            return arr
        }
        else if pickerView.tag == 654 {
            let arr:NSMutableArray = []
            for index in 0..<linkedSpouseArray.count {
                arr.add(linkedSpouseArray[index])
            }
            return arr
        }
        else if pickerView.tag == 987 {
            let arr:NSMutableArray = []
            for index in 0..<linkedSpouseArray.count {
                arr.add(linkedSpouseArray[index])
            }
            return arr
        }
        else if pickerView.tag == 098 {
            let arr:NSMutableArray = []
            for index in 0..<linkedSpouseArray.count {
                arr.add(linkedSpouseArray[index])
            }
            return arr
        }
        let Arrayname : NSMutableArray = []
        if getRecreationCategoriesList.valid {
            let result:[getRecreationResult] = getRecreationCategoriesList.results
            for i in 0 ..< result.count {
                Arrayname.add(result[i].name!)
            }
            return Arrayname
        }
        return []
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        //        self.selectedContacts = []
        if (pickerView.tag == 321)
        {
            
            let indexPath = IndexPath(row: 0, section: 0)
            let cell:ContactssCell = tableView.cellForRow(at: indexPath) as! ContactssCell
            cell.fieldCompany.text = linkedAccountArray[row]
            if(cell.fieldCompanyName.text == ""){
              cell.fieldCompanyName.text = linkedAccountArray[row]
            }
            companyID = linkedAccountIDArray[row]
        }
        if (pickerView.tag == 654)
        {
            
            let indexPath = IndexPath(row: 0, section: 0)
            let cell:ContactssCell = tableView.cellForRow(at: indexPath) as! ContactssCell
            cell.fieldExecutor.text = linkedSpouseArray[row]
            if(cell.fieldExecutorName.text == ""){
                cell.fieldExecutorName.text = linkedSpouseArray[row]
            }
            executorID = linkedExecutorIDArray[row]
        }
        if (pickerView.tag == 987)
        {
            
            let indexPath = IndexPath(row: 0, section: 0)
            let cell:ContactssCell = tableView.cellForRow(at: indexPath) as! ContactssCell
            cell.fieldSpouse2.text = linkedSpouseArray[row]
            if(cell.fieldSpouse.text == ""){
                cell.fieldSpouse.text = linkedSpouseArray[row]
            }
            spouseID = linkedspouseIDArray[row]
        }
        if (pickerView.tag == 098)
        {
            
            let indexPath = IndexPath(row: 0, section: 0)
            let cell:ContactssCell = tableView.cellForRow(at: indexPath) as! ContactssCell
            cell.fieldPowerAtroney.text = linkedSpouseArray[row]
            if(cell.fieldPowerName.text == ""){
                cell.fieldPowerName.text = linkedSpouseArray[row]
            }
            powerAttroneyID = linkedAttronyIDArray[row]
        }
    }
    
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)        setupBottomView()
    }
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, withoutBool value: Bool) {
        if pickerView.tag == 12 {
            var idsList:[String] = []
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
        }else if pickerView.tag == 13 {
            //linkaddressArray
            //getLinkedAccountsResult
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
        else if pickerView.tag == 321 {
            return
        }
        else if pickerView.tag == 654 {
            return
        }
        else if pickerView.tag == 987 {
            return
        }
        else if pickerView.tag == 098 {
            return
        }
        var idsList:[String] = []
        //selectedRecreationIDList
        var tempRemoveIdLists:[String] = []
        
        var selectedContacts:[String] = []
        for row in rows {
            if let row = row as? Int {
                let getContact = getRecreationCategoriesList.results[row]
                selectedContacts.append(getContact.name!)
                idsList.append(getContact.id!)
            }
        }
        
        if selectedRecreationIDList.count > 0 {
            for index in 0..<selectedRecreationIDList.count {
                if !idsList.contains(selectedRecreationIDList[index]) {
                    tempRemoveIdLists.append(selectedRecreationIDList[index])
                }
            }
        }
        
        
        if selectedContacts.count > 0 {
            let stringRepresentation = selectedContacts.joined(separator: ", ")
            getRecreationNames = stringRepresentation
            self.linkRecreationCategorie(leftid: self.contactInfoDetail.id, rightid: idsList[0], idList: idsList, index: 0, removeList: tempRemoveIdLists)
        }
        
        setCategories = true
        self.tableView.reloadData()
    }
    func refreshLinkedAccounts(){
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ListObjectName": "company",
                                       "ObjectName": "linker_contacts_companies",
                                       "LinkParentId": contactInfoDetail.id!,
                                       "PassKey": passKey,
                                       "OrganizationId": currentOrgID]
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
                        self.cellCalled = false
                        self.tableView.reloadData()
                    }
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
            
        }
        
    }
    func linkLinkedCategorie(leftid:String,rightid:String,idList:[String],index:Int,removeList:[String]){
        let json: [String: Any] = ["ObjectName": "linker_contacts_companies",
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
                                   "LeftId":leftid,
                                   "LeftObjectName":"contact",
                                   "RightId":rightid,
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
        let json: [String: Any] = ["ObjectName": "linker_contacts_addresses",
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID,
                                   "LeftId":leftid,
                                   "LeftObjectName":"contact",
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
    func refreshAdditionalAddress(){
        if contactInfoDetail != nil {
            let json: [String: Any] = ["ListObjectName": "address",
                                       "ObjectName": "linker_contacts_addresses",
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
                        self.cellCalled = false
                        self.tableView.reloadData()
                    }
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            })
            
        }
        
    }
    func removeLinkContactCategorie(leftid:String,rightid:String,idList:[String],index:Int,removeList:[String]){
        let json: [String: Any] = ["ObjectName": "linker_contacts_addresses",
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID,
                                   "LeftId":leftid,
                                   "LeftObjectName":"contact",
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
    
    //    didconfirm
    //    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, with value: Bool, arrayvalue array: NSMutableArray!)
    //    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!, setBool value: Bool, arrayvalue array: NSMutableArray!)
    
    func linkRecreationCategorie(leftid:String,rightid:String,idList:[String],index:Int,removeList:[String]){
        let json: [String: Any] = ["ObjectName": "linker_contacts_recreations",
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID,
                                   "LeftId":leftid,
                                   "LeftObjectName":"contact",
                                   "RightId":rightid,
                                   "RightObjectName":"recreation"]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                let getIndex = index + 1
                
                if getIndex < idList.count {
                    self.linkRecreationCategorie(leftid: leftid, rightid: idList[getIndex], idList: idList, index: getIndex, removeList: removeList)
                }else{
                    if removeList.count > 0 {
                        self.removeLinkRecreationCategorie(leftid: leftid, rightid: removeList[0], idList: idList, index: getIndex, removeList: removeList)
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func removeLinkRecreationCategorie(leftid:String,rightid:String,idList:[String],index:Int,removeList:[String]){
        let json: [String: Any] = ["ObjectName": "linker_contacts_recreations",
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID,
                                   "LeftId":leftid,
                                   "LeftObjectName":"contact",
                                   "RightId":rightid,
                                   "RightObjectName":"recreation"]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: removeLinkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let getIndex = index + 1
                if getIndex <= removeList.count {
                    self.removeLinkRecreationCategorie(leftid: leftid, rightid: removeList[index], idList: idList, index: getIndex, removeList: removeList)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
}
extension UITextField{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let reset = UIBarButtonItem(title: "Done", style: .plain , target: self, action: #selector(self.doneButtonAction))
        reset.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.PSNavigaitonController()], for: .normal)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let items = [flexSpace, reset]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

extension UITextView{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let reset = UIBarButtonItem(title: "Done", style: .plain , target: self, action: #selector(self.doneButtonAction))
        reset.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.PSNavigaitonController()], for: .normal)
        
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        //        done.tintColor = UIColor.red
        
        let items = [flexSpace, reset]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
extension ContactssController:HMPopUpViewDelegate {
    func popUpView(_ view: HMPopUpView!, accepted accept: Bool, inputText text: String!) {
        if accept {
            let indexPath = IndexPath(row: 0, section: 0)
            let cell:ContactssCell = tableView.cellForRow(at: indexPath) as! ContactssCell
            let appendStr = ", \(text ?? "")"
            if cell.fieldChildrenname.text?.count ?? 0 > 0 {
                cell.fieldChildrenname.text = cell.fieldChildrenname.text! + appendStr
            }else{
                cell.fieldChildrenname.text = text //childNames.append(appendStr)
            }
            childNames = cell.fieldChildrenname.text ?? ""
            print("ok button pressed")
        }else{
            print("cancel button pressed")
        }
    }
}

extension ContactssController : TagViewDelegate {
    func didRemoveTag(_ indexPath: IndexPath) {
        print("RemoveIndexPath==\(indexPath)")
    }
    
    func didTaponTag(_ indexPath: IndexPath) {
        print("Tag tapped: \(self.aryTeglist[indexPath.item])")
    }
    
}

extension ContactssController: UIGestureRecognizerDelegate {
    @objc  func handleTap(_ gesture: UITapGestureRecognizer){
        print("tappp")
        isEditable = true
        tableView?.visibleCells.forEach { cell in
            if let cell = cell as? ContactssCell {
                cell.checkIfEditable(value: isEditable)
            }
        }
        actionBtn.removeTarget(nil, action: nil, for: .allEvents)
        actionBtn.setTitle("Save", for: .normal)
        actionBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchDown)
        
        if contactInfoDetail != nil {
            self.title = "Edit Contact"
            self.removeCustomView()
        }
        
    }
}
