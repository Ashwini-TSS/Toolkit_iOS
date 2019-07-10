//
//	LoginModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class LoginModel{

	var passKey : String!
	var responseMessage : String!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
        
		passKey = dictionary["PassKey"] as? String ?? ""
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
		valid = dictionary["Valid"] as? Bool
	}

}
