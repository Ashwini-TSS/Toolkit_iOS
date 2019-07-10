//
//  ChangePasswordVC.swift
//  Pareto Systems
//
//  Created by Thabresh on 06/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var currentPwdField: ACFloatingTextfield!
    @IBOutlet weak var newPwdField: ACFloatingTextfield!
    @IBOutlet weak var confirmPwdField: ACFloatingTextfield!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tappedCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedSave(_ sender: Any) {
        if (currentPwdField.text?.isEmpty)! || (newPwdField.text?.isEmpty)! || (confirmPwdField.text?.isEmpty)! {
            NavigationHelper.showSimpleAlert(message: "Please enter the required fields")
            return
        }else if newPwdField.text != confirmPwdField.text  {
            NavigationHelper.showSimpleAlert(message: "New password and confirm password not matched")
            return
        }else if (newPwdField.text == currentPwdField.text) {
            NavigationHelper.showSimpleAlert(message: "New password should not be same as old password")
            return
        }
        callChangeAPI()
    }
    
    func callChangeAPI(){
        let json: [String: Any] = ["NewPassword": newPwdField.text!,
                                   "UserId": "",
                                   "CurrentPassword": currentPwdField.text!,
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: changePasswordURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let logModel:ChangePasswordModel = ChangePasswordModel.init(fromDictionary: jsonResponse)
                if logModel.valid {
                    DispatchQueue.main.async(execute: {
                        AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Password changed successfully.") { (index, title) in
                            OperationQueue.main.addOperation {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    })
                }else{
                    NavigationHelper.showSimpleAlert(message:logModel.responseMessage)
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
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
extension ChangePasswordVC:URLSessionDelegate {
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
