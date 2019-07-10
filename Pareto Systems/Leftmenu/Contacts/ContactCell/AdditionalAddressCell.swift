//
//  AdditionalAddressCell.swift
//  ContactsModule
//
//  Created by Test Technologies PVT LTD on 16/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class AdditionalAddressCell: UITableViewCell {
//    @IBOutlet weak var lblitem6: UILabel!
//    @IBOutlet weak var lblZipcode: UILabel!
    @IBOutlet weak var lblItem5: UILabel!
    @IBOutlet weak var lblItem4: UILabel!
    @IBOutlet weak var lblItem3: UILabel!
    @IBOutlet weak var lblItem2: UILabel!
    @IBOutlet weak var lblItem1: UILabel!
    @IBOutlet weak var lblTelephone: UILabel!
    @IBOutlet weak var lblStateProvince: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
