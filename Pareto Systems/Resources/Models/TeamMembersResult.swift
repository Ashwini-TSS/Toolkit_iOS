//
//	TeamMembersResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class TeamMembersResult : NSObject, NSCoding{

	var addressLine1 : String!
	var addressLine2 : String!
	var addressLine3 : String!
	var city : String!
	var country : String!
	var createdBy : String!
	var createdOn : String!
	var descriptionField : String!
	var eMailAddress1 : String!
	var eMailAddress2 : String!
	var eMailAddress3 : String!
	var fax : String!
	var ftpSiteUrl : String!
	var id : String!
	var legalName : String!
	var mobilePhone : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var name : String!
	var pager : String!
	var poBox : String!
	var postal : String!
	var state : String!
	var telephone1 : String!
	var telephone2 : String!
	var telephone3 : String!
	var webSiteUrl : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		addressLine1 = dictionary["AddressLine1"] as? String ?? ""
		addressLine2 = dictionary["AddressLine2"] as? String ?? ""
		addressLine3 = dictionary["AddressLine3"] as? String ?? ""
		city = dictionary["City"] as? String ?? ""
		country = dictionary["Country"] as? String ?? ""
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		descriptionField = dictionary["Description"] as? String ?? ""
		eMailAddress1 = dictionary["EMailAddress1"] as? String ?? ""
		eMailAddress2 = dictionary["EMailAddress2"] as? String ?? ""
		eMailAddress3 = dictionary["EMailAddress3"] as? String ?? ""
		fax = dictionary["Fax"] as? String ?? ""
		ftpSiteUrl = dictionary["FtpSiteUrl"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		legalName = dictionary["LegalName"] as? String ?? ""
		mobilePhone = dictionary["MobilePhone"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		name = dictionary["Name"] as? String ?? ""
		pager = dictionary["Pager"] as? String ?? ""
		poBox = dictionary["PoBox"] as? String ?? ""
		postal = dictionary["Postal"] as? String ?? ""
		state = dictionary["State"] as? String ?? ""
		telephone1 = dictionary["Telephone1"] as? String ?? ""
		telephone2 = dictionary["Telephone2"] as? String ?? ""
		telephone3 = dictionary["Telephone3"] as? String ?? ""
		webSiteUrl = dictionary["WebSiteUrl"] as? String ?? ""
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
		if descriptionField != nil{
			dictionary["Description"] = descriptionField
		}
		if eMailAddress1 != nil{
			dictionary["EMailAddress1"] = eMailAddress1
		}
		if eMailAddress2 != nil{
			dictionary["EMailAddress2"] = eMailAddress2
		}
		if eMailAddress3 != nil{
			dictionary["EMailAddress3"] = eMailAddress3
		}
		if fax != nil{
			dictionary["Fax"] = fax
		}
		if ftpSiteUrl != nil{
			dictionary["FtpSiteUrl"] = ftpSiteUrl
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if legalName != nil{
			dictionary["LegalName"] = legalName
		}
		if mobilePhone != nil{
			dictionary["MobilePhone"] = mobilePhone
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
		if pager != nil{
			dictionary["Pager"] = pager
		}
		if poBox != nil{
			dictionary["PoBox"] = poBox
		}
		if postal != nil{
			dictionary["Postal"] = postal
		}
		if state != nil{
			dictionary["State"] = state
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
		if webSiteUrl != nil{
			dictionary["WebSiteUrl"] = webSiteUrl
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
         addressLine3 = aDecoder.decodeObject(forKey: "AddressLine3") as? String ?? ""
         city = aDecoder.decodeObject(forKey: "City") as? String ?? ""
         country = aDecoder.decodeObject(forKey: "Country") as? String ?? ""
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
         descriptionField = aDecoder.decodeObject(forKey: "Description") as? String ?? ""
         eMailAddress1 = aDecoder.decodeObject(forKey: "EMailAddress1") as? String ?? ""
         eMailAddress2 = aDecoder.decodeObject(forKey: "EMailAddress2") as? String ?? ""
         eMailAddress3 = aDecoder.decodeObject(forKey: "EMailAddress3") as? String ?? ""
         fax = aDecoder.decodeObject(forKey: "Fax") as? String ?? ""
         ftpSiteUrl = aDecoder.decodeObject(forKey: "FtpSiteUrl") as? String ?? ""
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         legalName = aDecoder.decodeObject(forKey: "LegalName") as? String ?? ""
         mobilePhone = aDecoder.decodeObject(forKey: "MobilePhone") as? String ?? ""
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
         name = aDecoder.decodeObject(forKey: "Name") as? String ?? ""
         pager = aDecoder.decodeObject(forKey: "Pager") as? String ?? ""
         poBox = aDecoder.decodeObject(forKey: "PoBox") as? String ?? ""
         postal = aDecoder.decodeObject(forKey: "Postal") as? String ?? ""
         state = aDecoder.decodeObject(forKey: "State") as? String ?? ""
         telephone1 = aDecoder.decodeObject(forKey: "Telephone1") as? String ?? ""
         telephone2 = aDecoder.decodeObject(forKey: "Telephone2") as? String ?? ""
         telephone3 = aDecoder.decodeObject(forKey: "Telephone3") as? String ?? ""
         webSiteUrl = aDecoder.decodeObject(forKey: "WebSiteUrl") as? String ?? ""

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
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "Description")
		}
		if eMailAddress1 != nil{
			aCoder.encode(eMailAddress1, forKey: "EMailAddress1")
		}
		if eMailAddress2 != nil{
			aCoder.encode(eMailAddress2, forKey: "EMailAddress2")
		}
		if eMailAddress3 != nil{
			aCoder.encode(eMailAddress3, forKey: "EMailAddress3")
		}
		if fax != nil{
			aCoder.encode(fax, forKey: "Fax")
		}
		if ftpSiteUrl != nil{
			aCoder.encode(ftpSiteUrl, forKey: "FtpSiteUrl")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if legalName != nil{
			aCoder.encode(legalName, forKey: "LegalName")
		}
		if mobilePhone != nil{
			aCoder.encode(mobilePhone, forKey: "MobilePhone")
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
		if pager != nil{
			aCoder.encode(pager, forKey: "Pager")
		}
		if poBox != nil{
			aCoder.encode(poBox, forKey: "PoBox")
		}
		if postal != nil{
			aCoder.encode(postal, forKey: "Postal")
		}
		if state != nil{
			aCoder.encode(state, forKey: "State")
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
		if webSiteUrl != nil{
			aCoder.encode(webSiteUrl, forKey: "WebSiteUrl")
		}

	}

}
