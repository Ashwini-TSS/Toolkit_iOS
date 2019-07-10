//
//  MyAccountHeaderCell.swift
//  TermsClickable
//
//  Created by Test Technologies PVT LTD on 24/08/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class MyAccountHeaderCell: UITableViewCell {

    @IBOutlet weak var imgSync: UIImageView!
    @IBOutlet weak var tappedSync: UIButton!
    @IBOutlet weak var tappedPayment: UIButton!
    @IBOutlet weak var tappedUser: UIButton!
    @IBOutlet weak var imgRight: UIImageView!
    @IBOutlet weak var lblOrganizationName: UILabel!
    @IBOutlet weak var tappedExpand: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
