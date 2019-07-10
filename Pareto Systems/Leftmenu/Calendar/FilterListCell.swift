//
//  FilterListCell.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 21/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class FilterListCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCheckMark: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
