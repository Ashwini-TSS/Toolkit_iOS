//
//	GetAdditionalAddressResult.swift
//
//	Create by thabresh thabu on 16/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GetAdditionalAddressResult : NSObject, NSCoding{

	var city : String!
	var country : String!
	var county : String!
	var createdBy : String!
	var createdOn : String!
	var fax : String!
	var id : String!
	var latitude : Float!
	var line1 : String!
	var line2 : String!
	var line3 : String!
	var longitude : Float!
	var modifiedBy : String!
	var modifiedOn : String!
	var name : String!
	var postOfficeBox : String!
	var postalCode : String!
	var stateOrProvince : String!
	var telephone1 : String!
	var telephone2 : String!
	var telephone3 : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		city = dictionary["City"] as? String ?? ""
		country = dictionary["Country"] as? String ?? ""
		county = dictionary["County"] as? String ?? ""
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		fax = dictionary["Fax"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		latitude = dictionary["Latitude"] as? Float
		line1 = dictionary["Line1"] as? String ?? ""
		line2 = dictionary["Line2"] as? String ?? ""
		line3 = dictionary["Line3"] as? String ?? ""
		longitude = dictionary["Longitude"] as? Float
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		name = dictionary["Name"] as? String ?? ""
		postOfficeBox = dictionary["PostOfficeBox"] as? String ?? ""
		postalCode = dictionary["PostalCode"] as? String ?? ""
		stateOrProvince = dictionary["StateOrProvince"] as? String ?? ""
		telephone1 = dictionary["Telephone1"] as? String ?? ""
		telephone2 = dictionary["Telephone2"] as? String ?? ""
		telephone3 = dictionary["Telephone3"] as? String ?? ""
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if city != nil{
			dictionary["City"] = city
		}
		if country != nil{
			dictionary["Country"] = country
		}
		if county != nil{
			dictionary["County"] = county
		}
		if createdBy != nil{
			dictionary["CreatedBy"] = createdBy
		}
		if createdOn != nil{
			dictionary["CreatedOn"] = createdOn
		}
		if fax != nil{
			dictionary["Fax"] = fax
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if latitude != nil{
			dictionary["Latitude"] = latitude
		}
		if line1 != nil{
			dictionary["Line1"] = line1
		}
		if line2 != nil{
			dictionary["Line2"] = line2
		}
		if line3 != nil{
			dictionary["Line3"] = line3
		}
		if longitude != nil{
			dictionary["Longitude"] = longitude
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
		if postOfficeBox != nil{
			dictionary["PostOfficeBox"] = postOfficeBox
		}
		if postalCode != nil{
			dictionary["PostalCode"] = postalCode
		}
		if stateOrProvince != nil{
			dictionary["StateOrProvince"] = stateOrProvince
		}
		if telephone1 != nil{
			dictionary["Telephone1"] = telephone1
		}
		if telephone2 != nil{
			dictionary["Telephone2"] = telephone2
		}
		if telephone3 != nil{
			dictionary["Telephone3"] = telephone3
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         city = aDecoder.decodeObject(forKey: "City") as? String ?? ""
         country = aDecoder.decodeObject(forKey: "Country") as? String ?? ""
         county = aDecoder.decodeObject(forKey: "County") as? String ?? ""
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
         fax = aDecoder.decodeObject(forKey: "Fax") as? String ?? ""
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         latitude = aDecoder.decodeObject(forKey: "Latitude") as? Float
         line1 = aDecoder.decodeObject(forKey: "Line1") as? String ?? ""
         line2 = aDecoder.decodeObject(forKey: "Line2") as? String ?? ""
         line3 = aDecoder.decodeObject(forKey: "Line3") as? String ?? ""
         longitude = aDecoder.decodeObject(forKey: "Longitude") as? Float
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
         name = aDecoder.decodeObject(forKey: "Name") as? String ?? ""
         postOfficeBox = aDecoder.decodeObject(forKey: "PostOfficeBox") as? String ?? ""
         postalCode = aDecoder.decodeObject(forKey: "PostalCode") as? String ?? ""
         stateOrProvince = aDecoder.decodeObject(forKey: "StateOrProvince") as? String ?? ""
         telephone1 = aDecoder.decodeObject(forKey: "Telephone1") as? String ?? ""
         telephone2 = aDecoder.decodeObject(forKey: "Telephone2") as? String ?? ""
         telephone3 = aDecoder.decodeObject(forKey: "Telephone3") as? String ?? ""

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if city != nil{
			aCoder.encode(city, forKey: "City")
		}
		if country != nil{
			aCoder.encode(country, forKey: "Country")
		}
		if county != nil{
			aCoder.encode(county, forKey: "County")
		}
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "CreatedBy")
		}
		if createdOn != nil{
			aCoder.encode(createdOn, forKey: "CreatedOn")
		}
		if fax != nil{
			aCoder.encode(fax, forKey: "Fax")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if latitude != nil{
			aCoder.encode(latitude, forKey: "Latitude")
		}
		if line1 != nil{
			aCoder.encode(line1, forKey: "Line1")
		}
		if line2 != nil{
			aCoder.encode(line2, forKey: "Line2")
		}
		if line3 != nil{
			aCoder.encode(line3, forKey: "Line3")
		}
		if longitude != nil{
			aCoder.encode(longitude, forKey: "Longitude")
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
		if postOfficeBox != nil{
			aCoder.encode(postOfficeBox, forKey: "PostOfficeBox")
		}
		if postalCode != nil{
			aCoder.encode(postalCode, forKey: "PostalCode")
		}
		if stateOrProvince != nil{
			aCoder.encode(stateOrProvince, forKey: "StateOrProvince")
		}
		if telephone1 != nil{
			aCoder.encode(telephone1, forKey: "Telephone1")
		}
		if telephone2 != nil{
			aCoder.encode(telephone2, forKey: "Telephone2")
		}
		if telephone3 != nil{
			aCoder.encode(telephone3, forKey: "Telephone3")
		}

	}

}
