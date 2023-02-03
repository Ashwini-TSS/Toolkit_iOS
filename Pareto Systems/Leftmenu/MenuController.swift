//
//  MenuController.swift
//  Blue Square
//
//  Created by Thabu on 23/10/18.
//  Copyright © 2018 VividInfotech. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {

    var mainViewController   : UIViewController!

    @IBOutlet weak var lblOrgName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        lblOrgName.text = currentUserName

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 5 || indexPath.row == 6){
            return 0
        }
        else if indexPath.row == 0{
            return 220
        }
        return 61
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
//            NotificationCenter.default.removeObserver(self)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
            let nvc: UINavigationController = UINavigationController(rootViewController: vc)
            self.slideMenuController()?.changeMainViewController(nvc, close: true)
        }
        else if indexPath.row == 2 {
         setupNavigation()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TaskListViewController") as! TaskListViewController
            let nvc: UINavigationController = UINavigationController(rootViewController: vc)
            self.slideMenuController()?.changeMainViewController(nvc, close: true)
            
        }else if indexPath.row == 3 {
            setupNavigation()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllContactsCoontroller") as! AllContactsCoontroller
            vc.fromAccounts = false
            let nvc: UINavigationController = UINavigationController(rootViewController: vc)
            self.slideMenuController()?.changeMainViewController(nvc, close: true)
        }else if indexPath.row == 4 {
            setupNavigation()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllContactsCoontroller") as! AllContactsCoontroller
            vc.fromAccounts = true
            let nvc: UINavigationController = UINavigationController(rootViewController: vc)
            self.slideMenuController()?.changeMainViewController(nvc, close: true)
        }
//        }else if indexPath.row == 5 {
//            setupNavigation()
//
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProcessesController") as! ProcessesController
//            let nvc: UINavigationController = UINavigationController(rootViewController: vc)
//            self.slideMenuController()?.changeMainViewController(nvc, close: true)
//        }else if indexPath.row == 6 {
//            setupNavigation()
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ServicesController") as! ServicesController
//            let nvc: UINavigationController = UINavigationController(rootViewController: vc)
//            self.slideMenuController()?.changeMainViewController(nvc, close: true)
//
//        }
        else if indexPath.row == 7 {
            setupNavigation()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsContoller") as! SettingsContoller
            let nvc: UINavigationController = UINavigationController(rootViewController: vc)
            self.slideMenuController()?.changeMainViewController(nvc, close: true)
        }
        else if indexPath.row == 8 {
            setupNavigation()
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TeammembersystemVC") as! TeammembersystemVC
            let nvc: UINavigationController = UINavigationController(rootViewController: vc)
            self.slideMenuController()?.changeMainViewController(nvc, close: true)
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
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
