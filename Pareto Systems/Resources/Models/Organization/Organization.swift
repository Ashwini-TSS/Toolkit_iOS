//
//	Organization.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Organization : NSObject, NSCoding{

	var addressLine1 : String!
	var addressLine2 : String!
	var city : String!
	var country : String!
	var createdBy : String!
	var createdOn : String!
	var id : String!
	var masterUserId : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var name : String!
	var state : String!
	var zip : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		addressLine1 = dictionary["AddressLine1"] as? String ?? ""
		addressLine2 = dictionary["AddressLine2"] as? String ?? ""
		city = dictionary["City"] as? String ?? ""
		country = dictionary["Country"] as? String ?? ""
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		masterUserId = dictionary["MasterUserId"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		name = dictionary["Name"] as? String ?? ""
		state = dictionary["State"] as? String ?? ""
		zip = dictionary["Zip"] as? String ?? ""
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
		if id != nil{
			dictionary["Id"] = id
		}
		if masterUserId != nil{
			dictionary["MasterUserId"] = masterUserId
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
		if state != nil{
			dictionary["State"] = state
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
         addressLine1 = aDecoder.decodeObject(forKey: "AddressLine1") as? String ?? ""
         addressLine2 = aDecoder.decodeObject(forKey: "AddressLine2") as? String ?? ""
         city = aDecoder.decodeObject(forKey: "City") as? String ?? ""
         country = aDecoder.decodeObject(forKey: "Country") as? String ?? ""
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         masterUserId = aDecoder.decodeObject(forKey: "MasterUserId") as? String ?? ""
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
         name = aDecoder.decodeObject(forKey: "Name") as? String ?? ""
         state = aDecoder.decodeObject(forKey: "State") as? String ?? ""
         zip = aDecoder.decodeObject(forKey: "Zip") as? String ?? ""

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
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if masterUserId != nil{
			aCoder.encode(masterUserId, forKey: "MasterUserId")
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
		if state != nil{
			aCoder.encode(state, forKey: "State")
		}
		if zip != nil{
			aCoder.encode(zip, forKey: "Zip")
		}

	}

}
