//
//	PaymentCard.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PaymentCard : NSObject, NSCoding{

	var addressCity : String!
	var addressCountry : String!
	var addressLine1 : String!
	var addressLine2 : String!
	var addressState : String!
	var addressZip : String!
	var brand : String!
	var country : String!
	var cvcCheck : String!
	var expMonth : Int!
	var expYear : Int!
	var fingerprint : String!
	var fullCCNum : String!
	var funding : String!
	var id : String!
	var last4 : String!
	var name : String!
	var organizationId : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		addressCity = dictionary["AddressCity"] as? String ?? ""
		addressCountry = dictionary["AddressCountry"] as? String ?? ""
		addressLine1 = dictionary["AddressLine1"] as? String ?? ""
		addressLine2 = dictionary["AddressLine2"] as? String ?? ""
		addressState = dictionary["AddressState"] as? String ?? ""
		addressZip = dictionary["AddressZip"] as? String ?? ""
		brand = dictionary["Brand"] as? String ?? ""
		country = dictionary["Country"] as? String ?? ""
		cvcCheck = dictionary["CvcCheck"] as? String ?? ""
		expMonth = dictionary["ExpMonth"] as? Int
		expYear = dictionary["ExpYear"] as? Int
		fingerprint = dictionary["Fingerprint"] as? String ?? ""
		fullCCNum = dictionary["FullCCNum"] as? String ?? ""
		funding = dictionary["Funding"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		last4 = dictionary["Last4"] as? String ?? ""
		name = dictionary["Name"] as? String ?? ""
		organizationId = dictionary["OrganizationId"] as? String ?? ""
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if addressCity != nil{
			dictionary["AddressCity"] = addressCity
		}
		if addressCountry != nil{
			dictionary["AddressCountry"] = addressCountry
		}
		if addressLine1 != nil{
			dictionary["AddressLine1"] = addressLine1
		}
		if addressLine2 != nil{
			dictionary["AddressLine2"] = addressLine2
		}
		if addressState != nil{
			dictionary["AddressState"] = addressState
		}
		if addressZip != nil{
			dictionary["AddressZip"] = addressZip
		}
		if brand != nil{
			dictionary["Brand"] = brand
		}
		if country != nil{
			dictionary["Country"] = country
		}
		if cvcCheck != nil{
			dictionary["CvcCheck"] = cvcCheck
		}
		if expMonth != nil{
			dictionary["ExpMonth"] = expMonth
		}
		if expYear != nil{
			dictionary["ExpYear"] = expYear
		}
		if fingerprint != nil{
			dictionary["Fingerprint"] = fingerprint
		}
		if fullCCNum != nil{
			dictionary["FullCCNum"] = fullCCNum
		}
		if funding != nil{
			dictionary["Funding"] = funding
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if last4 != nil{
			dictionary["Last4"] = last4
		}
		if name != nil{
			dictionary["Name"] = name
		}
		if organizationId != nil{
			dictionary["OrganizationId"] = organizationId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         addressCity = aDecoder.decodeObject(forKey: "AddressCity") as? String ?? ""
         addressCountry = aDecoder.decodeObject(forKey: "AddressCountry") as? String ?? ""
         addressLine1 = aDecoder.decodeObject(forKey: "AddressLine1") as? String ?? ""
         addressLine2 = aDecoder.decodeObject(forKey: "AddressLine2") as? String ?? ""
         addressState = aDecoder.decodeObject(forKey: "AddressState") as? String ?? ""
         addressZip = aDecoder.decodeObject(forKey: "AddressZip") as? String ?? ""
         brand = aDecoder.decodeObject(forKey: "Brand") as? String ?? ""
         country = aDecoder.decodeObject(forKey: "Country") as? String ?? ""
         cvcCheck = aDecoder.decodeObject(forKey: "CvcCheck") as? String ?? ""
         expMonth = aDecoder.decodeObject(forKey: "ExpMonth") as? Int
         expYear = aDecoder.decodeObject(forKey: "ExpYear") as? Int
         fingerprint = aDecoder.decodeObject(forKey: "Fingerprint") as? String ?? ""
         fullCCNum = aDecoder.decodeObject(forKey: "FullCCNum") as? String ?? ""
         funding = aDecoder.decodeObject(forKey: "Funding") as? String ?? ""
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         last4 = aDecoder.decodeObject(forKey: "Last4") as? String ?? ""
         name = aDecoder.decodeObject(forKey: "Name") as? String ?? ""
         organizationId = aDecoder.decodeObject(forKey: "OrganizationId") as? String ?? ""

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if addressCity != nil{
			aCoder.encode(addressCity, forKey: "AddressCity")
		}
		if addressCountry != nil{
			aCoder.encode(addressCountry, forKey: "AddressCountry")
		}
		if addressLine1 != nil{
			aCoder.encode(addressLine1, forKey: "AddressLine1")
		}
		if addressLine2 != nil{
			aCoder.encode(addressLine2, forKey: "AddressLine2")
		}
		if addressState != nil{
			aCoder.encode(addressState, forKey: "AddressState")
		}
		if addressZip != nil{
			aCoder.encode(addressZip, forKey: "AddressZip")
		}
		if brand != nil{
			aCoder.encode(brand, forKey: "Brand")
		}
		if country != nil{
			aCoder.encode(country, forKey: "Country")
		}
		if cvcCheck != nil{
			aCoder.encode(cvcCheck, forKey: "CvcCheck")
		}
		if expMonth != nil{
			aCoder.encode(expMonth, forKey: "ExpMonth")
		}
		if expYear != nil{
			aCoder.encode(expYear, forKey: "ExpYear")
		}
		if fingerprint != nil{
			aCoder.encode(fingerprint, forKey: "Fingerprint")
		}
		if fullCCNum != nil{
			aCoder.encode(fullCCNum, forKey: "FullCCNum")
		}
		if funding != nil{
			aCoder.encode(funding, forKey: "Funding")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if last4 != nil{
			aCoder.encode(last4, forKey: "Last4")
		}
		if name != nil{
			aCoder.encode(name, forKey: "Name")
		}
		if organizationId != nil{
			aCoder.encode(organizationId, forKey: "OrganizationId")
		}

	}

}
