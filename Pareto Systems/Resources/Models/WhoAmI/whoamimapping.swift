//
//	whoamimapping.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class whoamimapping : NSObject, NSCoding{

	var responseMessage : String!
	var superUser : Bool!
	var user : whoamiUser!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
		superUser = dictionary["SuperUser"] as? Bool
		if let userData = dictionary["User"] as? [String:Any]{
			user = whoamiUser(fromDictionary: userData)
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
		if superUser != nil{
			dictionary["SuperUser"] = superUser
		}
		if user != nil{
			dictionary["User"] = user.toDictionary()
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
         superUser = aDecoder.decodeObject(forKey: "SuperUser") as? Bool
         user = aDecoder.decodeObject(forKey: "User") as? whoamiUser
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
		if superUser != nil{
			aCoder.encode(superUser, forKey: "SuperUser")
		}
		if user != nil{
			aCoder.encode(user, forKey: "User")
		}
		if valid != nil{
			aCoder.encode(valid, forKey: "Valid")
		}

	}

}
