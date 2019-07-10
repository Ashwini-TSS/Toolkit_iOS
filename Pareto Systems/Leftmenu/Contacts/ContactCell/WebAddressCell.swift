//
//  WebAddressCell.swift
//  ContactsModule
//
//  Created by Test Technologies PVT LTD on 11/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class WebAddressCell: UITableViewCell {

    @IBOutlet weak var fieldFtp: ACFloatingTextfield!
    @IBOutlet weak var fieldEmail3: ACFloatingTextfield!
    @IBOutlet weak var fieldWebsite: ACFloatingTextfield!
    @IBOutlet weak var fieldEmail: ACFloatingTextfield!
    @IBOutlet weak var fieldEmail2: ACFloatingTextfield!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
