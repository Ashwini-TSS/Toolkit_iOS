//
//	getCompanyListResult.swift
//
//	Create by thabresh thabu on 5/11/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class getCompanyListResult : NSObject, NSCoding{

	var addressLine1 : String!
	var addressLine2 : String!
	var addressLine3 : String!
	var anniversary : String!
	var assistantName : String!
	var assistantPhone : String!
	var assistantPhoneExt : AnyObject!
	var birthDate : String!
	var childrensNames : AnyObject!
	var city : String!
	var clientClassId : String!
	var clientSince : String!
	var companyId : AnyObject!
	var companyName : String!
	var country : AnyObject!
	var createdBy : String!
	var createdOn : String!
	var creditLimit : Int!
	var creditOnHold : Int!
	var department : String!
	var descriptionField : String!
	var driversLicenseExpiry : String!
	var driversLicenseNumber : String!
	var eMailAddress1 : String!
	var eMailAddress2 : String!
	var eMailAddress3 : String!
	var executorId : String!
	var executorName : String!
	var familyNotes : String!
	var fax : String!
	var faxExt : AnyObject!
	var firstName : String!
	var ftpSiteUrl : String!
	var fullName : String!
	var gender : String!
	var governmentIdent : String!
	var groupInsurance : String!
	var groupPensionPlan : String!
	var id : String!
	var income : Int!
	var jobTitle : String!
	var lastName : String!
	var maritalStatus : String!
	var middleName : String!
	var mobilePhone : String!
	var mobilePhoneExt : AnyObject!
	var modifiedBy : String!
	var modifiedOn : String!
	var moneyNotes : String!
	var nickName : String!
	var occupationNotes : String!
	var owningOrganizationUserId : String!
	var pager : String!
	var pagerExt : AnyObject!
	var poBox : String!
	var postal : String!
	var powerofAttorneyId : String!
	var powerofAttorneyName : String!
	var privateField : Bool!
	var recreationNotes : String!
	var revenue : Int!
	var reviewDate : String!
	var salutation : String!
	var spousePartnerId : String!
	var spousePartnerName : String!
	var state : String!
	var suffix : String!
	var telephone1 : String!
	var telephone1Ext : AnyObject!
	var telephone2 : String!
	var telephone2Ext : AnyObject!
	var telephone3 : String!
	var telephone3Ext : AnyObject!
	var title : String!
	var webSiteUrl : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		addressLine1 = dictionary["AddressLine1"] as? String ?? ""
		addressLine2 = dictionary["AddressLine2"] as? String ?? ""
		addressLine3 = dictionary["AddressLine3"] as? String ?? ""
		anniversary = dictionary["Anniversary"] as? String ?? "" ?? ""
		assistantName = dictionary["AssistantName"] as? String
		assistantPhone = dictionary["AssistantPhone"] as? String ?? ""
		assistantPhoneExt = dictionary["AssistantPhoneExt"] as? AnyObject
		birthDate = dictionary["BirthDate"] as? String ?? ""
		childrensNames = dictionary["ChildrensNames"] as? AnyObject
		city = dictionary["City"] as? String ?? ""
		clientClassId = dictionary["ClientClassId"] as? String ?? ""
		clientSince = dictionary["ClientSince"] as? String ?? ""
		companyId = dictionary["CompanyId"] as? AnyObject
		companyName = dictionary["CompanyName"] as? String ?? ""
		country = dictionary["Country"] as? AnyObject
		createdBy = dictionary["CreatedBy"] as? String ?? ""
		createdOn = dictionary["CreatedOn"] as? String ?? ""
		creditLimit = dictionary["CreditLimit"] as? Int
		creditOnHold = dictionary["CreditOnHold"] as? Int
		department = dictionary["Department"] as? String ?? ""
		descriptionField = dictionary["Description"] as? String ?? ""
		driversLicenseExpiry = dictionary["DriversLicenseExpiry"] as? String ?? ""
		driversLicenseNumber = dictionary["DriversLicenseNumber"] as? String ?? ""
		eMailAddress1 = dictionary["EMailAddress1"] as? String ?? ""
		eMailAddress2 = dictionary["EMailAddress2"] as? String ?? ""
		eMailAddress3 = dictionary["EMailAddress3"] as? String ?? ""
		executorId = dictionary["ExecutorId"] as? String ?? ""
		executorName = dictionary["ExecutorName"] as? String ?? ""
		familyNotes = dictionary["FamilyNotes"] as? String ?? ""
		fax = dictionary["Fax"] as? String ?? ""
		faxExt = dictionary["FaxExt"] as? AnyObject
		firstName = dictionary["FirstName"] as? String ?? ""
		ftpSiteUrl = dictionary["FtpSiteUrl"] as? String ?? ""
		fullName = dictionary["FullName"] as? String ?? ""
		gender = dictionary["Gender"] as? String ?? ""
		governmentIdent = dictionary["GovernmentIdent"] as? String ?? ""
		groupInsurance = dictionary["GroupInsurance"] as? String
		groupPensionPlan = dictionary["GroupPensionPlan"] as? String  ?? ""
		id = dictionary["Id"] as? String ?? ""
		income = dictionary["Income"] as? Int
		jobTitle = dictionary["JobTitle"] as? String ?? ""
		lastName = dictionary["LastName"] as? String ?? ""
		maritalStatus = dictionary["MaritalStatus"] as? String ?? ""
		middleName = dictionary["MiddleName"] as? String ?? ""
		mobilePhone = dictionary["MobilePhone"] as? String ?? ""
		mobilePhoneExt = dictionary["MobilePhoneExt"] as? AnyObject
		modifiedBy = dictionary["ModifiedBy"] as? String ?? ""
		modifiedOn = dictionary["ModifiedOn"] as? String ?? ""
		moneyNotes = dictionary["MoneyNotes"] as? String ?? ""
		nickName = dictionary["NickName"] as? String ?? ""
		occupationNotes = dictionary["OccupationNotes"] as? String ?? ""
		owningOrganizationUserId = dictionary["OwningOrganizationUserId"] as? String ?? ""
		pager = dictionary["Pager"] as? String ?? ""
		pagerExt = dictionary["PagerExt"] as? AnyObject
		poBox = dictionary["PoBox"] as? String ?? ""
		postal = dictionary["Postal"] as? String ?? ""
		powerofAttorneyId = dictionary["PowerofAttorneyId"] as? String ?? ""
		powerofAttorneyName = dictionary["PowerofAttorneyName"] as? String ?? ""
		privateField = dictionary["Private"] as? Bool
		recreationNotes = dictionary["RecreationNotes"] as? String ?? ""
		revenue = dictionary["Revenue"] as? Int
		reviewDate = dictionary["ReviewDate"] as? String ?? ""
		salutation = dictionary["Salutation"] as? String ?? ""
		spousePartnerId = dictionary["SpousePartnerId"] as? String ?? ""
		spousePartnerName = dictionary["SpousePartnerName"] as? String ?? ""
		state = dictionary["State"] as? String ?? ""
		suffix = dictionary["Suffix"] as? String ?? ""
		telephone1 = dictionary["Telephone1"] as? String ?? ""
		telephone1Ext = dictionary["Telephone1Ext"] as? AnyObject
		telephone2 = dictionary["Telephone2"] as? String ?? ""
		telephone2Ext = dictionary["Telephone2Ext"] as? AnyObject
		telephone3 = dictionary["Telephone3"] as? String ?? ""
		telephone3Ext = dictionary["Telephone3Ext"] as? AnyObject
		title = dictionary["Title"] as? String ?? ""
		webSiteUrl = dictionary["WebSiteUrl"] as? String ?? ""
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if addressLine1 != nil{
			dictionary["AddressLine1"] = addressLine1
		}
		if addressLine2 != nil{
			dictionary["AddressLine2"] = addressLine2
		}
		if addressLine3 != nil{
			dictionary["AddressLine3"] = addressLine3
		}
		if anniversary != nil{
			dictionary["Anniversary"] = anniversary
		}
		if assistantName != nil{
			dictionary["AssistantName"] = assistantName
		}
		if assistantPhone != nil{
			dictionary["AssistantPhone"] = assistantPhone
		}
		if assistantPhoneExt != nil{
			dictionary["AssistantPhoneExt"] = assistantPhoneExt
		}
		if birthDate != nil{
			dictionary["BirthDate"] = birthDate
		}
		if childrensNames != nil{
			dictionary["ChildrensNames"] = childrensNames
		}
		if city != nil{
			dictionary["City"] = city
		}
		if clientClassId != nil{
			dictionary["ClientClassId"] = clientClassId
		}
		if clientSince != nil{
			dictionary["ClientSince"] = clientSince
		}
		if companyId != nil{
			dictionary["CompanyId"] = companyId
		}
		if companyName != nil{
			dictionary["CompanyName"] = companyName
		}
		if country != nil{
			dictionary["Country"] = country
		}
		if createdBy != nil{
			dictionary["CreatedBy"] = createdBy
		}
		if createdOn != nil{
			dictionary["CreatedOn"] = createdOn
		}
		if creditLimit != nil{
			dictionary["CreditLimit"] = creditLimit
		}
		if creditOnHold != nil{
			dictionary["CreditOnHold"] = creditOnHold
		}
		if department != nil{
			dictionary["Department"] = department
		}
		if descriptionField != nil{
			dictionary["Description"] = descriptionField
		}
		if driversLicenseExpiry != nil{
			dictionary["DriversLicenseExpiry"] = driversLicenseExpiry
		}
		if driversLicenseNumber != nil{
			dictionary["DriversLicenseNumber"] = driversLicenseNumber
		}
		if eMailAddress1 != nil{
			dictionary["EMailAddress1"] = eMailAddress1
		}
		if eMailAddress2 != nil{
			dictionary["EMailAddress2"] = eMailAddress2
		}
		if eMailAddress3 != nil{
			dictionary["EMailAddress3"] = eMailAddress3
		}
		if executorId != nil{
			dictionary["ExecutorId"] = executorId
		}
		if executorName != nil{
			dictionary["ExecutorName"] = executorName
		}
		if familyNotes != nil{
			dictionary["FamilyNotes"] = familyNotes
		}
		if fax != nil{
			dictionary["Fax"] = fax
		}
		if faxExt != nil{
			dictionary["FaxExt"] = faxExt
		}
		if firstName != nil{
			dictionary["FirstName"] = firstName
		}
		if ftpSiteUrl != nil{
			dictionary["FtpSiteUrl"] = ftpSiteUrl
		}
		if fullName != nil{
			dictionary["FullName"] = fullName
		}
		if gender != nil{
			dictionary["Gender"] = gender
		}
		if governmentIdent != nil{
			dictionary["GovernmentIdent"] = governmentIdent
		}
		if groupInsurance != nil{
			dictionary["GroupInsurance"] = groupInsurance
		}
		if groupPensionPlan != nil{
			dictionary["GroupPensionPlan"] = groupPensionPlan
		}
		if id != nil{
			dictionary["Id"] = id
		}
		if income != nil{
			dictionary["Income"] = income
		}
		if jobTitle != nil{
			dictionary["JobTitle"] = jobTitle
		}
		if lastName != nil{
			dictionary["LastName"] = lastName
		}
		if maritalStatus != nil{
			dictionary["MaritalStatus"] = maritalStatus
		}
		if middleName != nil{
			dictionary["MiddleName"] = middleName
		}
		if mobilePhone != nil{
			dictionary["MobilePhone"] = mobilePhone
		}
		if mobilePhoneExt != nil{
			dictionary["MobilePhoneExt"] = mobilePhoneExt
		}
		if modifiedBy != nil{
			dictionary["ModifiedBy"] = modifiedBy
		}
		if modifiedOn != nil{
			dictionary["ModifiedOn"] = modifiedOn
		}
		if moneyNotes != nil{
			dictionary["MoneyNotes"] = moneyNotes
		}
		if nickName != nil{
			dictionary["NickName"] = nickName
		}
		if occupationNotes != nil{
			dictionary["OccupationNotes"] = occupationNotes
		}
		if owningOrganizationUserId != nil{
			dictionary["OwningOrganizationUserId"] = owningOrganizationUserId
		}
		if pager != nil{
			dictionary["Pager"] = pager
		}
		if pagerExt != nil{
			dictionary["PagerExt"] = pagerExt
		}
		if poBox != nil{
			dictionary["PoBox"] = poBox
		}
		if postal != nil{
			dictionary["Postal"] = postal
		}
		if powerofAttorneyId != nil{
			dictionary["PowerofAttorneyId"] = powerofAttorneyId
		}
		if powerofAttorneyName != nil{
			dictionary["PowerofAttorneyName"] = powerofAttorneyName
		}
		if privateField != nil{
			dictionary["Private"] = privateField
		}
		if recreationNotes != nil{
			dictionary["RecreationNotes"] = recreationNotes
		}
		if revenue != nil{
			dictionary["Revenue"] = revenue
		}
		if reviewDate != nil{
			dictionary["ReviewDate"] = reviewDate
		}
		if salutation != nil{
			dictionary["Salutation"] = salutation
		}
		if spousePartnerId != nil{
			dictionary["SpousePartnerId"] = spousePartnerId
		}
		if spousePartnerName != nil{
			dictionary["SpousePartnerName"] = spousePartnerName
		}
		if state != nil{
			dictionary["State"] = state
		}
		if suffix != nil{
			dictionary["Suffix"] = suffix
		}
		if telephone1 != nil{
			dictionary["Telephone1"] = telephone1
		}
		if telephone1Ext != nil{
			dictionary["Telephone1Ext"] = telephone1Ext
		}
		if telephone2 != nil{
			dictionary["Telephone2"] = telephone2
		}
		if telephone2Ext != nil{
			dictionary["Telephone2Ext"] = telephone2Ext
		}
		if telephone3 != nil{
			dictionary["Telephone3"] = telephone3
		}
		if telephone3Ext != nil{
			dictionary["Telephone3Ext"] = telephone3Ext
		}
		if title != nil{
			dictionary["Title"] = title
		}
		if webSiteUrl != nil{
			dictionary["WebSiteUrl"] = webSiteUrl
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         addressLine1 = aDecoder.decodeObject(forKey: "AddressLine1") as? String ?? ""
         addressLine2 = aDecoder.decodeObject(forKey: "AddressLine2") as? String ?? ""
         addressLine3 = aDecoder.decodeObject(forKey: "AddressLine3") as? String ?? ""
         anniversary = aDecoder.decodeObject(forKey: "Anniversary") as? String ?? ""
         assistantName = aDecoder.decodeObject(forKey: "AssistantName") as? String ?? ""
         assistantPhone = aDecoder.decodeObject(forKey: "AssistantPhone") as? String ?? ""
         assistantPhoneExt = aDecoder.decodeObject(forKey: "AssistantPhoneExt") as? AnyObject
         birthDate = aDecoder.decodeObject(forKey: "BirthDate") as? String ?? ""
         childrensNames = aDecoder.decodeObject(forKey: "ChildrensNames") as? AnyObject
         city = aDecoder.decodeObject(forKey: "City") as? String ?? ""
         clientClassId = aDecoder.decodeObject(forKey: "ClientClassId") as? String ?? ""
         clientSince = aDecoder.decodeObject(forKey: "ClientSince") as? String ?? ""
         companyId = aDecoder.decodeObject(forKey: "CompanyId") as? AnyObject
         companyName = aDecoder.decodeObject(forKey: "CompanyName") as? String ?? ""
         country = aDecoder.decodeObject(forKey: "Country") as? AnyObject
         createdBy = aDecoder.decodeObject(forKey: "CreatedBy") as? String ?? ""
         createdOn = aDecoder.decodeObject(forKey: "CreatedOn") as? String ?? ""
         creditLimit = aDecoder.decodeObject(forKey: "CreditLimit") as? Int
         creditOnHold = aDecoder.decodeObject(forKey: "CreditOnHold") as? Int
         department = aDecoder.decodeObject(forKey: "Department") as? String ?? ""
         descriptionField = aDecoder.decodeObject(forKey: "Description") as? String ?? ""
         driversLicenseExpiry = aDecoder.decodeObject(forKey: "DriversLicenseExpiry") as? String ?? ""
         driversLicenseNumber = aDecoder.decodeObject(forKey: "DriversLicenseNumber") as? String ?? ""
         eMailAddress1 = aDecoder.decodeObject(forKey: "EMailAddress1") as? String ?? ""
         eMailAddress2 = aDecoder.decodeObject(forKey: "EMailAddress2") as? String ?? ""
         eMailAddress3 = aDecoder.decodeObject(forKey: "EMailAddress3") as? String ?? ""
         executorId = aDecoder.decodeObject(forKey: "ExecutorId") as? String ?? ""
         executorName = aDecoder.decodeObject(forKey: "ExecutorName") as? String ?? ""
         familyNotes = aDecoder.decodeObject(forKey: "FamilyNotes") as? String ?? ""
         fax = aDecoder.decodeObject(forKey: "Fax") as? String ?? ""
         faxExt = aDecoder.decodeObject(forKey: "FaxExt") as? AnyObject
         firstName = aDecoder.decodeObject(forKey: "FirstName") as? String ?? ""
         ftpSiteUrl = aDecoder.decodeObject(forKey: "FtpSiteUrl") as? String ?? ""
         fullName = aDecoder.decodeObject(forKey: "FullName") as? String ?? ""
         gender = aDecoder.decodeObject(forKey: "Gender") as? String ?? ""
         governmentIdent = aDecoder.decodeObject(forKey: "GovernmentIdent") as? String ?? ""
         groupInsurance = aDecoder.decodeObject(forKey: "GroupInsurance") as? String ?? ""
         groupPensionPlan = aDecoder.decodeObject(forKey: "GroupPensionPlan") as? String ?? ""
         id = aDecoder.decodeObject(forKey: "Id") as? String ?? ""
         income = aDecoder.decodeObject(forKey: "Income") as? Int
         jobTitle = aDecoder.decodeObject(forKey: "JobTitle") as? String ?? ""
         lastName = aDecoder.decodeObject(forKey: "LastName") as? String ?? ""
         maritalStatus = aDecoder.decodeObject(forKey: "MaritalStatus") as? String ?? ""
         middleName = aDecoder.decodeObject(forKey: "MiddleName") as? String ?? ""
         mobilePhone = aDecoder.decodeObject(forKey: "MobilePhone") as? String ?? ""
         mobilePhoneExt = aDecoder.decodeObject(forKey: "MobilePhoneExt") as? AnyObject
         modifiedBy = aDecoder.decodeObject(forKey: "ModifiedBy") as? String ?? ""
         modifiedOn = aDecoder.decodeObject(forKey: "ModifiedOn") as? String ?? "" ?? ""
         moneyNotes = aDecoder.decodeObject(forKey: "MoneyNotes") as? String
         nickName = aDecoder.decodeObject(forKey: "NickName") as? String ?? ""
         occupationNotes = aDecoder.decodeObject(forKey: "OccupationNotes") as? String ?? ""
         owningOrganizationUserId = aDecoder.decodeObject(forKey: "OwningOrganizationUserId") as? String ?? ""
         pager = aDecoder.decodeObject(forKey: "Pager") as? String ?? ""
         pagerExt = aDecoder.decodeObject(forKey: "PagerExt") as? AnyObject
         poBox = aDecoder.decodeObject(forKey: "PoBox") as? String ?? ""
         postal = aDecoder.decodeObject(forKey: "Postal") as? String ?? ""
         powerofAttorneyId = aDecoder.decodeObject(forKey: "PowerofAttorneyId") as? String ?? ""
         powerofAttorneyName = aDecoder.decodeObject(forKey: "PowerofAttorneyName") as? String ?? ""
         privateField = aDecoder.decodeObject(forKey: "Private") as? Bool
         recreationNotes = aDecoder.decodeObject(forKey: "RecreationNotes") as? String ?? ""
         revenue = aDecoder.decodeObject(forKey: "Revenue") as? Int
         reviewDate = aDecoder.decodeObject(forKey: "ReviewDate") as? String ?? ""
         salutation = aDecoder.decodeObject(forKey: "Salutation") as? String ?? ""
         spousePartnerId = aDecoder.decodeObject(forKey: "SpousePartnerId") as? String ?? ""
         spousePartnerName = aDecoder.decodeObject(forKey: "SpousePartnerName") as? String ?? ""
         state = aDecoder.decodeObject(forKey: "State") as? String ?? ""
         suffix = aDecoder.decodeObject(forKey: "Suffix") as? String ?? ""
         telephone1 = aDecoder.decodeObject(forKey: "Telephone1") as? String ?? ""
         telephone1Ext = aDecoder.decodeObject(forKey: "Telephone1Ext") as? AnyObject
         telephone2 = aDecoder.decodeObject(forKey: "Telephone2") as? String ?? ""
         telephone2Ext = aDecoder.decodeObject(forKey: "Telephone2Ext") as? AnyObject
         telephone3 = aDecoder.decodeObject(forKey: "Telephone3") as? String ?? ""
         telephone3Ext = aDecoder.decodeObject(forKey: "Telephone3Ext") as? AnyObject
         title = aDecoder.decodeObject(forKey: "Title") as? String ?? ""
         webSiteUrl = aDecoder.decodeObject(forKey: "WebSiteUrl") as? String ?? ""

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if addressLine1 != nil{
			aCoder.encode(addressLine1, forKey: "AddressLine1")
		}
		if addressLine2 != nil{
			aCoder.encode(addressLine2, forKey: "AddressLine2")
		}
		if addressLine3 != nil{
			aCoder.encode(addressLine3, forKey: "AddressLine3")
		}
		if anniversary != nil{
			aCoder.encode(anniversary, forKey: "Anniversary")
		}
		if assistantName != nil{
			aCoder.encode(assistantName, forKey: "AssistantName")
		}
		if assistantPhone != nil{
			aCoder.encode(assistantPhone, forKey: "AssistantPhone")
		}
		if assistantPhoneExt != nil{
			aCoder.encode(assistantPhoneExt, forKey: "AssistantPhoneExt")
		}
		if birthDate != nil{
			aCoder.encode(birthDate, forKey: "BirthDate")
		}
		if childrensNames != nil{
			aCoder.encode(childrensNames, forKey: "ChildrensNames")
		}
		if city != nil{
			aCoder.encode(city, forKey: "City")
		}
		if clientClassId != nil{
			aCoder.encode(clientClassId, forKey: "ClientClassId")
		}
		if clientSince != nil{
			aCoder.encode(clientSince, forKey: "ClientSince")
		}
		if companyId != nil{
			aCoder.encode(companyId, forKey: "CompanyId")
		}
		if companyName != nil{
			aCoder.encode(companyName, forKey: "CompanyName")
		}
		if country != nil{
			aCoder.encode(country, forKey: "Country")
		}
		if createdBy != nil{
			aCoder.encode(createdBy, forKey: "CreatedBy")
		}
		if createdOn != nil{
			aCoder.encode(createdOn, forKey: "CreatedOn")
		}
		if creditLimit != nil{
			aCoder.encode(creditLimit, forKey: "CreditLimit")
		}
		if creditOnHold != nil{
			aCoder.encode(creditOnHold, forKey: "CreditOnHold")
		}
		if department != nil{
			aCoder.encode(department, forKey: "Department")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "Description")
		}
		if driversLicenseExpiry != nil{
			aCoder.encode(driversLicenseExpiry, forKey: "DriversLicenseExpiry")
		}
		if driversLicenseNumber != nil{
			aCoder.encode(driversLicenseNumber, forKey: "DriversLicenseNumber")
		}
		if eMailAddress1 != nil{
			aCoder.encode(eMailAddress1, forKey: "EMailAddress1")
		}
		if eMailAddress2 != nil{
			aCoder.encode(eMailAddress2, forKey: "EMailAddress2")
		}
		if eMailAddress3 != nil{
			aCoder.encode(eMailAddress3, forKey: "EMailAddress3")
		}
		if executorId != nil{
			aCoder.encode(executorId, forKey: "ExecutorId")
		}
		if executorName != nil{
			aCoder.encode(executorName, forKey: "ExecutorName")
		}
		if familyNotes != nil{
			aCoder.encode(familyNotes, forKey: "FamilyNotes")
		}
		if fax != nil{
			aCoder.encode(fax, forKey: "Fax")
		}
		if faxExt != nil{
			aCoder.encode(faxExt, forKey: "FaxExt")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "FirstName")
		}
		if ftpSiteUrl != nil{
			aCoder.encode(ftpSiteUrl, forKey: "FtpSiteUrl")
		}
		if fullName != nil{
			aCoder.encode(fullName, forKey: "FullName")
		}
		if gender != nil{
			aCoder.encode(gender, forKey: "Gender")
		}
		if governmentIdent != nil{
			aCoder.encode(governmentIdent, forKey: "GovernmentIdent")
		}
		if groupInsurance != nil{
			aCoder.encode(groupInsurance, forKey: "GroupInsurance")
		}
		if groupPensionPlan != nil{
			aCoder.encode(groupPensionPlan, forKey: "GroupPensionPlan")
		}
		if id != nil{
			aCoder.encode(id, forKey: "Id")
		}
		if income != nil{
			aCoder.encode(income, forKey: "Income")
		}
		if jobTitle != nil{
			aCoder.encode(jobTitle, forKey: "JobTitle")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "LastName")
		}
		if maritalStatus != nil{
			aCoder.encode(maritalStatus, forKey: "MaritalStatus")
		}
		if middleName != nil{
			aCoder.encode(middleName, forKey: "MiddleName")
		}
		if mobilePhone != nil{
			aCoder.encode(mobilePhone, forKey: "MobilePhone")
		}
		if mobilePhoneExt != nil{
			aCoder.encode(mobilePhoneExt, forKey: "MobilePhoneExt")
		}
		if modifiedBy != nil{
			aCoder.encode(modifiedBy, forKey: "ModifiedBy")
		}
		if modifiedOn != nil{
			aCoder.encode(modifiedOn, forKey: "ModifiedOn")
		}
		if moneyNotes != nil{
			aCoder.encode(moneyNotes, forKey: "MoneyNotes")
		}
		if nickName != nil{
			aCoder.encode(nickName, forKey: "NickName")
		}
		if occupationNotes != nil{
			aCoder.encode(occupationNotes, forKey: "OccupationNotes")
		}
		if owningOrganizationUserId != nil{
			aCoder.encode(owningOrganizationUserId, forKey: "OwningOrganizationUserId")
		}
		if pager != nil{
			aCoder.encode(pager, forKey: "Pager")
		}
		if pagerExt != nil{
			aCoder.encode(pagerExt, forKey: "PagerExt")
		}
		if poBox != nil{
			aCoder.encode(poBox, forKey: "PoBox")
		}
		if postal != nil{
			aCoder.encode(postal, forKey: "Postal")
		}
		if powerofAttorneyId != nil{
			aCoder.encode(powerofAttorneyId, forKey: "PowerofAttorneyId")
		}
		if powerofAttorneyName != nil{
			aCoder.encode(powerofAttorneyName, forKey: "PowerofAttorneyName")
		}
		if privateField != nil{
			aCoder.encode(privateField, forKey: "Private")
		}
		if recreationNotes != nil{
			aCoder.encode(recreationNotes, forKey: "RecreationNotes")
		}
		if revenue != nil{
			aCoder.encode(revenue, forKey: "Revenue")
		}
		if reviewDate != nil{
			aCoder.encode(reviewDate, forKey: "ReviewDate")
		}
		if salutation != nil{
			aCoder.encode(salutation, forKey: "Salutation")
		}
		if spousePartnerId != nil{
			aCoder.encode(spousePartnerId, forKey: "SpousePartnerId")
		}
		if spousePartnerName != nil{
			aCoder.encode(spousePartnerName, forKey: "SpousePartnerName")
		}
		if state != nil{
			aCoder.encode(state, forKey: "State")
		}
		if suffix != nil{
			aCoder.encode(suffix, forKey: "Suffix")
		}
		if telephone1 != nil{
			aCoder.encode(telephone1, forKey: "Telephone1")
		}
		if telephone1Ext != nil{
			aCoder.encode(telephone1Ext, forKey: "Telephone1Ext")
		}
		if telephone2 != nil{
			aCoder.encode(telephone2, forKey: "Telephone2")
		}
		if telephone2Ext != nil{
			aCoder.encode(telephone2Ext, forKey: "Telephone2Ext")
		}
		if telephone3 != nil{
			aCoder.encode(telephone3, forKey: "Telephone3")
		}
		if telephone3Ext != nil{
			aCoder.encode(telephone3Ext, forKey: "Telephone3Ext")
		}
		if title != nil{
			aCoder.encode(title, forKey: "Title")
		}
		if webSiteUrl != nil{
			aCoder.encode(webSiteUrl, forKey: "WebSiteUrl")
		}

	}

}