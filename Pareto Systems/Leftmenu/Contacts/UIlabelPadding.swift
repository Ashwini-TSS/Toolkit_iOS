//
//  UIlabelPadding.swift
//  Blue Square
//
//  Created by Sayeed Syed on 11/26/19.
//  Copyright © 2019 VividInfotech. All rights reserved.
//

import Foundation
class UILabelPadding: UILabel {
    
    let padding = UIEdgeInsets(top: 8, left:8, bottom: 8, right: 8)
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 8.0, dy: 8.0))
    }
    
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
}

