//
//  PopActivityController.swift
//  Blue Square
//
//  Created by mac on 15/09/21.
//  Copyright © 2021 VividInfotech. All rights reserved.
//

import UIKit
import iOSDropDown

class PopActivityController: UIViewController {
    @IBOutlet weak var droptxtfld: DropDown!
    var selectedTag : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        droptxtfld.isInside = true
        droptxtfld.optionArray = ["Delete this single activity","Delete all incomplete activities in this series","Delete all incomplete activities that have not been modified/changed since creation","Delete all incomplete future activities, from today onwards"]
        droptxtfld.text = "Delete this single activity"
        droptxtfld.didSelect{(selectedText , index ,id) in
            self.selectedTag = index
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteAction(_ sender: UIButton)
    {
        if(selectedTag == 0)
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deletesingle"), object: nil, userInfo:nil)
            self.dismiss(animated: true, completion: nil)
        }else if(selectedTag == 1)
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteseries"), object: nil, userInfo:nil)
            self.dismiss(animated: true, completion: nil)
        }
        else if(selectedTag == 2)
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteunmodify"), object: nil, userInfo:nil)
            self.dismiss(animated: true, completion: nil)
        }else if(selectedTag == 3)
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deletefuture"), object: nil, userInfo:nil)
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }


}
