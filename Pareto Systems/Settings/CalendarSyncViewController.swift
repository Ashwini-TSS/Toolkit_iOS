//
//  CalendarSyncViewController.swift
//  Blue Square
//
//  Created by Gowrisankar G on 16/04/25.
//  Copyright © 2025 VividInfotech. All rights reserved.
//

import UIKit

class CalendarSyncViewController: UIViewController {

    
    @IBOutlet weak var googleCalendarSyncBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        self.title = "Integrations"
        self.googleCalendarSyncBtn.layer.cornerRadius = 8
    }
    
    
  
    @IBAction func googleCalendarSyncAction(_ sender: UIButton) {
        
        
    }
    
    func loginToTheUser()
    {
            let json: [String: Any] = ["UserName": "ios-review",
                                       "Password": "ios-review"]
            print(json)
            OperationQueue.main.addOperation {
                  SVProgressHUD.show()
                MBProgressHUD.showAdded(to: self.view, animated: true)
            }
            APIManager.sharedInstance.postRequestCall(postURL: orgListURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                OperationQueue.main.addOperation {
                     SVProgressHUD.dismiss()
                                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                DispatchQueue.main.async {
                
                  
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                OperationQueue.main.addOperation {
                     SVProgressHUD.dismiss()
                                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            })
        }
    
    func renavigateToOauthPage()
    {
        
    }
}
