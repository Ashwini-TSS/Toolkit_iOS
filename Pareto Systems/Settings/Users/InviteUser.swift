//
//  InviteUser.swift
//  Pareto Systems
//
//  Created by Thabresh on 05/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class InviteUser: UIViewController {

    @IBOutlet weak var titleField: ACFloatingTextfield!
    @IBOutlet weak var emailField: ACFloatingTextfield!
    @IBOutlet weak var invitationExpiry: ACFloatingTextfield!
    @IBOutlet weak var firstnameField: ACFloatingTextfield!
    var inviteDateStr:String = ""
    var orgID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        textField.text = NavigationHelper.USPhoneFormat(number: textField.text!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tappedSave(_ sender: Any) {
        inviteUser()
    }
    
    func inviteUser() {
        let detailDict:NSMutableDictionary = [:]
        detailDict.setValue(titleField.text!, forKey: "PersonalMessage")
        detailDict.setValue(firstnameField.text! , forKey: "InviteeName")
        detailDict.setValue(orgID, forKey: "OrganizationId")
        detailDict.setValue(emailField.text!, forKey: "EmailAddress")
        detailDict.setValue(inviteDateStr, forKey: "InviteExpiry")

        let json: [String: Any] = ["PassKey": passKey,
                                   "EmailInvite":detailDict]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: inviteUserURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let invite:inviteuser = inviteuser.init(fromDictionary: jsonResponse)
                if invite.valid {
                    if invite.responseMessage == "success" {
                        DispatchQueue.main.async(execute: {
                            AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Invited") { (index, title) in
                                OperationQueue.main.addOperation {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            }
                        })
                    }else{
                        NavigationHelper.showSimpleAlert(message:invite.responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:invite.responseMessage)
                }
               
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
extension NSDate {
    var dayAfter:NSDate {
        let oneDay:Double = 60 * 60 * 24
        return self.addingTimeInterval(oneDay)
    }
    var dayBefore:NSDate {
        let oneDay:Double = 60 * 60 * 24
        return self.addingTimeInterval(-(Double(oneDay)))
    }
}
extension InviteUser:URLSessionDelegate {
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
extension InviteUser:UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == invitationExpiry {
            // Date Picker
            let min = Date()
            DPPickerManager.shared.showPicker(title: "Invitation Expiry Date", selected: Date(), min: min, max: nil) { (date, cancel) in
                if !cancel {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "YYYY-MM-dd"
                    textField.text = formatter.string(from: date!)
                    formatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    self.inviteDateStr = formatter.string(from: date!)
                }
            }
            return false
        }
        return true
    }
    
}
