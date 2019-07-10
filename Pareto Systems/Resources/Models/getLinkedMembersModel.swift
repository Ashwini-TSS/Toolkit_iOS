//
//	getLinkedMembersModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class getLinkedMembersModel : NSObject, NSCoding{

	var responseMessage : String!
	var results : [getLinkedMembersResult]!
	var totalResults : Int!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
		results = [getLinkedMembersResult]()
		if let resultsArray = dictionary["Results"] as? [[String:Any]]{
			for dic in resultsArray{
				let value = getLinkedMembersResult(fromDictionary: dic)
				results.append(value)
			}
		}
		totalResults = dictionary["TotalResults"] as? Int
		valid = dictionary["Valid"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if responseMessage != nil{
			dictionary["ResponseMessage"] = responseMessage
		}
		if results != nil{
			var dictionaryElements = [[String:Any]]()
			for resultsElement in results {
				dictionaryElements.append(resultsElement.toDictionary())
			}
			dictionary["Results"] = dictionaryElements
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
         responseMessage = aDecoder.decodeObject(forKey: "ResponseMessage") as? String ?? ""
         results = aDecoder.decodeObject(forKey :"Results") as? [getLinkedMembersResult]
         totalResults = aDecoder.decodeObject(forKey: "TotalResults") as? Int
         valid = aDecoder.decodeObject(forKey: "Valid") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if responseMessage != nil{
			aCoder.encode(responseMessage, forKey: "ResponseMessage")
		}
		if results != nil{
			aCoder.encode(results, forKey: "Results")
		}
		if totalResults != nil{
			aCoder.encode(totalResults, forKey: "TotalResults")
		}
		if valid != nil{
			aCoder.encode(valid, forKey: "Valid")
		}

	}

}
