//
//  AddAddtionalCell.swift
//  Blue Square
//
//  Created by Imcrinox Technologies PVT LTD on 15/10/18.
//  Copyright © 2018 VividInfotech. All rights reserved.
//

import UIKit

class AddAddtionalCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
//    @IBOutlet weak var lblTelephone: UILabel!
//    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
//    @IBOutlet weak var lblZipcode: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
