//
//  ExSlideMenu.swift
//  FrenchCookies
//
//  Created by Thabresh on 13/05/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class ExSlideMenu: SlideMenuController {
    
//    override func isTagetViewController() -> Bool {
//        if UIApplication.topViewController() != nil {
////            if vc is CalendarController ||
////                vc is contactsController ||
////                vc is ProcessesController ||
////                vc is ServicesController {
////                return true
////            }
//
//        }
//        return false
//    }
    
    override func isTagetViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc is DashboardController ||
                vc is AllContactsCoontroller ||
                vc is ProcessesController ||
                vc is ServicesController ||
                vc is CalendarController ||
                vc is SettingsContoller{
                return true
            }
        }
        return false
    }
 }

extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        if let slide = viewController as? SlideMenuController {
            return topViewController(slide.mainViewController)
        }
        return viewController
    }
}

