//
//  ContactsUsViewcontroller.swift
//  Blue Square
//
//  Created by Sayeed Syed on 5/24/19.
//  Copyright © 2019 VividInfotech. All rights reserved.
//

import UIKit
import MessageUI

class ContactsUsViewcontroller: UIViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet var BtnMail: UIButton!
    @IBOutlet var contactBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact US"
        // Do any additional setup after loading the view.
    }
    @IBAction func CallAction(_ sender: Any) {
        let busPhone = "1-877-969-8199"
        if let url = URL(string: "tel://\(busPhone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func MailAction(_ sender: Any) {
        let mailComposeViewController = configureMailComposer()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            print("Can't send email")
        }
    }
    
    func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["clientsupport@bluesquareapps.com"])
        mailComposeVC.setSubject("Subject for email")
        mailComposeVC.setMessageBody("Email message string", isHTML: false)
        return mailComposeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
