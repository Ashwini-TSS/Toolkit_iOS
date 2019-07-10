//
//  SettingsContoller.swift
//  Pareto Systems
//
//  Created by Thabresh on 29/05/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class SettingsContoller: UITableViewController {

    var items: [[DropdownItem]]!
    var showSection: Bool = true
    var selectedRow: Int = 0
    var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    @IBOutlet weak var btnDropDown: UIBarButtonItem!
    var isFromDashboard:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isFromDashboard{
            self.setNavigationBarItem()
        }
        self.title = "Settings"
        tableView.tableFooterView = UIView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
//        NavigationHelper().setupScreen(vc: self)

//        let tabView = NavigationHelper().setupBarSqureImage()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            let setupImage:UIImage = tabView.takeScreenshot()
//            self.btnDropDown.image = setupImage
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tappedTab(_ sender: Any) {
        
        if addPreviousControllers.count > 0 {
//            var menuView: DropdownMenu?
//            let addItems:NSMutableArray = []
//            
//            for index in 0..<addPreviousControllers.count {
//                let item1 = DropdownItem(title: addPreviousControllers[index] as! String)
//                addItems.add(item1)
//            }
//            items = [addItems] as! [[DropdownItem]]
//            menuView = DropdownMenu(navigationController: navigationController!, items: addItems as! [DropdownItem], selectedRow: 10)
//            
//            menuView?.topOffsetY = CGFloat(0.0)
//            //menuView?.separatorStyle = .none
//            menuView?.zeroInsetSeperatorIndexPaths = [IndexPath(row: 1, section: 0)]
//            menuView?.delegate = self
//            menuView?.rowHeight = 50
//            menuView?.showMenu()
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 2){
            return 0
        }
        return 50
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let controller:ToolkitPackagesController = self.storyboard?.instantiateViewController(withIdentifier: "ToolkitPackagesController") as! ToolkitPackagesController
            self.navigationController?.pushViewController(controller
                , animated: true)
        }
        if indexPath.row == 4 {
            let controller:ContactsUsViewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "ContactsUsViewcontroller") as! ContactsUsViewcontroller
            self.navigationController?.pushViewController(controller
                , animated: true)
        }
        if indexPath.row == 5 {
            UserDefaults.standard.set(true, forKey: "Logout")
            NavigationHelper().setRootViewController()
        }
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SettingsContoller: DropdownMenuDelegate {
    func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        print("DropdownMenu didselect \(indexPath.row) text:\(items[indexPath.section][indexPath.row].title)")
        if indexPath.row != items.count - 1 {
            self.selectedRow = indexPath.row
        }
        
        let indexTitle:String = "\(items[indexPath.section][indexPath.row].title)"
        print(indexTitle)
        NavigationHelper().setupRootViewController(senderVC: self, title: indexTitle)
        
        
        
    }
}

