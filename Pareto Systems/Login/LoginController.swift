
//
//  LoginController.swift
//  Pareto Systems
//
//  Created by Thabresh on 24/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import CoreData
import iOSDropDown
class LoginController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var twofactorheightconstraint: NSLayoutConstraint!
    @IBOutlet weak var factorauthCodeBtn: ACFloatingTextfield!
    @IBOutlet weak var countryimage: UIImageView!
    @IBOutlet weak var countrydropdown: DropDown!
    @IBOutlet weak var listTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var passwordField: ACFloatingTextfield!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var countryimg: UIImageView!

    var pppasskey : String = ""
    var isAlreadyLogin : Bool = false
    var isFromDirectLogin:Bool = false
    var whiteBG = UIView()
    var organizationIndex : Int!
    var whoUser:whoamiUser!
    var First : String!
    var organizationList:[Organization] = []
    var ArrayOrganisationID : [String] = []
    var ArrayOrganisationName : [String] = []
    var savedEmailArray : [String]  = []
    var changeTextEmailArray : [String] = []
    var globalFlag : String = "us"
    var globalTwoFARequired : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
       organizationIndex = 0
        First = "no"
        self.emailField.delegate = self
        self.emailField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        self.listTableView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureView(tapgesture:)))
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = false
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        countrydropdown.optionArray = ["us","canada"]
        countrydropdown.optionImageArray = ["us","canada"]
        countrydropdown.optionIds = [1,2]
        

        countrydropdown.didSelect{(selectedText , index ,id) in
            print(selectedText)
            print(index)
            print(id)
            if(selectedText == "us")
            {
//                self.emailField.text = "ios-review"
//                self.passwordField.text = "ios-review"
                self.globalFlag = "us"
                self.emailField.text = ""
                self.passwordField.text = ""
                self.countryimg.image = UIImage(named: "us")
                UserDefaults.standard.set("https://toolkit.bluesquareapps.com", forKey: "logg")
                globalURL  = UserDefaults.standard.string(forKey: "logg")
                UserDefaults.standard.setValue("us", forKey: "flagg")
                self.changeAllURL()
            }else
            {
//                self.emailField.text = "sathish@tecnovaters.com"
//                self.passwordField.text = "tecnovators"
                self.globalFlag = "canada"
                self.emailField.text = ""
                self.passwordField.text = ""
                self.countryimg.image = UIImage(named: "canada")
                UserDefaults.standard.set("https://toolkit.bluesquareapps.ca", forKey: "logg")
                globalURL  = UserDefaults.standard.string(forKey: "logg")
                UserDefaults.standard.setValue("canada", forKey: "flagg")
                self.changeAllURL()
            }
        }
     guard let flgs = UserDefaults.standard.string(forKey: "flagg") else
        {
            self.countryimg.image = UIImage(named: "us")
             UserDefaults.standard.set("https://toolkit.bluesquareapps.com", forKey: "logg")
             globalURL  = UserDefaults.standard.string(forKey: "logg")
             globalFlag = "us"
             self.changeAllURL()
            let status = UserDefaults.standard.bool(forKey: "coredatastatus")
            if(status)
            {
                self.retriveRecordsFromCoreData(selectflag: self.globalFlag)
            }
            return
        }
        if(flgs == "us")
        {
            countryimg.image = UIImage(named: "us")
            self.globalFlag = "us"
            countrydropdown.selectedIndex = 0
            UserDefaults.standard.set("https://toolkit.bluesquareapps.com", forKey: "logg")
            globalURL  = UserDefaults.standard.string(forKey: "logg")
            globalFlag = "us"
            self.changeAllURL()

        }else
        {
            countryimg.image = UIImage(named: "canada")
            self.globalFlag = "canada"
            countrydropdown.selectedIndex = 1
            UserDefaults.standard.set("https://toolkit.bluesquareapps.ca", forKey: "logg")
            globalURL  = UserDefaults.standard.string(forKey: "logg")
            globalFlag = "canada"
            self.changeAllURL()
        }
        let status = UserDefaults.standard.bool(forKey: "coredatastatus")
        if(status)
        {
            self.retriveRecordsFromCoreData(selectflag: self.globalFlag)
        }

    }
    func changeAllURL()
    {
        endpintURL = globalURL + "/endpoints/ajax/"
       
       //let imageLoadURL:String = "https://toolkit.bluesquareapps.com"
        imageLoadURL = globalURL

        dataEndPointURL = "com.platform.vc.endpoints.data.VCDataEndpoint/"

        orgEndPointURL = "com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/"

        calenderEndPointURL = "com.platform.vc.endpoints.calendar.VCCalendarEndpoint/"

        syncEndPointURL = "com.platform.vc.endpoints.sync.VCSyncEndpoint/"

        APIBaseURL = endpintURL + dataEndPointURL

        orgBaseURL = endpintURL + orgEndPointURL

        calenderBaseURL = endpintURL + calenderEndPointURL

        syncBaseURL = endpintURL + syncEndPointURL
         loginURL = APIBaseURL + "login.json"
        
         getHistoryURL = syncBaseURL + "getHistory.json"


         signupURL = APIBaseURL + "signup.json"

         forgotURL = APIBaseURL + "forgotPassword.json"

         listByOrgURL = APIBaseURL + "listUserOrganizations.json"

         organizationStatusURL = orgBaseURL + "organizationStatus.json"

         listDefaultTrialPeriods = APIBaseURL + "listDefaultTrialPeriods.json"

         packagesURL = APIBaseURL + "listSaleableVerticalPackages.json"

         userListByOrgURL = APIBaseURL + "listUsersInOrganization.json"

         paymentListURL = APIBaseURL + "listPaymentCards.json"

         inviteUserURL = APIBaseURL + "createEmailInvite.json"

         deleteEmailInviteURL = APIBaseURL + "deleteEmailInvite.json"

         listEmailInviteURL = APIBaseURL + "listEmailInvites.json"

         createPaymentURL = APIBaseURL + "createPaymentCard.json"

         changePasswordURL = APIBaseURL + "setPassword.json"

         getDefaultPaymentCardURL = APIBaseURL + "getDefaultPaymentCard.json"

         deletePaymentCardURL = APIBaseURL + "deletePaymentCard.json"

         setDefaultCardURL = APIBaseURL + "setDefaultPaymentCard.json"

         getUserURL = APIBaseURL + "whoAmI.json"

         modifyUserURL = APIBaseURL + "modifyUser.json"

         getUserMetaURL = APIBaseURL + "getUserMeta.json"

         getContactListURL = APIBaseURL + "list.json"

         getOrgListURL = orgBaseURL + "list.json"

         deleteContactListURL = orgBaseURL + "delete.json"

         createContact = orgBaseURL + "create.json"

         searchURL = orgBaseURL + "search.json"

         linkedURL = orgBaseURL + "listLinked.json"

         linkURL = orgBaseURL + "link.json"

         removeLinkURL = orgBaseURL + "removeLink.json"

         ListNotes = orgBaseURL + "listNotes.json"

         modifyURL = orgBaseURL + "modify.json"

         getIncompleteActivitiesURL = calenderBaseURL + "getIncompleteActivities.json"

         orgListURL = orgBaseURL + "list.json"

         getURL = orgBaseURL + "get.json"

         getActivities = calenderBaseURL + "getActivities.json"

         getOrganizationStatusInfo = APIBaseURL + "getOrganizationStatus.json"

         purchasePackageURL = APIBaseURL + "linkVerticalPackageToOrganization.json"
    }
    func checkCountry()
    {
        guard let flgs = UserDefaults.standard.string(forKey: "flagg") else
        {
            self.countryimg.image = UIImage(named: "us")
             UserDefaults.standard.set("https://toolkit.bluesquareapps.com", forKey: "logg")
             globalURL  = UserDefaults.standard.string(forKey: "logg")
             globalFlag = "us"
             self.changeAllURL()
            return
        }
        if(flgs == "us")
        {
            self.countryimg.image = UIImage(named: "us")
             UserDefaults.standard.set("https://toolkit.bluesquareapps.com", forKey: "logg")
             globalURL  = UserDefaults.standard.string(forKey: "logg")
             globalFlag = "us"
             self.changeAllURL()
        }
        else{
            self.countryimg.image = UIImage(named: "canada")
             UserDefaults.standard.set("https://toolkit.bluesquareapps.ca", forKey: "logg")
             globalURL  = UserDefaults.standard.string(forKey: "logg")
             globalFlag = "canada"
             self.changeAllURL()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.twofactorheightconstraint.constant = 0
        self.factorauthCodeBtn.isHidden = true
        let logout = UserDefaults.standard.value(forKey: "Logout") as? Bool
        if(logout == nil || !logout!){
            if let data = UserDefaults.standard.object(forKey: "userEmail") as? String{
                if let data1 = UserDefaults.standard.object(forKey: "userPassword") as? String{
                    if data.count == 0 && data1.count == 0 {
                        return
                    }
                    isFromDirectLogin = true
                    whiteBG.frame = self.view.frame
                    whiteBG.backgroundColor = UIColor.white
                    self.view.addSubview(whiteBG)
                    DispatchQueue.main.async {
                        let passky = self.retriveemailpasskeyFromCoreData(email: data)
                        self.isAlreadyLogin = true
                        self.loginUser(userEmail: data , userPassword:data1, twoFactorCode: "", passkey: passky)
                    }
                }
            }
            else{
                self.checkCountry()
            }
        }
        else
        {
            self.checkCountry()
        }
    }
    
    //do this for all four directions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Tap gesture method
    @objc func tapGestureView(tapgesture : UITapGestureRecognizer)
    {
        self.listTableView.isHidden = true
    }
    //MARK: - Textfield delegate methods
    @objc func textFieldDidChange(textField: UITextField) {
        self.changeTextEmailArray.removeAll()
        if((textField.text?.count)! > 0){
            for (_,username) in self.savedEmailArray.enumerated()
            {
                if(textField.text?.lowercased() == username.prefix((textField.text?.count)!).lowercased())
                {
                    changeTextEmailArray.append(username)
                }
            }
            self.listTableViewHeightConstraint.constant = CGFloat(44 * self.changeTextEmailArray.count)
            self.listTableView.isHidden = false
            self.listTableView.reloadData()
        }
        else
        {
            self.listTableView.isHidden = true
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.retriveRecordsFromCoreData(selectflag: self.globalFlag)
        if(textField == self.emailField)
        {
            if(savedEmailArray.count > 0)
            {
                self.listTableView.isHidden = false
                self.listTableView.delegate = self
                self.listTableView.dataSource = self
                self.listTableView.layer.masksToBounds = false
                self.listTableView.layer.borderColor = UIColor.lightGray.cgColor
                self.listTableView.layer.borderWidth = 1.0
                self.listTableViewHeightConstraint.constant = CGFloat(44 * self.changeTextEmailArray.count)
                self.listTableView.reloadData()
            }
        }
        return true
    }
    @IBAction func dropDownAction(_ sender: UIButton) {
        self.countrydropdown.showList()
    }
    
    @IBAction func tappedSignIn(_ sender: Any) {
        if(emailField.text != "" && passwordField.text != ""){
            if(!self.globalTwoFARequired)
            {
                if let data = UserDefaults.standard.object(forKey: "userEmail") as? String{
                    First = "yesss"
                    let dataaa = emailField.text
                    if(data == dataaa){
                    }
                    else{
                        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                        UserDefaults.standard.synchronize()
                    }
                }
                UserDefaults.standard.set("filterss", forKey: "FilterTask")
                UserDefaults.standard.set([], forKey: "UserFilter")
                isFromDirectLogin = false
                    self.isAlreadyLogin = false
                    loginUser(userEmail: emailField.text!, userPassword: passwordField.text!, twoFactorCode: self.factorauthCodeBtn.text!, passkey: "")
            }
            else if(factorauthCodeBtn.text != "")
            {
                
            if let data = UserDefaults.standard.object(forKey: "userEmail") as? String{
                First = "yesss"
                let dataaa = emailField.text
                if(data == dataaa){
                }
                else{
                    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
                    UserDefaults.standard.synchronize()
                }
            }
            UserDefaults.standard.set("filterss", forKey: "FilterTask")
            UserDefaults.standard.set([], forKey: "UserFilter")
            isFromDirectLogin = false
                self.isAlreadyLogin = false
                loginUser(userEmail: emailField.text!, userPassword: passwordField.text!, twoFactorCode: self.factorauthCodeBtn.text!, passkey: "")
            }
            else{
                NavigationHelper.showSimpleAlert(message: "Please enter Two Factor Auth Code")
            }

        }
        else{
            NavigationHelper.showSimpleAlert(message: "Please enter your email and password")
        }
    }
    
    @IBAction func tapForgetPassword(_ sender: UIButton) {
        let alert = UIAlertController(title: "Forget Password", message: " ", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if textField?.text?.count == 0 {
                NavigationHelper.showSimpleAlert(message: "Please enter a valid email")
            }else{
                self.forgotPasswordAPI(userName: (textField?.text)!)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func validate() -> Bool {
        if (emailField.text?.isEmpty)! || (passwordField.text?.isEmpty)! {
            NavigationHelper.showSimpleAlert(message: "Enter email and password")
            return false
        }
        return true
    }
    func toStoreValuesCoreData(email : String, password: String, storepasskey : String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let managedobj = appDelegate.persistentContainer.viewContext
        if(self.First == "yesss")
        {
            let fetchreq = NSFetchRequest<NSFetchRequestResult>(entityName: "MailAccounts")
            fetchreq.predicate = NSPredicate(format: "(email=%@)AND(password=%@)", email,password)
            do{
                let result = try managedobj.fetch(fetchreq)
                if(result.count == 0)
                {
                    let userEntity = NSEntityDescription.entity(forEntityName: "MailAccounts", in: managedobj)
                    let user = NSManagedObject(entity: userEntity!, insertInto: managedobj)
                    user.setValue(email, forKey: "email")
                    user.setValue(password, forKey: "password")
                    user.setValue(self.globalFlag, forKey: "flag")
                    user.setValue(storepasskey, forKey: "passkey")

                    do
                    {
                        try managedobj.save()
                    }catch let error as NSError{
                        print(error.localizedDescription)
                    }
                }
            } catch{
                print("Error cordata")
            }
        }
        else{
            let userEntity = NSEntityDescription.entity(forEntityName: "MailAccounts", in: managedobj)
            let user = NSManagedObject(entity: userEntity!, insertInto: managedobj)
            user.setValue(email, forKey: "email")
            user.setValue(password, forKey: "password")
            user.setValue(self.globalFlag, forKey: "flag")
            user.setValue(storepasskey, forKey: "passkey")
            do
            {
                try managedobj.save()
            }catch let error as NSError{
                print(error.localizedDescription)
            }}
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.listTableView) ?? false {
            
            // Don't let selections of auto-complete entries fire the
            // gesture recognizer
            return false
        }
        
        return true
    }
    
    func retriveRecordsFromCoreData(selectflag : String)
    {
        self.savedEmailArray.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let managedobj = appDelegate.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MailAccounts")
        fetchrequest.predicate = NSPredicate(format: "flag=%@", selectflag)
        do{
            let result = try managedobj.fetch(fetchrequest)
            for data in (result as? [NSManagedObject])!
            {
                print(data.value(forKey: "email") as! String)
               let emailval = data.value(forKey: "email") as? String
                if(emailval != "" && emailval != nil){
                    self.savedEmailArray.append(data.value(forKey: "email") as! String)}
            }
            self.changeTextEmailArray = self.savedEmailArray
        }catch{
            print("Error while fetching data")
        }
    }
    func retriveemailpasskeyFromCoreData(email : String) -> String
    {
        var passkey : String = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return ""
        }
        let managedobj = appDelegate.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MailAccounts")
        fetchrequest.returnsObjectsAsFaults = false
        fetchrequest.predicate = NSPredicate(format: "email=%@", email)
        do{
            let result = try managedobj.fetch(fetchrequest)
            let data = result.last as? NSManagedObject
            passkey = (data?.value(forKey: "passkey") as? String)!
            return passkey
        }
        catch{
            print("Error while fetching data")
        }
        return passkey
    }
    func retriveSelectedRecordsFromCoreData(email : String) -> String
    {
        var password : String = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return ""
        }
        let managedobj = appDelegate.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MailAccounts")
        fetchrequest.predicate = NSPredicate(format: "email=%@", email)
        do{
            let result = try managedobj.fetch(fetchrequest)
            let data = result[0] as? NSManagedObject
            password = (data?.value(forKey: "password") as? String)!
            return password
        }
        catch{
            print("Error while fetching data")
        }
        return password
    }
    
    func loginUser(userEmail:String,userPassword:String, twoFactorCode : String, passkey : String){
        var json: [String: Any] = [:]
        if(globalTwoFARequired)
        {
            json = ["UserName": userEmail,
                                       "Password": userPassword,
                                       "TwoFACode" : twoFactorCode]
        }
        else if(self.isAlreadyLogin)
        {
            json = ["PassKey" : passkey]
        }
        else
        {
            json = ["UserName": userEmail,
                                       "Password": userPassword]
        }
        
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: loginURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(jsonResponse)
                print(json)
                let logModel:LoginModel = LoginModel.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    UserDefaults.standard.set(true, forKey: "coredatastatus")
                    passKey = logModel.passKey
                    
                    self.toStoreValuesCoreData(email: self.emailField.text!, password: self.passwordField.text!, storepasskey: logModel.passKey)
                    
                    self.globalTwoFARequired = logModel.TwoFARequired
                    if(self.globalTwoFARequired && !self.isAlreadyLogin)
                    {
                        self.factorauthCodeBtn.isHidden = false
                        self.twofactorheightconstraint.constant = 30
                        return
                    }
                    if UserDefaults.standard.object(forKey: "userEmail") != nil{
                        if UserDefaults.standard.object(forKey: "userPassword") != nil{
                            isFromLogin = true
                            NavigationHelper().createMenuView()
                        }else{
                            isFromLogin = true
                            self.listByOrganization()
                        }
                    }else{
                        isFromLogin = true
                        self.listByOrganization()
                    }
                   
                    if(self.emailField.text != ""){
                        UserDefaults.standard.setValue(self.globalFlag, forKey: "flagg")
                    UserDefaults.standard.setValue(globalURL, forKey: "logg")
                    UserDefaults.standard.set(self.emailField.text!, forKey: "userEmail")
                    UserDefaults.standard.set(self.passwordField.text!, forKey: "userPassword")
                    UserDefaults.standard.set(false, forKey: "Logout")
                    }
                }else{
                    
                    if self.isFromDirectLogin {
                        self.whiteBG.removeFromSuperview()
                        self.isFromDirectLogin = false
                        if(logModel.passKey == "")
                        {
                            UserDefaults.standard.set(true, forKey: "Logout")
                            NavigationHelper().setRootViewController()
                        }
                        return
                    }
                    NavigationHelper.showSimpleAlert(message:logModel.responseMessage)

                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
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
                        self.getUserProfile()
                        self.organizationList = logModel.organizations
                        self.GetToolkitEnabled()
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
    
    func getUserProfile(){
        let json: [String: Any] = ["PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: getUserURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:whoamimapping = whoamimapping.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    OperationQueue.main.addOperation {
                        self.whoUser = logModel.user
                        UserDefaults.standard.set(self.whoUser.id!, forKey: "masterUserID")
                        UserDefaults.standard.set(self.whoUser.id!, forKey: "BCCID")
                        currentMasterID = self.whoUser.id!
                    }
                }else {
                    NavigationHelper.showSimpleAlert(message:logModel.responseMessage)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    
    func GetToolkitEnabled(){
        print(self.organizationList)
        if(self.organizationList.count > 0){
            if(self.organizationList.count-1 >= self.organizationIndex){
                let json: [String: Any] = [
                    "OrganizationId":self.organizationList[organizationIndex].id!,
                    "PassKey": passKey
                ]
                print(json)
                APIManager.sharedInstance.postRequestCall(postURL: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/organizationStatus.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                    DispatchQueue.main.async {
                        print(json)
                        print(json["Status"]["ToolKitEnabled"])
                        if(json["Status"]["ToolKitEnabled"]).boolValue{
                            self.ArrayOrganisationID.append(self.organizationList[self.organizationIndex].id!)
                            self.ArrayOrganisationName.append(self.organizationList[self.organizationIndex].name!)
                            UserDefaults.standard.set(self.organizationList[self.organizationIndex].id!, forKey: "userOrganizationID")
                            UserDefaults.standard.set(self.organizationList[self.organizationIndex].name!, forKey: "loggedUserName")
                        }
                        if let data:String = UserDefaults.standard.object(forKey: "userOrganizationID") as? String {
                            print(data)
                            self.organizationIndex = self.organizationIndex + 1
                            self.GetToolkitEnabled()
                        }
                        else{
//                            UserDefaults.standard.set(self.organizationList[self.organizationIndex].id!, forKey: "userOrganizationID")
//                            UserDefaults.standard.set(self.organizationList[self.organizationIndex].name!, forKey: "loggedUserName")
                            self.organizationIndex = self.organizationIndex + 1
                            self.GetToolkitEnabled()
                        }
                    }
                },  onFailure: { error in
                    print(error.localizedDescription)
                    NavigationHelper.showSimpleAlert(message:error.localizedDescription)
                })
            }
            else{
                if(First == "yesss"){
                    NavigationHelper().createMenuView()
                }
                else{
                    let controller:IntroController = self.storyboard?.instantiateViewController(withIdentifier: "IntroController") as! IntroController
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = controller
                }
            }
        }
    }
    //MARK: - UItableview delegate and datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.changeTextEmailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ccell", for: indexPath)
        cell.textLabel?.text = changeTextEmailArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.emailField.text = self.changeTextEmailArray[indexPath.row]
        self.passwordField.text = self.retriveSelectedRecordsFromCoreData(email: self.changeTextEmailArray[indexPath.row])
        self.listTableView.isHidden = true
    }
    func forgotPasswordAPI(userName: String){
        let json: [String: Any] = ["UserName": userName]
        APIManager.sharedInstance.postRequestCall(postURL: forgotURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                NavigationHelper.showSimpleAlert(message:jsonResponse["ResponseMessage"]! as! String)
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
extension UIImageView {
    public func imageFromURL(urlString: String,senderVC:UIViewController) {
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        if self.image == nil{
            self.addSubview(activityIndicator)
        }
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration, delegate: senderVC as? URLSessionDelegate, delegateQueue:OperationQueue.main)
        let task = session.dataTask(with: NSURL(string: urlString)! as URL){ data, response, error in
            if error != nil {
                print(error ?? "No Error")
                return
            }
            print(response as Any)
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
            })
        }
        task.resume()
        
        //        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
        //
        //            if error != nil {
        //                print(error ?? "No Error")
        //                return
        //            }
        //            DispatchQueue.main.async(execute: { () -> Void in
        //                let image = UIImage(data: data!)
        //                activityIndicator.removeFromSuperview()
        //                self.image = image
        //            })
        //
        //        }).resume()
    }
}
extension LoginController:URLSessionDelegate {
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

