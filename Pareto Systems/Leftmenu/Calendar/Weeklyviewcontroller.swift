//
//  Weeklyviewcontroller.swift
//  Blue Square
//
//  Created by TECNVATORS SOFTWARE on 03/09/19.
//  Copyright © 2019 VividInfotech. All rights reserved.
//

import UIKit
import JZCalendarWeekView
import CoreData

@objc class Weeklyviewcontroller: UIViewController {
    
    var startDatee : Date!
    var endDate : Date!
    var teamMembersIDList:NSMutableArray = []

    @IBOutlet var Containerview: JZLongPressWeekView!
    let viewModel = AllDayViewModel()
    var getWeekCalendarActivityList:[GetCalendarListActivity] = []

    var selectDate : Date!
    var devv : String!
    
    var appointmentIDList:NSMutableArray = []
    var appointmentColorList:NSMutableArray = []
    
    var appointmentcolor:NSMutableArray = []
    var appointmentID:NSMutableArray = []
    
    var listAppointments : NSDictionary!
    var isAlldayEvent:Bool = false
    var isRollOver:Bool = false
    var isComplete:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        print(listAppointments)
        setupCalendarView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        var value = UserDefaults.standard.string(forKey: "cale")
        if(value == "draganddrop"){
            UserDefaults.standard.removeObject(forKey: "cale")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalendarController") as! CalendarController
            let nvc: UINavigationController = UINavigationController(rootViewController: vc)
            self.slideMenuController()?.changeMainViewController(nvc, close: true)
        }
    }
    
    // Support device orientation change
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        JZWeekViewHelper.viewTransitionHandler(to: size, weekView: Containerview)
    }
    
    func UpdatedNewAppointment1(){
        let parameters = [
            "ForUsers":[],
            "From": startTime,
            "IncludeAppointments": true,
            "IncludeAttendees": true,
            "IncludeTasks": false,
            "OrganizationId": currentOrgID,
            "To": endTime,
            "PassKey": passKey
            ] as [String : Any]
        
        var mainURL:String!
        let headers = [
            "Content-Type": "application/json",
        ]
        
        
        mainURL = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.calendar.VCCalendarEndpoint/getActivities.json"
    
        let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 7.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        //        request.httpBody = postData as Data
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            request.httpBody = jsonData
        }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self as? URLSessionDelegate, delegateQueue:OperationQueue.main)
        let dataTask11 = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                print(jsonObj)
            
            }catch {
                print(error.localizedDescription)
            }
        })
        dataTask11.resume()
    }
    private func setupCalendarView() {
        Containerview.baseDelegate = self
        
        if let data = UserDefaults.standard.data(forKey: "longterm"),
            let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [GetCalendarListActivity] {
            self.getWeekCalendarActivityList = myPeopleList
        } else {
            print("There is an issue")
        }
        
        if let data = UserDefaults.standard.data(forKey: "ColorAppID"),
            let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSMutableArray {
            self.appointmentcolor = myPeopleList
        } else {
            print("There is APPID issue")
        }
        
        if let data = UserDefaults.standard.data(forKey: "AppointAppID"),
            let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSMutableArray {
            self.appointmentID = myPeopleList
        } else {
            print("There is APPID issue")
        }
        
        //AppointAppID
        
        
        
        let ss = UserDefaults.standard.object(forKey: "selectDay") as! String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let data = dateFormatter.date(from:ss )!
        print(data)
        
        for (windex, _) in self.getWeekCalendarActivityList.enumerated()
        {
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
            let st_date : Date = dateFormatter1.date(from: (self.getWeekCalendarActivityList[windex].activity.startTime)!)!
            let en_date : Date = dateFormatter1.date(from: (self.getWeekCalendarActivityList[windex].activity.endTime)!)!
            print(self.getWeekCalendarActivityList[windex].activity.subject)
            let newEvent = AllDayEvent(id: (self.getWeekCalendarActivityList[windex].activity.id)!, title: (self.getWeekCalendarActivityList[windex].activity.subject)!, startDate:st_date, endDate:en_date, isAllDay:self.getWeekCalendarActivityList[windex].activity.allDay ?? false, advocateProcessIndex: self.getWeekCalendarActivityList[windex].activity.advocateProcessIndex ?? 0, allDay: self.getWeekCalendarActivityList[windex].activity.allDay ?? false, appliedAdvocateProcessId: self.getWeekCalendarActivityList[windex].activity.appliedAdvocateProcessId ?? "", appointmentTypeId: self.getWeekCalendarActivityList[windex].activity.appointmentTypeId ?? "" as AnyObject, complete: self.getWeekCalendarActivityList[windex].activity.complete ?? false, createdBy: self.getWeekCalendarActivityList[windex].activity.createdBy ?? "", createdOn: self.getWeekCalendarActivityList[windex].activity.createdOn ?? "", descriptionField: self.getWeekCalendarActivityList[windex].activity.descriptionField ?? "", endTime: self.getWeekCalendarActivityList[windex].activity.endTime ?? "", location: self.getWeekCalendarActivityList[windex].activity.location ?? "", modifiedBy: self.getWeekCalendarActivityList[windex].activity.modifiedBy ?? "", modifiedOn: self.getWeekCalendarActivityList[windex].activity.modifiedOn ?? "", recurrenceIndex: self.getWeekCalendarActivityList[windex].activity.recurrenceIndex ?? 0, recurringActivityId: self.getWeekCalendarActivityList[windex].activity.recurringActivityId ?? "" as AnyObject , rollOver: self.getWeekCalendarActivityList[windex].activity.rollOver ?? false, startTime: self.getWeekCalendarActivityList[windex].activity.startTime ?? "", subject: self.getWeekCalendarActivityList[windex].activity.subject ?? "", type: self.getWeekCalendarActivityList[windex].activity.type ?? "", DueTime: self.getWeekCalendarActivityList[windex].activity.DueTime ?? "", AppointmentTypeId: self.getWeekCalendarActivityList[windex].activity.AppointmentTypeId ?? "", PercentComplete: self.getWeekCalendarActivityList[windex].activity.PercentComplete ?? 0, Priority:self.getWeekCalendarActivityList[windex].activity.Priority ?? "", Color:getvalueID(str:self.getWeekCalendarActivityList[windex].activity.appointmentTypeId ?? ""))
            
            viewModel.events.append(newEvent)
        }
        
        if viewModel.currentSelectedData != nil {
            // For example only
            setupCalendarViewWithSelectedData()
        } else {
            Containerview.setupCalendar(numOfDays: 1 ,
                                           setDate: data,
                                           allEvents: viewModel.eventsByDate,
                                           scrollType: .pageScroll,
                                           scrollableRange: (nil, nil))
        }
        
        // LongPress delegate, datasorce and type setup
        Containerview.longPressDelegate = self
        Containerview.longPressDataSource = self
        Containerview.longPressTypes = [.addNew, .move]
        
        // Optional
        Containerview.addNewDurationMins = 120
        Containerview.moveTimeMinInterval = 15
        
       
    }
    func getJson(IDD : String){
      
        let json: [String: Any] = ["ObjectName": "organization_user",
                                   "ObjectId": currentMasterID,
                                   "OrganizationId": currentOrgID,
                                   "PassKey":passKey]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/get.json", parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
              
                print(json)
                let contactModel = getTeammemberModel.init(fromDictionary: jsonResponse)
                print(contactModel.dataObject)
               
                if contactModel.valid{
                            self.teamMembersIDList = []
                            self.teamMembersIDList.add(contactModel.dataObject.id!)
                    
                    let json: [String: Any] = ["ObjectName": "linker_appointments_users",
                                               "LeftId": IDD,
                                               "LeftObjectName": "appointment",
                                               "RightId": self.teamMembersIDList[0],
                                               "RightObjectName": "contact",
                                               "PassKey": passKey,
                                               "OrganizationId": currentOrgID]
                    print(json)
                    
                    APIManager.sharedInstance.postRequestCall(postURL: linkURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
                        DispatchQueue.main.async {
                            print(json)
                            
                        }
                    },  onFailure: { error in
                    })

                    }
                
               
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
        
    }
    func getvalueID(str : Any) -> String {
        print(str)
        for index in 0..<self.appointmentID.count {
            if let value = appointmentID[index] as? String {
                print(value)
            if str is String {
            if appointmentID[index] as! String == str as! String {
                devv = appointmentcolor[index] as? String
                print(devv)
                return devv
            }
            }
            else{
                devv = "a5c2f2"
                }
            }
            
        }
        return devv
    }
    
    /// For example only
    private func setupCalendarViewWithSelectedData() {
        guard let selectedData = viewModel.currentSelectedData else { return }
        Containerview.setupCalendar(numOfDays: selectedData.numOfDays,
                                       setDate: selectedData.date,
                                       allEvents: viewModel.eventsByDate,
                                       scrollType: selectedData.scrollType,
                                       firstDayOfWeek: selectedData.firstDayOfWeek)
        Containerview.updateFlowLayout(JZWeekViewFlowLayout(hourGridDivision: selectedData.hourGridDivision))
    }
}

