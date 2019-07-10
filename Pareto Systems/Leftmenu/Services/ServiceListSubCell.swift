//
//  ServiceListSubCell.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 11/09/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ServiceListSubCell: UITableViewCell {

    @IBOutlet weak var lblActivityType: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
