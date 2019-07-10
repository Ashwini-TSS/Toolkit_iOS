//
//  OtherContactCell.swift
//  ContactsModule
//
//  Created by Test Technologies PVT LTD on 11/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class OtherContactCell: UITableViewCell {

    @IBOutlet weak var fieldDescription: UITextView!
    @IBOutlet weak var fieldOwner: ACFloatingTextfield!
    @IBOutlet weak var fieldLicenseExpiry: ACFloatingTextfield!
    @IBOutlet weak var fieldReviewDate: ACFloatingTextfield!
    @IBOutlet weak var fieldGender: ACFloatingTextfield!
    @IBOutlet weak var fieldBirthDate: ACFloatingTextfield!
    
    @IBOutlet weak var btnPrivate: UIButton!
    @IBOutlet weak var fieldGovernmentID: ACFloatingTextfield!
    @IBOutlet weak var clientLicenseNumber: ACFloatingTextfield!
    @IBOutlet weak var fieldClientSince: ACFloatingTextfield!
    @IBOutlet weak var fieldAnniversary: ACFloatingTextfield!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fieldGender.setupRightView()
        fieldOwner.setupRightView()
        fieldLicenseExpiry.setupRightView()
        fieldReviewDate.setupRightView()
        fieldBirthDate.setupRightView()

        fieldClientSince.setupRightView()
        fieldAnniversary.setupRightView()
        
        // Initialization code
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
