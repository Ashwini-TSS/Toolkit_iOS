//
//	AdditionalAddsModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class AdditionalAddsModel{

	var responseMessage : String!
	var results : [AdditionalAddsResult]!
	var totalResults : Int!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
		results = [AdditionalAddsResult]()
		if let resultsArray = dictionary["Results"] as? [[String:Any]]{
			for dic in resultsArray{
				let value = AdditionalAddsResult(fromDictionary: dic)
				results.append(value)
			}
		}
		totalResults = dictionary["TotalResults"] as? Int
		valid = dictionary["Valid"] as? Bool
	}

}
