
//
//  PhoneNumberCell.swift
//  ContactsModule
//
//  Created by Test Technologies PVT LTD on 11/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class PhoneNumberCell: UITableViewCell {
    @IBOutlet weak var fieldFax: ACFloatingTextfield!
    @IBOutlet weak var fieldPager: ACFloatingTextfield!
    @IBOutlet weak var fieldMobilePhone: ACFloatingTextfield!
    @IBOutlet weak var fieldAlternatePhone: ACFloatingTextfield!
    @IBOutlet weak var fieldEveningPhone: ACFloatingTextfield!
    @IBOutlet weak var fieldBusinessPhone: ACFloatingTextfield!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
         fieldMobilePhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
         fieldAlternatePhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
         fieldEveningPhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
         fieldBusinessPhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
         fieldAlternatePhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
         fieldMobilePhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        // Initialization code
    }
    @objc func textFieldDidChange(textField : UITextField){
        textField.text = NavigationHelper.USPhoneFormat(number: textField.text!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
