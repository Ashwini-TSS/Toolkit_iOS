//
//	GetStepsResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GetStepsResult : NSObject, NSCoding{

	var activityType : String!
	var advocateProcessId : String!
	var allDay : Bool!
	var appointmentTypeId : String!
	var assigneeType : String!
	var createdBy : String!
	var createdOn : String!
	var dayOffset : Int!
	var descriptionField : String!
	var endTime : String!
	var id : String!
	var location : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var rollOver : Bool!
	var sequence : Int!
	var startTime : String!
	var subject : String!
    var AssigneeId : String!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		activityType = dictionary["ActivityType"] as? String ?? ""
		advocateProcessId = dictionary["AdvocateProcessId"] as? String ?? ""
		allDay = dictionary["AllDay"] as? Bool
		appointmentTypeId = dictionary["AppointmentTypeId"] as? String ?? ""
		assigneeType = dictionary["AssigneeType"] as? String ?? ""
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		dayOffset = dictionary["DayOffset"] as? Int
		descriptionField = dictionary["Description"] as? String ?? ""
		endTime = dictionary["EndTime"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		location = dictionary["Location"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		rollOver = dictionary["RollOver"] as? Bool
		sequence = dictionary["Sequence"] as? Int
		startTime = dictionary["StartTime"] as? String ?? ""
		subject = dictionary["Subject"] as? String ?? ""
        AssigneeId = dictionary["AssigneeId"] as? String ?? ""

        //    var AssigneeId : String!

	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if AssigneeId != nil{
            dictionary["AssigneeId"] = activityType
        }
		if activityType != nil{
			dictionary["ActivityType"] = activityType
		}
		if advocateProcessId != nil{
			dictionary["AdvocateProcessId"] = advocateProcessId
		}
		if allDay != nil{
			dictionary["AllDay"] = allDay
		}
		if appointmentTypeId != nil{
			dictionary["AppointmentTypeId"] = appointmentTypeId
		}
		if assigneeType != nil{
			dictionary["AssigneeType"] = assigneeType
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
       
         AssigneeId = aDecoder.decodeObject(forKey: "AssigneeId") as? String ?? ""
         activityType = aDecoder.decodeObject(forKey: "ActivityType") as? String ?? ""
         advocateProcessId = aDecoder.decodeObject(forKey: "AdvocateProcessId") as? String ?? ""
         allDay = aDecoder.decodeObject(forKey: "AllDay") as? Bool
         appointmentTypeId = aDecoder.decodeObject(forKey: "AppointmentTypeId") as? String ?? ""
         assigneeType = aDecoder.decodeObject(forKey: "AssigneeType") as? String ?? ""
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
         dayOffset = aDecoder.decodeObject(forKey: "DayOffset") as? Int
         descriptionField = aDecoder.decodeObject(forKey: "Description") as? String ?? ""
         endTime = aDecoder.decodeObject(forKey: "EndTime") as? String ?? ""
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         location = aDecoder.decodeObject(forKey: "Location") as? String ?? ""
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
         rollOver = aDecoder.decodeObject(forKey: "RollOver") as? Bool
         sequence = aDecoder.decodeObject(forKey: "Sequence") as? Int
         startTime = aDecoder.decodeObject(forKey: "StartTime") as? String ?? ""
         subject = aDecoder.decodeObject(forKey: "Subject") as? String ?? ""

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
        if AssigneeId != nil{
            aCoder.encode(activityType, forKey: "AssigneeId")
        }
		if activityType != nil{
			aCoder.encode(activityType, forKey: "ActivityType")
		}
		if advocateProcessId != nil{
			aCoder.encode(advocateProcessId, forKey: "AdvocateProcessId")
		}
		if allDay != nil{
			aCoder.encode(allDay, forKey: "AllDay")
		}
		if appointmentTypeId != nil{
			aCoder.encode(appointmentTypeId, forKey: "AppointmentTypeId")
		}
		if assigneeType != nil{
			aCoder.encode(assigneeType, forKey: "AssigneeType")
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
