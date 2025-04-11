//
//  Uploadfilecell.swift
//  Blue Square
//
//  Created by TECNVATORS SOFTWARE on 18/10/19.
//  Copyright © 2019 VividInfotech. All rights reserved.
//

import UIKit

class Uploadfilecell: UICollectionViewCell {
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet var Attachmentlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupBasic()
    }
    
    func setupBasic() {
        Attachmentlbl.isUserInteractionEnabled = true
        Attachmentlbl.layer.masksToBounds = true
        Attachmentlbl.layer.cornerRadius = 10.0
    }
}
