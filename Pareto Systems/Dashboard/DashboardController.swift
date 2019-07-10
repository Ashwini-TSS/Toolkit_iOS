//
//  DashboardController.swift
//  Pareto Systems
//
//  Created by Thabresh on 24/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit


class DashboardController: UIViewController {
    
    var items: [[DropdownItem]]!
    var showSection: Bool = true
    var selectedRow: Int = 0
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    var originalPosition: CGRect = .zero

    @IBOutlet weak var learnmoreBG: UIView!
    @IBOutlet weak var learnMoreText: UITextView!
    @IBOutlet weak var btnDropDown: UIBarButtonItem!
    @IBOutlet weak var tblItems: UITableView!
    var isRecentShow:Bool = false
    var purchaseLists:PurchaseListModel!
    var priceIDList:NSMutableArray = []
    var pricesList:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        tblItems.tableFooterView = UIView()
        tblItems.estimatedRowHeight = 310
        tblItems.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedClose(_ sender: Any) {
        learnmoreBG.isHidden = true
        tblItems.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        learnmoreBG.isHidden = true
        let tabView = NavigationHelper().setupBarSqureImage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let setupImage:UIImage = tabView.takeScreenshot()
            self.btnDropDown.image = setupImage
        }
        
        if let data = UserDefaults.standard.object(forKey: "userOrganizationID") {
            currentOrgID = data as! String
            if let name = UserDefaults.standard.object(forKey: "loggedUserName") {
                currentUserName = name as! String
                self.title = currentUserName
            }
            if let data = UserDefaults.standard.object(forKey: "masterUserID") {
                currentMasterID = data as! String
            }
            self.getOrganizationStatus()
            return
        }
        listByOrganization()
    }
    
    func listByOrganization() {
        
        let json: [String: Any] = ["PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: listByOrgURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:OrganizationMapping = OrganizationMapping.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    if logModel.organizations.count > 0 {
                        let getOrgID = logModel.organizations[0]
                        print(getOrgID.id)
                        print(getOrgID.masterUserId)
                        if let data:String = UserDefaults.standard.object(forKey: "userOrganizationID") as? String {
                            print(data)
                        }
                        else{
                      //  UserDefaults.standard.set(getOrgID.masterUserId!, forKey: "masterUserID")

                        UserDefaults.standard.set(getOrgID.id!, forKey: "userOrganizationID")
                        UserDefaults.standard.set(getOrgID.name!, forKey: "loggedUserName")
                        currentMasterID = getOrgID.masterUserId!
                        currentOrgID = getOrgID.id
                        currentUserName = getOrgID.name
                        self.title = currentUserName
                        }
                        self.getOrganizationStatus()
                    }
                }else{
                    if logModel.responseMessage == "User is disabled." {
                        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                        UserDefaults.standard.synchronize()
                        
                        NavigationHelper().setRootViewController()
                        return
                    }
                    NavigationHelper.showSimpleAlert(message:"Invalid session.")
                    NavigationHelper().setRootViewController()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            //            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }

    func getOrganizationStatus(){
        let json: [String: Any] = ["OrganizationId": currentOrgID,
                                   "PassKey": passKey]
        print(json)
        OperationQueue.main.addOperation {
           // SVProgressHUD.show()
//            MBProgressHUD.showAdded(to: self.view, animated: true)

        }
        APIManager.sharedInstance.postRequestCall(postURL: organizationStatusURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            OperationQueue.main.addOperation {
              //  SVProgressHUD.dismiss()
            }
            DispatchQueue.main.async {
                print(json)
                let logModel:OrgStatusModel = OrgStatusModel.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    if !logModel.status.toolKitEnabled {
                        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"ic_setting"), style: .plain, target: self, action: #selector(self.menuButtonTapped))
                        self.getDefaultTrialPeriods()
                    }else{
                        NavigationHelper().setupCalanderMenuView()
                    }
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            OperationQueue.main.addOperation {
              //  SVProgressHUD.dismiss()
//                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
    }
    func getDefaultTrialPeriods(){
        let json: [String: Any] = ["TypeFilter": "Toolkit",
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: listDefaultTrialPeriods, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
         
            DispatchQueue.main.async {
                print(json)
                OperationQueue.main.addOperation {
                    //SVProgressHUD.dismiss()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            OperationQueue.main.addOperation {
              //  SVProgressHUD.dismiss()
            }
        })
    }
    func setupCalendarView(){
//        NotificationCenter.default.removeObserver(self)
        let subview = UIView()
        subview.frame = self.view.frame
        let controller:CalendarController = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
        subview.addSubview(controller.view)
        self.view.addSubview(subview)
    }

    func getListOfPackages(){
        let json: [String: Any] = ["PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: packagesURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            self.priceIDList = []
            self.pricesList = []
            
            DispatchQueue.main.async {
                print(json)
                self.purchaseLists = PurchaseListModel.init(fromDictionary: jsonResponse)
                if self.purchaseLists.valid {
                    for index in 0..<self.purchaseLists.pricingSchemeTiers.count {
                        self.priceIDList.add(self.purchaseLists.pricingSchemeTiers[index].pricingSchemeId)
                        self.pricesList.add("\(self.purchaseLists.pricingSchemeTiers[index].pricePerUser!)")
                    }
                }
                self.tblItems.reloadData()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            
        })
    }
    @objc func menuButtonTapped(sender: UIBarButtonItem) {
        let controller:SettingsContoller = self.storyboard?.instantiateViewController(withIdentifier: "SettingsContoller") as! SettingsContoller
        controller.isFromDashboard = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func tappedDropDown(_ sender: Any) {
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
    
    func setupRightBarDropDown() {
        
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
extension DashboardController: DropdownMenuDelegate {
    func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        if indexPath.row != items.count - 1 {
            self.selectedRow = indexPath.row
        }
        
        let indexTitle:String = "\(items[indexPath.section][indexPath.row].title)"
        print(indexTitle)
        NavigationHelper().setupRootViewController(senderVC: self, title: indexTitle)
    }
}
extension DashboardController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if purchaseLists == nil {
            return 0
        }
        return purchaseLists.verticalPackages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell

        
        cell.lblTitle.text = self.purchaseLists.verticalPackages[indexPath.row].name
        cell.lblDescription.setHtmlText(self.purchaseLists.verticalPackages[indexPath.row].descriptionField)

        let url = URL(string: imageLoadURL + self.purchaseLists.verticalPackages[indexPath.row].largeImageUri)
        cell.productImage.kf.setImage(with: url)
        
        cell.lblPlan.text = self.purchaseLists.verticalPackages[indexPath.row].tagLine

        if self.purchaseLists.verticalPackages[indexPath.row].free {
            cell.lblPrice.text = "FREE"
            cell.btnBuy.setTitle("SUBSCRIBE", for: .normal)
        }else{
            cell.btnBuy.setTitle("BUY", for: .normal)
            if priceIDList.contains(self.purchaseLists.verticalPackages[indexPath.row].pricingSchemeId) {
                let getIndex = priceIDList.index(of: self.purchaseLists.verticalPackages[indexPath.row].pricingSchemeId)
                let priceStr:String = pricesList[getIndex] as! String
                cell.lblPrice.text = "$ \(priceStr) USD/MO Per User"
            }
        }
        cell.btnLearnMore.tag = indexPath.row
        cell.btnLearnMore.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        if self.purchaseLists.pricingSchemeTiers.contains(self.pr)
        
//        cell.itemImg.image = UIImage.init(named: recentTabImages[indexPath.row] as! String)
//        cell.itemTitle.text = (recentItmeTabs[indexPath.row] as! String)
        return cell
    }
    @objc func buttonAction(sender: UIButton!) {
        learnMoreText.setContentOffset(.zero, animated: false)
        let btnsendtag: UIButton = sender
        learnMoreText.setHtmlTextView(self.purchaseLists.verticalPackages[btnsendtag.tag].outline)
        learnmoreBG.isHidden = false
        tblItems.isHidden = true
        //self.purchaseLists.verticalPackages[indexPath.row].tagLine
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension DashboardController:URLSessionDelegate {
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
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
extension String {
    
    var utfData: Data? {
        return self.data(using: .utf8)
    }
    
    var attributedHtmlString: NSAttributedString? {
        guard let data = self.utfData else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,
                                          options: [
                                            .documentType: NSAttributedString.DocumentType.html,
                                            .characterEncoding: String.Encoding.utf8.rawValue
                ], documentAttributes: nil)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension UILabel {
    func setHtmlText(_ html: String) {
        if let attributedText = html.attributedHtmlString {
            self.attributedText = attributedText
        }
    }
}
extension UITextView {
    func setHtmlTextView(_ html: String) {
        if let attributedText = html.attributedHtmlString {
            self.attributedText = attributedText
        }
    }
}
