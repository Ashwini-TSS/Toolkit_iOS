//
//  KeyboardHelper.swift
//  Emoji
//
//  Created by Thabresh on 11/11/17.
//  Copyright © 2017 Thabresh. All rights reserved.
//

import UIKit

let KEYBOARD_ANIMATION_DURATION : CGFloat = 0.3
let MINIMUM_SCROLL_FRACTION     : CGFloat = 0.2
let MAXIMUM_SCROLL_FRACTION     : CGFloat = 0.8
let PORTRAIT_KEYBOARD_HEIGHT    : CGFloat = 240
let LANDSCAPE_KEYBOARD_HEIGHT   : CGFloat = 140
var animatedDistance            : CGFloat = 0.0

class KeyboardHelper: NSObject {

    func BeginEditing(tf:UITextField,vc:UIViewController){
        let textFieldRect: CGRect? = vc.view.window?.convert(tf.bounds, from: tf)
        let viewRect: CGRect? = vc.view.window?.convert(vc.view.bounds, from: vc.view)
        let midline: CGFloat? = (textFieldRect?.origin.y)! + 0.5 * (textFieldRect?.size.height)!
        let numerator: CGFloat? = midline! - (viewRect?.origin.y)! - MINIMUM_SCROLL_FRACTION * (viewRect?.size.height)!
        let denominator: CGFloat? = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * (viewRect?.size.height)!
        var heightFraction: CGFloat = numerator! / denominator!
        if heightFraction < 0.0 {
            heightFraction = 0.0
        }
        else if heightFraction > 1.0 {
            heightFraction = 1.0
        }
        
        let orientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        
        if orientation == .portrait || orientation == .portraitUpsideDown {
            animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction)
        }
        else {
            animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction)
        }
        var viewFrame: CGRect = vc.view.frame
        viewFrame.origin.y -= animatedDistance
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(TimeInterval(KEYBOARD_ANIMATION_DURATION))
        vc.view.frame = viewFrame
        UIView.commitAnimations()
    }
    
    func EndEditing(tf:UITextField,vc:UIViewController){
        var viewFrame: CGRect = vc.view.frame
        viewFrame.origin.y += animatedDistance
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(TimeInterval(KEYBOARD_ANIMATION_DURATION))
        vc.view.frame = viewFrame
        UIView.commitAnimations()
    }
    
    func ShouldReturn(tf:UITextField,vc:UIViewController) -> Bool {
        let nextTag: Int = tf.tag + 1
        // Try to find next responder
        let nextResponder: UIResponder? = vc.view.viewWithTag(nextTag)
        if nextResponder != nil {
            // Found next responder, so set it.
            nextResponder?.becomeFirstResponder()
        }
        else
        {
            tf.resignFirstResponder()
        }
        // We do not want UITextField to insert line-breaks.
        return false
    }
}
