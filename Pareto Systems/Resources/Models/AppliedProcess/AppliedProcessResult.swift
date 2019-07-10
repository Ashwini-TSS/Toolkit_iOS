//
//	AppliedProcessResult.swift
//
//	Create by Thabresh on 4/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AppliedProcessResult : NSObject, NSCoding{

	var advocateProcessId : String!
	var contactId : String!
	var createdBy : String!
	var createdOn : String!
	var dynamicProcess : Bool!
	var id : String!
	var initializationDate : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var name : String!
	var weekendAvoidance : Bool!
    var CompanyId:String!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
        CompanyId = dictionary["CompanyId"] as? String ?? ""
		advocateProcessId = dictionary["AdvocateProcessId"] as? String ?? ""
		contactId = dictionary["ContactId"] as? String ?? ""
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		dynamicProcess = dictionary["DynamicProcess"] as? Bool
		id = dictionary["Id"] as? String ?? ""
		initializationDate = dictionary["InitializationDate"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		name = dictionary["Name"] as? String ?? ""
		weekendAvoidance = dictionary["WeekendAvoidance"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        
        if CompanyId != nil{
            dictionary["CompanyId"] = CompanyId
        }
		if advocateProcessId != nil{
			dictionary["AdvocateProcessId"] = advocateProcessId
		}
		if contactId != nil{
			dictionary["ContactId"] = contactId
		}
		if createdBy != nil{
			dictionary["CreatedBy"] = createdBy
		}
		if createdOn != nil{
			dictionary["CreatedOn"] = createdOn
		}
		if dynamicProcess != nil{
			dictionary["DynamicProcess"] = dynamicProcess
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if initializationDate != nil{
			dictionary["InitializationDate"] = initializationDate
		}
		if modifiedBy != nil{
			dictionary["ModifiedBy"] = modifiedBy
		}
		if modifiedOn != nil{
			dictionary["ModifiedOn"] = modifiedOn
		}
		if name != nil{
			dictionary["Name"] = name
		}
		if weekendAvoidance != nil{
			dictionary["WeekendAvoidance"] = weekendAvoidance
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         CompanyId = aDecoder.decodeObject(forKey: "CompanyId") as? String ?? ""
         advocateProcessId = aDecoder.decodeObject(forKey: "AdvocateProcessId") as? String ?? ""
         contactId = aDecoder.decodeObject(forKey: "ContactId") as? String ?? ""
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
         dynamicProcess = aDecoder.decodeObject(forKey: "DynamicProcess") as? Bool
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         initializationDate = aDecoder.decodeObject(forKey: "InitializationDate") as? String ?? ""
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
         name = aDecoder.decodeObject(forKey: "Name") as? String ?? ""
         weekendAvoidance = aDecoder.decodeObject(forKey: "WeekendAvoidance") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if advocateProcessId != nil{
			aCoder.encode(advocateProcessId, forKey: "AdvocateProcessId")
		}
        if CompanyId != nil{
            aCoder.encode(CompanyId, forKey: "CompanyId")
        }
		if contactId != nil{
			aCoder.encode(contactId, forKey: "ContactId")
		}
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "CreatedBy")
		}
		if createdOn != nil{
			aCoder.encode(createdOn, forKey: "CreatedOn")
		}
		if dynamicProcess != nil{
			aCoder.encode(dynamicProcess, forKey: "DynamicProcess")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if initializationDate != nil{
			aCoder.encode(initializationDate, forKey: "InitializationDate")
		}
		if modifiedBy != nil{
			aCoder.encode(modifiedBy, forKey: "ModifiedBy")
		}
		if modifiedOn != nil{
			aCoder.encode(modifiedOn, forKey: "ModifiedOn")
		}
		if name != nil{
			aCoder.encode(name, forKey: "Name")
		}
		if weekendAvoidance != nil{
			aCoder.encode(weekendAvoidance, forKey: "WeekendAvoidance")
		}

	}

}
