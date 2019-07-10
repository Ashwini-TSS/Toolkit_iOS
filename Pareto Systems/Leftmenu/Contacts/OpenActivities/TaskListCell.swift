//
//  TaskListCell.swift
//  Blue Square
//
//  Created by mac on 14/11/18.
//  Copyright © 2018 VividInfotech. All rights reserved.
//

import UIKit

class TaskListCell: UITableViewCell {

    @IBOutlet weak var LblDuedate: UILabel!
    @IBOutlet weak var LblPriority: UILabel!
    @IBOutlet weak var LblSubject: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       LblDuedate.isUserInteractionEnabled = true
       LblSubject.isUserInteractionEnabled = true
       LblPriority.isUserInteractionEnabled = true
        // Configure the view for the selected state
    }

}
