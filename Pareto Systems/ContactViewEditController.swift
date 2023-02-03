//
//  ContactViewEditController.swift
//  Blue Square
//
//  Created by Thabu on 19/10/18.
//  Copyright © 2018 VividInfotech. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ContactViewEditController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ContactEditViewCell = tableView.dequeueReusableCell(withIdentifier: "ContactEditViewCell", for: indexPath) as! ContactEditViewCell
        return cell
    }
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 4237
    }

}
