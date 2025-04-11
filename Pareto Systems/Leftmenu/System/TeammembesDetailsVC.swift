//
//  TeammembesDetailsVC.swift
//  Blue Square
//
//  Created by Sayeed Syed on 3/26/20.
//  Copyright © 2020 VividInfotech. All rights reserved.
//

import UIKit
import CoreLocation

class TeammembesDetailsVC: UIViewController,URLSessionDelegate,UIGestureRecognizerDelegate{
    
    
    
    var latitude : Double! = 0.0
    var longitutude : Double! = 0.0

    @IBOutlet weak var bottomSpaceTableView: NSLayoutConstraint!
    @IBOutlet weak var linkurlTxtview: UITextView!
    @IBOutlet weak var headerurl: UILabel!
    @IBOutlet weak var emailurl: UILabel!
    var ArrayEmail : NSMutableArray!
    var firstname : String = ""
    var lastname : String = ""
    var emailaddress : String = ""
    var jobtitle : String = ""
    var mobileno : String = ""
    var addressline : String = ""
    var selectedId : String = ""
    var department : String = ""
    var assistantID : String = ""
    var teamMemberPicture : String = ""
    var addressLine2 : String = ""
    var addressLine3 : String = ""
    var city : String = ""
    var stateProvince : String = ""
    var postalCode : String = ""
    var country : String = ""
    var website : String = ""
    var mainPhone : String = ""
    var sedondaryPhone : String = ""
    var timeZone : String = ""
    var assistantName : String = ""
    var connID : String = ""
    var copyEmail : String = ""
    var copyPhoneNumber : String = ""
    var copySecondaryPhone : String = ""
    var bccObj : BCCTrackingModal!
    @IBOutlet weak var membersTableview: UITableView!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    var tablelsit = ["First Name", "Last Name", "Email Address", "Job Title","Department","Assistant","Team Member Picture", "Address Line 1","Address Line 2","Address Line 3","City","State / Province","Postal Code","Country","Website","Main Phone", "Secondary Phone","Time Zone"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.membersTableview.delegate = self
//        self.membersTableview.dataSource = self
//        self.membersTableview.reloadData()
        self.Getteammeberslist()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        latitude = 0.0
        longitutude = 0.0
    }
    @IBAction func backBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    func toGetBCCTrackingEmailAddress()
    {
        let json: [String: Any] = ["PassKey": passKey]
        
        OperationQueue.main.addOperation {
            SVProgressHUD.show()
        }
        
        let url = URL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.data.VCDataEndpoint/listOrganizationUserBCCMailTrackingEntries.json")!
                var request = URLRequest(url: url)
                request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
                request.addValue("en", forHTTPHeaderField: "Accept-Language")
                request.httpMethod = "POST"
                
                if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
                    request.httpBody = jsonData
                }
                let configuration = URLSessionConfiguration.default
                let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
                let task = session.dataTask(with: request){ data, response, error in
                    OperationQueue.main.addOperation {
                        SVProgressHUD.dismiss()
                    }
                    guard let data = data, error == nil else {
                        return
                    }
                    do{
                    self.bccObj = try? JSONDecoder().decode(BCCTrackingModal.self, from: data)
                        self.headerurl.isHidden = false
                        self.linkurlTxtview.isHidden = false
                    let textlink = self.bccObj.organizationUserBCCMailTrackingEntries?.first?.bccAddressPrefix
                    self.linkurlTxtview.text = (textlink ?? "") + "@etrack.toolkit.bluesquareapps.com"
                    }
                   catch {
                     print(error.localizedDescription)
                   }
                }
                task.resume()
        }
    func Getteammeberslist()
      {
            let json: [String: Any] = ["AscendingOrder": true,
                                       "OrderBy" : "FullName",
                                       "IncludeExtendedProperties":true,
                                       "ResultsPerPage":1000,
                                       "PageOffset":1,
                                       "ObjectName":"organization_user",
                                       "PassKey":passKey,
                                       "OrganizationId":currentOrgID]
         
            OperationQueue.main.addOperation {
                SVProgressHUD.show()
            }
            let url = URL(string: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/list.json")!
            var request = URLRequest(url: url)
            request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.addValue("en", forHTTPHeaderField: "Accept-Language")
            request.httpMethod = "POST"
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) {
                request.httpBody = jsonData
            }
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
            let task = session.dataTask(with: request){ data, response, error in
                OperationQueue.main.addOperation {
                    SVProgressHUD.dismiss()
                }
                guard let data = data, error == nil else {
                    return
                }
                do{
                 let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                 print(jsonObj)
                 guard let _:Dictionary = jsonObj as? [String:AnyObject] else{
                 return
                 }
                 let result = try JSON(data: data)
                 print(result)
                 for (index,_) in result["Results"].enumerated(){
                 let currid = result["Results"][index]["Id"].stringValue
                    if(currid == self.selectedId)
                      {
                        self.title = result["Results"][index]["FullName"].stringValue
                        self.firstname = result["Results"][index]["FullName"].stringValue
                        self.lastname = result["Results"][index]["LastName"].stringValue
                        self.emailaddress = result["Results"][index]["EmailAddress"].stringValue
                        self.jobtitle = result["Results"][index]["JobTitle"].stringValue
                        self.department = result["Results"][index]["Department"].stringValue
                        self.assistantID = result["Results"][index]["AssistantId"].stringValue
                        self.teamMemberPicture = result["Results"][index]["Avatar"].stringValue
                        self.addressline = result["Results"][index]["AddressLine1"].stringValue
                        self.addressLine2 = result["Results"][index]["AddressLine2"].stringValue
                        self.addressLine3 = result["Results"][index]["AddressLine3"].stringValue
                        self.city = result["Results"][index]["City"].stringValue
                        self.stateProvince = result["Results"][index]["State"].stringValue
                        self.postalCode = result["Results"][index]["Zip"].stringValue
                        self.country = result["Results"][index]["Country"].stringValue
                        self.website = result["Results"][index]["Website"].stringValue
                        self.mainPhone = result["Results"][index]["MainPhone"].stringValue
                        self.sedondaryPhone = result["Results"][index]["SecondaryPhone"].stringValue
                        self.timeZone =  result["Results"][index]["TimeZone"].stringValue
                        self.connID = result["Results"][index]["Id"].stringValue
                        
                      }
                 }
                    if(self.assistantID != ""){
                    for (index,_) in result["Results"].enumerated(){
                        let currid = result["Results"][index]["Id"].stringValue
                        if(currid == self.assistantID)
                        {
                            self.assistantName = result["Results"][index]["FullName"].stringValue
                        }
                        }
                      
                    }
                    let orgID = UserDefaults.standard.string(forKey: "BCCID")
                                              if(orgID == self.connID)
                                              {
                                                  self.toGetBCCTrackingEmailAddress()
                                                  self.bottomSpaceTableView.constant = 70
                                              }else
                                              {
                                                self.headerurl.isHidden = true
                                                self.linkurlTxtview.isHidden = true
                                                   self.bottomSpaceTableView.constant = 0
                                              }
                    self.membersTableview.delegate = self
                    self.membersTableview.dataSource = self
                    self.membersTableview.reloadData()
                }
               catch {
                 print(error.localizedDescription)
               }
            }
            task.resume()
    }
    @objc func tapActionToMailAddress()
    {
        let email = copyEmail
        if(email == "")
        {
            return
        }else
        {
            if let url = URL(string: "mailto:\(email)") {
                     if #available(iOS 10.0, *) {
                       UIApplication.shared.open(url)
                     } else {
                       UIApplication.shared.openURL(url)
                     }
                   }
        }
    }
    @objc func tapActionToPhoneNumber()
    {
        if(copyPhoneNumber == "" || copyPhoneNumber.count < 5)
        {
            return
        }else
        {
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(copyPhoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.openURL(phoneCallURL as URL)
          }
                }}
    }
    @objc func tapActionToSecondaryPhoneNumber()
       {
        if(copySecondaryPhone == "" || copySecondaryPhone.count < 5)
               {
                   return
               }else
               {
           if let phoneCallURL:NSURL = NSURL(string:"tel://\(copySecondaryPhone)") {
               let application:UIApplication = UIApplication.shared
               if (application.canOpenURL(phoneCallURL as URL)) {
                   application.openURL(phoneCallURL as URL)
             }
           }
        }}
    
    @objc func tapActionToAddress()
    {
        if(addressline != ""){
            var geocoder = CLGeocoder()
            geocoder.geocodeAddressString(addressline) {
                placemarks, error in
                let placemark = placemarks?.first
                let lat = placemark?.location?.coordinate.latitude
                let lon = placemark?.location?.coordinate.longitude
                
                self.latitude = lat
                self.longitutude = lon
                
                let controller:LocationVC = self.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
                controller.latitude = self.latitude
                controller.longitutude = self.longitutude
                self.navigationController?.pushViewController(controller, animated: true)
                
            }
        }
    }
    
    @objc func tapActionToAddress1()
    {
        if(addressLine2 != ""){
                   var geocoder = CLGeocoder()
                   geocoder.geocodeAddressString(addressLine2) {
                       placemarks, error in
                       let placemark = placemarks?.first
                       let lat = placemark?.location?.coordinate.latitude
                       let lon = placemark?.location?.coordinate.longitude
                    
                    self.latitude = lat
                    self.longitutude = lon
                    
                    let controller:LocationVC = self.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
                    controller.latitude = self.latitude
                    controller.longitutude = self.longitutude
                    self.navigationController?.pushViewController(controller, animated: true)
                   }
        }
    }
    
    @objc func tapActionToAddress2()
    {
        if(addressLine3 != ""){
            var geocoder = CLGeocoder()
                   geocoder.geocodeAddressString(addressLine3) {
                       placemarks, error in
                       let placemark = placemarks?.first
                       let lat = placemark?.location?.coordinate.latitude
                       let lon = placemark?.location?.coordinate.longitude
                    
                    self.latitude = lat
                    self.longitutude = lon
                    
                    let controller:LocationVC = self.storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
                    controller.latitude = self.latitude
                    controller.longitutude = self.longitutude
                    self.navigationController?.pushViewController(controller, animated: true)
                   }
        }
    }
}
extension TeammembesDetailsVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tablelsit.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "DetailMembersCell", for: indexPath) as? DetailMembersCell
        cell?.headerLbl.text = self.tablelsit[indexPath.row]
        if(self.tablelsit[indexPath.row] == "First Name")
        {
            cell?.textValue.text = self.firstname
            cell?.textValue.isUserInteractionEnabled = false
            cell?.textValue.isEnabled = false
        }else if(self.tablelsit[indexPath.row] == "Last Name")
        {
          cell?.textValue.text =  self.lastname
            cell?.textValue.isUserInteractionEnabled = false
            cell?.textValue.isEnabled = false
        }else if(self.tablelsit[indexPath.row] == "Email Address")
        {
            copyEmail = self.emailaddress
            cell?.textValue.text = self.emailaddress
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapActionToMailAddress))
            cell?.textValue.addGestureRecognizer(tapGesture)
            tapGesture.delegate = self
        }else if(self.tablelsit[indexPath.row] == "Job Title")
        {
          cell?.textValue.text = self.jobtitle
            cell?.textValue.isUserInteractionEnabled = false
            cell?.textValue.isEnabled = false
        }
        else if(self.tablelsit[indexPath.row] == "Department")
        {
         cell?.textValue.text =  self.department
            cell?.textValue.isUserInteractionEnabled = false
            cell?.textValue.isEnabled = false
        }
        else if(self.tablelsit[indexPath.row] == "Assistant")
        {
        cell?.textValue.text = self.assistantName
            cell?.textValue.isUserInteractionEnabled = false
            cell?.textValue.isEnabled = false
        }
        else if(self.tablelsit[indexPath.row] == "Team Member Picture")
        {
            cell?.textValue.text = self.teamMemberPicture
            cell?.textValue.isUserInteractionEnabled = false
            cell?.textValue.isEnabled = false
        }
        else if(self.tablelsit[indexPath.row] == "Address Line 1")
        {
            cell?.textValue.text = self.addressline
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapActionToAddress))
            cell?.textValue.addGestureRecognizer(tapGesture)
            tapGesture.delegate = self
            
        }
        else if(self.tablelsit[indexPath.row] == "Address Line 2")
        {
            cell?.textValue.text = self.addressLine2
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapActionToAddress1))
            cell?.textValue.addGestureRecognizer(tapGesture)
            tapGesture.delegate = self
        }
        else if(self.tablelsit[indexPath.row] == "Address Line 3")
        {
            cell?.textValue.text = self.addressLine3
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapActionToAddress2))
                       cell?.textValue.addGestureRecognizer(tapGesture)
                       tapGesture.delegate = self
        }
        else if(self.tablelsit[indexPath.row] == "City")
        {
            cell?.textValue.text = self.city
            cell?.textValue.isUserInteractionEnabled = false
            cell?.textValue.isEnabled = false
        }
        else if(self.tablelsit[indexPath.row] == "State / Province")
        {
            cell?.textValue.text = self.stateProvince
            cell?.textValue.isUserInteractionEnabled = false
            cell?.textValue.isEnabled = false
        }
        else if(self.tablelsit[indexPath.row] == "Postal Code")
               {
                cell?.textValue.text = self.postalCode
                cell?.textValue.isUserInteractionEnabled = false
                cell?.textValue.isEnabled = false
               }
        else if(self.tablelsit[indexPath.row] == "Country")
               {
                cell?.textValue.text = self.country
                cell?.textValue.isUserInteractionEnabled = false
                cell?.textValue.isEnabled = false
               }
        else if(self.tablelsit[indexPath.row] == "Website")
               {
                cell?.textValue.text = self.website
                cell?.textValue.isUserInteractionEnabled = false
                cell?.textValue.isEnabled = false
               }
        else if(self.tablelsit[indexPath.row] == "Main Phone")
                     {
                        copyPhoneNumber = self.mainPhone
                        cell?.textValue.text = self.mainPhone
                        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapActionToPhoneNumber))
                        cell?.textValue.addGestureRecognizer(tapGesture)
                        tapGesture.delegate = self
                     }
        else if(self.tablelsit[indexPath.row] == "Secondary Phone")
                     {
                        copySecondaryPhone = self.sedondaryPhone
                        cell?.textValue.text = self.sedondaryPhone
                        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapActionToSecondaryPhoneNumber))
                        cell?.textValue.addGestureRecognizer(tapGesture)
                        tapGesture.delegate = self
                     }
        else if(self.tablelsit[indexPath.row] == "Time Zone")
                     {
                        cell?.textValue.text = self.timeZone
                        cell?.textValue.isUserInteractionEnabled = false
                        cell?.textValue.isEnabled = false
                     }
        return cell!
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
}
