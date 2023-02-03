//
//  LongPressWeekView.swift
//  JZCalendarWeekViewExample
//
//  Created by Jeff Zhang on 30/4/18.
//  Copyright © 2018 Jeff Zhang. All rights reserved.
//

import UIKit
import JZCalendarWeekView

/// All-Day & Long Press
class LongPressWeekView: JZLongPressWeekView {
    
    var gDict = [String : Any]()
    var Indexpaths : IndexPath!
    var globaldayevent : [AllDayEvent] = []

    override func registerViewClasses() {
        super.registerViewClasses()

        self.collectionView.register(UINib(nibName: LongPressEventCell.className, bundle: nil), forCellWithReuseIdentifier: LongPressEventCell.className)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LongPressEventCell.className, for: indexPath) as? LongPressEventCell,
            let event = getCurrentEvent(with: indexPath) as? AllDayEvent {
            let str  = "#" + getCurrentEvent(with: indexPath)!.Color
            cell.contentView.backgroundColor = hexStringToUIColor(hex: str)
            cell.configureCell(event: event)
            return cell
        }
        preconditionFailure("LongPressEventCell and AllDayEvent should be casted")
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == JZSupplementaryViewKinds.allDayHeader {
            guard let alldayHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath) as? JZAllDayHeader else {
                preconditionFailure("SupplementaryView should be JZAllDayHeader")
            }
            let date = flowLayout.dateForColumnHeader(at: indexPath)
            var events = allDayEventsBySection[date]
            if(events != nil){
            if(events!.count > 0){
            self.globaldayevent = (events as? [AllDayEvent])!
            if(self.globaldayevent.count > 1){
                self.globaldayevent = self.globaldayevent.removingDuplicates(byKey: \.createdOn)
                events = events!.removingDuplicates(byKey: \.createdOn)
                print(self.globaldayevent.count)
                print(events?.count)
            }
            }
            }
            let views = getAllDayHeaderViews(allDayEvents: events as? [AllDayEvent] ?? [], indexpath: indexPath)
            alldayHeader.updateView(views: views)
            return alldayHeader
        }
        return super.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }

    private func getAllDayHeaderViews(allDayEvents: [AllDayEvent] , indexpath :IndexPath) -> [UIView] {
        var allDayViews = [UIView]()
        for (index,event) in allDayEvents.enumerated() {
            if let view = UINib(nibName: LongPressEventCell.className, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? LongPressEventCell {
                let editButton = UIButton(frame: CGRect(x:0, y:0, width:600,height:view.frame.height))
                editButton.addTarget(self, action: #selector(editButtonTapped), for: UIControlEvents.touchUpInside)
                editButton.tag = index
                Indexpaths = indexpath
                view.addSubview(editButton)
                view.configureCell(event: event, isAllDay: true)
                allDayViews.append(view)
            }
        }
        return allDayViews
    }
    
    @objc func editButtonTapped(sender : UIButton){
      
        let selectevent = self.globaldayevent[sender.tag]
        self.convertActivityData(event: selectevent)
        let converdict = self.convertJZBaseEventToDict(event: selectevent)
        OperationQueue.main.addOperation {
            let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: converdict )
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "UpdatenewappointmentVC") as? UpdatenewappointmentVC {
                controller.Editvalue = "edit"
                controller.EditCondition = "calendar"
                if(selectevent.isAllDay == true){
                    controller.isallday = "true"
                }
                else{
                    controller.isallday = "false"
                }
                controller.openedActivties = getAddress
                let nvc: UINavigationController = UINavigationController(rootViewController: controller)
                nvc.navigationBar.tintColor = .black
                nvc.navigationBar.barTintColor = .black
                nvc.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = nvc
                
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
                //                    self.navigationController?.pushViewController(controller, animated: true)
            }        }
    }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedEvent = getCurrentEvent(with: indexPath) as? AllDayEvent {
            self.convertActivityData(event: selectedEvent)
            let converdict = self.convertJZBaseEventToDict(event: selectedEvent)
            OperationQueue.main.addOperation {
                let getAddress:OpenActivityActivity = OpenActivityActivity.init(fromDictionary: converdict )
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                if let controller = storyboard.instantiateViewController(withIdentifier: "UpdatenewappointmentVC") as? UpdatenewappointmentVC {
                    controller.Editvalue = "edit"
                    controller.EditCondition = "calendar"
                    if(selectedEvent.isAllDay == true){
                        controller.isallday = "true"
                    }
                    else{
                        controller.isallday = "false"
                    }
                    controller.openedActivties = getAddress
                    let nvc: UINavigationController = UINavigationController(rootViewController: controller)
                    nvc.navigationBar.tintColor = .black
                    nvc.navigationBar.barTintColor = .black
                    nvc.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = nvc
                    
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
                    //                    self.navigationController?.pushViewController(controller, animated: true)
                }        }
        }
    }
    func convertActivityData(event : AllDayEvent) -> [String : Any]
    {
        gDict["RecurringActivityId"] = event.recurringActivityId
        gDict["DueTime"] = event.DueTime
        gDict["Priority"] = event.Priority
        gDict["AdvocateProcessIndex"] = event.advocateProcessIndex
        gDict["PercentComplete"] = event.PercentComplete
        gDict["AppointmentTypeId"] = event.appointmentTypeId
        gDict["AllDay"] = event.allDay
        gDict["AppliedAdvocateProcessId"] = event.appliedAdvocateProcessId
        gDict["Complete"] = event.complete
        gDict["CreatedBy"] = event.createdBy
        gDict["CreatedOn"] = event.createdOn
        gDict["Description"] = event.descriptionField
        gDict["EndTime"] = event.endTime
        gDict["Id"] = event.id
        gDict["Location"] = event.location
        gDict["ModifiedBy"] = event.modifiedBy
        gDict["ModifiedOn"] = event.modifiedOn
        gDict["RecurrenceIndex"] = event.recurrenceIndex
        gDict["RollOver"] = event.rollOver
        gDict["StartTime"] = event.startTime
        gDict["Subject"] = event.subject
        gDict["Activity"] = nil
        gDict["Type"] = event.type
        return gDict
    }
    func convertJZBaseEventToDict(event : AllDayEvent) -> [String : Any]
    {
        var cDict = [String : Any]()
        cDict["RecurringActivityId"] = event.recurringActivityId
        cDict["DueTime"] = event.DueTime
        cDict["Priority"] = event.Priority
        cDict["AdvocateProcessIndex"] = event.advocateProcessIndex
        cDict["PercentComplete"] = event.PercentComplete
        cDict["AppointmentTypeId"] = event.appointmentTypeId
        cDict["AllDay"] = event.allDay
        cDict["AppliedAdvocateProcessId"] = event.appliedAdvocateProcessId
        cDict["Complete"] = event.complete
        cDict["CreatedBy"] = event.createdBy
        cDict["CreatedOn"] = event.createdOn
        cDict["Description"] = event.descriptionField
        cDict["EndTime"] = event.endTime
        cDict["Id"] = event.id
        cDict["Location"] = event.location
        cDict["ModifiedBy"] = event.modifiedBy
        cDict["ModifiedOn"] = event.modifiedOn
        cDict["RecurrenceIndex"] = event.recurrenceIndex
        cDict["RollOver"] = event.rollOver
        cDict["StartTime"] = event.startTime
        cDict["Subject"] = event.subject
        cDict["Activity"] = gDict
        cDict["Type"] = event.type
        return cDict
    }
    

}



