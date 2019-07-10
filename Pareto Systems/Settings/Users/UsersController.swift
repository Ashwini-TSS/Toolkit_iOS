//
//  UsersController.swift
//  Pareto Systems
//
//  Created by Thabresh on 30/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class UsersController: UITableViewController {

    var userNamesList:NSArray = ["Tyler Murray","Ryan Weeks","Duncan MacPherson"]
    var userStatusList:NSArray = ["Invitation","User(Administrator)","User"]
    var organizationID:String = ""
    var usersList:[UserlistUser] = []
    var userEmailInvites:[inviteUsersEmailInvite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        //userListByOrgURL
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func tappedUserInvite(_ sender: Any) {
        let controller:InviteUser = (self.storyboard?.instantiateViewController(withIdentifier: "InviteUser") as? InviteUser)!
        controller.orgID = organizationID
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        listEmailInvite()
        listOfUsersBasedOnOrganization()
    }
    func listEmailInvite(){
        //listEmailInvites
        let json: [String: Any] = ["OrganizationId": organizationID,
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: listEmailInviteURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                //inviteUsersList
                
                let logModel:inviteUsersList = inviteUsersList.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    self.userEmailInvites = logModel.emailInvites
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"No data available")
                    NavigationHelper().setRootViewController()
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
            
        })
    }
    func listOfUsersBasedOnOrganization() {
        
        let json: [String: Any] = ["OrganizationId": organizationID,
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
                        self.tableView.reloadData()
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"No data available")
                    NavigationHelper().setRootViewController()
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
        if usersList.count > 0 {
            tableView.backgroundView = nil
            return 1
        } else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "Retrieving data.\nPlease wait."
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "Raleway-Regular", size: 17.0)!
            messageLabel.sizeToFit()
            tableView.backgroundView = messageLabel;
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UsersCell = (tableView.dequeueReusableCell(withIdentifier: "UsersCell", for: indexPath) as? UsersCell)!
//        let eachUser:inviteUsersEmailInvite = userEmailInvites[indexPath.row]
        let eachUser:UserlistUser = usersList[indexPath.row]

        cell.lblUsername.text = eachUser.firstName + " " + eachUser.lastName
        cell.lblUserStatus.text = eachUser.emailAddress
        cell.lblcount.text = "\(indexPath.row + 1)."
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eachUser:UserlistUser = usersList[indexPath.row]

//        let eachUser:inviteUsersEmailInvite = userEmailInvites[indexPath.row]
//        print(eachUser.firstName)
        let controller:UserProfileController = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileController") as! UserProfileController
        controller.userProfile = eachUser
        self.navigationController?.pushViewController(controller, animated: true)
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
extension UsersController:URLSessionDelegate {
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
