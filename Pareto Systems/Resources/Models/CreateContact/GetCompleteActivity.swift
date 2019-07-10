//
//	GetCompleteActivity.swift
//
//	Create by thabresh thabu on 16/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GetCompleteActivity : NSObject, NSCoding{

	var advocateProcessIndex : Int!
	var allDay : Bool!
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
	var rollOver : Bool!
	var startTime : String!
	var subject : String!
	var activity : GetCompleteActivity!
	var type : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		advocateProcessIndex = dictionary["AdvocateProcessIndex"] as? Int
		allDay = dictionary["AllDay"] as? Bool
		complete = dictionary["Complete"] as? Bool
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		descriptionField = dictionary["Description"] as? String ?? ""
		endTime = dictionary["EndTime"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		location = dictionary["Location"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		recurrenceIndex = dictionary["RecurrenceIndex"] as? Int
		rollOver = dictionary["RollOver"] as? Bool
		startTime = dictionary["StartTime"] as? String ?? ""
		subject = dictionary["Subject"] as? String ?? ""
		if let activityData = dictionary["Activity"] as? [String:Any]{
			activity = GetCompleteActivity(fromDictionary: activityData)
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
		if allDay != nil{
			dictionary["AllDay"] = allDay
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
         advocateProcessIndex = aDecoder.decodeObject(forKey: "AdvocateProcessIndex") as? Int
         allDay = aDecoder.decodeObject(forKey: "AllDay") as? Bool
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
         rollOver = aDecoder.decodeObject(forKey: "RollOver") as? Bool
         startTime = aDecoder.decodeObject(forKey: "StartTime") as? String ?? ""
         subject = aDecoder.decodeObject(forKey: "Subject") as? String ?? ""
         activity = aDecoder.decodeObject(forKey: "Activity") as? GetCompleteActivity
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
		if allDay != nil{
			aCoder.encode(allDay, forKey: "AllDay")
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
		if type != nil{
			aCoder.encode(type, forKey: "Type")
		}

	}

}
