//
//  CalendarSyncViewController.swift
//  Blue Square
//
//  Created by Gowrisankar G on 16/04/25.
//  Copyright © 2025 VividInfotech. All rights reserved.
//

import UIKit
import CoreData
import EventKit
class CalendarSyncViewController: UIViewController {

    @IBOutlet weak var btnBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var syncedEmail: UILabel!
    var passkey : String = ""
    @IBOutlet weak var googleCalendarSyncBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarItem()
        self.title = "Integrations"
        self.googleCalendarSyncBtn.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.syncedEmail.isHidden = true
        self.btnBottomSpace.constant = 12
        NotificationCenter.default.addObserver(self, selector: #selector(syncDetails), name: NSNotification.Name("choosetab"), object: nil)
        self.getSyncedUserDetails()
    }
  
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @objc func syncDetails()
    {
        self.getSyncedUserDetails()
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    @IBAction func googleCalendarSyncAction(_ sender: UIButton) {
        
        let eventStore = EKEventStore()

        eventStore.requestAccess(to: .event) { (granted, error) in
            if granted {
                print("Access granted to calendar")
                
                let eventStore = EKEventStore()
                var startComponents = DateComponents()
                startComponents.year = 2025
                startComponents.month = 4
                startComponents.day = 25
                startComponents.hour = 11
                startComponents.minute = 30

                var endComponents = startComponents
                endComponents.hour = 12

                let calendar = Calendar.current
                let startDate = calendar.date(from: startComponents)!
                let endDate = calendar.date(from: endComponents)!
                    eventStore.requestAccess(to: .event) { (granted, error) in
                        if granted {
                            let event = EKEvent(eventStore: eventStore)
                            event.title = "Holiday party"
                            event.startDate = startDate
                            event.endDate = endDate
                            event.notes = "Holiday party in night theme"
                            event.calendar = eventStore.defaultCalendarForNewEvents
                            let alarm = EKAlarm(relativeOffset: -600) // -600 seconds = 10 minutes before
                            event.alarms = [alarm]
                            do {
                                try eventStore.save(event, span: .thisEvent)
                                print("Event added to calendar")
                            } catch let err {
                                print("Failed to save event: \(err.localizedDescription)")
                            }
                        } else {
                            print("Permission not granted")
                        }
                    }
            } else {
                print("Access denied")
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        
       
//        if(sender.titleLabel?.text == "Unsync")
//        {
//            DispatchQueue.main.async {
//                self.profileEditAlert()
//            }
//        }else{
//            self.loginToTheUser()
//        }
    }
    
    func unsyncUserFromGcal()
    {
        let url = URL(string: "https://toolkit-gcal.tecnovaters.com/api/v1/google-calendar/unsync")
            
        var request = URLRequest(url: url!)

        request.setValue(
            "Bearer \(self.passkey)",
            forHTTPHeaderField: "Authorization"
        )

        // For POST requests with a JSON body, set the Content-Type header
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        request.httpMethod = "DELETE"
            // create URLSession with default configuration
            let session = URLSession.shared
            
            // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    print("GET Request Error: \(error.localizedDescription)")
                    return
                }
                
                // ensure there is valid response code returned from this HTTP response
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                          print("Invalid Response received from the server")
                          return
                      }
                
                // ensure there is data returned
                guard let responseData = data else {
                    print("nil Data received from the server")
                    return
                }
                
                do {
                    // serialise the data object into Dictionary [String : Any]
                    if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                        print(jsonResponse)
                        self.deletAllpasskeyRecordsInCoredata()
                        DispatchQueue.main.async {
                            self.syncedEmail.isHidden = true
                            self.btnBottomSpace.constant = 12
                            self.googleCalendarSyncBtn.backgroundColor = UIColor(red: 0/255, green: 82/255, blue: 155/255, alpha: 1.0)
                            self.googleCalendarSyncBtn.setTitle("Connect Calendar", for: .normal)
                        }
                      
                    } else {
                        print("data maybe corrupted or in wrong format")
                        throw URLError(.badServerResponse)
                    }
                } catch let error {
                    print("JSON Parsing Error: \(error.localizedDescription)")
                }
            }
            // resume the task
            task.resume()
    }

    
    func loginToTheUser()
    {
            let json: [String: Any] = ["UserName": "Mirdhun",
                                       "Password": "Tecno@123"]
            print(json)
            OperationQueue.main.addOperation {
//                  SVProgressHUD.show()
//                MBProgressHUD.showAdded(to: self.view, animated: true)
            }
            APIManager.sharedInstance.postRequestCall(postURL: syncLoginurl, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                OperationQueue.main.addOperation {
//                     SVProgressHUD.dismiss()
//                                    MBProgressHUD.hide(for: self.view, animated: true)
                }
                DispatchQueue.main.async {
                    if let passKey = jsonResponse["PassKey"] as? String
                    {
                        print("passkey -- \(passKey)")
                        self.passkey = passKey
                        self.deletAllpasskeyRecordsInCoredata()
                        self.toStoreValuesCoreData(passkey: passKey)
                        self.renavigateToOauthPage()
                    }
                    
                }
            },  onFailure: { error in
                print(error.localizedDescription)
                OperationQueue.main.addOperation {
//                     SVProgressHUD.dismiss()
//                                    MBProgressHUD.hide(for: self.view, animated: true)
                }
            })
        }
    
    func toStoreValuesCoreData(passkey : String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let managedobj = appDelegate.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "GcalPasskey", in: managedobj)
            let user = NSManagedObject(entity: userEntity!, insertInto: managedobj)
            user.setValue(passkey, forKey: "passkey")
            do
            {
                try managedobj.save()
            }catch let error as NSError{
                print(error.localizedDescription)
            }
    }
    
    func deletAllpasskeyRecordsInCoredata()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GcalPasskey")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
        } catch {
        }
    }
    
    func retriveRecordsFromCoreData() -> String
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return ""
        }
        let managedobj = appDelegate.persistentContainer.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GcalPasskey")
        do{
            let result = try managedobj.fetch(fetchrequest)
            for data in (result as? [NSManagedObject])!
            {
            print(data.value(forKey: "passkey") as! String)
                let passkey = data.value(forKey: "passkey") as? String ?? ""
                return passkey
            }
            
        }catch{
            print("Error while fetching data")
        }
        return ""
    }
    
    func getSyncedUserDetails()
    {
        self.passkey = self.retriveRecordsFromCoreData()
        let url = URL(string: "https://toolkit-gcal.tecnovaters.com/api/v1/google-calendar/synced-user")
            
        OperationQueue.main.addOperation {
//                  SVProgressHUD.show()
//                MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        var request = URLRequest(url: url!)

        request.setValue(
            "Bearer \(self.passkey)",
            forHTTPHeaderField: "Authorization"
        )

        // For POST requests with a JSON body, set the Content-Type header
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
            // create URLSession with default configuration
            let session = URLSession.shared
            
            // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    OperationQueue.main.addOperation {
//                         SVProgressHUD.dismiss()
//                         MBProgressHUD.hide(for: self.view, animated: true)
                    }
                    DispatchQueue.main.async {
                        self.btnBottomSpace.constant = 12
                        self.syncedEmail.isHidden = true
                    }
                    print("GET Request Error: \(error.localizedDescription)")
                    return
                }
                
                // ensure there is valid response code returned from this HTTP response
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    OperationQueue.main.addOperation {
//                         SVProgressHUD.dismiss()
//                                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                    DispatchQueue.main.async {
                        self.btnBottomSpace.constant = 12
                        self.syncedEmail.isHidden = true
                    }
                          print("Invalid Response received from the server")
                          return
                      }
                
                // ensure there is data returned
                guard let responseData = data else {
                    OperationQueue.main.addOperation {
//                         SVProgressHUD.dismiss()
//                                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                    DispatchQueue.main.async {
                        self.btnBottomSpace.constant = 12
                        self.syncedEmail.isHidden = true
                    }
                    print("nil Data received from the server")
                    return
                }
                
                do {
                    // serialise the data object into Dictionary [String : Any]
                    if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                        print(jsonResponse)
                        OperationQueue.main.addOperation {
//                             SVProgressHUD.dismiss()
//                                            MBProgressHUD.hide(for: self.view, animated: true)
                        }
                        DispatchQueue.main.async {
                            let msg = jsonResponse["message"] as? String
                            let dataobj = jsonResponse["data"] as? [String : Any]
                            if(dataobj != nil){
                                self.syncedEmail.isHidden = false
                                self.syncedEmail.text = dataobj?["email"] as? String
                                self.btnBottomSpace.constant = 44
                                self.googleCalendarSyncBtn.backgroundColor = UIColor.systemRed
                                self.googleCalendarSyncBtn.setTitle("Unsync", for: .normal)
                            }
                            else{
                                self.syncedEmail.isHidden = true
                                self.btnBottomSpace.constant = 12
                                self.googleCalendarSyncBtn.backgroundColor = UIColor(red: 0/255, green: 82/255, blue: 155/255, alpha: 1.0)
                                self.googleCalendarSyncBtn.setTitle("Connect Calendar", for: .normal)
                            }
                        }
                      
                    } else {
                        print("data maybe corrupted or in wrong format")
                        throw URLError(.badServerResponse)
                    }
                } catch let error {
                    OperationQueue.main.addOperation {
//                         SVProgressHUD.dismiss()
//                                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                    DispatchQueue.main.async {
                        self.btnBottomSpace.constant = 12
                        self.syncedEmail.isHidden = true
                    }
                    print("JSON Parsing Error: \(error.localizedDescription)")
                }
            }
            // resume the task
            task.resume()
    }
    
    func renavigateToOauthPage()
    {
        // request url
        let url = URL(string: "https://toolkit-gcal.tecnovaters.com/api/v1/google-calendar/auth")
            
        var request = URLRequest(url: url!)

        request.setValue(
            "Bearer \(self.passkey)",
            forHTTPHeaderField: "Authorization"
        )

        // For POST requests with a JSON body, set the Content-Type header
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
            // create URLSession with default configuration
            let session = URLSession.shared
            
            // create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    print("GET Request Error: \(error.localizedDescription)")
                    return
                }
                
                // ensure there is valid response code returned from this HTTP response
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                          print("Invalid Response received from the server")
                          return
                      }
                
                // ensure there is data returned
                guard let responseData = data else {
                    print("nil Data received from the server")
                    return
                }
                
                do {
                    // serialise the data object into Dictionary [String : Any]
                    if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                        print(jsonResponse)
                        let urlSting = jsonResponse["authUrl"] as? String
                        if let url = URL(string: urlSting ?? ""), UIApplication.shared.canOpenURL(url) {
                            DispatchQueue.main.async {
                                UIApplication.shared.open(url)
                            }
                        }
                    } else {
                        print("data maybe corrupted or in wrong format")
                        throw URLError(.badServerResponse)
                    }
                } catch let error {
                    print("JSON Parsing Error: \(error.localizedDescription)")
                }
            }
            // resume the task
            task.resume()
    }
    
    func profileEditAlert(){
        let alert = UIAlertController(title: "Are you sure want to disconnect the Gcal", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alert) in
            self.unsyncUserFromGcal()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alert) in
           
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
