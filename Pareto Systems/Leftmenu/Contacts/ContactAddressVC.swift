//
//  ContactAddressVC.swift
//  Pareto Systems
//
//  Created by Thabresh on 18/06/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class ContactAddressVC: UITableViewController {
    @IBOutlet weak var poboxField: ACFloatingTextfield!
    
    @IBOutlet weak var ftpField: ACFloatingTextfield!
    @IBOutlet weak var websiteField: ACFloatingTextfield!
    @IBOutlet weak var emailAdds3Field: ACFloatingTextfield!
    @IBOutlet weak var emailAdds2Field: ACFloatingTextfield!
    @IBOutlet weak var emailAdds1Field: ACFloatingTextfield!
    @IBOutlet weak var postalField: ACFloatingTextfield!
    @IBOutlet weak var countryField: ACFloatingTextfield!
    @IBOutlet weak var stateField: ACFloatingTextfield!
    @IBOutlet weak var cityField: ACFloatingTextfield!
    @IBOutlet weak var adds3Field: ACFloatingTextfield!
    @IBOutlet weak var adds2Field: ACFloatingTextfield!
    @IBOutlet weak var adds1Field: ACFloatingTextfield!
    var headerTitle:[String] = ["Address","Web Addresses"]
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        if selectedContactInfo != nil {
            poboxField.text = selectedContactInfo.poBox
            ftpField.text = selectedContactInfo.ftpSiteUrl
            websiteField.text = selectedContactInfo.webSiteUrl
            emailAdds3Field.text = selectedContactInfo.eMailAddress3
            emailAdds2Field.text = selectedContactInfo.eMailAddress2
            emailAdds1Field.text = selectedContactInfo.eMailAddress1
            postalField.text = selectedContactInfo.postal
            countryField.text = selectedContactInfo.country
            stateField.text = selectedContactInfo.state
            cityField.text = selectedContactInfo.city
            adds3Field.text = selectedContactInfo.addressLine3
            adds2Field.text = selectedContactInfo.addressLine2
            adds1Field.text = selectedContactInfo.addressLine1
        }else{
            if let data = UserDefaults.standard.object(forKey: "AddressInfo") as? NSDictionary{
                print(data)
                
                poboxField.text = data.value(forKey: "PoBox") as? String
                ftpField.text = data.value(forKey: "FtpSiteUrl") as? String
                websiteField.text = data.value(forKey: "WebSiteUrl") as? String
                emailAdds3Field.text = data.value(forKey: "EMailAddress3") as? String
                emailAdds2Field.text = data.value(forKey: "EMailAddress2") as? String
                emailAdds1Field.text = data.value(forKey: "EMailAddress1") as? String
                postalField.text = data.value(forKey: "Postal") as? String
                countryField.text = data.value(forKey: "Country") as? String
                stateField.text = data.value(forKey: "State") as? String
                cityField.text = data.value(forKey: "City") as? String
                adds3Field.text = data.value(forKey: "AddressLine3") as? String
                adds2Field.text = data.value(forKey: "AddressLine2") as? String
                adds1Field.text = data.value(forKey: "AddressLine1") as? String
                
                
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 40))
        headerView.backgroundColor = UIColor.init(red: 143.0/255.0, green: 143.0/255.0, blue: 143.0/255.0, alpha: 1.0)
        
        let label = UILabel(frame: CGRect(x: 10.0, y: 0.0, width: tableView.bounds.size.width - 20, height: 30.0))
        label.text = headerTitle[section]
        headerView.addSubview(label)
        
        return headerView
    }
    @IBAction func clickedSave(_ sender: Any) {
        tappedSave()
    }
    
    func tappedSave(){
        let dataObject:NSMutableDictionary = [:]
        
        //Address
        dataObject.setValue(adds1Field.text!, forKey: "AddressLine1")
        dataObject.setValue(adds2Field.text!, forKey: "AddressLine2")
        dataObject.setValue(adds3Field.text!, forKey: "AddressLine3")
        dataObject.setValue(cityField.text!, forKey: "City")
        dataObject.setValue(stateField.text!, forKey: "State")
        dataObject.setValue(postalField.text!, forKey: "Postal")
        dataObject.setValue("", forKey: "Country")
//        dataObject.setValue(countryField.text!, forKey: "Country")

        dataObject.setValue(poboxField.text!, forKey: "PoBox")
        
        //Email Address
        dataObject.setValue(emailAdds1Field.text!, forKey: "EMailAddress1")
        dataObject.setValue(emailAdds2Field.text!, forKey: "EMailAddress2")
        dataObject.setValue(emailAdds3Field.text!, forKey: "EMailAddress3")
        dataObject.setValue(websiteField.text!, forKey: "WebSiteUrl")
        dataObject.setValue(ftpField.text!, forKey: "FtpSiteUrl")
                
        UserDefaults.standard.set(dataObject, forKey: "AddressInfo")
        self.navigationController?.popViewController(animated: true)
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
