//
//  NewClientClassVC.swift
//  Processes
//
//  Created by Test Technologies PVT LTD on 06/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class NewClientClassVC: UIViewController {

    @IBOutlet weak var fieldDescription: KMPlaceholderTextView!
    @IBOutlet weak var fieldName: ACFloatingTextfield!
    var processList:ServicesResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        fieldDescription.layer.cornerRadius = 5.0
        fieldDescription.layer.borderColor = UIColor.lightGray.cgColor
        fieldDescription.layer.borderWidth = 1.0
        fieldDescription.clipsToBounds = true
        self.title = "New Client Class"

        if processList != nil {
            self.title = "Edit Client Class"
            fieldName.text = processList.name
            fieldDescription.text = processList.descriptionField
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tappedSave(_ sender: Any) {
        if fieldName.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please enter the \(String(describing: fieldName.placeholder!))")
            return
        }
        var mainURL:String = createContact
        
        let dataObject:NSMutableDictionary = [:]
        dataObject.setValue(fieldName.text!, forKey: "Name")
        dataObject.setValue(fieldDescription.text!, forKey: "Description")
        
        if processList != nil {
            dataObject.setValue(processList.id!, forKey: "Id")
            mainURL = modifyURL
        }
        
        let json:[String:Any] = ["DataObject":dataObject,
                                 "ObjectName":"client_class",
                                 "PassKey":passKey,
                                 "OrganizationId":currentOrgID]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: mainURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
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
                    }
                }else{
                    
                }
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
extension NewClientClassVC:URLSessionDelegate {
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
