//
//  ProcessCell.swift
//  Processes
//
//  Created by Test Technologies PVT LTD on 02/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class ProcessCell: UITableViewCell {

    @IBOutlet weak var descriHeight: NSLayoutConstraint!
    @IBOutlet weak var LblnoSerivcesHeight: NSLayoutConstraint!
    @IBOutlet weak var AddTopSize: NSLayoutConstraint!
    @IBOutlet weak var btnSteps: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var DescriptionHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
