//
//	getRecreationResult.swift
//
//	Create by thabresh thabu on 17/10/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class getRecreationResult : NSObject, NSCoding{

	var createdBy : String!
	var createdOn : String!
	var descriptionField : String!
	var id : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var name : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		createdBy = dictionary["CreatedBy"] as? String
		createdOn = dictionary["CreatedOn"] as? String
		descriptionField = dictionary["Description"] as? String
		id = dictionary["Id"] as? String
		modifiedBy = dictionary["ModifiedBy"] as? String
		modifiedOn = dictionary["ModifiedOn"] as? String
		name = dictionary["Name"] as? String
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
		if descriptionField != nil{
			dictionary["Description"] = descriptionField
		}
		if id != nil{
			dictionary["Id"] = id
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
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String
         descriptionField = aDecoder.decodeObject(forKey: "Description") as? String
         id = aDecoder.decodeObject(forKey: "Id") as? String
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String
         name = aDecoder.decodeObject(forKey: "Name") as? String

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
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "Description")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
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

	}

}