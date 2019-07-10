//
//  AppliedProcessCell.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 04/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class AppliedProcessCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblProcess: UILabel!
    
    @IBOutlet weak var lblCreatedBy: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
