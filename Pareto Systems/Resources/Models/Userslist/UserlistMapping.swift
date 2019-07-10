//
//	UserlistMapping.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UserlistMapping : NSObject, NSCoding{

	var responseMessage : String!
	var users : [UserlistUser]!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
		users = [UserlistUser]()
		if let usersArray = dictionary["Users"] as? [[String:Any]]{
			for dic in usersArray{
				let value = UserlistUser(fromDictionary: dic)
				users.append(value)
			}
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
		if users != nil{
			var dictionaryElements = [[String:Any]]()
			for usersElement in users {
				dictionaryElements.append(usersElement.toDictionary())
			}
			dictionary["Users"] = dictionaryElements
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
         users = aDecoder.decodeObject(forKey :"Users") as? [UserlistUser]
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
		if users != nil{
			aCoder.encode(users, forKey: "Users")
		}
		if valid != nil{
			aCoder.encode(valid, forKey: "Valid")
		}

	}

}
