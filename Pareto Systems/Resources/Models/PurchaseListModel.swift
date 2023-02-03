//
//	PurchaseListModel.swift
//
//	Create by thabresh thabu on 17/8/2018
//	Copyright © 2018. All rights reserved.

import Foundation


class PurchaseListModel : NSObject, NSCoding{

	var pricingSchemeTiers : [PurchaseListPricingSchemeTier]!
	var responseMessage : String!
	var valid : Bool!
	var verticalPackages : [PurchaseListVerticalPackage]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary){
		pricingSchemeTiers = [PurchaseListPricingSchemeTier]()
		if let pricingSchemeTiersArray = dictionary["PricingSchemeTiers"] as? [[String:Any]]{
			for dic in pricingSchemeTiersArray{
				let value = PurchaseListPricingSchemeTier(fromDictionary: dic)
				pricingSchemeTiers.append(value)
			}
		}
		responseMessage = dictionary["ResponseMessage"] as? String ?? ""
		valid = dictionary["Valid"] as? Bool
		verticalPackages = [PurchaseListVerticalPackage]()
		if let verticalPackagesArray = dictionary["VerticalPackages"] as? [[String:Any]]{
			for dic in verticalPackagesArray{
				let value = PurchaseListVerticalPackage(fromDictionary: dic)
                if value.id == "dc8e4580-e5fb-4dcd-a6e8-1d76b3e8abcb" {
                    verticalPackages.append(value)
                }
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if pricingSchemeTiers != nil{
			var dictionaryElements = [[String:Any]]()
			for pricingSchemeTiersElement in pricingSchemeTiers {
				dictionaryElements.append(pricingSchemeTiersElement.toDictionary())
			}
			dictionary["PricingSchemeTiers"] = dictionaryElements
		}
		if responseMessage != nil{
			dictionary["ResponseMessage"] = responseMessage
		}
		if valid != nil{
			dictionary["Valid"] = valid
		}
		if verticalPackages != nil{
			var dictionaryElements = [[String:Any]]()
			for verticalPackagesElement in verticalPackages {
				dictionaryElements.append(verticalPackagesElement.toDictionary())
			}
			dictionary["VerticalPackages"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         pricingSchemeTiers = aDecoder.decodeObject(forKey :"PricingSchemeTiers") as? [PurchaseListPricingSchemeTier]
         responseMessage = aDecoder.decodeObject(forKey: "ResponseMessage") as? String ?? ""
         valid = aDecoder.decodeObject(forKey: "Valid") as? Bool
         verticalPackages = aDecoder.decodeObject(forKey :"VerticalPackages") as? [PurchaseListVerticalPackage]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if pricingSchemeTiers != nil{
			aCoder.encode(pricingSchemeTiers, forKey: "PricingSchemeTiers")
		}
		if responseMessage != nil{
			aCoder.encode(responseMessage, forKey: "ResponseMessage")
		}
		if valid != nil{
			aCoder.encode(valid, forKey: "Valid")
		}
		if verticalPackages != nil{
			aCoder.encode(verticalPackages, forKey: "VerticalPackages")
		}

	}

}
