//
//	getTeammemberDataObject.swift
//
//	Create by thabresh thabu on 17/10/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class getTeammemberDataObject : NSObject, NSCoding{

	var addressLine1 : String!
	var addressLine2 : String!
	var addressLine3 : String!
	var assistantId : AnyObject!
	var avatar : String!
	var city : String!
	var country : String!
	var createdBy : String!
	var createdOn : String!
	var emailAddress : String!
	var firstName : String!
	var fullName : String!
	var id : String!
	var lastName : String!
	var mainPhone : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var secondaryPhone : String!
	var state : String!
	var timeZone : String!
	var website : String!
	var zip : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		addressLine1 = dictionary["AddressLine1"] as? String
		addressLine2 = dictionary["AddressLine2"] as? String
		addressLine3 = dictionary["AddressLine3"] as? String
		assistantId = dictionary["AssistantId"] as? AnyObject
		avatar = dictionary["Avatar"] as? String
		city = dictionary["City"] as? String
		country = dictionary["Country"] as? String
		createdBy = dictionary["CreatedBy"] as? String
		createdOn = dictionary["CreatedOn"] as? String
		emailAddress = dictionary["EmailAddress"] as? String
		firstName = dictionary["FirstName"] as? String
		fullName = dictionary["FullName"] as? String
		id = dictionary["Id"] as? String
		lastName = dictionary["LastName"] as? String
		mainPhone = dictionary["MainPhone"] as? String
		modifiedBy = dictionary["ModifiedBy"] as? String
		modifiedOn = dictionary["ModifiedOn"] as? String
		secondaryPhone = dictionary["SecondaryPhone"] as? String
		state = dictionary["State"] as? String
		timeZone = dictionary["TimeZone"] as? String
		website = dictionary["Website"] as? String
		zip = dictionary["Zip"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if addressLine1 != nil{
			dictionary["AddressLine1"] = addressLine1
		}
		if addressLine2 != nil{
			dictionary["AddressLine2"] = addressLine2
		}
		if addressLine3 != nil{
			dictionary["AddressLine3"] = addressLine3
		}
		if assistantId != nil{
			dictionary["AssistantId"] = assistantId
		}
		if avatar != nil{
			dictionary["Avatar"] = avatar
		}
		if city != nil{
			dictionary["City"] = city
		}
		if country != nil{
			dictionary["Country"] = country
		}
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
		if fullName != nil{
			dictionary["FullName"] = fullName
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if lastName != nil{
			dictionary["LastName"] = lastName
		}
		if mainPhone != nil{
			dictionary["MainPhone"] = mainPhone
		}
		if modifiedBy != nil{
			dictionary["ModifiedBy"] = modifiedBy
		}
		if modifiedOn != nil{
			dictionary["ModifiedOn"] = modifiedOn
		}
		if secondaryPhone != nil{
			dictionary["SecondaryPhone"] = secondaryPhone
		}
		if state != nil{
			dictionary["State"] = state
		}
		if timeZone != nil{
			dictionary["TimeZone"] = timeZone
		}
		if website != nil{
			dictionary["Website"] = website
		}
		if zip != nil{
			dictionary["Zip"] = zip
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         addressLine1 = aDecoder.decodeObject(forKey: "AddressLine1") as? String
         addressLine2 = aDecoder.decodeObject(forKey: "AddressLine2") as? String
         addressLine3 = aDecoder.decodeObject(forKey: "AddressLine3") as? String
         assistantId = aDecoder.decodeObject(forKey: "AssistantId") as? AnyObject
         avatar = aDecoder.decodeObject(forKey: "Avatar") as? String
         city = aDecoder.decodeObject(forKey: "City") as? String
         country = aDecoder.decodeObject(forKey: "Country") as? String
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String
         emailAddress = aDecoder.decodeObject(forKey: "EmailAddress") as? String
         firstName = aDecoder.decodeObject(forKey: "FirstName") as? String
         fullName = aDecoder.decodeObject(forKey: "FullName") as? String
         id = aDecoder.decodeObject(forKey: "Id") as? String
         lastName = aDecoder.decodeObject(forKey: "LastName") as? String
         mainPhone = aDecoder.decodeObject(forKey: "MainPhone") as? String
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String
         secondaryPhone = aDecoder.decodeObject(forKey: "SecondaryPhone") as? String
         state = aDecoder.decodeObject(forKey: "State") as? String
         timeZone = aDecoder.decodeObject(forKey: "TimeZone") as? String
         website = aDecoder.decodeObject(forKey: "Website") as? String
         zip = aDecoder.decodeObject(forKey: "Zip") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if addressLine1 != nil{
			aCoder.encode(addressLine1, forKey: "AddressLine1")
		}
		if addressLine2 != nil{
			aCoder.encode(addressLine2, forKey: "AddressLine2")
		}
		if addressLine3 != nil{
			aCoder.encode(addressLine3, forKey: "AddressLine3")
		}
		if assistantId != nil{
			aCoder.encode(assistantId, forKey: "AssistantId")
		}
		if avatar != nil{
			aCoder.encode(avatar, forKey: "Avatar")
		}
		if city != nil{
			aCoder.encode(city, forKey: "City")
		}
		if country != nil{
			aCoder.encode(country, forKey: "Country")
		}
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
		if fullName != nil{
			aCoder.encode(fullName, forKey: "FullName")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "LastName")
		}
		if mainPhone != nil{
			aCoder.encode(mainPhone, forKey: "MainPhone")
		}
		if modifiedBy != nil{
			aCoder.encode(modifiedBy, forKey: "ModifiedBy")
		}
		if modifiedOn != nil{
			aCoder.encode(modifiedOn, forKey: "ModifiedOn")
		}
		if secondaryPhone != nil{
			aCoder.encode(secondaryPhone, forKey: "SecondaryPhone")
		}
		if state != nil{
			aCoder.encode(state, forKey: "State")
		}
		if timeZone != nil{
			aCoder.encode(timeZone, forKey: "TimeZone")
		}
		if website != nil{
			aCoder.encode(website, forKey: "Website")
		}
		if zip != nil{
			aCoder.encode(zip, forKey: "Zip")
		}

	}

}