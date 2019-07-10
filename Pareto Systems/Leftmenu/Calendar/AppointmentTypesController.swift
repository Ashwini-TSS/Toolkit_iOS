//
//  AppointmentTypesController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 20/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class AppointmentTypesController: UIViewController {

    @IBOutlet weak var tblAppointmentTypes: UITableView!
    var appointmentResults:[GetAppointmentTypesResult] = []
    
    var items: [[DropdownItem]]!
    var showSection: Bool = true
    var selectedRow: Int = 0
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    @IBOutlet weak var btnDropDown: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblAppointmentTypes.tableFooterView = UIView()
        tblAppointmentTypes.estimatedRowHeight = 118
        tblAppointmentTypes.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        NavigationHelper().setupScreen(vc: self)
        
        let tabView = NavigationHelper().setupBarSqureImage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let setupImage:UIImage = tabView.takeScreenshot()
            self.btnDropDown.image = setupImage
        }
        
        getAppointmentTypesList()
    }

    @IBAction func tappedAdd(_ sender: Any) {

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
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func getAppointmentTypesList(){
        let json: [String: Any] = ["PageOffset": 1,
                                   "ResultsPerPage": 5000,
                                   "ObjectName":"appointment_type",
                                   "AscendingOrder":true,
                                   "OrderBy":"Name",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
              
                let model = GetAppointmentTypesModel.init(fromDictionary: jsonResponse)
                self.appointmentResults = []
                if model.valid {
                    self.appointmentResults = model.results
                }
                self.tblAppointmentTypes.reloadData()
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension AppointmentTypesController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AppointmentTypeCell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTypeCell") as! AppointmentTypeCell
        cell.lblName.text = appointmentResults[indexPath.row].name
        cell.lblDescription.text = appointmentResults[indexPath.row].descriptionField
        cell.lblColor.text = appointmentResults[indexPath.row].calendarColor
        if appointmentResults[indexPath.row].calendarColor != nil && appointmentResults[indexPath.row].calendarColor.count > 0 {
            let color1 = hexStringToUIColor(hex: "#\(appointmentResults[indexPath.row].calendarColor!)")
            cell.lblColor.backgroundColor = color1
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
extension AppointmentTypesController: DropdownMenuDelegate {
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
extension AppointmentTypesController:URLSessionDelegate {
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
