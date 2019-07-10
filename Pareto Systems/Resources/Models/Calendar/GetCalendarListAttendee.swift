//
//	GetCalendarListAttendee.swift
//
//	Create by thabresh thabu on 23/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GetCalendarListAttendee : NSObject, NSCoding{

	var companyIds : [String]!
	var contactIds : [AnyObject]!
	var userIds : [AnyObject]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		companyIds = dictionary["CompanyIds"] as? [String]
		contactIds = dictionary["ContactIds"] as? [AnyObject]
		userIds = dictionary["UserIds"] as? [AnyObject]
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if companyIds != nil{
			dictionary["CompanyIds"] = companyIds
		}
		if contactIds != nil{
			dictionary["ContactIds"] = contactIds
		}
		if userIds != nil{
			dictionary["UserIds"] = userIds
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         companyIds = aDecoder.decodeObject(forKey: "CompanyIds") as? [String]
         contactIds = aDecoder.decodeObject(forKey: "ContactIds") as? [AnyObject]
         userIds = aDecoder.decodeObject(forKey: "UserIds") as? [AnyObject]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if companyIds != nil{
			aCoder.encode(companyIds, forKey: "CompanyIds")
		}
		if contactIds != nil{
			aCoder.encode(contactIds, forKey: "ContactIds")
		}
		if userIds != nil{
			aCoder.encode(userIds, forKey: "UserIds")
		}

	}

}