//
//  NewRecurrenceController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 28/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class NewRecurrenceController: UITableViewController {

    var linkParentID:String = ""
    var fromAccounts:Bool = false

    var contactList:[ContactListResult] = []
    var teamMembers:[NewAppointmentResult] = []
    var accountsList:[TeamMembersResult] = []
    
    @IBOutlet weak var fieldActivity: ACFloatingTextfield!
    
    @IBOutlet weak var fieldSubject: ACFloatingTextfield!
    
    @IBOutlet weak var fieldDescription: KMPlaceholderTextView!
    
    @IBOutlet weak var fieldLocation: ACFloatingTextfield!
    
    @IBOutlet weak var fieldAppointmentType: ACFloatingTextfield!
    
    @IBOutlet weak var btnAllDayEvent: UIButton!
    
    @IBOutlet weak var btnRollOver: UIButton!
    
    @IBOutlet weak var fieldRecurrence: ACFloatingTextfield!
    
    @IBOutlet weak var fieldPattern: ACFloatingTextfield!
    
    @IBOutlet weak var fieldEndTime: ACFloatingTextfield!
    @IBOutlet weak var fieldRecurrenceStart: ACFloatingTextfield!
    
    @IBOutlet weak var fieldRecurrenceEnd: ACFloatingTextfield!
    
    @IBOutlet weak var fieldRemovalRule: ACFloatingTextfield!
    
    @IBOutlet weak var fieldChooseTeamMember: ACFloatingTextfield!
    
    @IBOutlet weak var fieldChooseContacts: ACFloatingTextfield!
    
    @IBOutlet weak var fieldChooseAccounts: ACFloatingTextfield!
    
    @IBOutlet var Fieldpatterntype: [ACFloatingTextfield]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func tappedSave(_ sender: Any) {
    }
    @IBAction func tappedAllDayEvent(_ sender: Any) {
    }
    @IBAction func tappedRollOver(_ sender: Any) {
    }
    override func viewWillAppear(_ animated: Bool) {
        getContacts()
    }
    func getContacts(){
        OperationQueue.main.addOperation {
//            SVProgressHUD.show()
            
        }
         
        let parameters = [
            "OrderBy": "",
            "ParentId": "",
            "ResultsPerPage": 5000,
            "OrganizationId": currentOrgID,
            "PassKey": passKey,
            "ParentObjectName": "",
            "PageOffset": 1,
            "ObjectName": "contact"
            ] as [String : Any]
        APIManager.sharedInstance.postRequestCall(postURL: getOrgListURL, parameters: parameters, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                self.getTeamMembers()
                print(json)
                let contactModel = ContactListModel.init(fromDictionary: jsonResponse)
                print(contactModel.responseMessage)
                
                self.contactList = contactModel.results
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func getLinkedAccounts(){
        
        let json: [String: Any] = ["ObjectName": "organization_user",
                                   "SearchTerm": "",
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                self.getTeamMembers()
                print(json)
                let contactModel = NewAppointmentModel.init(fromDictionary: jsonResponse)
                print(contactModel.results)
                self.teamMembers = contactModel.results
                
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    func getTeamMembers(){
        let json: [String: Any] = ["ObjectName": "company",
                                   "SearchTerm": "",
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: searchURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let res = json["ResponseMessage"].string
                if(res == "success"){
                let contactModel = TeamMembersModel.init(fromDictionary: jsonResponse)
                print(contactModel.results)
                self.accountsList = contactModel.results
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 16
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
extension NewRecurrenceController:URLSessionDelegate {
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
