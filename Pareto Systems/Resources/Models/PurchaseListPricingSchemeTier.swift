//
//	PurchaseListPricingSchemeTier.swift
//
//	Create by thabresh thabu on 17/8/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PurchaseListPricingSchemeTier : NSObject, NSCoding{

	var createdBy : String!
	var createdOn : String!
	var id : String!
	var minUsers : Int!
	var modifiedBy : String!
	var modifiedOn : String!
	var pricePerUser : Int!
	var pricingSchemeId : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		minUsers = dictionary["MinUsers"] as? Int
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		pricePerUser = dictionary["PricePerUser"] as? Int
		pricingSchemeId = dictionary["PricingSchemeId"] as? String ?? ""
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
		if id != nil{
			dictionary["Id"] = id
		}
		if minUsers != nil{
			dictionary["MinUsers"] = minUsers
		}
		if modifiedBy != nil{
			dictionary["ModifiedBy"] = modifiedBy
		}
		if modifiedOn != nil{
			dictionary["ModifiedOn"] = modifiedOn
		}
		if pricePerUser != nil{
			dictionary["PricePerUser"] = pricePerUser
		}
		if pricingSchemeId != nil{
			dictionary["PricingSchemeId"] = pricingSchemeId
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
         id = aDecoder.decodeObject(forKey: "Id") as? String
         minUsers = aDecoder.decodeObject(forKey: "MinUsers") as? Int
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String
         pricePerUser = aDecoder.decodeObject(forKey: "PricePerUser") as? Int
         pricingSchemeId = aDecoder.decodeObject(forKey: "PricingSchemeId") as? String

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
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if minUsers != nil{
			aCoder.encode(minUsers, forKey: "MinUsers")
		}
		if modifiedBy != nil{
			aCoder.encode(modifiedBy, forKey: "ModifiedBy")
		}
		if modifiedOn != nil{
			aCoder.encode(modifiedOn, forKey: "ModifiedOn")
		}
		if pricePerUser != nil{
			aCoder.encode(pricePerUser, forKey: "PricePerUser")
		}
		if pricingSchemeId != nil{
			aCoder.encode(pricingSchemeId, forKey: "PricingSchemeId")
		}

	}

}
