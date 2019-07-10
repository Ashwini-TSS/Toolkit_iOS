//
//  SearchCalendarCell.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 26/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class SearchCalendarCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var toTime: UILabel!
    @IBOutlet weak var fromTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
