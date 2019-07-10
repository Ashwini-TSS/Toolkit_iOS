//
//  ContactssCell.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 24/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit


class ContactssCell: UITableViewCell {
    var aryTeglist = [String]()
    
    @IBOutlet weak var tagsCollection: TaglistCollection!
    @IBOutlet weak var BtnAdd: UIButton!
    @IBOutlet weak var BtnSearch: UIButton!
    @IBOutlet weak var alterphone_placeholderLabel: UILabel!
    @IBOutlet weak var mobilephone_placeholderLabel: UILabel!
    @IBOutlet weak var fieldCategoriesRecreation: ACFloatingTextfield!
    //    @IBOutlet weak var fieldMobileExt: ACFloatingTextfield!
    //    @IBOutlet weak var fieldAlternateExt: ACFloatingTextfield!
    //    @IBOutlet weak var fieldEveningExt: ACFloatingTextfield!
    @IBOutlet weak var fieldBusinessExt: ACFloatingTextfield!
    @IBOutlet weak var fieldTitle: ACFloatingTextfield!
    @IBOutlet weak var fieldNickName: ACFloatingTextfield!
    @IBOutlet weak var fieldsuffix: ACFloatingTextfield!
    @IBOutlet weak var fieldSalutation: ACFloatingTextfield!
    @IBOutlet weak var fieldClientClass: ACFloatingTextfield!
    @IBOutlet weak var fieldLastName: ACFloatingTextfield!
    @IBOutlet weak var fieldMiddleName: ACFloatingTextfield!
    @IBOutlet weak var fieldFirstName: ACFloatingTextfield!
    
    @IBOutlet var fieldChildrenname: ACFloatingTextfield!
    @IBOutlet weak var fieldImportantInformation: KMPlaceholderTextView!
    
    @IBOutlet weak var fieldFtp: ACFloatingTextfield!
    @IBOutlet weak var fieldEmail3: ACFloatingTextfield!
    @IBOutlet weak var fieldWebsite: ACFloatingTextfield!
    @IBOutlet weak var fieldEmail: ACFloatingTextfield!
    @IBOutlet weak var fieldEmail2: ACFloatingTextfield!
    
    @IBOutlet weak var fieldFax: ACFloatingTextfield!
    @IBOutlet weak var fieldPager: ACFloatingTextfield!
    @IBOutlet var fieldMobilePhone: ACFloatingTextfield!
    @IBOutlet weak var fieldAlternatePhone: ACFloatingTextfield!
    @IBOutlet weak var fieldEveningPhone: ACFloatingTextfield!
    @IBOutlet weak var fieldBusinessPhone: ACFloatingTextfield!
    
    @IBOutlet weak var fieldPOBox: ACFloatingTextfield!
    @IBOutlet weak var fieldCountry: ACFloatingTextfield!
    @IBOutlet weak var fieldZip: ACFloatingTextfield!
    @IBOutlet weak var fieldState: ACFloatingTextfield!
    @IBOutlet weak var fieldCity: ACFloatingTextfield!
    @IBOutlet weak var fieldAddress3: ACFloatingTextfield!
    @IBOutlet weak var fieldAddress2: ACFloatingTextfield!
    @IBOutlet weak var fieldAddress1: ACFloatingTextfield!
    
    //    @IBOutlet weak var fieldDescription: UITextView!
    @IBOutlet weak var fieldOwner: ACFloatingTextfield!
    @IBOutlet weak var fieldLicenseExpiry: ACFloatingTextfield!
    @IBOutlet weak var fieldReviewDate: ACFloatingTextfield!
    @IBOutlet weak var fieldGender: ACFloatingTextfield!
    @IBOutlet weak var fieldBirthDate: ACFloatingTextfield!
    
    //    @IBOutlet weak var btnPrivate: UIButton!
    @IBOutlet weak var fieldGovernmentID: ACFloatingTextfield!
    @IBOutlet weak var clientLicenseNumber: ACFloatingTextfield!
    @IBOutlet weak var fieldClientSince: ACFloatingTextfield!
    @IBOutlet weak var fieldAnniversary: ACFloatingTextfield!
    
    @IBOutlet weak var fieldFamilyDescription: UITextView!
    @IBOutlet weak var fieldMaritalStatus: ACFloatingTextfield!
    @IBOutlet weak var fieldSpouse2: ACFloatingTextfield!
    @IBOutlet weak var fieldSpouse: ACFloatingTextfield!
    @IBOutlet weak var btnAddChildren: UIButton!
    
