//
//  LinkedAccountsCell.swift
//  Pareto Systems
//
//  Created by Thabresh on 22/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class LinkedAccountsCell: UITableViewCell {

    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
