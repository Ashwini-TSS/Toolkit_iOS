//
//	OrgStatusModel.swift
//
//	Create by thabresh thabu on 16/8/2018
//	Copyright © 2018. All rights reserved.

import Foundation


class OrgStatusModel : NSObject, NSCoding{

	var responseMessage : String!
	var status : OrgStatusStatu!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
		if let statusData = dictionary["Status"] as? [String:Any]{
			status = OrgStatusStatu(fromDictionary: statusData)
		}
		valid = dictionary["Valid"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if responseMessage != nil{
			dictionary["ResponseMessage"] = responseMessage
		}
		if status != nil{
			dictionary["Status"] = status.toDictionary()
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
         responseMessage = aDecoder.decodeObject(forKey: "ResponseMessage") as? String ?? ""
         status = aDecoder.decodeObject(forKey: "Status") as? OrgStatusStatu
         valid = aDecoder.decodeObject(forKey: "Valid") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if responseMessage != nil{
			aCoder.encode(responseMessage, forKey: "ResponseMessage")
		}
		if status != nil{
			aCoder.encode(status, forKey: "Status")
		}
		if valid != nil{
			aCoder.encode(valid, forKey: "Valid")
		}

	}

}
