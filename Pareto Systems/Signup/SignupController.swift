//
//  SignupController.swift
//  Pareto Systems
//
//  Created by Thabresh on 24/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class SignupController: UITableViewController {
    @IBOutlet weak var lastnameField: ACFloatingTextfield!
    @IBOutlet weak var passwordField: ACFloatingTextfield!
    @IBOutlet weak var confirmPasswordField: ACFloatingTextfield!
    
    @IBOutlet weak var confirmEmailField: ACFloatingTextfield!
    @IBOutlet weak var emailField: ACFloatingTextfield!
    @IBOutlet weak var firstnameField: ACFloatingTextfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func tappedSignup(_ sender: Any) {
        validate() ? signUpAPICall() : Void()
    }
    func validate() -> Bool {
        if (firstnameField.text?.isEmpty)! || (lastnameField.text?.isEmpty)! || (emailField.text?.isEmpty)! || (confirmEmailField.text?.isEmpty)! || (passwordField.text?.isEmpty)! || (confirmPasswordField.text?.isEmpty)! {
            NavigationHelper.showSimpleAlert(message: "Please enter the required fields")
            return false
        }else if !emailField.text!.isValidEmail() {
            NavigationHelper.showSimpleAlert(message: "Please enter the valid email")
            return false
        }else if emailField.text != confirmEmailField.text {
            NavigationHelper.showSimpleAlert(message: "Email not matched")
            return false
        }else if passwordField.text != confirmPasswordField.text {
            NavigationHelper.showSimpleAlert(message: "Password not matched")
            return false
        }
        return true
    }
    func signUpAPICall(){
        let users:NSMutableDictionary = [:]
        users.setValue(emailField.text!, forKey: "EmailAddress")
        users.setValue(firstnameField.text!, forKey: "FirstName")
        users.setValue(lastnameField.text!, forKey: "LastName")

        let json: [String: Any] = ["User": users,
                                   "Device":"mobile",
                                       "Password": passwordField.text!]
       
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: signupURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(jsonResponse)
                let logModel:LoginModel = LoginModel.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    DispatchQueue.main.async(execute: {
                        globalURL  = "https://toolkit.bluesquareapps.com"
                        AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Signup submitted successfully. Please check your email to proceed.") { (index, title) in
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                    
                }else{
                    NavigationHelper.showSimpleAlert(message:logModel.responseMessage)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
    }
    @IBAction func tappedsignin(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        return 8
    }

   

}
extension SignupController:URLSessionDelegate {
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
