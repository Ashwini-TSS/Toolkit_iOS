//
//	GetCalendarListActivity.swift
//
//	Create by thabresh thabu on 23/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GetCalendarListActivity : NSObject, NSCoding{

	var advocateProcessIndex : Int!
	var allDay : Bool!
	var appliedAdvocateProcessId : String!
	var appointmentTypeId : AnyObject!
	var complete : Bool!
	var createdBy : String!
	var createdOn : String!
	var descriptionField : String!
	var endTime : String!
	var id : String!
	var location : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var recurrenceIndex : Int!
	var recurringActivityId : AnyObject!
	var rollOver : Bool!
	var startTime : String!
	var subject : String!
	var activity : GetCalendarListActivity!
	var attendees : GetCalendarListAttendee!
	var type : String!
    var DueTime :String!

    var AppointmentTypeId : String!
    var PercentComplete:NSNumber!
    var Priority:String!
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
        AppointmentTypeId = dictionary["AppointmentTypeId"] as? String ?? ""
        Priority = dictionary["Priority"] as? String ?? ""
        PercentComplete = dictionary["PercentComplete"] as? NSNumber

		advocateProcessIndex = dictionary["AdvocateProcessIndex"] as? Int
		allDay = dictionary["AllDay"] as? Bool
		appliedAdvocateProcessId = dictionary["AppliedAdvocateProcessId"] as? String ?? ""
		appointmentTypeId = dictionary["AppointmentTypeId"] as? AnyObject
		complete = dictionary["Complete"] as? Bool
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		descriptionField = dictionary["Description"] as? String ?? ""
		endTime = dictionary["EndTime"] as? String ?? ""
        DueTime = dictionary["DueTime"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		location = dictionary["Location"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		recurrenceIndex = dictionary["RecurrenceIndex"] as? Int
		recurringActivityId = dictionary["RecurringActivityId"] as? AnyObject
		rollOver = dictionary["RollOver"] as? Bool
		startTime = dictionary["StartTime"] as? String ?? ""
		subject = dictionary["Subject"] as? String ?? ""
		if let activityData = dictionary["Activity"] as? [String:Any]{
			activity = GetCalendarListActivity(fromDictionary: activityData)
		}
		if let attendeesData = dictionary["Attendees"] as? [String:Any]{
			attendees = GetCalendarListAttendee(fromDictionary: attendeesData)
		}
		type = dictionary["Type"] as? String ?? ""
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if advocateProcessIndex != nil{
			dictionary["AdvocateProcessIndex"] = advocateProcessIndex
		}
        if PercentComplete != nil{
            dictionary["PercentComplete"] = PercentComplete
        }
        if AppointmentTypeId != nil{
            dictionary["AppointmentTypeId"] = AppointmentTypeId
        }
        if DueTime != nil{
            dictionary["DueTime"] = DueTime
        }
        
		if allDay != nil{
			dictionary["AllDay"] = allDay
		}
		if appliedAdvocateProcessId != nil{
			dictionary["AppliedAdvocateProcessId"] = appliedAdvocateProcessId
		}
		if appointmentTypeId != nil{
			dictionary["AppointmentTypeId"] = appointmentTypeId
		}
		if complete != nil{
			dictionary["Complete"] = complete
		}
		if createdBy != nil{
			dictionary["CreatedBy"] = createdBy
		}
		if createdOn != nil{
			dictionary["CreatedOn"] = createdOn
		}
		if descriptionField != nil{
			dictionary["Description"] = descriptionField
		}
		if endTime != nil{
			dictionary["EndTime"] = endTime
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if location != nil{
			dictionary["Location"] = location
		}
		if modifiedBy != nil{
			dictionary["ModifiedBy"] = modifiedBy
		}
		if modifiedOn != nil{
			dictionary["ModifiedOn"] = modifiedOn
		}
		if recurrenceIndex != nil{
			dictionary["RecurrenceIndex"] = recurrenceIndex
		}
		if recurringActivityId != nil{
			dictionary["RecurringActivityId"] = recurringActivityId
		}
		if rollOver != nil{
			dictionary["RollOver"] = rollOver
		}
		if startTime != nil{
			dictionary["StartTime"] = startTime
		}
		if subject != nil{
			dictionary["Subject"] = subject
		}
		if activity != nil{
			dictionary["Activity"] = activity.toDictionary()
		}
		if attendees != nil{
			dictionary["Attendees"] = attendees.toDictionary()
		}
		if type != nil{
			dictionary["Type"] = type
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        DueTime = aDecoder.decodeObject(forKey: "DueTime") as? String ?? ""

            PercentComplete = aDecoder.decodeObject(forKey: "PercentComplete") as? NSNumber

         advocateProcessIndex = aDecoder.decodeObject(forKey: "AdvocateProcessIndex") as? Int
         allDay = aDecoder.decodeObject(forKey: "AllDay") as? Bool
         appliedAdvocateProcessId = aDecoder.decodeObject(forKey: "AppliedAdvocateProcessId") as? String ?? ""
         appointmentTypeId = aDecoder.decodeObject(forKey: "AppointmentTypeId") as? AnyObject
         complete = aDecoder.decodeObject(forKey: "Complete") as? Bool
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
         descriptionField = aDecoder.decodeObject(forKey: "Description") as? String ?? ""
         endTime = aDecoder.decodeObject(forKey: "EndTime") as? String ?? ""
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         location = aDecoder.decodeObject(forKey: "Location") as? String ?? ""
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
         recurrenceIndex = aDecoder.decodeObject(forKey: "RecurrenceIndex") as? Int
         recurringActivityId = aDecoder.decodeObject(forKey: "RecurringActivityId") as? AnyObject
         rollOver = aDecoder.decodeObject(forKey: "RollOver") as? Bool
         startTime = aDecoder.decodeObject(forKey: "StartTime") as? String ?? ""
         subject = aDecoder.decodeObject(forKey: "Subject") as? String ?? ""
         activity = aDecoder.decodeObject(forKey: "Activity") as? GetCalendarListActivity
         attendees = aDecoder.decodeObject(forKey: "Attendees") as? GetCalendarListAttendee
         type = aDecoder.decodeObject(forKey: "Type") as? String ?? ""

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if advocateProcessIndex != nil{
			aCoder.encode(advocateProcessIndex, forKey: "AdvocateProcessIndex")
		}
        if PercentComplete != nil{
            aCoder.encode(PercentComplete, forKey: "PercentComplete")
        }
        if DueTime != nil{
            aCoder.encode(advocateProcessIndex, forKey: "DueTime")
        }
		if allDay != nil{
			aCoder.encode(allDay, forKey: "AllDay")
		}
		if appliedAdvocateProcessId != nil{
			aCoder.encode(appliedAdvocateProcessId, forKey: "AppliedAdvocateProcessId")
		}
		if appointmentTypeId != nil{
			aCoder.encode(appointmentTypeId, forKey: "AppointmentTypeId")
		}
		if complete != nil{
			aCoder.encode(complete, forKey: "Complete")
		}
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "CreatedBy")
		}
		if createdOn != nil{
			aCoder.encode(createdOn, forKey: "CreatedOn")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "Description")
		}
		if endTime != nil{
			aCoder.encode(endTime, forKey: "EndTime")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if location != nil{
			aCoder.encode(location, forKey: "Location")
		}
		if modifiedBy != nil{
			aCoder.encode(modifiedBy, forKey: "ModifiedBy")
		}
		if modifiedOn != nil{
			aCoder.encode(modifiedOn, forKey: "ModifiedOn")
		}
		if recurrenceIndex != nil{
			aCoder.encode(recurrenceIndex, forKey: "RecurrenceIndex")
		}
		if recurringActivityId != nil{
			aCoder.encode(recurringActivityId, forKey: "RecurringActivityId")
		}
		if rollOver != nil{
			aCoder.encode(rollOver, forKey: "RollOver")
		}
		if startTime != nil{
			aCoder.encode(startTime, forKey: "StartTime")
		}
		if subject != nil{
			aCoder.encode(subject, forKey: "Subject")
		}
		if activity != nil{
			aCoder.encode(activity, forKey: "Activity")
		}
		if attendees != nil{
			aCoder.encode(attendees, forKey: "Attendees")
		}
		if type != nil{
			aCoder.encode(type, forKey: "Type")
		}

	}

}
