//
//  NewAppointmentTypeContorller.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 20/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class NewAppointmentTypeContorller: UITableViewController {

    @IBOutlet weak var lblBgColor: UILabel!
    @IBOutlet weak var bgColor: ColorPickerView!
    @IBOutlet weak var fieldColor: ACFloatingTextfield!
    @IBOutlet weak var fieldDescription: KMPlaceholderTextView!
    @IBOutlet weak var fieldName: ACFloatingTextfield!
    var bottomView = UIView()
    var isTappedColor:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Appointment Type"
        
        bgColor.delegate = self
        
//        tableView.tableFooterView = UIView()
        
        fieldDescription.layer.borderColor = UIColor.lightGray.cgColor
        fieldDescription.layer.borderWidth = 1.0
        fieldDescription.clipsToBounds = true
        
        lblBgColor.layer.cornerRadius = lblBgColor.frame.size.width / 2
        lblBgColor.clipsToBounds = true
        
        
        fieldColor.setupRightView()
        
        setupBottomView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func removeBottomView(){
        bottomView.removeFromSuperview()
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeBottomView()
    }
    
    func setupBottomView() {
        bottomView.removeFromSuperview()
        bottomView = UIView()
        bottomView.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.height - 67.0, width: UIScreen.main.bounds.width, height: 67.0)
        bottomView.backgroundColor = UIColor.PSNavigaitonController()
        
        let cancelBtn = UIButton()
        cancelBtn.setTitle("Close", for: .normal)
        cancelBtn.frame = CGRect(x: 15.0, y: 9.0, width: 168.0, height: 38)
        cancelBtn.backgroundColor = UIColor.white
        cancelBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        cancelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        cancelBtn.addTarget(self, action: #selector(tappedClose(_:)), for: .touchUpInside)
        
        bottomView.addSubview(cancelBtn)
        
        let donelBtn = UIButton()
        donelBtn.setTitle("Save", for: .normal)
        donelBtn.frame = CGRect(x: UIScreen.main.bounds.width-182, y: 9.0, width: 168.0, height: 38)
        donelBtn.backgroundColor = UIColor.white
        donelBtn.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17.0)!
        donelBtn.setTitleColor(UIColor.PSNavigaitonController(), for: .normal)
        donelBtn.addTarget(self, action: #selector(tappedSave(_:)), for: .touchUpInside)
        
        bottomView.addSubview(donelBtn)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.addSubview(bottomView)
    }
    
  
    @IBAction func tappedSave(_ sender: Any) {
        if (fieldName.text?.isEmpty)! {
            NavigationHelper.showSimpleAlert(message: "Please enter the name")
            return
        }
        if (fieldColor.text?.isEmpty)! {
            NavigationHelper.showSimpleAlert(message: "Please choose the color")
            return
        }
        
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(fieldName.text!, forKey: "Name")
        dataObject.setValue(fieldDescription.text!, forKey: "Description")
        dataObject.setValue(fieldColor.text!, forKey: "CalendarColor")
        let json: [String: Any] = ["DataObject": dataObject,
                                   "ObjectName":"appointment_type",
                                   "PassKey":passKey,
                                   "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: createContact, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                        OperationQueue.main.addOperation {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        print(responseMessage)
                        NavigationHelper.showSimpleAlert(message:responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
              
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if !isTappedColor {
//            return 3
//        }
        return 4
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            if isTappedColor {
                isTappedColor = false
            }else{
                isTappedColor = true
            }
            tableView.reloadData()
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
extension NewAppointmentTypeContorller: ColorPickerDelegate {
    func colorDidChange(color: UIColor) {
        fieldColor.text = color.hexStringg
        lblBgColor.backgroundColor = color
//        isTappedColor = false
//        tableView.reloadData()
        
    }
}
extension NewAppointmentTypeContorller:URLSessionDelegate {
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
