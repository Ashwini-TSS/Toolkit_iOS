//
//	AdditionalAddsResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class AdditionalAddsResult{

	var city : String!
	var country : String!
	var county : String!
	var createdBy : String!
	var createdOn : String!
	var fax : String!
	var id : String!
	var latitude : NSNumber!
	var line1 : String!
	var line2 : String!
	var line3 : String!
	var longitude : NSNumber!
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
		latitude = dictionary["Latitude"] as? NSNumber
		line1 = dictionary["Line1"] as? String ?? ""
		line2 = dictionary["Line2"] as? String ?? ""
		line3 = dictionary["Line3"] as? String ?? ""
		longitude = dictionary["Longitude"] as? NSNumber
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

}
