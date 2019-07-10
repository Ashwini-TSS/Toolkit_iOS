//
//  ColorHelper.swift
//  Pareto Systems
//
//  Created by Thabresh on 24/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ColorHelper: NSObject {

}
// MARK: - Extension form UIColor

extension UIColor {
    
    class func PSNavigaitonController() -> UIColor {
        return UIColor.init(red: 0.0/255.0, green: 82.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    }
    class func PSNavigaitonBlack() -> UIColor {
        return UIColor.black
    }
    class func PSNavigaitonTop() -> UIColor {
        return UIColor(rgb: 0x242D3C)
    }
    
    class func PSRed() -> UIColor {
        return UIColor(rgb: 0xCA0810)
    }
    
    class func PSLiteRed() -> UIColor {
        return UIColor(rgb: 0xD5171F)
    }
    
    class func PSBlue() -> UIColor {
        return UIColor(rgb: 0x484DE5)
    }
    
    class func PSLightGray() -> UIColor {
        return UIColor(rgb: 0xDDDDDD)
    }
    class func PSCellEvenBG() -> UIColor {
        return UIColor(rgb: 0xF1F1F1)
    }
    
    class func PSAcceptBG() -> UIColor {
        return UIColor(rgb: 0x080A66)
    }
    
    class func PSDeclineBG() -> UIColor {
        return UIColor(rgb: 0xD5171F)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
