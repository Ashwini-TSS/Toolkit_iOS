//
//	LinkedAccountsModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class LinkedAccountsModel{

	var responseMessage : String!
	var results : [LinkedAccountsResult]!
	var totalResults : Int!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
		results = [LinkedAccountsResult]()
		if let resultsArray = dictionary["Results"] as? [[String:Any]]{
			for dic in resultsArray{
				let value = LinkedAccountsResult(fromDictionary: dic)
				results.append(value)
			}
		}
		totalResults = dictionary["TotalResults"] as? Int
		valid = dictionary["Valid"] as? Bool
	}

}
