//
//  FamilyCell.swift
//  ContactsModule
//
//  Created by Test Technologies PVT LTD on 11/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class FamilyCell: UITableViewCell {

    @IBOutlet weak var fieldDescription: UITextView!
    @IBOutlet weak var fieldMaritalStatus: ACFloatingTextfield!
    @IBOutlet weak var fieldSpouse2: ACFloatingTextfield!
    @IBOutlet weak var fieldSpouse: ACFloatingTextfield!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fieldSpouse2.setupRightView()
        fieldMaritalStatus.setupRightView()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
