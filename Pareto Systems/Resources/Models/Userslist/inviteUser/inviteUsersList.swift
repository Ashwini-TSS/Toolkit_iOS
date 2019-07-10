//
//	inviteUsersList.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class inviteUsersList : NSObject, NSCoding{

	var emailInvites : [inviteUsersEmailInvite]!
	var responseMessage : String!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		emailInvites = [inviteUsersEmailInvite]()
		if let emailInvitesArray = dictionary["EmailInvites"] as? [[String:Any]]{
			for dic in emailInvitesArray{
				let value = inviteUsersEmailInvite(fromDictionary: dic)
				emailInvites.append(value)
			}
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
		if emailInvites != nil{
			var dictionaryElements = [[String:Any]]()
			for emailInvitesElement in emailInvites {
				dictionaryElements.append(emailInvitesElement.toDictionary())
			}
			dictionary["EmailInvites"] = dictionaryElements
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
         emailInvites = aDecoder.decodeObject(forKey :"EmailInvites") as? [inviteUsersEmailInvite]
         responseMessage = aDecoder.decodeObject(forKey: "ResponseMessage") as? String ?? ""
         valid = aDecoder.decodeObject(forKey: "Valid") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if emailInvites != nil{
			aCoder.encode(emailInvites, forKey: "EmailInvites")
		}
		if responseMessage != nil{
			aCoder.encode(responseMessage, forKey: "ResponseMessage")
		}
		if valid != nil{
			aCoder.encode(valid, forKey: "Valid")
		}

	}

}
