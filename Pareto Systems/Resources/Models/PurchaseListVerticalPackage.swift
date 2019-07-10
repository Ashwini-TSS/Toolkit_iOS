//
//	PurchaseListVerticalPackage.swift
//
//	Create by thabresh thabu on 17/8/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PurchaseListVerticalPackage : NSObject, NSCoding{

	var annualPricingSchemeId : AnyObject!
	var createdBy : String!
	var createdOn : String!
	var descriptionField : String!
	var free : Bool!
	var id : String!
	var largeImageUri : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var name : String!
	var outline : String!
	var pricingSchemeId : AnyObject!
	var saleable : Bool!
	var smallImageUri : String!
	var tagLine : String!
	var toolkit : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		annualPricingSchemeId = dictionary["AnnualPricingSchemeId"] as? AnyObject
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		descriptionField = dictionary["Description"] as? String ?? ""
		free = dictionary["Free"] as? Bool
		id = dictionary["Id"] as? String ?? ""
		largeImageUri = dictionary["LargeImageUri"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		name = dictionary["Name"] as? String ?? ""
		outline = dictionary["Outline"] as? String ?? ""
		pricingSchemeId = dictionary["PricingSchemeId"] as? AnyObject
		saleable = dictionary["Saleable"] as? Bool
		smallImageUri = dictionary["SmallImageUri"] as? String ?? ""
		tagLine = dictionary["TagLine"] as? String ?? ""
		toolkit = dictionary["Toolkit"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if annualPricingSchemeId != nil{
			dictionary["AnnualPricingSchemeId"] = annualPricingSchemeId
		}
		if createdBy != nil{
			dictionary["CreatedBy"] = createdBy
		}
		if createdOn != nil{
			dictionary["CreatedOn"] = createdOn
		}
		if descriptionField != nil{
			dictionary["Description"] = descriptionField
		}
		if free != nil{
			dictionary["Free"] = free
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if largeImageUri != nil{
			dictionary["LargeImageUri"] = largeImageUri
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
		if outline != nil{
			dictionary["Outline"] = outline
		}
		if pricingSchemeId != nil{
			dictionary["PricingSchemeId"] = pricingSchemeId
		}
		if saleable != nil{
			dictionary["Saleable"] = saleable
		}
		if smallImageUri != nil{
			dictionary["SmallImageUri"] = smallImageUri
		}
		if tagLine != nil{
			dictionary["TagLine"] = tagLine
		}
		if toolkit != nil{
			dictionary["Toolkit"] = toolkit
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         annualPricingSchemeId = aDecoder.decodeObject(forKey: "AnnualPricingSchemeId") as? AnyObject
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String
         descriptionField = aDecoder.decodeObject(forKey: "Description") as? String
         free = aDecoder.decodeObject(forKey: "Free") as? Bool
         id = aDecoder.decodeObject(forKey: "Id") as? String
         largeImageUri = aDecoder.decodeObject(forKey: "LargeImageUri") as? String
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String
         name = aDecoder.decodeObject(forKey: "Name") as? String
         outline = aDecoder.decodeObject(forKey: "Outline") as? String
         pricingSchemeId = aDecoder.decodeObject(forKey: "PricingSchemeId") as? AnyObject
         saleable = aDecoder.decodeObject(forKey: "Saleable") as? Bool
         smallImageUri = aDecoder.decodeObject(forKey: "SmallImageUri") as? String
         tagLine = aDecoder.decodeObject(forKey: "TagLine") as? String
         toolkit = aDecoder.decodeObject(forKey: "Toolkit") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if annualPricingSchemeId != nil{
			aCoder.encode(annualPricingSchemeId, forKey: "AnnualPricingSchemeId")
		}
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "CreatedBy")
		}
		if createdOn != nil{
			aCoder.encode(createdOn, forKey: "CreatedOn")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "Description")
		}
		if free != nil{
			aCoder.encode(free, forKey: "Free")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if largeImageUri != nil{
			aCoder.encode(largeImageUri, forKey: "LargeImageUri")
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
		if outline != nil{
			aCoder.encode(outline, forKey: "Outline")
		}
		if pricingSchemeId != nil{
			aCoder.encode(pricingSchemeId, forKey: "PricingSchemeId")
		}
		if saleable != nil{
			aCoder.encode(saleable, forKey: "Saleable")
		}
		if smallImageUri != nil{
			aCoder.encode(smallImageUri, forKey: "SmallImageUri")
		}
		if tagLine != nil{
			aCoder.encode(tagLine, forKey: "TagLine")
		}
		if toolkit != nil{
			aCoder.encode(toolkit, forKey: "Toolkit")
		}

	}

}
