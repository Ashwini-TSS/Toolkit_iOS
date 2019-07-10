//
//	getHistoryEntry.swift
//
//	Create by thabresh thabu on 24/8/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class getHistoryEntry : NSObject, NSCoding{

	var action : String!
	var after : getHistoryAfter!
	var before : AnyObject!
	var createdBy : String!
	var createdOn : String!
	var entityId : String!
	var entityType : String!
	var id : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var sequence : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		action = dictionary["Action"] as? String ?? ""
		if let afterData = dictionary["After"] as? [String:Any]{
			after = getHistoryAfter(fromDictionary: afterData)
		}
		before = dictionary["Before"] as? AnyObject
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		entityId = dictionary["EntityId"] as? String ?? ""
		entityType = dictionary["EntityType"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		sequence = dictionary["Sequence"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if action != nil{
			dictionary["Action"] = action
		}
		if after != nil{
			dictionary["After"] = after.toDictionary()
		}
		if before != nil{
			dictionary["Before"] = before
		}
		if createdBy != nil{
			dictionary["CreatedBy"] = createdBy
		}
		if createdOn != nil{
			dictionary["CreatedOn"] = createdOn
		}
		if entityId != nil{
			dictionary["EntityId"] = entityId
		}
		if entityType != nil{
			dictionary["EntityType"] = entityType
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
		if sequence != nil{
			dictionary["Sequence"] = sequence
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         action = aDecoder.decodeObject(forKey: "Action") as? String
         after = aDecoder.decodeObject(forKey: "After") as? getHistoryAfter
         before = aDecoder.decodeObject(forKey: "Before") as? AnyObject
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String
         entityId = aDecoder.decodeObject(forKey: "EntityId") as? String
         entityType = aDecoder.decodeObject(forKey: "EntityType") as? String
         id = aDecoder.decodeObject(forKey: "Id") as? String
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String
         sequence = aDecoder.decodeObject(forKey: "Sequence") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if action != nil{
			aCoder.encode(action, forKey: "Action")
		}
		if after != nil{
			aCoder.encode(after, forKey: "After")
		}
		if before != nil{
			aCoder.encode(before, forKey: "Before")
		}
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "CreatedBy")
		}
		if createdOn != nil{
			aCoder.encode(createdOn, forKey: "CreatedOn")
		}
		if entityId != nil{
			aCoder.encode(entityId, forKey: "EntityId")
		}
		if entityType != nil{
			aCoder.encode(entityType, forKey: "EntityType")
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
		if sequence != nil{
			aCoder.encode(sequence, forKey: "Sequence")
		}

	}

}
