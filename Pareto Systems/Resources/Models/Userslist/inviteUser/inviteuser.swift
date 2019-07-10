//
//	inviteuser.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class inviteuser : NSObject, NSCoding{

	var emailInvite : inviteEmailInvite!
	var responseMessage : String!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary) {
		if let emailInviteData = dictionary["EmailInvite"] as? [String:Any]{
			emailInvite = inviteEmailInvite(fromDictionary: emailInviteData)
		}
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
		valid = dictionary["Valid"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if emailInvite != nil{
			dictionary["EmailInvite"] = emailInvite.toDictionary()
		}
		if responseMessage != nil{
			dictionary["ResponseMessage"] = responseMessage
		}
		if valid != nil{
			dictionary["Valid"] = valid
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         emailInvite = aDecoder.decodeObject(forKey: "EmailInvite") as? inviteEmailInvite
         responseMessage = aDecoder.decodeObject(forKey: "ResponseMessage") as? String ?? ""
         valid = aDecoder.decodeObject(forKey: "Valid") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if emailInvite != nil{
			aCoder.encode(emailInvite, forKey: "EmailInvite")
		}
		if responseMessage != nil{
			aCoder.encode(responseMessage, forKey: "ResponseMessage")
		}
		if valid != nil{
			aCoder.encode(valid, forKey: "Valid")
		}

	}

}
