//
//  ToolkitOrgCell.swift
//  Pareto Systems
//
//  Created by Imcrinox Technologies PVT LTD on 09/10/18.
//  Copyright © 2018 VividInfotech. All rights reserved.
//

import UIKit

class ToolkitOrgCell: UITableViewCell {

    @IBOutlet weak var btnCheckbox: UIButton!
    @IBOutlet weak var lblOrganizationTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
