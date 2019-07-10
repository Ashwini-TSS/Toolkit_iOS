//
//  ContactFieldsCell.swift
//  ContactsModule
//
//  Created by Test Technologies PVT LTD on 11/07/18.
//  Copyright © 2018 Test Technologies PVT LTD. All rights reserved.
//

import UIKit

class ContactFieldsCell: UITableViewCell {
    @IBOutlet weak var fieldTitle: ACFloatingTextfield!
    
    @IBOutlet weak var fieldNickName: ACFloatingTextfield!
    @IBOutlet weak var fieldsuffix: ACFloatingTextfield!
    @IBOutlet weak var fieldSalutation: ACFloatingTextfield!
    @IBOutlet weak var fieldClientClass: ACFloatingTextfield!
    @IBOutlet weak var fieldLastName: ACFloatingTextfield!
    @IBOutlet weak var fieldMiddleName: ACFloatingTextfield!
    @IBOutlet weak var fieldFirstName: ACFloatingTextfield!
    override func awakeFromNib() {
        super.awakeFromNib()
        
       fieldClientClass.setupRightView()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UITextField {
    func setupRightView(){
        self.rightView = UIImageView.init(image: UIImage.init(named:"ic_drop_down"))
        self.rightView?.frame = CGRect(x: self.frame.size.width - 40, y: 20, width: 20 , height:20)
        self.rightViewMode = .always
    }
}