extension Weeklyviewcontroller: JZBaseViewDelegate {
    func initDateDidChange(_ weekView: JZBaseWeekView, initDate: Date) {
    }
}


// LongPress core
extension Weeklyviewcontroller: JZLongPressViewDelegate, JZLongPressViewDataSource {
    
    func weekView(_ weekView: JZLongPressWeekView, didEndAddNewLongPressAt startDate: Date) {
        let formatter1 = DateFormatter()
        formatter1.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        startTime = formatter1.string(from: startDate)
//        UserDefaults.standard.set(startTime, forKey: "datestart")
        print(startTime)
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        endTime = formatter2.string(from: startDate.add(component: .hour, value: weekView.addNewDurationMins/60))
        
      
        
       
//        UserDefaults.standard.set(endTime, forKey: "dateend")
//        UserDefaults.standard.set("yes", forKey: "new")
        print(endTime)
        
        let mainURL:String = createContact

       let insertData:NSMutableDictionary = [:]
        insertData.setValue("New Event", forKey: "Subject")
        insertData.setValue("", forKey: "Description")
        insertData.setValue("", forKey: "AppointmentTypeId")
        insertData.setValue("", forKey: "Location")
        insertData.setValue(startTime, forKey: "StartTime")
        insertData.setValue(endTime, forKey: "EndTime")
        
        insertData.setValue(self.isAlldayEvent, forKey: "AllDay")
        insertData.setValue(self.isRollOver, forKey: "RollOver")
        insertData.setValue(self.isComplete, forKey: "Complete")
        
        let objectName:String = "appointment"
        let json: [String: Any] = ["ObjectName": objectName,
                                   "PassKey": passKey,
                                   "OrganizationId":currentOrgID,
                                   "DataObject":insertData]
        print(json)
        
        APIManager.sharedInstance.postRequestCall(postURL: mainURL, parameters: json, senderVC: self, onSuccess: { (jsonResponse, json) in
            DispatchQueue.main.async {
                print(json)
                if let getValid = jsonResponse["Valid"] as? Bool {
                    if getValid == true {
                        if let getDataObject:NSDictionary = jsonResponse["DataObject"] as? NSDictionary {
                            if let getID:String = getDataObject["Id"] as? String {
                                print(getID)
                                self.getJson(IDD: getID)

                                let newEvent = AllDayEvent(id: getID, title: "New Event", startDate: startDate, endDate: startDate.add(component: .hour, value: weekView.addNewDurationMins/60), isAllDay: false, advocateProcessIndex: 0, allDay:false, appliedAdvocateProcessId: "", appointmentTypeId: self.viewModel.events[0].appointmentTypeId, complete: false, createdBy: "", createdOn: "", descriptionField: "", endTime: endTime, location: "", modifiedBy: "", modifiedOn: "", recurrenceIndex: 0, recurringActivityId: self.viewModel.events[0].recurringActivityId, rollOver: false, startTime: startTime , subject: "New Event", type: "", DueTime: "", AppointmentTypeId: "", PercentComplete: 0, Priority: "", Color: "#9aaed6")

                                if self.viewModel.eventsByDate[startDate.startOfDay] == nil {
                                    self.viewModel.eventsByDate[startDate.startOfDay] = [AllDayEvent]()
                                }
                                self.viewModel.events.append(newEvent)
                                self.viewModel.eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: self.viewModel.events)
                                weekView.forceReload(reloadEvents: self.viewModel.eventsByDate)
                                let starttime =  getDataObject["StartTime"] as? String
                                let endtime =  getDataObject["EndTime"] as? String
                                self.createGoogleCalendarEvent(toolkitEventID: getID, startTimes: starttime ?? "", endTimes: endtime ?? "")
  //  NotificationCenter.default.post(name: NSNotification.Name("dragappointment"), object: nil)
                             //   self.UpdatedNewAppointment1()
                            }
                        }
                    }else{
                        let responseMessage:String = jsonResponse["ResponseMessage"] as! String
                        print(responseMessage)
                    }
                }else{
                    NavigationHelper.showSimpleAlert(message:"Please try in sometime")
                }
            }
        },  onFailure: { error in
            print(error.localizedDescription)
            NavigationHelper.showSimpleAlert(message:error.localizedDescription)
        })
        
    }
   
    
    func getCurrentTimeZone() -> String{
             return TimeZone.current.identifier
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
    
    func createGoogleCalendarEvent(toolkitEventID : String, startTimes : String, endTimes : String)
    {
        let passkey = self.retriveRecordsFromCoreData()
        let timezone = self.getCurrentTimeZone()
        let parameterDictionary: [String: Any] = ["summary": "New Event",
                                                  "location": "",
                                                  "description":"",
                                                  "start": startTimes,
                                                  "end":endTimes,
                                   "time_zone":timezone,
                                   "event_type":"Party",
        ]
        let Url = String(format: "https://toolkit-gcal.tecnovaters.com/api/v1/google-calendar/events")
           guard let serviceUrl = URL(string: Url) else { return }
           var request = URLRequest(url: serviceUrl)
           request.httpMethod = "POST"
           request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
           request.setValue("Bearer \(passkey)", forHTTPHeaderField: "Authorization")
           guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
               return
           }
           request.httpBody = httpBody
           
           let session = URLSession.shared
           session.dataTask(with: request) { (data, response, error) in
               if let response = response {
                   print(response)
               }
               if let data = data {
                   do {
                       let json = try JSONSerialization.jsonObject(with: data, options: [])
                       print(json)
                       let model = try JSONDecoder().decode(SyncLoginModal.self, from: data)
                       DispatchQueue.main.async {
                           if(model.data?.id != nil){
                               self.toStoreValuesCoreData(toolkitEventID: toolkitEventID, googleEventID: model.data?.id ?? "")
                           }
                       }
                       
                   } catch {
                       print(error)
                   }
               }
           }.resume()
    }
    
    func toStoreValuesCoreData(toolkitEventID : String, googleEventID : String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let managedobj = appDelegate.persistentContainer.viewContext
            let userEntity = NSEntityDescription.entity(forEntityName: "GcalConfig", in: managedobj)
            let user = NSManagedObject(entity: userEntity!, insertInto: managedobj)
        user.setValue(googleEventID, forKey: "gcalEventID")
        user.setValue(toolkitEventID, forKey: "toolkitEventID")
            do
            {
                try managedobj.save()
            }catch let error as NSError{
                print(error.localizedDescription)
            }
    }
    func weekView(_ weekView: JZLongPressWeekView, editingEvent: JZBaseEvent, didEndMoveLongPressAt startDate: Date) {
        guard let event = editingEvent as? AllDayEvent else { return }
        let duration = Calendar.current.dateComponents([.minute], from: event.startDate, to: event.endDate).minute!
        let selectedIndex = viewModel.events.firstIndex(where: { $0.id == event.id })!
        viewModel.events[selectedIndex].startDate = startDate
        viewModel.events[selectedIndex].endDate = startDate.add(component: .minute, value: duration)
        self.endDate = viewModel.events[selectedIndex].endDate
        self.startDatee = viewModel.events[selectedIndex].startDate

        viewModel.eventsByDate = JZWeekViewHelper.getIntraEventsByDate(originalEvents: viewModel.events)
        weekView.forceReload(reloadEvents: viewModel.eventsByDate)
   
        let formatter1 = DateFormatter()
        formatter1.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        startTime = formatter1.string(from: self.startDatee)
        UserDefaults.standard.set(startTime, forKey: "datestart")
        print(startTime)
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        endTime = formatter2.string(from: self.endDate)
        UserDefaults.standard.set(endTime, forKey: "dateend")
        UserDefaults.standard.set("yes", forKey: "new")
        print(endTime)
        
            let parameters = [
                "ForUsers":[],
                "From": startTime,
                "IncludeAppointments": true,
                "IncludeAttendees": true,
                "IncludeTasks": false,
                "OrganizationId": currentOrgID,
                "To": endTime,
                "PassKey": passKey
                ] as [String : Any]
            
            var mainURL:String!
            let headers = [
                "Content-Type": "application/json",
            ]
            
            
            mainURL = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.calendar.VCCalendarEndpoint/getActivities.json"
        
            let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 7.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            //        request.httpBody = postData as Data
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                request.httpBody = jsonData
            }
            
            let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self as? URLSessionDelegate, delegateQueue:OperationQueue.main)
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription as Any)
                    return
                }
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonObj)
                    guard let _:Dictionary = jsonObj as? [String:AnyObject] else{
                        return
                    }
                    let result = try JSON(data: data)
                    print(result)
                    let activities = result["Activities"].arrayValue
                    print(activities)
                    var parameters1 : [String : Any]
                    if let value = self.viewModel.events[selectedIndex].recurringActivityId as? String {
                        parameters1 = [
                            "DataObject": [
                                "Location" : self.viewModel.events[selectedIndex].location,
                                "AdvocateProcessIndex": self.viewModel.events[selectedIndex].advocateProcessIndex,
                                "AppointmentTypeId" : self.viewModel.events[selectedIndex].appointmentTypeId,
                                "AllDay": self.viewModel.events[selectedIndex].allDay,
                                "Complete": self.viewModel.events[selectedIndex].complete,
                                "CreatedBy": self.viewModel.events[selectedIndex].createdBy,
                                "CreatedOn": self.viewModel.events[selectedIndex].createdOn,
                                "Description":self.viewModel.events[selectedIndex].description,
                                "EndTime": endTime,
                                "Id": self.viewModel.events[selectedIndex].id,
                                "ModifiedBy": self.viewModel.events[selectedIndex].modifiedBy,
                                "ModifiedOn": self.viewModel.events[selectedIndex].modifiedOn,
                                "RecurrenceIndex": self.viewModel.events[selectedIndex].recurrenceIndex,
                                "RecurringActivityId":self.viewModel.events[selectedIndex].recurringActivityId,
                                "RollOver": self.viewModel.events[selectedIndex].rollOver,
                                "StartTime": startTime,
                                "Subject": self.viewModel.events[selectedIndex].subject
                            ],
                            "OrganizationId": currentOrgID,
                            "ObjectName": "appointment",
                            "PassKey": passKey
                            ] as [String : Any]
                    }
                    else{
                        
                        if(self.viewModel.events[selectedIndex].appliedAdvocateProcessId == nil){
                            self.viewModel.events[selectedIndex].appliedAdvocateProcessId = ""
                        }
                        //appointmentById
                        parameters1 = [
                            "DataObject": [
                                "Location" : self.viewModel.events[selectedIndex].location,
                                "AdvocateProcessIndex": self.viewModel.events[selectedIndex].advocateProcessIndex,
                                "AppointmentTypeId" : self.viewModel.events[selectedIndex].appointmentTypeId,
                        "AppliedAdvocateProcessId":self.viewModel.events[selectedIndex].appliedAdvocateProcessId,
                        "AllDay": self.viewModel.events[selectedIndex].allDay,
                        "Complete": self.viewModel.events[selectedIndex].complete,
                        "CreatedBy": self.viewModel.events[selectedIndex].createdBy,
                        "CreatedOn": self.viewModel.events[selectedIndex].createdOn,
                        "Description":self.viewModel.events[selectedIndex].description,
                        "EndTime": endTime,
                        "Id": self.viewModel.events[selectedIndex].id,
                        "ModifiedBy": self.viewModel.events[selectedIndex].modifiedBy,
                        "ModifiedOn": self.viewModel.events[selectedIndex].modifiedOn,
                        "RecurrenceIndex": self.viewModel.events[selectedIndex].recurrenceIndex,
                        "RollOver": self.viewModel.events[selectedIndex].rollOver,
                        "StartTime": startTime,
                        "Subject": self.viewModel.events[selectedIndex].subject
                            ],
                            "OrganizationId": currentOrgID,
                            "ObjectName": "appointment",
                            "PassKey": passKey
                            ] as [String : Any]
                        
                    }
                    
                    var mainURL:String!
                    let headers = [
                        "Content-Type": "application/json",
                    ]
                    mainURL = globalURL+"/endpoints/ajax/com.platform.vc.endpoints.orgdata.VCOrgDataEndpoint/modify.json"
                    
                    
                    let request = NSMutableURLRequest(url: NSURL(string: mainURL)! as URL,
                                                      cachePolicy: .useProtocolCachePolicy,
                                                      timeoutInterval: 7.0)
                    
                    request.httpMethod = "POST"
                    request.allHTTPHeaderFields = headers
                    if let jsonData = try? JSONSerialization.data(withJSONObject: parameters1, options: []) {
                        request.httpBody = jsonData
                    }
                    let configuration = URLSessionConfiguration.default
                    let session = URLSession(configuration: configuration, delegate: self as? URLSessionDelegate, delegateQueue:OperationQueue.main)
                    let dataTask11 = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                        guard let data = data, error == nil else {
                            print(error?.localizedDescription as Any)
                            return
                        }
                        do {
                            let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                            print(jsonObj)
                            guard let _:Dictionary = jsonObj as? [String:AnyObject] else{
                                return
                            }
                            let result = try JSON(data: data)
                            print(result)
                            UserDefaults.standard.set("draganddrop", forKey: "cale")
                        }catch {
                            print(error.localizedDescription)
                        }
                    })
                    dataTask11.resume()
                    
                }catch {
                    print(error.localizedDescription)
                }
            })
            
            dataTask.resume()
        }
    
    
    
    func weekView(_ weekView: JZLongPressWeekView, viewForAddNewLongPressAt startDate: Date) -> UIView {
        if let view = UINib(nibName: EventCell.className, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? EventCell {
            view.titleLabel.text = "New Event"
            
            return view
        }
        return UIView()
    }
}

