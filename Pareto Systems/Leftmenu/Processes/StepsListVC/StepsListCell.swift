//
//  StepsListCell.swift
//  Processes
//
//  Created by Test Technologies PVT LTD on 02/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class StepsListCell: UITableViewCell {

    @IBOutlet weak var lblStartTime: UILabel!
//    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblActivityType: UILabel!
//    @IBOutlet weak var lblSequence: UILabel!
    @IBOutlet weak var lblSubject: UILabel!
//    @IBOutlet weak var sequenceLbl: UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var scheduleLbl: UILabel!
    @IBOutlet weak var patternLbl: UILabel!
//    @IBOutlet weak var appointmentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
