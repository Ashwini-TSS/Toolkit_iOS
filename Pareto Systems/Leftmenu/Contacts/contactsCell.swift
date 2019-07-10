//
//  contactsCell.swift
//  Pareto Systems
//
//  Created by Thabresh on 14/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class contactsCell: UITableViewCell {

    @IBOutlet weak var lblCreatedBy: UILabel!
    @IBOutlet weak var lblLastname: UILabel!
    @IBOutlet weak var lblFirstname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
