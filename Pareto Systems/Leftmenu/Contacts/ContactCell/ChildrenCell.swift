//
//  ChildrenCell.swift
//  Blue Square
//
//  Created by Thabu on 15/02/19.
//  Copyright © 2019 VividInfotech. All rights reserved.
//

import UIKit

class ChildrenCell: UITableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
