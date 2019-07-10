//
//  LeftmenuController.swift
//  Pareto Systems
//
//  Created by Thabresh on 24/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import SSCalendar

class LeftmenuController: UIViewController {

    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var tblItems: UITableView!
    var mainViewController   : UIViewController!
    
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.removeObject(forKey: "filterarray")
        tblItems.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblUsername.text = currentUserName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedSettings(_ sender: Any) {
        setupNavigation()

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsContoller") as! SettingsContoller
        let nvc: UINavigationController = UINavigationController(rootViewController: vc)
        self.slideMenuController()?.changeMainViewController(nvc, close: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LeftmenuController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if sectionNames.count > 0 {
            tableView.backgroundView = nil
            return sectionNames.count
        } else {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
            messageLabel.text = "Retrieving data.\nPlease wait."
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont(name: "Raleway-Bold", size: 17.0)!
            messageLabel.sizeToFit()
            self.tblItems.backgroundView = messageLabel;
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            let arrayOfItems = sectionItems[section] as! NSArray
            return arrayOfItems.count;
        } else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if (sectionNames.count != 0) {
//            return sectionNames[section] as? String
//        }
        return ""
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 63.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //recast your view as a UITableViewHeaderFooterView
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor.PSNavigaitonTop()
        header.textLabel?.textColor = UIColor.white
        
        let headerFrame = self.view.frame.size

        let seperatorLine = UILabel(frame: CGRect(x: 0, y: 62.0, width: headerFrame.width, height: 1));
        seperatorLine.backgroundColor = UIColor.white
        header.contentView.addSubview(seperatorLine)
        
        let imageViewGame = UIImageView(frame: CGRect(x: 10.0, y: 18, width: 30, height: 30));
        let image = UIImage(named: (sectionImages[section] as? String)!)
        imageViewGame.image = image;
        header.contentView.addSubview(imageViewGame)
        
        let headerTitle = UILabel()
        headerTitle.frame = CGRect(x: 48.0, y: 18, width: headerFrame.width - 30, height: 30)
        headerTitle.text = sectionNames[section] as? String
        headerTitle.textColor = UIColor.white
        header.contentView.addSubview(headerTitle)

        if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
            viewWithTag.removeFromSuperview()
        }
        let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 32, y: 18, width: 26, height: 26));
        theImageView.image = UIImage(named: "ic_right_black_arrow")
        theImageView.tag = kHeaderSectionTag + section
        header.addSubview(theImageView)
        
        // make headers touchable
        header.tag = section
        let headerTapGesture = UITapGestureRecognizer()
        headerTapGesture.addTarget(self, action: #selector(sectionHeaderWasTouched(_:)))
        header.addGestureRecognizer(headerTapGesture)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuCell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        let section = sectionItems[indexPath.section] as! NSArray
        cell.itemTitle.text = section[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Expand / Collapse Methods
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! UITableViewHeaderFooterView
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!)
            } else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                tableViewExpandSection(section, imageView: eImageView!)
            }
        }
    }
    
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
        let sectionData = sectionItems[section] as! NSArray
        
        self.expandedSectionHeaderNumber = -1;
        if (sectionData.count == 0) {
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            tblItems.beginUpdates()
            tblItems.deleteRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            tblItems.endUpdates()
        }
    }
    fileprivate func generateEvents() -> [SSEvent] {
        var events: [SSEvent] = []
        for year in 2016...2017 {
            // for _ in 1...200 {
            events.append(generateEvent(year));
            // }
        }
        return events
    }
    
    fileprivate func generateEvent(_ year: Int) -> SSEvent {
        let event = SSEvent()
        event.startDate = SSCalendarUtils.date(withYear: 2019, month: 05, day: 01)
        event.startTime = "09:00"
        event.name = "Example Event"
        event.desc = "Details of the event"
        return event
    }
    func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
        let sectionData = sectionItems[section] as! NSArray
        
        if (sectionData.count == 0) {
            self.expandedSectionHeaderNumber = -1;
            if section == 0 {
//                NotificationCenter.default.removeObserver(self)
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
//                let nvc: UINavigationController = UINavigationController(rootViewController: vc)
//                self.slideMenuController()?.changeMainViewController(nvc, close: true)
                NavigationHelper().createMenuView()

            }else if section == 1 {
                setupNavigation()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllContactsCoontroller") as! AllContactsCoontroller
                vc.fromAccounts = false
                let nvc: UINavigationController = UINavigationController(rootViewController: vc)
                self.slideMenuController()?.changeMainViewController(nvc, close: true)
            }else if section == 2 {
                setupNavigation()

                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllContactsCoontroller") as! AllContactsCoontroller
                vc.fromAccounts = true
                let nvc: UINavigationController = UINavigationController(rootViewController: vc)
                self.slideMenuController()?.changeMainViewController(nvc, close: true)
            }else if section == 3 {
                setupNavigation()

                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProcessesController") as! ProcessesController
                let nvc: UINavigationController = UINavigationController(rootViewController: vc)
                self.slideMenuController()?.changeMainViewController(nvc, close: true)
            }else if section == 4 {
                setupNavigation()

                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ServicesController") as! ServicesController
                let nvc: UINavigationController = UINavigationController(rootViewController: vc)
                self.slideMenuController()?.changeMainViewController(nvc, close: true)
            }
            return;
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                imageView.transform = CGAffineTransform(rotationAngle: (90.0 * CGFloat(Double.pi)) / 180.0)
            })
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            tblItems.beginUpdates()
            tblItems.insertRows(at: indexesPath, with: UITableViewRowAnimation.fade)
            tblItems.endUpdates()
        }
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
}
