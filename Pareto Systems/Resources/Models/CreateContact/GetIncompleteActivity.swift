//
//	GetIncompleteActivity.swift
//
//	Create by thabresh thabu on 16/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GetIncompleteActivity : NSObject, NSCoding{

	var advocateProcessIndex : Int!
	var allDay : Bool!
	var complete : Bool!
	var createdBy : String!
	var createdOn : String!
    var DueTime : String!
	var descriptionField : String!
	var endTime : String!
    var AppliedAdvocateProcessId : String!
	var id : String!
	var location : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var recurrenceIndex : Int!
    var RecurringActivityId : String!
	var rollOver : Bool!
	var startTime : String!
	var subject : String!
	var activity : GetIncompleteActivity!
	var type : String!
    var Priority : String!
    var PercentComplete : Int!
    var appID : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		advocateProcessIndex = dictionary["AdvocateProcessIndex"] as? Int
        PercentComplete = dictionary["PercentComplete"] as? Int
		allDay = dictionary["AllDay"] as? Bool
		complete = dictionary["Complete"] as? Bool
		createdBy = dictionary["CreatedBy"] as? String ?? ""
        Priority = dictionary["Priority"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		descriptionField = dictionary["Description"] as? String ?? ""
		endTime = dictionary["EndTime"] as? String ?? ""
        DueTime = dictionary["DueTime"] as? String ?? ""
        AppliedAdvocateProcessId = dictionary["AppliedAdvocateProcessId"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		location = dictionary["Location"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
        RecurringActivityId = dictionary["RecurringActivityId"] as? String ?? ""
		recurrenceIndex = dictionary["RecurrenceIndex"] as? Int
		rollOver = dictionary["RollOver"] as? Bool
		startTime = dictionary["StartTime"] as? String ?? ""
		subject = dictionary["Subject"] as? String ?? ""
        appID = dictionary["AppointmentTypeId"] as? String ?? ""
		if let activityData = dictionary["Activity"] as? [String:Any]{
			activity = GetIncompleteActivity(fromDictionary: activityData)
		}
		type = dictionary["Type"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if appID != nil{
            dictionary["AppointmentTypeId"] = appID
        }
		if advocateProcessIndex != nil{
			dictionary["AdvocateProcessIndex"] = advocateProcessIndex
		}
        if PercentComplete != nil{
            dictionary["PercentComplete"] = PercentComplete
        }
		if allDay != nil{
			dictionary["AllDay"] = allDay
		}
		if complete != nil{
			dictionary["Complete"] = complete
		}
        if Priority != nil{
            dictionary["Priority"] = Priority
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
        if DueTime != nil{
            dictionary["DueTime"] = DueTime
        }
        if AppliedAdvocateProcessId != nil{
            dictionary["AppliedAdvocateProcessId"] = AppliedAdvocateProcessId
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
        if RecurringActivityId != nil{
            dictionary["RecurringActivityId"] = RecurringActivityId
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
         PercentComplete = aDecoder.decodeObject(forKey: "PercentComplete") as? Int
         allDay = aDecoder.decodeObject(forKey: "AllDay") as? Bool
         complete = aDecoder.decodeObject(forKey: "Complete") as? Bool
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
         descriptionField = aDecoder.decodeObject(forKey: "Description") as? String ?? ""
         AppliedAdvocateProcessId = aDecoder.decodeObject(forKey: "AppliedAdvocateProcessId") as? String ?? ""
         endTime = aDecoder.decodeObject(forKey: "EndTime") as? String ?? ""
         Priority = aDecoder.decodeObject(forKey: "Priority") as? String ?? ""
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         location = aDecoder.decodeObject(forKey: "Location") as? String ?? ""
         DueTime = aDecoder.decodeObject(forKey: "DueTime") as? String ?? ""
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
         RecurringActivityId = aDecoder.decodeObject(forKey: "RecurringActivityId") as? String ?? ""
         recurrenceIndex = aDecoder.decodeObject(forKey: "RecurrenceIndex") as? Int
         rollOver = aDecoder.decodeObject(forKey: "RollOver") as? Bool
         startTime = aDecoder.decodeObject(forKey: "StartTime") as? String ?? ""
         subject = aDecoder.decodeObject(forKey: "Subject") as? String ?? ""
         activity = aDecoder.decodeObject(forKey: "Activity") as? GetIncompleteActivity
         type = aDecoder.decodeObject(forKey: "Type") as? String ?? ""
            appID = aDecoder.decodeObject(forKey: "AppointmentTypeId") as? String ?? ""

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
        if appID != nil{
            aCoder.encode(appID, forKey: "AppointmentTypeId")
        }
		if advocateProcessIndex != nil{
			aCoder.encode(advocateProcessIndex, forKey: "AdvocateProcessIndex")
		}
        if PercentComplete != nil{
            aCoder.encode(PercentComplete, forKey: "PercentComplete")
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
        if Priority != nil{
            aCoder.encode(Priority, forKey: "Priority")
        }
		if createdOn != nil{
			aCoder.encode(createdOn, forKey: "CreatedOn")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "Description")
		}
        if AppliedAdvocateProcessId != nil{
            aCoder.encode(AppliedAdvocateProcessId, forKey: "AppliedAdvocateProcessId")
        }
        else
        {
            AppliedAdvocateProcessId = ""
            aCoder.encode(AppliedAdvocateProcessId, forKey: "AppliedAdvocateProcessId")
        }
		if endTime != nil{
			aCoder.encode(endTime, forKey: "EndTime")
		}
        if DueTime != nil{
            aCoder.encode(DueTime, forKey: "DueTime")
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
        if RecurringActivityId != nil{
            aCoder.encode(RecurringActivityId, forKey: "RecurringActivityId")
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
