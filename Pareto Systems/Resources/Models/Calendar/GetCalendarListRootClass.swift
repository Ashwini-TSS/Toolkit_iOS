//
//	GetCalendarListRootClass.swift
//
//	Create by thabresh thabu on 23/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GetCalendarListRootClass : NSObject, NSCoding{

	var activities : [GetCalendarListActivity]!
	var responseMessage : String!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		activities = [GetCalendarListActivity]()
		if let activitiesArray = dictionary["Activities"] as? [[String:Any]]{
			for dic in activitiesArray{
                let dics = dic["Type"] as! String
                if(dics != "Task"){
				let value = GetCalendarListActivity(fromDictionary: dic)
				activities.append(value)
                }
			}
		}
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
		valid = dictionary["Valid"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if activities != nil{
			var dictionaryElements = [[String:Any]]()
			for activitiesElement in activities {
				dictionaryElements.append(activitiesElement.toDictionary())
			}
			dictionary["Activities"] = dictionaryElements
		}
		if responseMessage != nil{
			dictionary["ResponseMessage"] = responseMessage
		}
		if valid != nil{
			dictionary["Valid"] = valid
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         activities = aDecoder.decodeObject(forKey :"Activities") as? [GetCalendarListActivity]
         responseMessage = aDecoder.decodeObject(forKey: "ResponseMessage") as? String ?? ""
         valid = aDecoder.decodeObject(forKey: "Valid") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if activities != nil{
			aCoder.encode(activities, forKey: "Activities")
		}
		if responseMessage != nil{
			aCoder.encode(responseMessage, forKey: "ResponseMessage")
		}
		if valid != nil{
			aCoder.encode(valid, forKey: "Valid")
		}

	}

}
