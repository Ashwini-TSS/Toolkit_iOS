
//  AppDelegate.swift
//  Pareto Systems
//
//  Created by Thabresh on 24/05/18.
//  Copyright © 2018 Test. All rights reserved.
//
import CoreData
import UIKit
import IQKeyboardManagerSwift
var childNames:String = ""
//import FirebaseAnalytics
//import Firebase

import FirebaseCrashlytics
import FirebaseCore
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print(UIScreen.main.bounds.width)
        print(UIScreen.main.bounds.height) // 812
        IQKeyboardManager.shared.enable = true
         FirebaseApp.configure()
//        Crashlytics.sharedInstance().delegate = self
//        Fabric.with([Crashlytics.self])
        IQKeyboardManager.shared.disabledDistanceHandlingClasses.append(ContactViewEditController.self)
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            print(countryCode)
            let Extensionnumber = getCountryPhonceCode(countryCode)
            UserDefaults.standard.set(Extensionnumber, forKey: "Extension")
        }
        
        //Setup HUD
        //        SVProgressHUD.setDefaultStyle(.dark)
        // SVProgressHUD.setDefaultMaskType(.black)
        // SVProgressHUD.setDefaultAnimationType(.native)
        
        //UINavigationBar.appearance().barTintColor = UIColor.PSNavigaitonTop()
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
        UserDefaults.standard.setValue(false, forKey: "Goday")
