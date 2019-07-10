//
//	inviteEmailInvite.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class inviteEmailInvite : NSObject, NSCoding{

	var createdBy : String!
	var createdOn : String!
	var emailAddress : String!
	var id : String!
	var inviteExpiry : String!
	var inviteeName : String!
	var inviterName : String!
	var modifiedBy : String!
	var modifiedOn : String!
	var organizationId : String!
	var personalMessage : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		emailAddress = dictionary["EmailAddress"] as? String ?? ""
		id = dictionary["Id"] as? String ?? ""
		inviteExpiry = dictionary["InviteExpiry"] as? String ?? ""
		inviteeName = dictionary["InviteeName"] as? String ?? ""
		inviterName = dictionary["InviterName"] as? String ?? ""
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		organizationId = dictionary["OrganizationId"] as? String ?? ""
		personalMessage = dictionary["PersonalMessage"] as? String ?? ""
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
		if emailAddress != nil{
			dictionary["EmailAddress"] = emailAddress
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if inviteExpiry != nil{
			dictionary["InviteExpiry"] = inviteExpiry
		}
		if inviteeName != nil{
			dictionary["InviteeName"] = inviteeName
		}
		if inviterName != nil{
			dictionary["InviterName"] = inviterName
		}
		if modifiedBy != nil{
			dictionary["ModifiedBy"] = modifiedBy
		}
		if modifiedOn != nil{
			dictionary["ModifiedOn"] = modifiedOn
		}
		if organizationId != nil{
			dictionary["OrganizationId"] = organizationId
		}
		if personalMessage != nil{
			dictionary["PersonalMessage"] = personalMessage
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
         emailAddress = aDecoder.decodeObject(forKey: "EmailAddress") as? String ?? ""
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         inviteExpiry = aDecoder.decodeObject(forKey: "InviteExpiry") as? String ?? ""
         inviteeName = aDecoder.decodeObject(forKey: "InviteeName") as? String ?? ""
         inviterName = aDecoder.decodeObject(forKey: "InviterName") as? String ?? ""
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? ""
         organizationId = aDecoder.decodeObject(forKey: "OrganizationId") as? String ?? ""
         personalMessage = aDecoder.decodeObject(forKey: "PersonalMessage") as? String ?? ""

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
		if emailAddress != nil{
			aCoder.encode(emailAddress, forKey: "EmailAddress")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if inviteExpiry != nil{
			aCoder.encode(inviteExpiry, forKey: "InviteExpiry")
		}
		if inviteeName != nil{
			aCoder.encode(inviteeName, forKey: "InviteeName")
		}
		if inviterName != nil{
			aCoder.encode(inviterName, forKey: "InviterName")
		}
		if modifiedBy != nil{
			aCoder.encode(modifiedBy, forKey: "ModifiedBy")
		}
		if modifiedOn != nil{
			aCoder.encode(modifiedOn, forKey: "ModifiedOn")
		}
		if organizationId != nil{
			aCoder.encode(organizationId, forKey: "OrganizationId")
		}
		if personalMessage != nil{
			aCoder.encode(personalMessage, forKey: "PersonalMessage")
		}

	}

}
