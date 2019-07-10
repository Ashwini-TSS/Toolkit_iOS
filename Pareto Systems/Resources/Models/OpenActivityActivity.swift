//
//	OpenActivityActivity.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class OpenActivityActivity : NSObject, NSCoding{
    var recurrenceID : String!

    var AppointmentTypeId : String!
	var advocateProcessIndex : Int!
    var AppliedAdvocateProcessId : String!
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
	var activity : OpenActivityActivity!
	var type : String!
    var PercentComplete:Int!
    var Priority:String!
    var DueTime:String!
    var appID:String!
	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    
	init(fromDictionary dictionary: [String:Any]){
        DueTime = dictionary["DueTime"] as? String ?? ""
        appID = dictionary["appID"] as? String ?? ""

        Priority = dictionary["Priority"] as? String ?? ""
        PercentComplete = dictionary["PercentComplete"] as? Int
		advocateProcessIndex = dictionary["AdvocateProcessIndex"] as? Int
		allDay = dictionary["AllDay"] as? Bool
		complete = dictionary["Complete"] as? Bool
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
        descriptionField = dictionary["Description"] as? String ?? ""
		AppliedAdvocateProcessId = dictionary["AppliedAdvocateProcessId"] as? String ?? ""
		endTime = dictionary["EndTime"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		location = dictionary["Location"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
        AppointmentTypeId = dictionary["AppointmentTypeId"] as? String ?? ""
		recurrenceIndex = dictionary["RecurrenceIndex"] as? Int
		rollOver = dictionary["RollOver"] as? Bool
		startTime = dictionary["StartTime"] as? String ?? ""
		subject = dictionary["Subject"] as? String ?? ""
        recurrenceID = dictionary["RecurringActivityId"] as? String ?? ""

		if let activityData = dictionary["Activity"] as? [String:Any]{
			activity = OpenActivityActivity(fromDictionary: activityData)
		}
		type = dictionary["Type"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if recurrenceID != nil{
            dictionary["RecurringActivityId"] = recurrenceID
        }
        if DueTime != nil{
            dictionary["DueTime"] = DueTime
        }
        if Priority != nil{
            dictionary["Priority"] = Priority
        }
		if advocateProcessIndex != nil{
			dictionary["AdvocateProcessIndex"] = advocateProcessIndex
		}
        if PercentComplete != nil{
            dictionary["PercentComplete"] = PercentComplete
        }
        if AppointmentTypeId != nil{
            dictionary["AppointmentTypeId"] = AppointmentTypeId
        }
		if allDay != nil{
			dictionary["AllDay"] = allDay
		}
        if AppliedAdvocateProcessId != nil{
            dictionary["AppliedAdvocateProcessId"] = AppliedAdvocateProcessId
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
       
         recurrenceID = aDecoder.decodeObject(forKey: "RecurringActivityId") as? String
         AppliedAdvocateProcessId = aDecoder.decodeObject(forKey: "AppliedAdvocateProcessId") as? String

         advocateProcessIndex = aDecoder.decodeObject(forKey: "AdvocateProcessIndex") as? Int
         allDay = aDecoder.decodeObject(forKey: "AllDay") as? Bool
         complete = aDecoder.decodeObject(forKey: "Complete") as? Bool
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
         DueTime = aDecoder.decodeObject(forKey: "DueTime") as? String ?? ""
         descriptionField = aDecoder.decodeObject(forKey: "Description") as? String ?? ""
         endTime = aDecoder.decodeObject(forKey: "EndTime") as? String ?? ""
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         location = aDecoder.decodeObject(forKey: "Location") as? String ?? ""
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
         recurrenceIndex = aDecoder.decodeObject(forKey: "RecurrenceIndex") as? Int
         PercentComplete = aDecoder.decodeObject(forKey: "PercentComplete") as? Int
         rollOver = aDecoder.decodeObject(forKey: "RollOver") as? Bool
         startTime = aDecoder.decodeObject(forKey: "StartTime") as? String ?? ""
         subject = aDecoder.decodeObject(forKey: "Subject") as? String ?? ""
         Priority = aDecoder.decodeObject(forKey: "Priority") as? String ?? ""
         activity = aDecoder.decodeObject(forKey: "Activity") as? OpenActivityActivity
         type = aDecoder.decodeObject(forKey: "Type") as? String ?? ""
        AppointmentTypeId = aDecoder.decodeObject(forKey: "AppointmentTypeId") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
        if recurrenceID != nil{
            aCoder.encode(recurrenceID, forKey: "RecurringActivityId")
        }
        
        if AppliedAdvocateProcessId != nil{
            aCoder.encode(AppliedAdvocateProcessId, forKey: "AppliedAdvocateProcessId")
        }
        
		if advocateProcessIndex != nil{
			aCoder.encode(advocateProcessIndex, forKey: "AdvocateProcessIndex")
		}
        if AppointmentTypeId != nil{
            aCoder.encode(AppointmentTypeId, forKey: "AppointmentTypeId")
        }
		if allDay != nil{
			aCoder.encode(allDay, forKey: "AllDay")
		}
		if complete != nil{
			aCoder.encode(complete, forKey: "Complete")
		}
        if Priority != nil{
            aCoder.encode(Priority, forKey: "Priority")
        }
        if DueTime != nil{
            aCoder.encode(DueTime, forKey: "DueTime")
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
        if PercentComplete != nil{
            aCoder.encode(PercentComplete, forKey: "PercentComplete")
        }

	}

}
