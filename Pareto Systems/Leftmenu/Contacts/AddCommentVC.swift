//
//  AddCommentVC.swift
//  Blue Square
//
//  Created by Sayeed Syed on 10/22/19.
//  Copyright © 2019 VividInfotech. All rights reserved.
//

import UIKit

class AddCommentVC: UIViewController,UITextViewDelegate {
    @IBOutlet weak var secondTitle: UILabel!
    var action : String = ""
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var editCloseBtn: UIButton!
    @IBOutlet weak var commentTxtViewOutlet: UITextView!
    @IBOutlet weak var commentCloseBtn: UIButton!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var editview: UIView!
    var istype : String = ""
    var controllername : String = ""
    var fromviewController : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTxtViewOutlet.delegate = self
        view.isOpaque = false
        if(istype == "comment")
        {
            self.editview.isHidden = true
        }else
        {
            self.commentView.isHidden = true
        }
        if(action == "delete")
        {
          self.firstTitle.text = "Are you sure want to delete this draft?"
          self.secondTitle.text = ""
        }else
        {
            self.firstTitle.text = "Are you sure want to close this note?"
            self.secondTitle.text = "This is not reversible!"
        }
        // Do any additional setup after loading the view.
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBtnFromKeyboardClicked))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.blue], for: .normal)
        commentTxtViewOutlet.inputAccessoryView = doneToolbar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        commentTxtViewOutlet.layer.cornerRadius = 5.0
        commentTxtViewOutlet.layer.borderWidth = 1.0
        commentTxtViewOutlet.layer.borderColor = UIColor.lightGray.cgColor
    }
    @IBAction func doneBtnFromKeyboardClicked (sender: Any) {
        print("Done Button Clicked.")
        //Hide Keyboard by endEditing or Anything you want.
        self.view.endEditing(true)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if(text == "\n") {
//            textView.resignFirstResponder()
//            return false
//        }
        return true
    }
    //MARK: - Comment view Action
    @IBAction func commentCancelAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func commentSaveAction(_ sender: UIButton) {
        if(self.fromviewController == "contact")
        {
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: ContactssController.contactssnotify), object: nil, userInfo: ["msg":self.commentTxtViewOutlet.text])
        }else if(self.fromviewController == "company")
        {
           NotificationCenter.default.post(name: NSNotification.Name(rawValue:  NewAccountsController.companynotify), object: nil, userInfo: ["msg":self.commentTxtViewOutlet.text])
        }
        else if(self.fromviewController == "appointment")
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:  UpdatenewappointmentVC.appointmentnotify), object: nil, userInfo: ["msg":self.commentTxtViewOutlet.text])
        }else
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:  UpdatenewtaskVC.commentTasknotify), object: nil, userInfo: ["msg":self.commentTxtViewOutlet.text])
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func commentCloseAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Edit view Action
    @IBAction func editNoAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editYesAction(_ sender: UIButton) {
        if(controllername == "notedetail")
        {
            if(action == "delete")
            {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NoteDetailsVC.deletenotify), object: nil, userInfo: nil)
            }
            else if(action == "editer"){
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NoteDetailsVC.completenotify), object: nil, userInfo: nil)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editCloseAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
