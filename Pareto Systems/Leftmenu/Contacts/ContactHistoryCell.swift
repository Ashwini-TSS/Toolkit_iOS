//
//  ContactHistoryCell.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 24/08/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ContactHistoryCell: UITableViewCell {
    @IBOutlet weak var lblWhen: UILabel!
    
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var lblWho: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
