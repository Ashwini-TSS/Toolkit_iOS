//
//  NavigationHelper.swift
//  Pareto Systems
//
//  Created by Thabresh on 24/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
//
//private let KEYBOARD_ANIMATION_DURATION : CGFloat = 0.2
//private let MINIMUM_SCROLL_FRACTION : CGFloat = 0.4
//private let MAXIMUM_SCROLL_FRACTION : CGFloat = 1.0
//private let PORTRAIT_KEYBOARD_HEIGHT : CGFloat = 240
//private let LANDSCAPE_KEYBOARD_HEIGHT : CGFloat = 140
//var animatedDistance : CGFloat = 0.0

var addPreviousControllers:NSMutableArray = []
var toolkitHelper:Bool = false

class NavigationHelper: NSObject {

    var items: [[DropdownItem]]!
    var showSection: Bool = true
    var selectedRow: Int = 0
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    
    func setupScreen(vc:UIViewController) {
        print(vc.restorationIdentifier as Any)

        if vc.restorationIdentifier == "CalendarController" {
            //Calendar
            if addPreviousControllers.contains("Calendar"){
                addPreviousControllers.remove("Calendar")
                addPreviousControllers.insert("Calendar", at: 0)
            }else{
                addPreviousControllers.insert("Calendar", at: 0)
            }
            return
        }
        if vc.navigationItem.title == "" {
            if addPreviousControllers.contains("Dashboard"){
                addPreviousControllers.remove("Dashboard")
                addPreviousControllers.insert("Dashboard", at: 0)
            }else{
                addPreviousControllers.insert("Dashboard", at: 0)
            }
            return
        }
        
        if addPreviousControllers.contains(vc.navigationItem.title as Any){
            addPreviousControllers.remove(vc.navigationItem.title as Any)
            addPreviousControllers.insert(vc.navigationItem.title as Any, at: 0)
        }else{
            addPreviousControllers.insert(vc.navigationItem.title as Any, at: 0)
        }
    }

    func setupBarSqureImage() -> UIView {
        
        let boxView = UIView()
        boxView.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        boxView.layer.borderColor = UIColor.white.cgColor
        boxView.layer.cornerRadius = 5.0
        boxView.layer.borderWidth = 1.0
        boxView.backgroundColor = UIColor.clear
        
        let insideText = UILabel()
        insideText.textAlignment = .center
        insideText.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        insideText.text = "\(addPreviousControllers.count)"
        insideText.textColor = UIColor.white
        insideText.backgroundColor = UIColor.clear
        boxView.addSubview(insideText)
        
        return UIView()
    }
    
