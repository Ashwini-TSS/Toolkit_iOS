//
//	getTeammemberModel.swift
//
//	Create by thabresh thabu on 17/10/2018
//	Copyright © 2018. All rights reserved.

import Foundation


class getTeammemberModel : NSObject, NSCoding{

	var dataObject : getTeammemberDataObject!
	var responseMessage : String!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		if let dataObjectData = dictionary["DataObject"] as? [String:Any]{
			dataObject = getTeammemberDataObject(fromDictionary: dataObjectData)
		}
		responseMessage = dictionary["ResponseMessage"] as? String
		valid = dictionary["Valid"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if dataObject != nil{
			dictionary["DataObject"] = dataObject.toDictionary()
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
         dataObject = aDecoder.decodeObject(forKey: "DataObject") as? getTeammemberDataObject
         responseMessage = aDecoder.decodeObject(forKey: "ResponseMessage") as? String
         valid = aDecoder.decodeObject(forKey: "Valid") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if dataObject != nil{
			aCoder.encode(dataObject, forKey: "DataObject")
		}
		if responseMessage != nil{
			aCoder.encode(responseMessage, forKey: "ResponseMessage")
		}
		if valid != nil{
			aCoder.encode(valid, forKey: "Valid")
		}

	}

}
