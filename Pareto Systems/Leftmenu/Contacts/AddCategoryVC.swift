//
//  AddCategoryVC.swift
//  Blue Square
//
//  Created by TECNVATORS SOFTWARE on 04/12/18.
//  Copyright © 2018 VividInfotech. All rights reserved.
//

import UIKit

class AddCategoryVC: UIViewController {

    @IBOutlet var Closebtn: UIButton!
    @IBOutlet var Savebtn: UIButton!
    @IBOutlet weak var FieldDescription: UITextView!
    @IBOutlet weak var FieldName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        FieldDescription.layer.borderColor = UIColor.lightGray.cgColor
        FieldDescription.layer.borderWidth = 1.0
        
        self.Closebtn.isUserInteractionEnabled = true
        self.Savebtn.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TappedClose(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func Tappedback(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func TappedSave(_ sender: Any) {
        if FieldName.text?.count == 0 {
            NavigationHelper.showSimpleAlert(message:"Please enter the Name")
            return
        }
        else{
            self.Closebtn.isUserInteractionEnabled = false
            self.Savebtn.isUserInteractionEnabled = false
            let dataObject:NSMutableDictionary = [:]
             if FieldDescription.text?.count == 0 {
             dataObject.setValue("", forKey: "Description")
             }
            else{
              dataObject.setValue(FieldDescription.text!, forKey: "Description")
            }
            dataObject.setValue(FieldName.text!, forKey: "Name")
        let json:[String: Any] = ["DataObject":dataObject,
                                  "PassKey":passKey,
                                  "OrganizationId":currentOrgID,
                                  "ObjectName":"recreation"]
        print(json)
        let url:String = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/create.json"
        APIManager.sharedInstance.postRequestCall(postURL: url, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                let response = json["ResponseMessage"]
                if(response == "success"){
                    
                    DispatchQueue.main.async(execute: {
                        AJAlertController.initialization().showAlertWithOkButton(aStrMessage: "Created Successfully") { (index, title) in
                            OperationQueue.main.addOperation {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    })
                    
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
        })
        }
        
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
extension AddCategoryVC:URLSessionDelegate {
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

