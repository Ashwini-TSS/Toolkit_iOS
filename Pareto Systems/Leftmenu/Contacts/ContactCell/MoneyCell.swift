//
//  MoneyCell.swift
//  ContactsModule
//
//  Created by Test Technologies PVT LTD on 11/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class MoneyCell: UITableViewCell {

    @IBOutlet weak var fieldDescription: UITextView!
    @IBOutlet weak var fieldGroupInsurancePlan: ACFloatingTextfield!
    @IBOutlet weak var fieldGroupInsurance: ACFloatingTextfield!
    @IBOutlet weak var fieldPowerAtroney: ACFloatingTextfield!
    @IBOutlet weak var fieldExecutor: ACFloatingTextfield!
    @IBOutlet weak var fieldPowerName: ACFloatingTextfield!
    @IBOutlet weak var fieldExecutorName: ACFloatingTextfield!
    @IBOutlet weak var fieldCreditOnHold: ACFloatingTextfield!
    @IBOutlet weak var fieldCreditLimit: ACFloatingTextfield!
    @IBOutlet weak var fieldRevenue: ACFloatingTextfield!
    @IBOutlet weak var fieldIncome: ACFloatingTextfield!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fieldExecutor.setupRightView()
        fieldPowerAtroney.setupRightView()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
