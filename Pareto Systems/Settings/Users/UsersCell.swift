//
//  UsersCell.swift
//  Pareto Systems
//
//  Created by Thabresh on 30/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class UsersCell: UITableViewCell {

    @IBOutlet weak var lblUserStatus: UILabel!
    @IBOutlet weak var lblcount: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
