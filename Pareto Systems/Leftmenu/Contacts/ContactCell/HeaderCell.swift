//
//  HeaderCell.swift
//  ContactsModule
//
//  Created by Test Technologies PVT LTD on 11/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var lblItem1: UILabel!
    
    @IBOutlet weak var AddTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var AddHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var SearchHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblNoDataAvailable: UILabel!
    @IBOutlet var Viewheader: UIView!
    @IBOutlet var AdditionalView: UIView!
    @IBOutlet weak var lblItem3: UILabel!
    @IBOutlet weak var lblItem2: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var lblHeader: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
