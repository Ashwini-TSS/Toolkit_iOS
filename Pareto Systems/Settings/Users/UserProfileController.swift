//
//  UserProfileController.swift
//  Pareto Systems
//
//  Created by Thabresh on 30/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {

    var userProfile:UserlistUser!
    
//    @IBOutlet weak var fieldType: ACFloatingTextfield!
//    @IBOutlet weak var fieldCreatedBy: ACFloatingTextfield!
    @IBOutlet weak var fieldExpirationDate: ACFloatingTextfield!
    @IBOutlet weak var fieldCreatedDate: ACFloatingTextfield!
//    @IBOutlet weak var fieldTitle: ACFloatingTextfield!
//    @IBOutlet weak var fieldPhone: ACFloatingTextfield!
    @IBOutlet weak var emailField: ACFloatingTextfield!
//    @IBOutlet weak var lastNameField: ACFloatingTextfield!
    @IBOutlet weak var firstNameField: ACFloatingTextfield!
    
    var bottomView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if userProfile != nil {
            fieldExpirationDate.isHidden = true
            firstNameField.text = userProfile.firstName
//            lastNameField.text = ""
            emailField.text = userProfile.emailAddress
//            fieldPhone.text = ""
//            fieldTitle.text = userProfile.personalMessage
//            fieldType.text = "User"
            
//            fieldCreatedBy.text = userProfile.createdBy
//            let string = userProfile.inviteExpiry
//            let dateFormatter = DateFormatter()
//            let tempLocale = dateFormatter.locale // save locale temporarily
//            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//            let date = dateFormatter.date(from: string!)!
//            dateFormatter.dateFormat = "dd/MM/YYYY" ; //"dd-MM-yyyy HH:mm:ss"
//            dateFormatter.locale = tempLocale // reset the locale --> but no need here
//            let dateString = dateFormatter.string(from: date)
//            fieldExpirationDate.text = dateString
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func tappedDelete(_ sender: Any) {
        DispatchQueue.main.async(execute: {
            AJAlertController.initialization().showAlert(aStrMessage: "Would you like to delete this?", aCancelBtnTitle: "Yes", aOtherBtnTitle: "No", completion: { (index, title) in
                print(index,title)
                
                
                if title == "Yes" {
                    self.deleteInviteUser()
                }
                
            })
        })
    }
    
    func deleteInviteUser(){
        let json: [String: Any] = ["Id": userProfile.id,
                                   "PassKey": passKey]
        print(json)
        APIManager.sharedInstance.postRequestCall(postURL: deleteEmailInviteURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                let invite:deleteInviteuser = deleteInviteuser.init(fromDictionary: jsonResponse)
                if invite.valid {
                    if invite.responseMessage == "success" {
                        DispatchQueue.main.async(execute: {
                            AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Successfully Deleted") { (index, title) in
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
    
    @IBAction func tappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension UserProfileController:URLSessionDelegate {
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
