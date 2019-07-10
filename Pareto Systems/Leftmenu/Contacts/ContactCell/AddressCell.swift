//
//  AddressCell.swift
//  ContactsModule
//
//  Created by Test Technologies PVT LTD on 11/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var fieldPOBox: ACFloatingTextfield!
    @IBOutlet weak var fieldCountry: ACFloatingTextfield!
    @IBOutlet weak var fieldZip: ACFloatingTextfield!
    @IBOutlet weak var fieldState: ACFloatingTextfield!
    @IBOutlet weak var fieldCity: ACFloatingTextfield!
    @IBOutlet weak var fieldAddress3: ACFloatingTextfield!
    @IBOutlet weak var fieldAddress2: ACFloatingTextfield!
    @IBOutlet weak var fieldAddress1: ACFloatingTextfield!
    override func awakeFromNib() {
        super.awakeFromNib()
        fieldCountry.setupRightView()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
