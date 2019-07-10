//
//  OccupationCell.swift
//  ContactsModule
//
//  Created by Test Technologies PVT LTD on 11/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class OccupationCell: UITableViewCell {

    @IBOutlet weak var fieldDescription: UITextView!
    @IBOutlet weak var fieldAssistantPhone: ACFloatingTextfield!
    @IBOutlet weak var fieldDepartment: ACFloatingTextfield!
    @IBOutlet weak var fieldAssistant: ACFloatingTextfield!
    @IBOutlet weak var fieldJobTitle: ACFloatingTextfield!
    @IBOutlet weak var fieldCompany: ACFloatingTextfield!
    @IBOutlet weak var fieldCompanyName: ACFloatingTextfield!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fieldCompany.setupRightView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