//        guard let logout = UserDefaults.standard.value(forKey: "Logout") as? Bool else
//        {
//            return true
//        }
//        if(!logout)
//        {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            NotificationCenter.default.removeObserver(self)
//
//            let mainViewController = storyboard.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
//            
//            let leftViewController = storyboard.instantiateViewController(withIdentifier: "MenuController") as! MenuController
//            
//            
//            mainViewController.setNavigationBarItem()
//            
//            let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
//            nvc.navigationBar.tintColor = UIColor.white
//            
//            leftViewController.mainViewController = nvc
//            
//            let slide = ExSlideMenu(mainViewController: nvc, leftMenuViewController: leftViewController)
//            self.window?.rootViewController = slide
//            self.window?.makeKeyAndVisible()
//        }
        
        //    setStatusBarBackgroundColor(color: UIColor.black)
        // Override point for customization after application launch.
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    
   
    func getCountryPhonceCode (_ country : String) -> String
    {
        var countryDictionary  = ["AF":"+93",
                                  "AL":"+355",
                                  "DZ":"+213",
                                  "AS":"+1",
                                  "AD":"+376",
                                  "AO":"+244",
                                  "AI":"+1",
                                  "AG":"+1",
                                  "AR":"+54",
                                  "AM":"+374",
                                  "AW":"+297",
                                  "AU":"+61",
                                  "AT":"+43",
                                  "AZ":"+994",
                                  "BS":"+1",
                                  "BH":"+973",
                                  "BD":"+880",
                                  "BB":"+1",
                                  "BY":"+375",
                                  "BE":"+32",
                                  "BZ":"+501",
                                  "BJ":"+229",
                                  "BM":"+1",
                                  "BT":"+975",
                                  "BA":"+387",
                                  "BW":"+267",
                                  "BR":"+55",
                                  "IO":"+246",
                                  "BG":"+359",
                                  "BF":"+226",
                                  "BI":"+257",
                                  "KH":"+855",
                                  "CM":"+237",
                                  "CA":"+1",
                                  "CV":"+238",
                                  "KY":"+345",
                                  "CF":"+236",
                                  "TD":"+235",
                                  "CL":"+56",
                                  "CN":"+86",
                                  "CX":"+61",
                                  "CO":"+57",
                                  "KM":"+269",
                                  "CG":"+242",
                                  "CK":"+682",
                                  "CR":"+506",
                                  "HR":"+385",
                                  "CU":"+53",
                                  "CY":"+537",
                                  "CZ":"+420",
                                  "DK":"+45",
                                  "DJ":"+253",
                                  "DM":"+1",
                                  "DO":"+1",
                                  "EC":"+593",
                                  "EG":"+20",
                                  "SV":"+503",
                                  "GQ":"+240",
                                  "ER":"+291",
                                  "EE":"+372",
                                  "ET":"+251",
                                  "FO":"+298",
                                  "FJ":"+679",
                                  "FI":"+358",
                                  "FR":"+33",
                                  "GF":"+594",
                                  "PF":"+689",
                                  "GA":"+241",
                                  "GM":"+220",
                                  "GE":"+995",
                                  "DE":"+49",
                                  "GH":"+233",
                                  "GI":"+350",
                                  "GR":"+30",
                                  "GL":"+299",
                                  "GD":"+1",
                                  "GP":"+590",
                                  "GU":"+1",
                                  "GT":"+502",
                                  "GN":"+224",
                                  "GW":"+245",
                                  "GY":"+595",
                                  "HT":"+509",
                                  "HN":"+504",
                                  "HU":"+36",
                                  "IS":"+354",
                                  "IN":"+91",
                                  "ID":"+62",
                                  "IQ":"+964",
                                  "IE":"+353",
                                  "IL":"+972",
                                  "IT":"+39",
                                  "JM":"+1",
                                  "JP":"+81",
                                  "JO":"+962",
                                  "KZ":"+77",
                                  "KE":"+254",
                                  "KI":"+686",
                                  "KW":"+965",
                                  "KG":"+996",
                                  "LV":"+371",
                                  "LB":"+961",
                                  "LS":"+266",
                                  "LR":"+231",
                                  "LI":"+423",
                                  "LT":"+370",
                                  "LU":"+352",
                                  "MG":"+261",
                                  "MW":"+265",
                                  "MY":"+60",
                                  "MV":"+960",
                                  "ML":"+223",
                                  "MT":"+356",
                                  "MH":"+692",
                                  "MQ":"+596",
                                  "MR":"+222",
                                  "MU":"+230",
                                  "YT":"+262",
                                  "MX":"+52",
                                  "MC":"+377",
                                  "MN":"+976",
                                  "ME":"+382",
                                  "MS":"+1",
                                  "MA":"+212",
                                  "MM":"+95",
                                  "NA":"+264",
                                  "NR":"+674",
                                  "NP":"+977",
                                  "NL":"+31",
                                  "AN":"+599",
                                  "NC":"+687",
                                  "NZ":"+64",
                                  "NI":"+505",
                                  "NE":"+227",
                                  "NG":"+234",
                                  "NU":"+683",
                                  "NF":"+672",
                                  "MP":"+1",
                                  "NO":"+47",
                                  "OM":"+968",
                                  "PK":"+92",
                                  "PW":"+680",
                                  "PA":"+507",
                                  "PG":"+675",
                                  "PY":"+595",
                                  "PE":"+51",
                                  "PH":"+63",
                                  "PL":"+48",
                                  "PT":"+351",
                                  "PR":"+1",
                                  "QA":"+974",
                                  "RO":"+40",
                                  "RW":"+250",
                                  "WS":"+685",
                                  "SM":"+378",
                                  "SA":"+966",
                                  "SN":"+221",
                                  "RS":"+381",
                                  "SC":"+248",
                                  "SL":"+232",
                                  "SG":"+65",
                                  "SK":"+421",
                                  "SI":"+386",
                                  "SB":"+677",
                                  "ZA":"+27",
                                  "GS":"+500",
                                  "ES":"+34",
                                  "LK":"+94",
                                  "SD":"+249",
                                  "SR":"+597",
                                  "SZ":"+268",
                                  "SE":"+46",
                                  "CH":"+41",
                                  "TJ":"+992",
                                  "TH":"+66",
                                  "TG":"+228",
                                  "TK":"+690",
                                  "TO":"+676",
                                  "TT":"+1",
                                  "TN":"+216",
                                  "TR":"+90",
                                  "TM":"+993",
                                  "TC":"+1",
                                  "TV":"+688",
                                  "UG":"+256",
                                  "UA":"+380",
                                  "AE":"+971",
                                  "GB":"+44",
                                  "US":"+1",
                                  "UY":"+598",
                                  "UZ":"+998",
                                  "VU":"+678",
                                  "WF":"+681",
                                  "YE":"+967",
                                  "ZM":"+260",
                                  "ZW":"+263",
                                  "BO":"+591",
                                  "BN":"+673",
                                  "CC":"+61",
                                  "CD":"+243",
                                  "CI":"+225",
                                  "FK":"+500",
                                  "GG":"+44",
                                  "VA":"+379",
                                  "HK":"+852",
                                  "IR":"+98",
                                  "IM":"+44",
                                  "JE":"+44",
                                  "KP":"+850",
                                  "KR":"+82",
                                  "LA":"+856",
                                  "LY":"+218",
                                  "MO":"+853",
                                  "MK":"+389",
                                  "FM":"+691",
                                  "MD":"+373",
                                  "MZ":"+258",
                                  "PS":"+970",
                                  "PN":"+872",
                                  "RE":"+262",
                                  "RU":"+7",
                                  "BL":"+590",
                                  "SH":"+290",
                                  "KN":"+1",
                                  "LC":"+1",
                                  "MF":"+590",
                                  "PM":"+508",
                                  "VC":"+1",
                                  "ST":"+239",
                                  "SO":"+252",
                                  "SJ":"+47",
                                  "SY":"+963",
                                  "TW":"+886",
                                  "TZ":"+255",
                                  "TL":"+670",
                                  "VE":"+58",
                                  "VN":"+84",
                                  "VG":"+284",
                                  "VI":"+340"]
        if countryDictionary[country] != nil {
            print(countryDictionary[country]!)
            return countryDictionary[country]!
        }
            
        else {
            return ""
        }
        
    }
    
    
    func setStatusBarBackgroundColor(color: UIColor) {
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        
        statusBar.backgroundColor = color
        
        statusBar.tintColor = UIColor.white
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        //        UIApplication.shared.ba
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        return false
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "BlueSquare")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

