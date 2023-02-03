//
//	ToolkitOrgOrganizationStatu.swift
//
//	Create by thabresh thabu on 9/10/2018
//	Copyright © 2018. All rights reserved.

import Foundation


class ToolkitOrgOrganizationStatu : NSObject, NSCoding{

	var billingEnabled : Bool!
	var disabledReason : String!
	var enabled : Bool!
	var extensions : AnyObject!
	var toolKitEnabled : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		billingEnabled = dictionary["BillingEnabled"] as? Bool
		disabledReason = dictionary["DisabledReason"] as? String
		enabled = dictionary["Enabled"] as? Bool
		extensions = dictionary["Extensions"] as? AnyObject
		toolKitEnabled = dictionary["ToolKitEnabled"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if billingEnabled != nil{
			dictionary["BillingEnabled"] = billingEnabled
		}
		if disabledReason != nil{
			dictionary["DisabledReason"] = disabledReason
		}
		if enabled != nil{
			dictionary["Enabled"] = enabled
		}
		if extensions != nil{
			dictionary["Extensions"] = extensions
		}
		if toolKitEnabled != nil{
			dictionary["ToolKitEnabled"] = toolKitEnabled
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         billingEnabled = aDecoder.decodeObject(forKey: "BillingEnabled") as? Bool
         disabledReason = aDecoder.decodeObject(forKey: "DisabledReason") as? String
         enabled = aDecoder.decodeObject(forKey: "Enabled") as? Bool
         extensions = aDecoder.decodeObject(forKey: "Extensions") as? AnyObject
         toolKitEnabled = aDecoder.decodeObject(forKey: "ToolKitEnabled") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if billingEnabled != nil{
			aCoder.encode(billingEnabled, forKey: "BillingEnabled")
		}
		if disabledReason != nil{
			aCoder.encode(disabledReason, forKey: "DisabledReason")
		}
		if enabled != nil{
			aCoder.encode(enabled, forKey: "Enabled")
		}
		if extensions != nil{
			aCoder.encode(extensions, forKey: "Extensions")
		}
		if toolKitEnabled != nil{
			aCoder.encode(toolKitEnabled, forKey: "ToolKitEnabled")
		}

	}

}
