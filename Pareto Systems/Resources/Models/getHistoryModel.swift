//
//	getHistoryModel.swift
//
//	Create by thabresh thabu on 24/8/2018
//	Copyright © 2018. All rights reserved.

import Foundation


class getHistoryModel : NSObject, NSCoding{

	var entries : [getHistoryEntry]!
	var responseMessage : String!
	var totalResults : Int!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		entries = [getHistoryEntry]()
		if let entriesArray = dictionary["Entries"] as? [[String:Any]]{
			for dic in entriesArray{
				let value = getHistoryEntry(fromDictionary: dic)
				entries.append(value)
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
		if entries != nil{
			var dictionaryElements = [[String:Any]]()
			for entriesElement in entries {
				dictionaryElements.append(entriesElement.toDictionary())
			}
			dictionary["Entries"] = dictionaryElements
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
         entries = aDecoder.decodeObject(forKey :"Entries") as? [getHistoryEntry]
         responseMessage = aDecoder.decodeObject(forKey: "ResponseMessage") as? String
         totalResults = aDecoder.decodeObject(forKey: "TotalResults") as? Int
         valid = aDecoder.decodeObject(forKey: "Valid") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if entries != nil{
			aCoder.encode(entries, forKey: "Entries")
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
