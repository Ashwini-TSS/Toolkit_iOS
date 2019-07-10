//
//	UserlistUser.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UserlistUser : NSObject, NSCoding{

	var createdBy : String!
	var createdOn : String!
	var emailAddress : String!
	var firstName : String!
	var id : String!
	var lastName : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var userName : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		emailAddress = dictionary["EmailAddress"] as? String ?? ""
		firstName = dictionary["FirstName"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		lastName = dictionary["LastName"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		userName = dictionary["UserName"] as? String ?? ""
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
		if emailAddress != nil{
			dictionary["EmailAddress"] = emailAddress
		}
		if firstName != nil{
			dictionary["FirstName"] = firstName
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if lastName != nil{
			dictionary["LastName"] = lastName
		}
		if modifiedBy != nil{
			dictionary["ModifiedBy"] = modifiedBy
		}
		if modifiedOn != nil{
			dictionary["ModifiedOn"] = modifiedOn
		}
		if userName != nil{
			dictionary["UserName"] = userName
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
         emailAddress = aDecoder.decodeObject(forKey: "EmailAddress") as? String ?? ""
         firstName = aDecoder.decodeObject(forKey: "FirstName") as? String ?? ""
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         lastName = aDecoder.decodeObject(forKey: "LastName") as? String ?? ""
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
         userName = aDecoder.decodeObject(forKey: "UserName") as? String ?? ""

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
		if emailAddress != nil{
			aCoder.encode(emailAddress, forKey: "EmailAddress")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "FirstName")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "LastName")
		}
		if modifiedBy != nil{
			aCoder.encode(modifiedBy, forKey: "ModifiedBy")
		}
		if modifiedOn != nil{
			aCoder.encode(modifiedOn, forKey: "ModifiedOn")
		}
		if userName != nil{
			aCoder.encode(userName, forKey: "UserName")
		}

	}

}
