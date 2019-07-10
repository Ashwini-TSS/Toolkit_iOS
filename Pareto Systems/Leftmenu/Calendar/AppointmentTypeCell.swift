//
//  AppointmentTypeCell.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 20/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class AppointmentTypeCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblColor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
