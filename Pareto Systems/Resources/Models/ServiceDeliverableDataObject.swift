//
//	ServiceDeliverableDataObject.swift
//
//	Create by thabresh thabu on 29/8/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ServiceDeliverableDataObject : NSObject, NSCoding{

	var activityType : String!
	var allDay : Bool!
	var appointmentTypeId : String!
	var assigneeId : AnyObject!
	var assigneeType : String!
	var contactDateFieldName : String!
	var createdBy : String!
	var createdOn : String!
	var dayOffset : Int!
	var deliverableDate : AnyObject!
	var deliverableType : String!
	var descriptionField : String!
	var endTime : String!
	var id : String!
	var location : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var recurrencePatternId : String!
	var rollOver : Bool!
	var sequence : Int!
	var startTime : String!
	var subject : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		activityType = dictionary["ActivityType"] as? String ?? ""
		allDay = dictionary["AllDay"] as? Bool
		appointmentTypeId = dictionary["AppointmentTypeId"] as? String ?? ""
		assigneeId = dictionary["AssigneeId"] as? AnyObject
		assigneeType = dictionary["AssigneeType"] as? String ?? ""
		contactDateFieldName = dictionary["ContactDateFieldName"] as? String ?? ""
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		dayOffset = dictionary["DayOffset"] as? Int
		deliverableDate = dictionary["DeliverableDate"] as? AnyObject
		deliverableType = dictionary["DeliverableType"] as? String ?? ""
		descriptionField = dictionary["Description"] as? String ?? ""
		endTime = dictionary["EndTime"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		location = dictionary["Location"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		recurrencePatternId = dictionary["RecurrencePatternId"] as? String ?? ""
		rollOver = dictionary["RollOver"] as? Bool
		sequence = dictionary["Sequence"] as? Int
		startTime = dictionary["StartTime"] as? String ?? ""
		subject = dictionary["Subject"] as? String ?? ""
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if activityType != nil{
			dictionary["ActivityType"] = activityType
		}
		if allDay != nil{
			dictionary["AllDay"] = allDay
		}
		if appointmentTypeId != nil{
			dictionary["AppointmentTypeId"] = appointmentTypeId
		}
		if assigneeId != nil{
			dictionary["AssigneeId"] = assigneeId
		}
		if assigneeType != nil{
			dictionary["AssigneeType"] = assigneeType
		}
		if contactDateFieldName != nil{
			dictionary["ContactDateFieldName"] = contactDateFieldName
		}
		if createdBy != nil{
			dictionary["CreatedBy"] = createdBy
		}
		if createdOn != nil{
			dictionary["CreatedOn"] = createdOn
		}
		if dayOffset != nil{
			dictionary["DayOffset"] = dayOffset
		}
		if deliverableDate != nil{
			dictionary["DeliverableDate"] = deliverableDate
		}
		if deliverableType != nil{
			dictionary["DeliverableType"] = deliverableType
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
		if recurrencePatternId != nil{
			dictionary["RecurrencePatternId"] = recurrencePatternId
		}
		if rollOver != nil{
			dictionary["RollOver"] = rollOver
		}
		if sequence != nil{
			dictionary["Sequence"] = sequence
		}
		if startTime != nil{
			dictionary["StartTime"] = startTime
		}
		if subject != nil{
			dictionary["Subject"] = subject
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         activityType = aDecoder.decodeObject(forKey: "ActivityType") as? String
         allDay = aDecoder.decodeObject(forKey: "AllDay") as? Bool
         appointmentTypeId = aDecoder.decodeObject(forKey: "AppointmentTypeId") as? String
         assigneeId = aDecoder.decodeObject(forKey: "AssigneeId") as? AnyObject
         assigneeType = aDecoder.decodeObject(forKey: "AssigneeType") as? String
         contactDateFieldName = aDecoder.decodeObject(forKey: "ContactDateFieldName") as? String
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String
         dayOffset = aDecoder.decodeObject(forKey: "DayOffset") as? Int
         deliverableDate = aDecoder.decodeObject(forKey: "DeliverableDate") as? AnyObject
         deliverableType = aDecoder.decodeObject(forKey: "DeliverableType") as? String
         descriptionField = aDecoder.decodeObject(forKey: "Description") as? String
         endTime = aDecoder.decodeObject(forKey: "EndTime") as? String
         id = aDecoder.decodeObject(forKey: "Id") as? String
         location = aDecoder.decodeObject(forKey: "Location") as? String
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String
         recurrencePatternId = aDecoder.decodeObject(forKey: "RecurrencePatternId") as? String
         rollOver = aDecoder.decodeObject(forKey: "RollOver") as? Bool
         sequence = aDecoder.decodeObject(forKey: "Sequence") as? Int
         startTime = aDecoder.decodeObject(forKey: "StartTime") as? String
         subject = aDecoder.decodeObject(forKey: "Subject") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if activityType != nil{
			aCoder.encode(activityType, forKey: "ActivityType")
		}
		if allDay != nil{
			aCoder.encode(allDay, forKey: "AllDay")
		}
		if appointmentTypeId != nil{
			aCoder.encode(appointmentTypeId, forKey: "AppointmentTypeId")
		}
		if assigneeId != nil{
			aCoder.encode(assigneeId, forKey: "AssigneeId")
		}
		if assigneeType != nil{
			aCoder.encode(assigneeType, forKey: "AssigneeType")
		}
		if contactDateFieldName != nil{
			aCoder.encode(contactDateFieldName, forKey: "ContactDateFieldName")
		}
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "CreatedBy")
		}
		if createdOn != nil{
			aCoder.encode(createdOn, forKey: "CreatedOn")
		}
		if dayOffset != nil{
			aCoder.encode(dayOffset, forKey: "DayOffset")
		}
		if deliverableDate != nil{
			aCoder.encode(deliverableDate, forKey: "DeliverableDate")
		}
		if deliverableType != nil{
			aCoder.encode(deliverableType, forKey: "DeliverableType")
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
		if recurrencePatternId != nil{
			aCoder.encode(recurrencePatternId, forKey: "RecurrencePatternId")
		}
		if rollOver != nil{
			aCoder.encode(rollOver, forKey: "RollOver")
		}
		if sequence != nil{
			aCoder.encode(sequence, forKey: "Sequence")
		}
		if startTime != nil{
			aCoder.encode(startTime, forKey: "StartTime")
		}
		if subject != nil{
			aCoder.encode(subject, forKey: "Subject")
		}

	}

}