    @IBOutlet weak var fieldOccupationDescription: UITextView!
    @IBOutlet weak var fieldAssistantPhone: ACFloatingTextfield!
    @IBOutlet weak var fieldDepartment: ACFloatingTextfield!
    @IBOutlet weak var fieldAssistant: ACFloatingTextfield!
    @IBOutlet weak var fieldJobTitle: ACFloatingTextfield!
    @IBOutlet weak var fieldCompany: ACFloatingTextfield!
    @IBOutlet weak var fieldCompanyName: ACFloatingTextfield!
    
    @IBOutlet weak var fieldRecreationDescription: UITextView!
    
    @IBOutlet weak var fieldMoneyDescription: UITextView!
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
        
        fieldIncome.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        fieldCreditLimit.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        fieldRevenue.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        fieldCreditOnHold.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        
        
        fieldMobilePhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.touchUpInside)
        fieldBusinessPhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        fieldEveningPhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        fieldAlternatePhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.touchUpInside)
        fieldAssistantPhone.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        
        
        
        fieldCategoriesRecreation.setupRightView()
        
        fieldCountry.setupRightView()
        fieldGender.setupRightView()
        fieldOwner.setupRightView()
        fieldLicenseExpiry.setupRightView()
        fieldReviewDate.setupRightView()
        fieldBirthDate.setupRightView()
        
        fieldClientSince.setupRightView()
        fieldAnniversary.setupRightView()
        fieldSpouse2.setupRightView()
        fieldMaritalStatus.setupRightView()
        fieldCompany.setupRightView()
        
        fieldExecutor.setupRightView()
        fieldPowerAtroney.setupRightView()
        fieldClientClass.setupRightView()
        
        
    }
    
    @objc func tapFunction() {
        alterphone_placeholderLabel.isHidden = true
        UserDefaults.standard.set(true, forKey: "alter") //Bool
        UserDefaults.standard.set(false, forKey: "mobile") //Bool
        fieldAlternatePhone.becomeFirstResponder()
    }
    
    @objc func tapFunction1() {
        mobilephone_placeholderLabel.isHidden = true
        UserDefaults.standard.set(true, forKey: "mobile")
        UserDefaults.standard.set(false, forKey: "alter")
        fieldMobilePhone.becomeFirstResponder()
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    @objc func textFieldDidBeginEditing(textField : UITextField) {
        
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        
    }
    func checkIfEditable(value:Bool) {
        
        if value {
            btnAddChildren.isHidden = false
            fieldBusinessExt.lineColor = UIColor.lightGray
            //            fieldEveningExt.lineColor = UIColor.lightGray
            //            fieldAlternateExt.lineColor = UIColor.lightGray
            //            fieldMobileExt.lineColor = UIColor.lightGray
            
            fieldBusinessPhone.lineColor = UIColor.lightGray
            fieldEveningPhone.lineColor = UIColor.lightGray
            fieldAlternatePhone.lineColor = UIColor.lightGray
            fieldMobilePhone.lineColor = UIColor.lightGray
            fieldEmail.lineColor = UIColor.lightGray
            fieldEmail2.lineColor = UIColor.lightGray
            fieldEmail3.lineColor = UIColor.lightGray
            fieldAssistantPhone.lineColor = UIColor.lightGray
            fieldWebsite.lineColor = UIColor.lightGray
            fieldChildrenname.lineColor = UIColor.lightGray
            fieldBusinessPhone.textColor = UIColor.black
            fieldEveningPhone.textColor = UIColor.black
            fieldAlternatePhone.textColor = UIColor.black
            fieldMobilePhone.textColor = UIColor.black
            fieldEmail.textColor = UIColor.black
            fieldEmail2.textColor = UIColor.black
            fieldEmail3.textColor = UIColor.black
            fieldAssistantPhone.textColor = UIColor.black
            fieldWebsite.textColor = UIColor.black
            fieldCategoriesRecreation.lineColor = UIColor.black
        }else{
            btnAddChildren.isHidden = true
            
            fieldChildrenname.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            
            fieldCategoriesRecreation.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldBusinessExt.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldAlternatePhone.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldMobilePhone.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldBusinessPhone.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEveningPhone.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail2.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail3.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldAssistantPhone.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldWebsite.lineColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            
            fieldBusinessPhone.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEveningPhone.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldAlternatePhone.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldMobilePhone.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail2.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldEmail3.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldAssistantPhone.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            fieldWebsite.textColor = UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            
            
        }
        
        
        fieldBusinessExt.isUserInteractionEnabled = value
        fieldChildrenname.isUserInteractionEnabled = value
        //        fieldAlternateExt.isUserInteractionEnabled = value
        //        fieldMobileExt.isUserInteractionEnabled = value
        
        fieldTitle.isUserInteractionEnabled = value
        fieldNickName.isUserInteractionEnabled = value
        fieldsuffix.isUserInteractionEnabled = value
        fieldSalutation.isUserInteractionEnabled = value
        fieldClientClass.isUserInteractionEnabled = value
        fieldLastName.isUserInteractionEnabled = value
        fieldMiddleName.isUserInteractionEnabled = value
        fieldFirstName.isUserInteractionEnabled = value
        
        fieldFtp.isUserInteractionEnabled = value
        //        fieldEmail3.isUserInteractionEnabled = value
        //        fieldWebsite.isUserInteractionEnabled = value
        //        fieldEmail.isUserInteractionEnabled = value
        //        fieldEmail2.isUserInteractionEnabled = value
        
        fieldFax.isUserInteractionEnabled = value
        fieldPager.isUserInteractionEnabled = value
        // fieldMobilePhone.isUserInteractionEnabled = value
        // fieldAlternatePhone.isUserInteractionEnabled = value
        //        fieldEveningPhone.isUserInteractionEnabled = value
        //  fieldBusinessPhone.isUserInteractionEnabled = value
        fieldCategoriesRecreation.isUserInteractionEnabled = value
        fieldPOBox.isUserInteractionEnabled = value
        fieldCountry.isUserInteractionEnabled = value
        fieldZip.isUserInteractionEnabled = value
        fieldState.isUserInteractionEnabled = value
        fieldCity.isUserInteractionEnabled = value
        fieldAddress3.isUserInteractionEnabled = value
        fieldAddress2.isUserInteractionEnabled = value
        fieldAddress1.isUserInteractionEnabled = value
        
        fieldImportantInformation.isUserInteractionEnabled = value
        fieldOwner.isUserInteractionEnabled = value
        fieldLicenseExpiry.isUserInteractionEnabled = value
        fieldReviewDate.isUserInteractionEnabled = value
        fieldGender.isUserInteractionEnabled = value
        fieldBirthDate.isUserInteractionEnabled = value
        
        //        btnPrivate.isUserInteractionEnabled = value
        fieldGovernmentID.isUserInteractionEnabled = value
        clientLicenseNumber.isUserInteractionEnabled = value
        fieldClientSince.isUserInteractionEnabled = value
        fieldAnniversary.isUserInteractionEnabled = value
        fieldFamilyDescription.isUserInteractionEnabled = value
        fieldMaritalStatus.isUserInteractionEnabled = value
        fieldSpouse2.isUserInteractionEnabled = value
        fieldSpouse.isUserInteractionEnabled = value
        
        fieldOccupationDescription.isUserInteractionEnabled = value
        //        fieldAssistantPhone.isUserInteractionEnabled = value
        fieldDepartment.isUserInteractionEnabled = value
        fieldAssistant.isUserInteractionEnabled = value
        fieldJobTitle.isUserInteractionEnabled = value
        fieldCompany.isUserInteractionEnabled = value
        fieldCompanyName.isUserInteractionEnabled = value
        fieldRecreationDescription.isUserInteractionEnabled = value
        
        fieldMoneyDescription.isUserInteractionEnabled = value
        fieldGroupInsurancePlan.isUserInteractionEnabled = value
        fieldGroupInsurance.isUserInteractionEnabled = value
        fieldPowerAtroney.isUserInteractionEnabled = value
        fieldExecutor.isUserInteractionEnabled = value
        fieldPowerName.isUserInteractionEnabled = value
        fieldExecutorName.isUserInteractionEnabled = value
        fieldCreditOnHold.isUserInteractionEnabled = value
        fieldCreditLimit.isUserInteractionEnabled = value
        fieldRevenue.isUserInteractionEnabled = value
        fieldIncome.isUserInteractionEnabled = value
    }
    @IBAction func tappedPrivate(_ sender: Any) {
        let btn:UIButton = sender as! UIButton
        if btn.currentImage == UIImage.init(named:"ic_check") {
            btn.setImage(UIImage.init(named:"ic_check_box"), for: .normal)
        }else{
            btn.setImage(UIImage.init(named:"ic_check"), for: .normal)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