    func createMenuView() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "DashboardController") as! DashboardController
        
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "MenuController") as! MenuController
        
        
        mainViewController.setNavigationBarItem()
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        nvc.navigationBar.tintColor = UIColor.white
        
        leftViewController.mainViewController = nvc
        
        let slide = ExSlideMenu(mainViewController: nvc, leftMenuViewController: leftViewController)
        appDelegate.window?.rootViewController = slide
        appDelegate.window?.makeKeyAndVisible()
    }
    func setRootViewController(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        nvc.navigationBar.tintColor = UIColor.white
        appDelegate.window?.rootViewController = nvc
        appDelegate.window?.makeKeyAndVisible()
        
    }
    func setupCalanderMenuView() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        NotificationCenter.default.removeObserver(self)

        let mainViewController = storyboard.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
        
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "MenuController") as! MenuController
        
        
        mainViewController.setNavigationBarItem()
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        nvc.navigationBar.tintColor = UIColor.white
        
        leftViewController.mainViewController = nvc
        
        let slide = ExSlideMenu(mainViewController: nvc, leftMenuViewController: leftViewController)
        appDelegate.window?.rootViewController = slide
        appDelegate.window?.makeKeyAndVisible()
    }
    func setupRootViewController(senderVC:UIViewController,title:String){
        var identfier:String = ""
        var fromAccounts:Bool = false
        
        if title == "Dashboard" {
            identfier = "DashboardController"
        }else if title == "Settings" {
            identfier = "SettingsContoller"
        }else if title == "Calendar" {
            identfier = "CalendarController"
        }else if title == "Contacts" {
            identfier = "AllContactsCoontroller"
        }else if title == "Accounts" {
            fromAccounts = true
            identfier = "AllContactsCoontroller"
        }else if title == "Processes" {
            identfier = "ProcessesController"
        }else if title == "Services" {
            identfier = "ServicesController"
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: identfier) as? AllContactsCoontroller {
            vc.fromAccounts = fromAccounts
            let leftViewController = storyboard.instantiateViewController(withIdentifier: "MenuController") as! MenuController
            
            
            vc.setNavigationBarItem()
            
            let nvc: UINavigationController = UINavigationController(rootViewController: vc)
            nvc.navigationBar.tintColor = UIColor.white
            
            leftViewController.mainViewController = nvc
            
            let slide = ExSlideMenu(mainViewController: nvc, leftMenuViewController: leftViewController)
            appDelegate.window?.rootViewController = slide
            appDelegate.window?.makeKeyAndVisible()
            return
        }
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: identfier)
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "MenuController") as! MenuController
        
        
        mainViewController.setNavigationBarItem()
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        nvc.navigationBar.tintColor = UIColor.white
        
        leftViewController.mainViewController = nvc
        
        let slide = ExSlideMenu(mainViewController: nvc, leftMenuViewController: leftViewController)
        appDelegate.window?.rootViewController = slide
        appDelegate.window?.makeKeyAndVisible()
        
        setupNavigation()

//        DispatchQueue.main.async {
//            if let vc = senderVC.storyboard?.instantiateViewController(withIdentifier: identfier) as? AllContactsCoontroller {
//                vc.fromAccounts = fromAccounts
//                let navVC = UINavigationController(rootViewController: vc)
//                //            navVC.navigationBar.tintColor = UIColor.white
//                                navVC.setNavigationBarItem()
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                appDelegate.window?.rootViewController = navVC
//
//                return
//            }
//            let vc = senderVC.storyboard?.instantiateViewController(withIdentifier: identfier)
//            let navVC = UINavigationController(rootViewController: vc!)
////            navVC.navigationBar.tintColor = UIColor.white
//                            navVC.setNavigationBarItem()
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = navVC
//        }
    }
    func setupNavigation(){
        UINavigationBar.appearance().barTintColor = UIColor.PSNavigaitonBlack()
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        
        let yourBackImage = UIImage(named: "ic_back_arrow")
        UINavigationBar.appearance().tintColor = .white//.blue as you required
        UINavigationBar.appearance().backIndicatorImage = yourBackImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = yourBackImage
        UINavigationBar.appearance().topItem?.title = "      "
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: UIControlState.highlighted)
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for:UIBarMetrics.default)
    }
    static func showSimpleAlert(message:String) {
        DispatchQueue.main.async(execute: {
            AJAlertController.initialization().showAlertWithOkButton(aStrMessage: message) { (index, title) in
                print(index,title)
            }
        })
    }
    static func USPhoneFormat(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var mask = "XXX-XXX-XXXX"
        
//        var mask = "XXX-XXX XXXX"
        //+1 (450) 878-0987
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask.characters {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
extension UIViewController {
    
    
    func setNavigationBarItem() {
        
        self.addLeftBarButtonWithImage(UIImage.init(named:"ic_side_menu")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }
    
    func setRightNavigationBarItem() {
        self.addRightBarButtonWithImage(#imageLiteral(resourceName: "ic_menu"))
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    func setAdditionalNavigation(title : String)
    {
        // self.addAdditionalLeftBarButtonWithImage(UIImage(named: "ic_menu")! ,NavigationTitle : title)
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
    
    func removeSlideNavigation() {
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
    }
}
extension UIView {
    
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
}
