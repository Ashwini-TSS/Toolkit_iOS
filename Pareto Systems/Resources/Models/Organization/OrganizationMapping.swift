//
//	OrganizationMapping.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class OrganizationMapping : NSObject, NSCoding{

	var organizations : [Organization]!
	var responseMessage : String!
	var totalResults : Int!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		organizations = [Organization]()
		if let organizationsArray = dictionary["Organizations"] as? [[String:Any]]{
			for dic in organizationsArray{
				let value = Organization(fromDictionary: dic)
				organizations.append(value)
			}
		}
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
		totalResults = dictionary["TotalResults"] as? Int
		valid = dictionary["Valid"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if organizations != nil{
			var dictionaryElements = [[String:Any]]()
			for organizationsElement in organizations {
				dictionaryElements.append(organizationsElement.toDictionary())
			}
			dictionary["Organizations"] = dictionaryElements
		}
		if responseMessage != nil{
			dictionary["ResponseMessage"] = responseMessage
		}
		if totalResults != nil{
			dictionary["TotalResults"] = totalResults
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
         organizations = aDecoder.decodeObject(forKey :"Organizations") as? [Organization]
         responseMessage = aDecoder.decodeObject(forKey: "ResponseMessage") as? String ?? ""
         totalResults = aDecoder.decodeObject(forKey: "TotalResults") as? Int
         valid = aDecoder.decodeObject(forKey: "Valid") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if organizations != nil{
			aCoder.encode(organizations, forKey: "Organizations")
		}
		if responseMessage != nil{
			aCoder.encode(responseMessage, forKey: "ResponseMessage")
		}
		if totalResults != nil{
			aCoder.encode(totalResults, forKey: "TotalResults")
		}
		if valid != nil{
			aCoder.encode(valid, forKey: "Valid")
		}

	}

}
