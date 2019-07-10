//
//  PaymentCell.swift
//  Pareto Systems
//
//  Created by Thabresh on 30/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class PaymentCell: UITableViewCell {
    
    @IBOutlet weak var btnActive: UIButton!
    @IBOutlet weak var lblExpiry: UILabel!
    @IBOutlet weak var lblDigits: UILabel!
    @IBOutlet weak var lblCardName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
