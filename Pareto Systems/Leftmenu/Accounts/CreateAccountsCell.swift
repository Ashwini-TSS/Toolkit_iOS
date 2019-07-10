//
//  CreateAccountsCell.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 18/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import AnyFormatKit


class CreateAccountsCell: UITableViewCell,TextInputFieldDelegate {
    
    @IBOutlet weak var fieldPrimaryContct: ACFloatingTextfield!
    @IBOutlet weak var fieldFTPSite: ACFloatingTextfield!
    @IBOutlet weak var fieldWebsite: ACFloatingTextfield!
    @IBOutlet weak var fieldEmail3: ACFloatingTextfield!
    @IBOutlet weak var fieldEmail2: ACFloatingTextfield!
    @IBOutlet weak var fieldEmail1: ACFloatingTextfield!
    @IBOutlet weak var fieldCountry: ACFloatingTextfield!
    @IBOutlet weak var fieldPOBox: ACFloatingTextfield!
    @IBOutlet weak var fieldPostal: ACFloatingTextfield!
    @IBOutlet weak var fieldState: ACFloatingTextfield!
    @IBOutlet weak var fieldCity: ACFloatingTextfield!
    @IBOutlet weak var addressLine3: ACFloatingTextfield!
    @IBOutlet weak var addressLine2: ACFloatingTextfield!
    @IBOutlet weak var addressLine1: ACFloatingTextfield!
    @IBOutlet weak var fieldPager: ACFloatingTextfield!
    @IBOutlet weak var fieldFax: ACFloatingTextfield!
    @IBOutlet weak var fieldMobilePhone: ACFloatingTextfield!
    @IBOutlet weak var fieldOtherPhone: ACFloatingTextfield!
    @IBOutlet weak var fieldSecondaryName: ACFloatingTextfield!
    @IBOutlet weak var fieldPrimaryPhone: ACFloatingTextfield!
    @IBOutlet weak var fieldDescription: KMPlaceholderTextView!
    @IBOutlet weak var fieldLegalName: ACFloatingTextfield!
    @IBOutlet weak var fieldName: ACFloatingTextfield!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fieldPrimaryPhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        fieldOtherPhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        fieldSecondaryName.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        fieldMobilePhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        fieldDescription.layer.borderColor = UIColor.lightGray.cgColor
        fieldDescription.layer.borderWidth = 1.0
        fieldDescription.clipsToBounds = true
        
        fieldCountry.setupRightView()
        fieldPrimaryContct.setupRightView()
        // Initialization code
    }
    @objc func textFieldDidChange(textField : UITextField){
//        textField.text = NavigationHelper.USPhoneFormat(number: textField.text!)
    }
    
    func checkIfEditable(value:Bool) {
        
        if value {
            fieldWebsite.lineColor = UIColor.lightGray
            fieldEmail1.lineColor = UIColor.lightGray
            fieldEmail2.lineColor = UIColor.lightGray
            fieldEmail3.lineColor = UIColor.lightGray
            fieldMobilePhone.lineColor = UIColor.lightGray
            fieldOtherPhone.lineColor = UIColor.lightGray
            fieldSecondaryName.lineColor = UIColor.lightGray
            fieldPrimaryPhone.lineColor = UIColor.lightGray
            
            fieldWebsite.textColor = UIColor.black
            fieldEmail1.textColor = UIColor.black
            fieldEmail2.textColor = UIColor.black
            fieldEmail3.textColor = UIColor.black
            fieldMobilePhone.textColor = UIColor.black
            fieldOtherPhone.textColor = UIColor.black
            fieldSecondaryName.textColor = UIColor.black
            fieldPrimaryPhone.textColor = UIColor.black
            
        }else{
            fieldWebsite.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail1.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail2.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail3.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldMobilePhone.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldOtherPhone.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldSecondaryName.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldPrimaryPhone.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            
            fieldWebsite.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail1.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail2.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail3.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldMobilePhone.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldOtherPhone.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldSecondaryName.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldPrimaryPhone.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            
        }
        
        fieldPrimaryContct.isUserInteractionEnabled = value
        fieldFTPSite.isUserInteractionEnabled = value
//        fieldWebsite.isUserInteractionEnabled = value
//        fieldEmail3.isUserInteractionEnabled = value
//        fieldEmail2.isUserInteractionEnabled = value
//        fieldEmail1.isUserInteractionEnabled = value
        fieldCountry.isUserInteractionEnabled = value
        fieldPOBox.isUserInteractionEnabled = value
        
        fieldPostal.isUserInteractionEnabled = value
        fieldState.isUserInteractionEnabled = value
        fieldCity.isUserInteractionEnabled = value
        addressLine3.isUserInteractionEnabled = value
        addressLine2.isUserInteractionEnabled = value
        
        addressLine1.isUserInteractionEnabled = value
        fieldPager.isUserInteractionEnabled = value
        fieldFax.isUserInteractionEnabled = value
//        fieldMobilePhone.isUserInteractionEnabled = value
//        fieldOtherPhone.isUserInteractionEnabled = value
//        fieldSecondaryName.isUserInteractionEnabled = value
//        fieldPrimaryPhone.isUserInteractionEnabled = value
        fieldDescription.isUserInteractionEnabled = value
        fieldLegalName.isUserInteractionEnabled = value
        fieldName.isUserInteractionEnabled = value
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
