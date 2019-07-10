//
//  AllContactsCoontroller.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 17/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class AllContactsCoontroller: UIViewController {
    
    var carsDictionary = [String: [String]]()
    var carSectionTitles = [String]()
    
    var contactList:[ContactListResult] = []
    var accountList:[GetAccountsListResult] = []
    var filteredcontactList:[ContactListResult] = []
    var filteredaccountList:[GetAccountsListResult] = []

    @IBOutlet weak var searchBBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var userOrgID:String = ""
    
    var fromAccounts:Bool = false
    var objectName:String = "contact"
    
    var items: [[DropdownItem]]!
    var showSection: Bool = true
    var selectedRow: Int = 0
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    @IBOutlet weak var btnDropDown: UIBarButtonItem!
    var searchActive:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributes = [
            NSAttributedStringKey.foregroundColor : UIColor.PSNavigaitonController(),
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        
        setNavigationBarItem()
        
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String
        print(appVersion as Any)
        
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 102
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    @IBAction func tappedTab(_ sender: Any) {
        
        if addPreviousControllers.count > 0 {

        }
        
    }
    override func viewWillAppear(_ animated: Bool) {

        var fullWidth = UIScreen.main.bounds.width
        fullWidth = fullWidth / 3 - 10
        
        let btnOneX:CGFloat = 10
        let btnTwoX:CGFloat = btnOneX + 5 + fullWidth
        let btnThirdX:CGFloat = btnTwoX + 5 + fullWidth
        print(btnOneX)
        print(btnTwoX)
        print(btnThirdX)
        
        if fromAccounts {
            self.title = "Accounts"
            objectName = "company"
        }
        
        selectedContactInfo = nil
        
        self.userOrgID = currentOrgID
        self.getContactListAPI(orgID: self.userOrgID)
//        NavigationHelper().setupScreen(vc: self)
        
//        let tabView = NavigationHelper().setupBarSqureImage()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            let setupImage:UIImage = tabView.takeScreenshot()
//            self.btnDropDown.image = setupImage
//        }

    }
    func listByOrganization() {
        
        let json: [String: Any] = ["OrderBy": "Name",
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: listByOrgURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:OrganizationMapping = OrganizationMapping.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    if logModel.organizations.count > 0 {
                        let getOrgID = logModel.organizations[0]
                        print(getOrgID.id)
                        currentOrgID = getOrgID.id
                        self.userOrgID = getOrgID.id
                        self.getContactListAPI(orgID: self.userOrgID)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Invalid session.")
                    NavigationHelper().setRootViewController()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    
    
    
    func getContactListAPI(orgID:String){
        let parameters = [
            "OrderBy": "",
            "ParentId": "",
            "ResultsPerPage": 500,
            "OrganizationId": orgID,
            "PassKey": passKey,
            "ParentObjectName": "",
            "PageOffset": 1,
            "ObjectName": objectName,
            "AscendingOrder":true
            ] as [String : Any]
        print(parameters)
        print(getOrgListURL)
        APIManager.sharedInstance.postRequestCall(postURL: getOrgListURL, parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                
                if self.fromAccounts {
                    let contactModel = GetAccountsListModel.init(fromDictionary: jsonResponse)
                    print(contactModel.responseMessage)
                    if(!contactModel.valid){
                      self.loginUser()
                    }
                    else {
                    self.accountList = contactModel.results
                    self.filteredaccountList = self.accountList
                    let nameList:NSMutableArray = []
                    for index in 0..<contactModel.results.count {
                        let result = contactModel.results[index]
//                        let getUserName:String = result.name!.capitalized
                        let getUserName:String = result.name!
//
                        nameList.add("\(getUserName)!@##@!\(result.id!)")
                    }
                    self.carSectionTitles = []
                    self.carsDictionary = [String: [String]]()
                    
                    for car in nameList {
                        let name:String = car as! String
                        
                        var carKey = String(name.prefix(1))
                        carKey = carKey.uppercased()
                        if var carValues = self.carsDictionary[carKey] {
                            carValues.append(name)
                            self.carsDictionary[carKey] = carValues
                        } else {
                            self.carsDictionary[carKey] = [name]
                        }
                    }
                    self.carSectionTitles = [String](self.carsDictionary.keys)
                    
                    self.carSectionTitles = self.carSectionTitles.sorted(by: { $0 < $1 })
                    }
                }else{
                    let contactModel = ContactListModel.init(fromDictionary: jsonResponse)
                    print(contactModel.responseMessage)
                    if(!contactModel.valid){
                        self.loginUser()
                    }
                    else {
                    self.contactList = contactModel.results
                    
                    self.filteredcontactList = self.contactList

                    let nameList:NSMutableArray = []
                    for index in 0..<contactModel.results.count {
                        let result = contactModel.results[index]
//                        let getUserName:String = result.firstName!.capitalized + " " + result.lastName!.capitalized
                        let getUserName:String = result.firstName! + " " + result.lastName!

//                        ("\(result.name!)!@##@!\(result.id!)")
                        nameList.add("\(getUserName)!@##@!\(result.id!)")

//                        nameList.add("\(result.firstName!) \(result.lastName!)")
                    }
                    self.carSectionTitles = []
                    self.carsDictionary = [String: [String]]()
                    
                    for car in nameList {
                        let name:String = car as! String

                        var carKey = String(name.prefix(1))
                        carKey = carKey.uppercased()
                        if var carValues = self.carsDictionary[carKey] {
                            carValues.append(name)
                            self.carsDictionary[carKey] = carValues
                        } else {
                            self.carsDictionary[carKey] = [name]
                        }
                    }
                    self.carSectionTitles = [String](self.carsDictionary.keys)
                    print(self.carSectionTitles)
                    
                    self.carSectionTitles = self.carSectionTitles.sorted(by: { $0 < $1 })
                }
                }
               
                    self.tableView.reloadData()
                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
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
                    self.getContactListAPI(orgID: self.userOrgID)
                }else{
                    NavigationHelper.showSimpleAlert(message:logModel.responseMessage)
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
    
    @IBAction func tappedAdd(_ sender: Any) {
        if fromAccounts {
            let controller:NewAccountsController = self.storyboard?.instantiateViewController(withIdentifier:"NewAccountsController") as! NewAccountsController
            controller.isEditable = true
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
            let controller:ContactssController = self.storyboard?.instantiateViewController(withIdentifier:"ContactssController") as! ContactssController
            controller.isEditable = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
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
extension AllContactsCoontroller: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return carSectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let carKey = carSectionTitles[section]
        if let carValues = carsDictionary[carKey] {
            return carValues.count
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        let carKey = carSectionTitles[indexPath.section]
        if let carValues = carsDictionary[carKey] {
            let rowTitle:String = carValues[indexPath.row]
            let seperateArr = rowTitle.components(separatedBy: "!@##@!")
            if seperateArr.count > 0 {
                if seperateArr.count == 2 {
                    cell.textLabel?.text = seperateArr[0]
                }
            }
        }
        cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return carSectionTitles[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 40))
        headerView.backgroundColor = UIColor.init(red: 143.0/255.0, green: 143.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        
        let label = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: tableView.bounds.size.width - 20, height: 30.0))
        label.text = carSectionTitles[section]
        headerView.addSubview(label)
        
        return headerView
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return carSectionTitles
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if fromAccounts {
            //accountList
            let carKey = carSectionTitles[indexPath.section]
            if let carValues = carsDictionary[carKey] {
                var carTitle:String = carValues[indexPath.row]
                
                let seperateArr = carTitle.components(separatedBy: "!@##@!")
                if seperateArr.count > 0 {
                    if seperateArr.count == 2 {
                        carTitle = seperateArr[1]
                    }else{
                        return
                    }
                }else{
                    return
                }
                
                for index in 0..<accountList.count {
                    let result = accountList[index]
                    let contactName:String = "\(result.id!)"
                    
                    if contactName == carTitle {
                        let controller:NewAccountsController = self.storyboard?.instantiateViewController(withIdentifier:"NewAccountsController") as! NewAccountsController
                        controller.contactInfoDetail = accountList[index]
                        self.navigationController?.pushViewController(controller, animated: true)
                        return
                    }
                }
            }
        }else{
                //accountList
                let carKey = carSectionTitles[indexPath.section]
                if let carValues = carsDictionary[carKey] {
                    var carTitle:String = carValues[indexPath.row]
                    
                    let seperateArr = carTitle.components(separatedBy: "!@##@!")
                    if seperateArr.count > 0 {
                        if seperateArr.count == 2 {
                            carTitle = seperateArr[1]
                        }else{
                            return
                        }
                    }else{
                        return
                    }
                    
                    
                    for index in 0..<contactList.count {
                        let result = contactList[index]
                        let contactName:String = "\(result.id!)"

                        if contactName == carTitle {
                            let controller:ContactssController = self.storyboard?.instantiateViewController(withIdentifier:"ContactssController") as! ContactssController
                            controller.contactInfoDetail = contactList[index]
                            print(contactList)
                            self.navigationController?.pushViewController(controller, animated: true)
                            return
                        }
                    }
                }
            }
      
    }
    
   
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        // 1
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete" , handler: { (action:UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            if self.fromAccounts {
                let carKey = self.carSectionTitles[indexPath.section]
                if let carValues = self.carsDictionary[carKey] {
                    var carTitle:String = carValues[indexPath.row]
                    
                    let seperateArr = carTitle.components(separatedBy: "!@##@!")
                    if seperateArr.count > 0 {
                        if seperateArr.count == 2 {
                            carTitle = seperateArr[1]
                        }else{
                            return
                        }
                    }else{
                        return
                    }
                    for index in 0..<self.accountList.count {
                        let result = self.accountList[index]
                        let contactName:String = "\(result.id!)"
                        
                        if contactName == carTitle {
                            DispatchQueue.main.async(execute: {
                                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                                    print(index,title)
                                    if title == "Yes" {
                                        self.deleteInviteUser(contactID: result.id!)
                                    }
                                })
                            })
                            return
                        }
                    }
                }
            }else{
                let carKey = self.carSectionTitles[indexPath.section]
                if let carValues = self.carsDictionary[carKey] {
                    var carTitle:String = carValues[indexPath.row]
                    
                    let seperateArr = carTitle.components(separatedBy: "!@##@!")
                    if seperateArr.count > 0 {
                        if seperateArr.count == 2 {
                            carTitle = seperateArr[1]
                        }else{
                            return
                        }
                    }else{
                        return
                    }
                    for index in 0..<self.contactList.count {
                        let result = self.contactList[index]
//                        let contactName:String = "\(result.fullName!)"
                        let contactID:String = "\(result.id!)"

                        if contactID == carTitle {
                            DispatchQueue.main.async(execute: {
                                AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                                    print(index,title)
                                    if title == "Yes" {
                                        self.deleteInviteUser(contactID: contactID)
                                    }
                                })
                            })
                            return
                        }
                    }
                }
            }
            
            
        })
        // 5
        return [shareAction]
    }
    func deleteInviteUser(contactID:String){
        
        let headers = [
            "Content-Type": "application/json"
        ]
        let parameters = [
            "ObjectName": objectName,
            "OrganizationId": userOrgID,
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
//                            self.listByOrganization()
                            self.getContactListAPI(orgID: self.userOrgID)

                        }
                    }
                })
            }
        })
        
        dataTask.resume()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension AllContactsCoontroller: DropdownMenuDelegate {
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
extension AllContactsCoontroller:URLSessionDelegate {
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
extension AllContactsCoontroller: UISearchBarDelegate {
    //MARK: - Search Bar Delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        if self.fromAccounts {
            accountList = filteredaccountList
        }else{
            contactList = filteredcontactList
        }

        searchActive = false;
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        var filteredcontactList:[ContactListResult] = []
//        var filteredaccountList:[GetAccountsListResult] = []
        
        
        if self.fromAccounts {
            accountList = filteredaccountList.filter {
                $0.name?.range(of: searchText, options: .caseInsensitive) != nil
            }
            if(accountList.count == 0){
                accountList = filteredaccountList
                searchActive = false;
            } else {
                searchActive = true;
            }
            let nameList:NSMutableArray = []
            for index in 0..<accountList.count {
                let result = accountList[index]
//                let getUserName:String = result.name!.capitalized
                let getUserName:String = result.name!

                nameList.add("\(getUserName)!@##@!\(result.id!)")
            }
            self.carSectionTitles = []
            self.carsDictionary = [String: [String]]()
            
            for car in nameList {
                let name:String = car as! String
                
                let carKey = String(name.prefix(1))
                if var carValues = self.carsDictionary[carKey] {
                    carValues.append(name)
                    self.carsDictionary[carKey] = carValues
                } else {
                    self.carsDictionary[carKey] = [name]
                }
            }
            self.carSectionTitles = [String](self.carsDictionary.keys)
            
            self.carSectionTitles = self.carSectionTitles.sorted(by: { $0 < $1 })    }
        else{
            contactList = filteredcontactList.filter {
                $0.firstName?.range(of: searchText, options: .caseInsensitive) != nil || $0.lastName?.range(of: searchText, options: .caseInsensitive) != nil
            }
            if(contactList.count == 0){
                contactList = filteredcontactList
                searchActive = false;
            } else {
                searchActive = true;
            }
            let nameList:NSMutableArray = []
            for index in 0..<contactList.count {
                let result = contactList[index]
//                let getUserName:String = result.firstName!.capitalized + " " + result.lastName!.capitalized
                let getUserName:String = result.firstName! + " " + result.lastName!

                nameList.add("\(getUserName)!@##@!\(result.id!)")
            }
            self.carSectionTitles = []
            self.carsDictionary = [String: [String]]()
            
            for car in nameList {
                let name:String = car as! String
                
                let carKey = String(name.prefix(1))
                if var carValues = self.carsDictionary[carKey] {
                    carValues.append(name)
                    self.carsDictionary[carKey] = carValues
                } else {
                    self.carsDictionary[carKey] = [name]
                }
            }
            self.carSectionTitles = [String](self.carsDictionary.keys)
            self.carSectionTitles = self.carSectionTitles.sorted(by: { $0 < $1 })
        }
        
      
        
//        filtered = titleList.filter({ (text) -> Bool in
//            let tmp: NSString = text as! NSString
//            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
//            return range.location != NSNotFound
//        }) as! [String]
//        if(filtered.count == 0){
//            searchActive = false;
//        } else {
//            searchActive = true;
//        }
        self.tableView.reloadData()
    }
}
