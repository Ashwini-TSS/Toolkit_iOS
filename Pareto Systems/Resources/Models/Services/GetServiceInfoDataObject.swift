//
//	GetServiceInfoDataObject.swift
//
//	Create by thabresh thabu on 10/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GetServiceInfoDataObject : NSObject, NSCoding{

	var createdBy : String!
	var createdOn : String!
	var daysOfWeekMask : Int!
	var enableMonthOverlap : Bool!
	var id : String!
	var interval : Int!
	var modifiedBy : String!
	var modifiedOn : String!
	var monthOfYear : Int!
	var name : String!
	var patternType : String!
	var rescheduleAlgorithm : String!
	var weekOfMonth : String!
	var weekendAvoidanceMode : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		daysOfWeekMask = dictionary["DaysOfWeekMask"] as? Int
		enableMonthOverlap = dictionary["EnableMonthOverlap"] as? Bool
		id = dictionary["Id"] as? String ?? ""
		interval = dictionary["Interval"] as? Int
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		monthOfYear = dictionary["MonthOfYear"] as? Int
		name = dictionary["Name"] as? String ?? ""
		patternType = dictionary["PatternType"] as? String ?? ""
		rescheduleAlgorithm = dictionary["RescheduleAlgorithm"] as? String ?? ""
		weekOfMonth = dictionary["WeekOfMonth"] as? String ?? ""
		weekendAvoidanceMode = dictionary["WeekendAvoidanceMode"] as? String ?? ""
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if createdBy != nil{
			dictionary["CreatedBy"] = createdBy
		}
		if createdOn != nil{
			dictionary["CreatedOn"] = createdOn
		}
		if daysOfWeekMask != nil{
			dictionary["DaysOfWeekMask"] = daysOfWeekMask
		}
		if enableMonthOverlap != nil{
			dictionary["EnableMonthOverlap"] = enableMonthOverlap
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if interval != nil{
			dictionary["Interval"] = interval
		}
		if modifiedBy != nil{
			dictionary["ModifiedBy"] = modifiedBy
		}
		if modifiedOn != nil{
			dictionary["ModifiedOn"] = modifiedOn
		}
		if monthOfYear != nil{
			dictionary["MonthOfYear"] = monthOfYear
		}
		if name != nil{
			dictionary["Name"] = name
		}
		if patternType != nil{
			dictionary["PatternType"] = patternType
		}
		if rescheduleAlgorithm != nil{
			dictionary["RescheduleAlgorithm"] = rescheduleAlgorithm
		}
		if weekOfMonth != nil{
			dictionary["WeekOfMonth"] = weekOfMonth
		}
		if weekendAvoidanceMode != nil{
			dictionary["WeekendAvoidanceMode"] = weekendAvoidanceMode
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
         daysOfWeekMask = aDecoder.decodeObject(forKey: "DaysOfWeekMask") as? Int
         enableMonthOverlap = aDecoder.decodeObject(forKey: "EnableMonthOverlap") as? Bool
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         interval = aDecoder.decodeObject(forKey: "Interval") as? Int
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
         monthOfYear = aDecoder.decodeObject(forKey: "MonthOfYear") as? Int
         name = aDecoder.decodeObject(forKey: "Name") as? String ?? ""
         patternType = aDecoder.decodeObject(forKey: "PatternType") as? String ?? ""
         rescheduleAlgorithm = aDecoder.decodeObject(forKey: "RescheduleAlgorithm") as? String ?? ""
         weekOfMonth = aDecoder.decodeObject(forKey: "WeekOfMonth") as? String ?? ""
         weekendAvoidanceMode = aDecoder.decodeObject(forKey: "WeekendAvoidanceMode") as? String ?? ""

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "CreatedBy")
		}
		if createdOn != nil{
			aCoder.encode(createdOn, forKey: "CreatedOn")
		}
		if daysOfWeekMask != nil{
			aCoder.encode(daysOfWeekMask, forKey: "DaysOfWeekMask")
		}
		if enableMonthOverlap != nil{
			aCoder.encode(enableMonthOverlap, forKey: "EnableMonthOverlap")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if interval != nil{
			aCoder.encode(interval, forKey: "Interval")
		}
		if modifiedBy != nil{
			aCoder.encode(modifiedBy, forKey: "ModifiedBy")
		}
		if modifiedOn != nil{
			aCoder.encode(modifiedOn, forKey: "ModifiedOn")
		}
		if monthOfYear != nil{
			aCoder.encode(monthOfYear, forKey: "MonthOfYear")
		}
		if name != nil{
			aCoder.encode(name, forKey: "Name")
		}
		if patternType != nil{
			aCoder.encode(patternType, forKey: "PatternType")
		}
		if rescheduleAlgorithm != nil{
			aCoder.encode(rescheduleAlgorithm, forKey: "RescheduleAlgorithm")
		}
		if weekOfMonth != nil{
			aCoder.encode(weekOfMonth, forKey: "WeekOfMonth")
		}
		if weekendAvoidanceMode != nil{
			aCoder.encode(weekendAvoidanceMode, forKey: "WeekendAvoidanceMode")
		}

	}

}
