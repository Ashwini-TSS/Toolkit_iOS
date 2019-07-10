//
//	PurchaseToolkitModel.swift
//
//	Create by thabresh thabu on 9/10/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct PurchaseToolkitModel{

	var responseMessage : String!
	var valid : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
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
		if valid != nil{
			dictionary["Valid"] = valid
		}
		return dictionary
	}

}
