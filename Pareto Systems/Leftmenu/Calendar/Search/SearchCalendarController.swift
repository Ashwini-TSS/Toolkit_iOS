//
//  SearchCalendarController.swift
//  Pareto Systems
//
//  Created by Test Technologies PVT LTD on 26/07/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class SearchCalendarController: UITableViewController,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var getCalendarActivityList:[GetCalendarListActivity] = []
    var appointmentResults:[GetAppointmentTypesResult] = []
    var appointmentIDList:NSMutableArray = []
    var appointmentColorList:NSMutableArray = []
    var searchTapped:Bool = false
    var searchActivity:[GetCalendarListActivity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchTapped = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchBar.text as Any)
        print(searchText)
        
        let arr = getCalendarActivityList.filter {
            $0.activity.subject.range(of: searchText, options: .caseInsensitive) != nil
        }
        searchActivity = arr
        print(arr)
        
        
        if searchBar.text?.count == 0 {
            searchTapped = false
        }else{
            searchTapped = true
        }
        tableView.reloadData()
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if searchTapped {
            return searchActivity.count
        }
        return getCalendarActivityList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SearchCalendarCell = tableView.dequeueReusableCell(withIdentifier: "SearchCalendarCell", for: indexPath) as! SearchCalendarCell
        if searchTapped {

            let result:GetCalendarListActivity = searchActivity[indexPath.section].activity
            
            cell.lblTitle.text = result.subject
            cell.lblDescription.text = result.descriptionField
            
            cell.fromTime.text = result.startTime.converTimeToString()
            if result.DueTime != nil {
                cell.toTime.text = result.DueTime.converTimeToString()
            }else if result.endTime != nil {
                cell.toTime.text = result.endTime.converTimeToString()
            }else{
                cell.toTime.text = ""
            }
            cell.lblTitle.backgroundColor = UIColor.clear
            if result.appointmentTypeId != nil {
                if self.appointmentIDList.contains(result.appointmentTypeId) {
                    let getIndex = self.appointmentIDList.index(of: result.appointmentTypeId)
                    cell.lblTitle.backgroundColor = UIColor.init(hexString: "#\(self.appointmentColorList[getIndex] as! String)")
                }
                
            }
            return cell
        }
        let result:GetCalendarListActivity = getCalendarActivityList[indexPath.section].activity

        cell.lblTitle.text = result.subject
        cell.lblDescription.text = result.descriptionField

        cell.fromTime.text = result.startTime.converTimeToString()
        if result.DueTime != nil {
            cell.toTime.text = result.DueTime.converTimeToString()
        }else if result.endTime != nil {
            cell.toTime.text = result.endTime.converTimeToString()
        }else{
             cell.toTime.text = ""
        }
        cell.lblTitle.backgroundColor = UIColor.clear
        if result.appointmentTypeId != nil {
            if self.appointmentIDList.contains(result.appointmentTypeId) {
                let getIndex = self.appointmentIDList.index(of: result.appointmentTypeId)
                cell.lblTitle.backgroundColor = UIColor.init(hexString: "#\(self.appointmentColorList[getIndex] as! String)")
            }
            
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchTapped {
            let getType:String = searchActivity[indexPath.section].type
            let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: searchActivity[indexPath.section].toDictionary())
            if getType == "Task" {
                let controller:UpdatenewtaskVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewtaskVC") as? UpdatenewtaskVC)!
                controller.openedActivties = getAddress
                self.navigationController?.pushViewController(controller, animated: true)
            }else if getType == "Appointment" || getAddress.type == "Appointments" {
                let controller:UpdatenewappointmentVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewappointmentVC") as? UpdatenewappointmentVC)!
                controller.EditCondition = "calendar"
                controller.openedActivties = getAddress
                self.navigationController?.pushViewController(controller, animated: true)
            }
            return
        }
        let getType:String = getCalendarActivityList[indexPath.section].type
        let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: getCalendarActivityList[indexPath.section].toDictionary())
        if getType == "Task" {
            let controller:UpdatenewtaskVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewtaskVC") as? UpdatenewtaskVC)!
            controller.openedActivties = getAddress
            self.navigationController?.pushViewController(controller, animated: true)
        }else if getType == "Appointment" || getAddress.type == "Appointments" {
            let controller:UpdatenewappointmentVC = (self.storyboard?.instantiateViewController(withIdentifier: "UpdatenewappointmentVC") as? UpdatenewappointmentVC)!
            controller.EditCondition = "calendar"
            controller.openedActivties = getAddress
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let lightView = UILabel()
        lightView.frame = CGRect(x: 0.0, y: 0.0, width: tableView.frame.size.width, height: 35.0)
        lightView.backgroundColor = UIColor.lightGray
        
        if searchTapped {
            let result:GetCalendarListActivity = searchActivity[section].activity
            lightView.text = "  \(result.startTime.converDateDayToString())"
        }else{
            let result:GetCalendarListActivity = getCalendarActivityList[section].activity
            lightView.text = "  \(result.startTime.converDateDayToString())"
        }
        lightView.textColor = UIColor.black
        
        
       
        return lightView
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
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
