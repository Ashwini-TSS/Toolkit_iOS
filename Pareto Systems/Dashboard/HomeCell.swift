//
//  HomeCell.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 17/08/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var lblPlan: UILabel!
    @IBOutlet weak var btnLearnMore: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productSubImage: UIImageView!
    @IBOutlet weak var btnBuy: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
